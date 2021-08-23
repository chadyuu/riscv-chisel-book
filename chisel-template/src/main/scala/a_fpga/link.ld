OUTPUT_ARCH( "riscv" )
ENTRY(_start)

MEMORY
{
    imem(rx)  : ORIGIN = 0x08000000, LENGTH = 1024
    dmem(rwx) : ORIGIN = 0x20000000, LENGTH = 512 
}

SECTIONS
{
  .isr_vector : {
      . = ALIGN(4);
      KEEP(*(.isr_vector))
      . = ALIGN(4);
  } >imem
  .text : { 
      . = ALIGN(4);
      *(.text) 
      . = ALIGN(4);
  } >imem
  .rodata : { 
      . = ALIGN(4);
      *(.rodata) 
      . = ALIGN(4);
  } >imem
  .data : {
      . = ALIGN(4);
      *(.data)
      . = ALIGN(4);
  } >dmem AT>imem
  .bss : { 
      *(.bss) 
      . = ALIGN(4);
  } >dmem
  PROVIDE(stack_bottom = .);
  PROVIDE(_end = .);
  PROVIDE(end = .);
  PROVIDE(ramend = ORIGIN(dmem) + LENGTH(dmem));
}
