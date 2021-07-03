Diffraction Simulator
=====================

Diffraction Simulator は 2次元回折シミュレーターです。（もっと良い名前考えなきゃ）

動作環境
========
[Processing](https://processing.org) が必要です。

使い方
======
diffraction.zip を diffraction フォルダに展開後、Processing で diffraction.pde を開き、実行して下さい。

左側のパネルには散乱体のパターンが表示されます（プログラムは輝度だけを読み取りますので色相は関係ありません）。右側のパネルには2次元フーリエ変換によって計算された、フラウンホーファー回折のパターンが表示されます。

左クリックで次のパターンを表示し、右クリックで前のパターンに踊ります。矢印キーを使ってパターンを制御できる場合には、"Control:↑↓←→"などの表示によって示されます。

Note
====
データファイルを作成することで、オリジナルの散乱体パターンを作成することが可能です。データファイルの文法についてはsyntax.ja.mdをご覧下さい。またデータファイルは data/datalist.txt に登録する必要があります。

またこのプログラムを利用したことによるいかなる損害も補償いたしません。ご了承ください。

Author
======
Sinagire (sinagire.k@gmail.com)

ライセンス
==========
このプログラムは MIT license を採用しております。