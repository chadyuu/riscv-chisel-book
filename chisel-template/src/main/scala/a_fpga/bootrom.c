#include <stdint.h>

void __attribute__((naked)) __attribute__((section(".isr_vector"))) isr_vector(void)
{
    asm volatile ("j start");
    asm volatile ("j start");
}

void __attribute__((noreturn)) main(void);

void __attribute__((naked)) start(void)
{
    asm volatile ("la sp, ramend");
    main();
}

static volatile uint32_t* const GPIO_OUT = (volatile uint32_t*)0x30000000;

void __attribute__((noreturn)) main(void)
{
    uint32_t led_out = 1;
    while(1) {
        *GPIO_OUT = led_out;
        led_out = (led_out << 1) | ((led_out >> 7) & 1);
        for(volatile int n = 0; n < 1000000; n++);
    }
}