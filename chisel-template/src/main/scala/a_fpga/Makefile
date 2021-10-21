.PHONY: all clean

CC = riscv64-unknown-elf-gcc
OBJDUMP = riscv64-unknown-elf-objdump
OBJCOPY = riscv64-unknown-elf-objcopy
CFLAGS = -mabi=ilp32 -march=rv32i -Os -g
LDFLAGS = -Wl,-Tlink.ld -nostartfiles 

OBJS := bootrom.o

all: bootrom.bin bootrom.hex bootrom.dump

bootrom.elf: $(OBJS) link.ld
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJS)

%.o: %.c
	$(CC) -c -o $@ $(CFLAGS) $<

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@

%.hex: %.bin
	od -An -tx4 -w4 -v $< > $@
%.dump: %.elf
	$(OBJDUMP) -dSC $< > $@

clean:
	-@$(RM) *.o *.elf *.bin *.hex