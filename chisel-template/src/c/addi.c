#include <stdio.h>

int main()
{
	asm volatile("addi x0, x0, 0");
	return 0;
}