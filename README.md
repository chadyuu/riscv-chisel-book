[English](README.md) | [日本語](README.ja.md)

# An educational open-source CPU implemented with RISC-V and Chisel

This CPU implementation aims to help you learn the CPU architecture, RISC-V (an open-source instruction set architecture developed at UC Berkeley), and Chisel (a Scala Embedded Language), mainly guided by the publication ["CPU Design with RISC-V and Chisel - First step to custom CPU implementation with open-source ISA."](https://www.amazon.co.jp/dp/4297123053/
)

![cover](https://user-images.githubusercontent.com/8579255/130305929-17113e1b-c9e7-4e51-8213-7238a140c01a.jpg)

The publication covers
- the basics of computer architecture
- RISC-V implementation with Chisel
	- Base Integer Instruction Set
	- CSR
	- Instruction pipelining
	- V Vector extension
	- Custom Instruction (e.g., Population Count)
	- riscv-tests

## Getting Started

1. Clone this repo.
	
	```
	git clone https://github.com/chadyuu/riscv-chisel-book.git
	```

2. Build the Docker image.

	Recommended to install the Docker image from [Docker Hub](https://hub.docker.com/repository/docker/yutaronishiyama/riscv-chisel-book).

	```
	docker pull yutaronishiyama/riscv-chisel-book
	```

	Or build the image from Dockerfile.
	```
	docker build . -t yutaronishiyama/riscv-chisel-book
	```

3. Run the image.

	```
	docker run -it -v $PWD/riscv-chisel-book:/src yutaronishiyama/riscv-chisel-book
	```

## Implementation Steps

1. Set constants

	- [Consts.scala](https://github.com/chadyuu/riscv-chisel-book/blob/master/chisel-template/src/main/scala/common/Consts.scala)
	- [Instructions.scala](https://github.com/chadyuu/riscv-chisel-book/blob/master/chisel-template/src/main/scala/common/Instructions.scala)

2. [Instruction Fetch](https://github.com/chadyuu/riscv-chisel-book/tree/master/chisel-template/src/main/scala/01_fetch)

3. [Instruction Decode](https://github.com/chadyuu/riscv-chisel-book/tree/master/chisel-template/src/main/scala/02_decode)

4. [Load Instruction](https://github.com/chadyuu/riscv-chisel-book/tree/master/chisel-template/src/main/scala/03_lw)

5. [Store Instruction](https://github.com/chadyuu/riscv-chisel-book/tree/master/chisel-template/src/main/scala/04_sw)

6. [Base Instructions & riscv-tests](https://github.com/chadyuu/riscv-chisel-book/tree/master/chisel-template/src/main/scala/05_riscvtests)

	Below are the steps to run riscv-tests.

	1. Update `link.ld`

	```
	$ vim /opt/riscv/riscv-tests/env/p/link.ld
	SECTIONS
	{
		. = 0x00000000; // update "0x80000000"
	}
	```

	2. Build riscv-tests.

	```
	cd /opt/riscv/riscv-tests
	autoconf
	./configure --prefix=/src/target
	make
	make install
	```

	3. Generate Hex files of riscv-tests.

	```
	cd /src/chisel-template/src/shell
	./tohex.sh
	```

	4. Execute riscv-tests

	```
	cd /src/chisel-template/src/shell
	./riscv_tests.sh riscvtests 05_RiscvTests
	```

7. [Pipelining](https://github.com/chadyuu/riscv-chisel-book/tree/master/chisel-template/src/main/scala/09_pipeline_datahazard)

	- Control hazards
	- Data hazards

8. [V Vector extension](https://github.com/chadyuu/riscv-chisel-book/tree/master/chisel-template/src/main/scala/13_vse)

	- VSETVLI
	- Vector Load
	- Vector Add
	- Vector Store

9. [Custom Instruction "Population Count (pcnt)"](https://github.com/chadyuu/riscv-chisel-book/tree/master/chisel-template/src/main/scala/14_pcnt)

	1. Add "pcnt" to GNU Assembler.

		/opt/riscv/riscv-gnu-toolchain/riscv-binutils/opcodes/riscv-opc.c
		```
		#include "opcode/riscv.h"
		...
		const struct riscv_opcode riscv_opcodes[] =
		{
		...
		/* name, xlen, isa, operands, match, mask, match_func, pinfo */
		{"pcnt", 0, INSN_CLASS_I, "d,s", MATCH_PCNT, MASK_PCNT, match_opcode, 0}, // add
		...
		}
		```

	2. Rebuild the assembler.

		```
		cd /opt/riscv/riscv-gnu-toolchain/build
		make clean
		make
		```

## ChiselTest on C programs

1. Generate a Hex file from C program

	```
	cd /src/chisel-template/src/c
	make [filename.c]
	```

2. ChiselTest on a Hex file

	```
	cd /src/chisel-template
	sbt "testOnly [package_name].HexTest"
	```

## FPGA implementation

Please see [fpga branch](https://github.com/chadyuu/riscv-chisel-book/tree/fpga) and [the documents for the security camp 2022](https://github.com/ciniml/seccamp_2022_riscv_cpu/tree/main/slide).
