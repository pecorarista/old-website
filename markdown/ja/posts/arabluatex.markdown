これは [TeX & LaTeX Advent Calendar](http://www.adventar.org/calendars/1734){target="\_blank"} 12 日目の記事です。

趣味で語学・言語学をやっていると、
左横書き以外の書字方向の表記体系を使う場面が多くあります。
そのような場面において LaTeX は非常に有効です。
以下で、どのように有効なのか、そして実際にどのように使っていくのかについて、
右横書きを中心に見ていきたいと思います。

## 書字方向の種類と LaTeX での扱い

本題に入る前に、書字方向一般について書きたくなったので書いておきます。
書字方向には例えば以下のようなものがあります。

1. __（下の行に移る）左横書き__  
    ラテン文字や日本語の横書きなど、多くの言語で採用されている書字方向です。
    左横書きと呼ぶと「左から進んで来る」なのか「左に進んで行く」なのか紛らわしいので、
    代わりに英語の略称で __LTR__ (Left-to-Right) と呼んでいきます。

    ![ltr](/public/img/ltr.jpg){class="centered-image" style="max-width: 300px;"}

    Babel/Polyglossia

2. __（下の行に移る）右横書き__  
    アラビア文字やヘブライ文字などで使われています。
    上と同様に __RTL__ (Right-to-Left) と呼んでいきます。  

    ![rtl](/public/img/rtl.jpg){class="centered-image" style="max-width: 300px;"}

3. __上から下、右の列から左の列へ移る縦書き__  
    日本語や中国語を縦書きしたときの書法です。

    ![tbrl](/public/img/tbrl.jpg){class="centered-image" style="max-height: 300px;"}

4. 上から下、左の列から右の列へ移る縦書き  
    モンゴル文字などがこれに該当します。
    書けないので Wikimedia commons の画像を貼っておきます。

5. __[牛耕式 (βουστροφηδόν)](https://ja.wikipedia.org/wiki/%E7%89%9B%E8%80%95%E5%BC%8F)__  
    古代ギリシャ文字で使われていた書字方向です。
    左から右に進み、端にたどり着いたら、今度は下の行に移り、
    左右反転させた文字を右から左に書いていく書法です。
    その様子が牛車で畑を耕す様子に似ているため名付けられました。

     ![boustrophedon](/public/img/boustrophedon.jpg){class="centered-image" style="max-width: 300px;"}

     LaTeX において牛耕式を扱う方法については、以下の記事が非常に参考になります。

     + [アセトアミノフェンの気ままな日常 – 牛耕式とロンゴロンゴ](http://d.hatena.ne.jp/acetaminophen/20150724/1437743800){target="\_blank"}


## RTL のテキストを編集する方法について

最近のデスクトップ環境は、Unicode への対応やフォントが進み、
アラビア文字やヘブライ文字を打ち込んでも、その文字が出力されるようになりました。

ただし、個々の文字が独立したヘブライ文字ならまだしも、
エディタ
アラビア文字を直接入力して編集するのは 2016 年の現在であっても、
なかなかよい方法はなさそうです。
MS Word は

+ アラビア語初学者は
+ キーボード入力するときキーの配置を覚えるのが大変

絵を貼る

そこで LaTeX の出番です。LaTeX は MS Word などと違って、
WYSIWYG (what you see is what you get) ではありません。

## LaTeX

```language-latex
\hello
```

## LuaLaTeX

```language-latex

```

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
