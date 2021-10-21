.PHONY: all clean restore device-tree open

PROJECT_NAME := riscv_arty35
TARGET_PART ?= digilentinc.com:arty-a7-35:part0:1.0
BD_NAME := design_top
BITSTREAM := project/$(PROJECT_NAME).runs/impl_1/$(BD_NAME)_wrapper.bit
BITSTREAM_BIN := $(BD_NAME)_wrapper.bit.bin
SDK_DIR := project/$(PROJECT_NAME).sdk
HARDWARE_DEF := $(SDK_DIR)/$(BD_NAME)_wrapper.xsa

BASH := /bin/bash
RISCV_CORE_DIR := ../../chisel-template/rtl/riscv
VIVADO ?= vivado
HSI ?= hsi
BOOTGEN ?= bootgen

SRCS := \
	src/riscv.v  \
	src/top.sv  \
	src/top_vivado.v \
	src/pins.xdc \
	src/debug.xdc \

all: $(HARDWARE_DEF)

restore: project/$(PROJECT_NAME).xpr

clean:
	-@rm -rf project
	-@rm *.jou *.str *.btree *.log

open: project/$(PROJECT_NAME).xpr
	$(VIVADO) $<&

project/$(PROJECT_NAME).xpr: $(SRCS)
	$(VIVADO) -mode batch -source restore_project.tcl -tclargs $(PROJECT_NAME) ${BD_NAME} ${TARGET_PART}

$(BITSTREAM) $(HARDWARE_DEF): project/$(PROJECT_NAME).xpr $(SRCS) project/$(PROJECT_NAME).srcs/sources_1/bd/$(BD_NAME)/$(BD_NAME).bd
	$(VIVADO) -mode batch -source implement.tcl -tclargs $(PROJECT_NAME) $(BD_NAME)
