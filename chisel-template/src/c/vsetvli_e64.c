#include <stdio.h>

int main()
{
	unsigned int size = 5; // 計算したい要素数
	unsigned int vl;

	while (size > 0)
	{
		// 実際に計算される要素数vlを格納
		asm volatile("vsetvli %0, %1, e64, m1"
								 : "=r"(vl)
								 : "r"(size));

		size -= vl;

		// ここにベクトル演算が入る
	}

	asm volatile("unimp");
	return 0;
}