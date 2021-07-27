#include <stdio.h>

int main()
{
	const unsigned int x = 1;
	const unsigned int y = 2;
	unsigned int z;
	z = x + y;
	asm volatile("unimp");
	return 0;
}