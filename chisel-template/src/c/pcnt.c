#include <stdio.h>

int main()
{
	unsigned int x = 0b1111000011110000;
	unsigned int y = 0b1111000000000000;
	asm volatile("pcnt a0, %0" ::"r"(x));
	asm volatile("pcnt a1, %0" ::"r"(y));
	asm volatile("unimp");
	return 0;
}