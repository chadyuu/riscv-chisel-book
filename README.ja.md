[English](README.md) | [日本語](README.ja.md)

# RISC-VとChiselで学ぶ はじめてのCPU自作 ――オープンソース命令セットによるカスタムCPU実装への第一歩

![cover](https://user-images.githubusercontent.com/8579255/130305929-17113e1b-c9e7-4e51-8213-7238a140c01a.jpg)


本リポジトリは書籍「RISC-VとChiselで学ぶ はじめてのCPU自作 ――オープンソース命令セットによるカスタムCPU実装への第一歩」用です。

https://www.amazon.co.jp/dp/4297123053/

> 本書では、UCバークレーで開発されたオープンソースの命令セット(ISA)「RISC-V」を用いて、CPUの作り方を解説します。  
> コンピュータアーキテクチャ、ハードウェアに関する知識があまりない方にも理解できるように基礎からわかりやすく学んでいきます。  
> CPUとコンピュータアーキテクチャのしくみを解説したうえで、基本整数命令の実装から、CPUの高速化で活躍するパイプラインの実装、スーパーコンピューターでも活躍するベクトル拡張命令(SIMD)、さらに、汎用CPUでは負荷の高い処理をより高速に実行するためにCPUへ追加可能なカスタム命令の実装までを行います。  
> CPU設計に用いる基本言語としては、Velilogを抽象化したHDL(ハードウェア記述言語)であるChiselを利用しています。  
> CPUの自作範囲に関して、手順が煩雑なFPGAでの動作確認は行わず、ソフトウェア上でエミュレーションをゴールとしているので、ソフトウェアエンジニアの方にも取っ付きやすいものとなっています。  
> 巻末には、昨今RISC-Vが注目されている理由を整理するため、RISC-Vのもたらす価値についてまとめています。

## Docker Hub

執筆時点からの状況の変化によりDockerfileが機能しなくなる可能性があります。
その場合、著者のDocker Hubから直接イメージをダウンロードしてください。

https://hub.docker.com/repository/docker/yutaronishiyama/riscv-chisel-book

```
docker pull yutaronishiyama/riscv-chisel-book
```

## Critical Update

### [2022-05-16](https://github.com/chadyuu/riscv-chisel-book/commit/2fff54720a17c86f2e421a455ecaac3e72a294a7)
dockerfile更新。riscv/riscv-gnu-toolchain.gitのrvv-0.9.xブランチが削除されたため、書籍に掲載したdockerfileではbuildに失敗してしまいます。そのため、forkしたchadyuu/riscv-gnu-toolchain.gitのrvv-0.9.x-for-bookブランチを参照するよう変更しました。

## FPGA実装版

FPGA実装版は [fpgaブランチ](https://github.com/chadyuu/riscv-chisel-book/tree/fpga) にあります。
セキュリティ・キャンプ2022の資料は[こちら](https://github.com/ciniml/seccamp_2022_riscv_cpu/tree/main/slide)。

## FAQ

書籍内で説明していなかった部分で、質問をいただいたものについて適宜記載します。

### なぜ他のHDLではなくChiselを選んだのですか？

前提として本書はHDLや論理回路にほとんど触れたことがない人をターゲットにしています。そういった中で初めて触れるHDLとしてChiselは以下の利点があります。

1. RISC-Vの主力実装がChiselで書かれており、RISC-Vを学ぶ上では切り離せない。
2. FIRRTLのサイクル精度シミュレータ(Treadle) を内蔵しており、ChiselTestを使ってサクッとサイクル精度シミュレーションを行える。

SystemVerilogなどで書く場合、OSSのシミュレータでは言語機能のサポート状況が良くなく、厳しい制限にひっかかります。
OSSでないFPGAベンダーが提供する比較的高機能なシミュレータを使うことも可能ですが、その場合、本書は各ベンダー向けのFPGA実装を目的としていないため利用規約に抵触する可能性があります。

また、そもそもHDL初学者に合成用記述とシミュレーション用記述を説明する必要がでてくるため、本質的ではない部分で時間を取られてしまいます。

Chiselにもハードウェアモジュールの記述とChiselTestでの記述の違いはありますが、書き方として明確に分かれているので、SystemVerilogなどのHDLと比べて混乱は少ないと思います。

こういった理由から、本書では記述言語としてChiselを採用しています。
