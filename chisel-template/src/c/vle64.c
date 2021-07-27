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

	unsigned int vl;

	while (size > 0)
	{
		// 実際に計算される要素数vlを格納
		asm volatile("vsetvli %0, %1, e64, m1"
								 : "=r"(vl)
								 : "r"(size));

		// 計算したい要素数sizeをデクリメント
		size -= vl;

		asm volatile("vle64.v v1,(%0)" ::"r"(xp));
		xp += vl;
	}

	asm volatile("unimp");
	return 0;
}