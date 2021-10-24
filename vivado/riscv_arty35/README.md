# Arty-A7向けVivadoプロジェクト

## 概要

Digilent Arty-A7向けのVivadoプロジェクトです。 FPGA実装版のRISC-Vコアを動かすことができます。

## 必要なもの

* Digilent Arty-A7
    * Arty-A7-35, Arty-A7-100 のいずれか
* Vivado 2020.2
* RISC-V用GCC
    * CPUで実行するプログラムのビルドに必要
    * dockerを使ってビルドすることも可能

## 使い方

VivadoおよびRISC-V GCCにパスが通っている状態で `make all` を実行すると、 `project/impl/riscv_arty35.runs/impl_1/design_top.bit` が生成される。
デフォルトではArty-A7-35向けのビットストリームを生成するが、`ARTY_SIZE=100 make all` とすると、Arty-A7-100向けのビットストリームを生成できる。

