#include <stdio.h>

int main()
{
	unsigned int size = 5; // 計算したい要素数

	unsigned int x[] = {
			0x11111111,
			0x22222222,
			0x33333333,
			0x44444444,
			0x55555555};
	unsigned int *xp = x;

	unsigned int vl;

	while (size > 0)
	{
		// 実際に計算される要素数vlを格納
		asm volatile("vsetvli %0, %1, e32, m1"
								 : "=r"(vl)
								 : "r"(size));

		// 計算したい要素数sizeをデクリメント
		size -= vl;

		// VLE32.V
		asm volatile("vle32.v v1,(%0)" ::"r"(xp));
		xp += vl; // ポインタの指す型のサイズが1単位に相当。今回は[int型サイズ × vl]分。
	}

	asm volatile("unimp");
	return 0;
}