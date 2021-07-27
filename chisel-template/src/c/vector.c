#include <stdio.h>

int main()
{
	unsigned int size = 5; // 計算したい要素数
	unsigned int x[] = {
			0x4b1a3f43,
			0x4b1a3f44,
			0x4b1a3f45,
			0x4b1a3f46,
			0x4b1a3f47};

	int *xp = x;
	unsigned int y[] = {
			0x272d3e3c,
			0x272d3e4c,
			0x272d3e5c,
			0x272d3e6c,
			0x272d3e7c};
	int *yp = y;
	unsigned int z[size];
	int *zp = z;

	/*
	計算結果はあってる
	1週目
	X = 4B1A3F46 4B1A3F45 4B1A3F44 4B1A3F43
	Y = 272D3E6C 272D3E5C 272D3E4C 272D3E3C
	Z = 72477db2 72477da1 72477d90 72477d7f
	2週目
	X = 0x4b1a3f47
	Y = 0x272d3e7c
	Z = 72477dc3
	*/

	/*
		a0 = size;
		a1 = x address;
		a2 = y address;
		a3 = z address
	*/
	asm volatile("loop:");

	asm volatile("vsetvli t0, %0, e32, m1" ::"r"(size)); // 実際に計算される要素数vlがt0に格納される

	// 計算したい要素数sizeをデクリメント
	asm volatile("sub %0, %1, t0"
							 : "=r"(size)
							 : "r"(size));

	asm volatile("slli t0, t0, 2"); // ポインタの進める量

	asm volatile("vle32.v v1,(%0)" ::"r"(xp));
	asm volatile("add %0, %1, t0"
							 : "=r"(xp)
							 : "r"(xp)); // xポインタを進める

	asm volatile("vle32.v v2,(%0)" ::"r"(yp));
	asm volatile("add %0, %1 ,t0"
							 : "=r"(yp)
							 : "r"(yp)); // yポインタを進める

	// ベクトル演算
	asm volatile("vadd.vv v3,v2,v1");

	// 結果のstore
	asm volatile("vse32.v v3,(%0)" ::"r"(zp));

	// 再ロードして検算
	asm volatile("vle32.v v4,(%0)" ::"r"(zp));

	// zポインタを進める
	asm volatile("add %0, %1 ,t0"
							 : "=r"(zp)
							 : "r"(zp));

	// 計算したい要素数size=0になったら、終了
	asm volatile("bnez %0, loop" ::"r"(size));
	asm volatile("unimp");
	return 0;
}