#include <stdint.h>

extern void __attribute__((naked)) __attribute__((section(".isr_vector"))) isr_vector(void)
{
    asm volatile ("j _start");
    asm volatile ("j _start");
}

void __attribute__((noreturn)) main(void);

extern void __attribute__((naked)) _start(void)
{
    asm volatile ("la sp, ramend");
    main();
}

static volatile uint32_t* const REG_GPIO_OUT = (volatile uint32_t*)0x30000000;
static volatile uint32_t* const REG_UART_DATA = (volatile uint32_t*)0x30001000;
static volatile uint32_t* const REG_UART_STATUS = (volatile uint32_t*)0x30001000;
static volatile uint32_t* const REG_CONFIG_ID = (volatile uint32_t*)0x40000000;
static volatile uint32_t* const REG_CONFIG_CLOCK_HZ = (volatile uint32_t*)0x40000004;

static uint64_t read_cycle(void)
{
    uint32_t l, h, hv;
    do {
        asm volatile ("rdcycleh %0" : "=r" (h));
        asm volatile ("rdcycle  %0" : "=r" (l));
        asm volatile ("rdcycleh %0" : "=r" (hv));
    } while(h != hv);
    return ((uint64_t)h << 32) | l;
} 

static void uart_tx(uint8_t value) 
{
    while((*REG_UART_STATUS & 0b01) != 0);
    *REG_UART_DATA = value;
}
// static uint8_t uart_rx() 
// {
//     while((*REG_UART_STATUS & 0b10) == 0);
//     return *REG_UART_DATA;
// }

static void uart_puts(const char* s)
{
    while(*s) {
        uart_tx((uint8_t)*(s++));
    }
}


static void wait_cycles(uint64_t cycles)
{
    uint64_t start = read_cycle();
    while(read_cycle() - start < cycles);
}

void __attribute__((noreturn)) main(void)
{
    uint32_t led_out = 1;
    uint32_t clock_hz = *REG_CONFIG_CLOCK_HZ;
    while(1) {
        uart_puts("Hello, RISC-V\r\n");
        *REG_GPIO_OUT = led_out;
        led_out = (led_out << 1) | ((led_out >> 7) & 1);
        wait_cycles(clock_hz >> 1);
    }
}