#include <stdio.h>

int main()
{
	unsigned int size = 11; // 計算したい要素数
	unsigned int x[] = {
			0x4b1a3f43,
			0x4b1a3f44,
			0x4b1a3f45,
			0x4b1a3f46,
			0x4b1a3f47,
			0x4b1a3f48,
			0x4b1a3f49,
			0x4b1a3f4a,
			0x4b1a3f4b,
			0x4b1a3f4c,
			0x4b1a3f4d};

	int *xp = x;
	unsigned int y[] = {
			0x272d3e3c,
			0x272d3e4c,
			0x272d3e5c,
			0x272d3e6c,
			0x272d3e7c,
			0x272d3e8c,
			0x272d3e9c,
			0x272d3eac,
			0x272d3ebc,
			0x272d3ecc,
			0x272d3edc};
	int *yp = y;
	unsigned int z[size];
	int *zp = z;

	asm volatile("loop:");

	asm volatile("vsetvli t0, %0, e32, m2" ::"r"(size)); // 実際に計算される要素数vlがt0に格納される

	// 計算したい要素数sizeをデクリメント
	asm volatile("sub %0, %1, t0"
							 : "=r"(size)
							 : "r"(size));

	// ポインタの進める量
	asm volatile("slli t0, t0, 2");

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