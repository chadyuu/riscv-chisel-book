#include <stdio.h>

int main()
{
	asm volatile("addi a0, x0, 1");
	asm volatile("add a1, a0, a0 ");

	// パイプラインを進めるためにBUBBLE
	asm volatile("nop");
	asm volatile("nop");
	asm volatile("nop");

	asm volatile("unimp");
	return 0;
}