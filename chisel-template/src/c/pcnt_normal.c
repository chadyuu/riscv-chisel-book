#include <stdio.h>

int popcount(unsigned int x)
{
	int c = 0;
	for (; x != 0; x >>= 1)
	{
		if (x & 1)
		{
			c++;
		}
	}
	return c;
}

int main()
{
	popcount(0b1111000011110000);
	asm volatile("unimp");
	return 0;
}