これは [TeX & LaTeX Advent Calendar](http://www.adventar.org/calendars/1734){target="\_blank"} 12 日目の記事です。

趣味で語学・言語学をやっていると、
左横書き以外の書字方向の表記体系を使う場面が多くあります。
そのような場面において LaTeX は非常に有効です。
以下で、どのように有効なのか、そして実際にどのように使っていくのかについて、
右横書きを中心に見ていきたいと思います。

## 書字方向の種類

本題に入る前に、書字方向一般について書きたくなったので書いておきます。
書字方向には例えば以下のようなものがあります。

1. __（下の行に移る）左横書き__  
    ラテン文字や日本語の横書きなど、多くの言語で採用されている書字方向です。
    左横書きと呼ぶと「左から進んで来る」なのか「左に進んで行く」なのか紛らわしいので、
    代わりに英語の略称で __LTR__ (Left-to-Right) と呼んでいきます。
    LaTeX では [Babel](https://www.ctan.org/pkg/babel){target="\_blank"} あるいはその後継の
    [Polyglossia](https://www.ctan.org/pkg/polyglossia){target="\_blank"} を使えば多くの
    LTR の文字（正確には言語）の組版が可能です。

    ![ltr](/public/img/ltr.jpg){class="centered-image" style="max-width: 300px;"}

2. __（下の行に移る）右横書き__  
    アラビア文字やヘブライ文字などで使われています。
    上と同様に __RTL__ (Right-to-Left) と呼んでいきます。
    日本語の文書でも左横書きが普及する前に使われていたことがあります。
    LaTeX での扱いは次節以降で説明します。

    ![rtl](/public/img/rtl.jpg){class="centered-image" style="max-width: 300px;"}

3. __上から下、右の列から左の列へ移る縦書き__  
    日本語や中国語を縦書きしたときの書法です。
    __TBRL__ (top-to-down, right-to-left) と呼ばれることがあります。
    日本語が TBRL なので LaTeX における TBRL を説明した日本語の資料はたくさん見つかります。

    + [TeX Wiki – pTeX と多言語処理](https://texwiki.texjp.org/?pTeX%E3%81%A8%E5%A4%9A%E8%A8%80%E8%AA%9E%E5%87%A6%E7%90%86#cjkinqd){target="\_blank"}
    + [縦書きしてみよう](http://www.fugenji.org/~thomas/texlive-guide/vertical.html){target="\_blank"}

4. __上から下、左の列から右の列へ移る縦書き__  
    モンゴル文字やソグド文字などがこれに該当します。
    モンゴル文字については [MonTeX](https://www.ctan.org/pkg/montex){target="\_blank"} というものがあるようですが、全く知識がないので割愛します。

5. __[牛耕式 (βουστροφηδόν)](https://ja.wikipedia.org/wiki/%E7%89%9B%E8%80%95%E5%BC%8F)__  
    古代ギリシャ文字の碑文などに使われていた書字方向です。
    左から右に進み、端にたどり着いたら、今度は下の行に移り、
    左右反転させた文字を右から左に書いていく書法です。
    その様子が牛車で畑を耕す様子に似ているため名付けられました。

     ![boustrophedon](/public/img/boustrophedon.jpg){class="centered-image" style="max-width: 300px;"}

     LaTeX において牛耕式を扱う方法については、以下の記事が参考になります。

     + [アセトアミノフェンの気ままな日常 – 牛耕式とロンゴロンゴ](http://d.hatena.ne.jp/acetaminophen/20150724/1437743800){target="\_blank"}

## RTL のテキストを編集する方法について

最近のデスクトップ環境は、Unicode への対応やフォントの普及が進み、
アラビア文字やヘブライ文字を打ち込んでも、その文字が出力されるようになりました。
例えば __MS Word__ では書字方向を切り替える機能を使ってアラビア文字の混じった文書を作成できます。

![word-arabic](/public/img/word-arabic.png){class="centered-image" style="max-width: 500px;"}

少し厄介な点は、__行ごとに書字方向を切り替えなければならない__、ということです。
もちろん可読性の観点から同一の行内に LTR/RTL が入り乱れているのはよくないと思いますが、
語学のテキストではそれをせざるを得ません。
__もし混ぜて書いてしまうとピリオドの位置がおかしくなります__。
これはピリオドはラテン文字などと共通したものを使っているからです。
もうひとつの問題は__カーソルの移動がわかりにくくなる__ことです。
例えばアラビア文字の上で [→] を押すと左に移動します。

MS Word を使わずエディタで編集するという方法もあります。
そこで生じる問題は、__環境によっては合字が正しくされず、
また文字どうしが重なり合って非常に見にくい__ということです。
広く使われている Gnome ターミナルは、まだアラビア文字の合字に対応していないのです。

![word-arabic](/public/img/terminal-arabic.png){class="centered-image" style="max-width: 100%;"}

解決方法のひとつは Vim の GUI 版である GVim を使うことです。
これについては[別の記事](/ja/type-arabic.html)で書きましたので興味があればご覧ください。

またどの編集用ソフトを使ったとしても、直接アラビア文字を入力すると、
__キーボード入力のためにキーの配置を覚えるのが大変__という問題もあります。
本格的にアラビア語やヘブライ語を勉強している人は、
ブラウザなどに直接入力する過程で覚えていくでしょうが、
初学者やとりあえず使いたい人にとっては覚えることが多くて大変になのは事実です。

## LaTeX の利用

アラビア文字を直接入力するほうが検索や、
アラビア語に精通している人の可読性のためには好ましいでしょう。
しかし前節で述べたような問題が生じる以上、
__ラテン文字転写を変換できる機構がある限りそれを使うほうが現実的__だと考えています。
アラビア文字については ArabTeX や ArabLuaTeX という素晴らしい環境がありますので、
それを利用する方法を以下で説明していきたいと思います。

### ArabTeX

```language-latex
\hello
```

### ArabLuaTeX

```language-latex
\documentclass[12pt]{article}
\usepackage{fontspec}
\usepackage{arabluatex}
\setmainfont{Linux Libertine O}[Ligatures=TeX]
\newfontfamily\arabicfont{Amiri}[%
    Script=Arabic,     % enable ligatures
    RawFeature={+anum, % use eastern arabic numerals
    +ss05}]            % put kasrah below shadda
\newfontfamily\translitfont{FreeSerif}[Ligatures=TeX]
\SetTranslitFont{\translitfont}
\SetTranslitStyle{\upshape}
\SetTranslitConvention{dmg} % `loc` or `dmg`
\usepackage{gb4e,cgloss4e}
\noautomath
\begin{document}

\arb[fullvoc]{`indanA muta`addidaTuN min 'l-xarAy"'i.ti.}
\arb[trans]{`indanA muta`addidaTuN min 'l-xarAy"'i.ti.}

\begin{exe}
    \ex%
    \gll {`indanā} {muta`addidat\textsuperscript{{\thinspace}un}} {min} {al-ḫarā'iṭi} \\
         {with+we.1\textsc{pl}.\textsc{gen}} {multiple.\textsc{f}.\textsc{sg}.\textsc{nom}} {of} {map.\textsc{pl}.\textsc{gen}.\textsc{def}} \\
    \trans {We have multiple maps.}
\end{exe}

\end{document}
```

### 日本語でも RTL をやってみる
