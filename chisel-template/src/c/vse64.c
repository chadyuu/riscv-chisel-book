#include <stdio.h>

int main()
{
	unsigned int size = 5; // 計算したい要素数

	unsigned long long x[] = {
			0x1111111111111111,
			0x2222222222222222,
			0x3333333333333333,
			0x4444444444444444,
			0x5555555555555555};
	unsigned long long *xp = x;

	unsigned long long y[] = {
			0xbbbbbbbbbbbbbbbb,
			0xcccccccccccccccc,
			0xdddddddddddddddd,
			0xeeeeeeeeeeeeeeee,
			0xffffffffffffffff};
	unsigned long long *yp = y;

	unsigned long long z[size];
	unsigned long long *zp = z;

	unsigned int vl;

	while (size > 0)
	{
		asm volatile("vsetvli %0, %1, e64, m1"
								 : "=r"(vl)
								 : "r"(size));

		size -= vl;

		asm volatile("vle64.v v1,(%0)" ::"r"(xp));
		xp += vl;

		asm volatile("vle64.v v2,(%0)" ::"r"(yp));
		yp += vl;

		asm volatile("vadd.vv v3,v2,v1");

		asm volatile("vse64.v v3,(%0)" ::"r"(zp));
		asm volatile("vle64.v v4,(%0)" ::"r"(zp)); // 検算
		zp += vl;
	}

	asm volatile("unimp");
	return 0;
}