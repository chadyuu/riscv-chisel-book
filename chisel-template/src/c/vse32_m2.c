#include <stdio.h>

int main()
{
	unsigned int size = 10; // 計算したい要素数

	unsigned int x[] = {
			0x11111111,
			0x22222222,
			0x33333333,
			0x44444444,
			0x55555555,
			0x66666666,
			0x77777777,
			0x88888888,
			0x99999999,
			0xaaaaaaaa};
	unsigned int *xp = x;

	unsigned int y[] = {
			0xbbbbbbbb,
			0xcccccccc,
			0xdddddddd,
			0xeeeeeeee,
			0xffffffff,
			0x11111111,
			0x22222222,
			0x33333333,
			0x44444444,
			0x55555555};
	unsigned int *yp = y;

	unsigned int z[size];
	unsigned int *zp = z;

	unsigned int vl;

	while (size > 0)
	{
		asm volatile("vsetvli %0, %1, e32, m2"
								 : "=r"(vl)
								 : "r"(size));

		size -= vl;

		asm volatile("vle32.v v2,(%0)" ::"r"(xp));
		xp += vl;

		asm volatile("vle32.v v4,(%0)" ::"r"(yp));
		yp += vl;

		asm volatile("vadd.vv v6,v4,v2");

		asm volatile("vse32.v v6,(%0)" ::"r"(zp));
		asm volatile("vle32.v v8,(%0)" ::"r"(zp)); // 検算
		zp += vl;
	}

	asm volatile("unimp");
	return 0;
}