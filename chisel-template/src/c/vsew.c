#include <stdio.h>

int main()
{
	unsigned int size = 11; // 計算したい要素数
	unsigned short x[] = {
			0x3f43,
			0x3f44,
			0x3f45,
			0x3f46,
			0x3f47,
			0x3f48,
			0x3f49,
			0x3f4a,
			0x3f4b,
			0x3f4c,
			0x3f4d};
	short *xp = x;

	unsigned short y[] = {
			0x3e3c,
			0x3e4c,
			0x3e5c,
			0x3e6c,
			0x3e7c,
			0x3e8c,
			0x3e9c,
			0x3eac,
			0x3ebc,
			0x3ecc,
			0x3edc};
	short *yp = y;

	unsigned short z[size];
	short *zp = z;
	/*
	7df6 7de5 7dd4 7dc3 7db2 7da1 7d90 7d7f
	7e29 7e18 7e07
	*/

	asm volatile("loop:");

	asm volatile("vsetvli t0, %0, e16, m1" ::"r"(size)); // 実際に計算される要素数vlがt0に格納される

	// 計算したい要素数sizeをデクリメント
	asm volatile("sub %0, %1, t0"
							 : "=r"(size)
							 : "r"(size));

	// ポインタの進める量(1要素2byteのため、ポインタの進める量は計算要素数*2)
	asm volatile("slli t0, t0, 1");

	// VLE32.V
	asm volatile("vle32.v v1,(%0)" ::"r"(xp));
	asm volatile("add %0, %1, t0"
							 : "=r"(xp)
							 : "r"(xp)); // xポインタを進める

	asm volatile("vle32.v v2,(%0)" ::"r"(yp));
	asm volatile("add %0, %1 ,t0"
							 : "=r"(yp)
							 : "r"(yp)); // yポインタを進める

	asm volatile("vadd.vv v3,v2,v1");
	asm volatile("vse32.v v3,(%0)" ::"r"(zp));
	asm volatile("add %0, %1 ,t0"
							 : "=r"(zp)
							 : "r"(zp)); // zポインタを進める

	// 計算したい要素数size=0になったら、終了
	asm volatile("bnez %0, loop" ::"r"(size));
	asm volatile("unimp");
	return 0;
}