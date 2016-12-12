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

    ![](/public/img/ltr.jpg){class="centered-image" style="max-width: 300px;"}

2. __（下の行に移る）右横書き__  
    アラビア文字やヘブライ文字などで使われています。
    上と同様に __RTL__ (Right-to-Left) と呼んでいきます。
    日本語の文書でも左横書きが普及する前に使われていたことがあります。
    LaTeX での扱いは次節以降で説明します。

    ![](/public/img/rtl.jpg){alt="Right-to-Left" class="centered-image" style="max-width: 300px;"}


3. __上から下、右の列から左の列へ移る縦書き__  
    日本語や中国語を縦書きしたときの書法です。
    __TBRL__ (top-to-down, right-to-left) と呼ばれることがあります。

     ![](/public/img/tbrl.jpg){alt="Top-to-Down, Right-to-Left" class="centered-image" style="max-height: 300px;"}

    日本語が TBRL なので LaTeX における TBRL を説明した日本語の資料はたくさん見つかります。

    + [TeX Wiki – pTeX と多言語処理](https://texwiki.texjp.org/?pTeX%E3%81%A8%E5%A4%9A%E8%A8%80%E8%AA%9E%E5%87%A6%E7%90%86#cjkinqd){target="\_blank"}
    + [縦書きしてみよう](http://www.fugenji.org/~thomas/texlive-guide/vertical.html){target="\_blank"}


4. __上から下、左の列から右の列へ移る縦書き__  
    モンゴル文字やソグド文字などがこれに該当します。
    モンゴル文字については [MonTeX](https://www.ctan.org/pkg/montex){target="\_blank"} というものがあるようですが、全く知識がないので説明は割愛します。

5. __[牛耕式 (βουστροφηδόν)](https://ja.wikipedia.org/wiki/%E7%89%9B%E8%80%95%E5%BC%8F)__  
    古代ギリシャ文字の碑文などに使われていた書字方向です。
    左から右に進み、右端にたどり着いたら、今度は下の行に移り、
    左右反転させた文字を右から左に書いていく書法です。
    その様子が牛車で畑を耕す様子に似ているため名付けられました。

     ![](/public/img/boustrophedon.jpg){alt="Boustrophedon" class="centered-image" style="max-width: 300px;"}

    LaTeX において牛耕式を扱う方法については、以下の記事が参考になります。

     + [アセトアミノフェンの気ままな日常 – 牛耕式とロンゴロンゴ](http://d.hatena.ne.jp/acetaminophen/20150724/1437743800){target="\_blank"}

## RTL のテキストを編集する方法について

最近のデスクトップ環境は、Unicode への対応やフォントの普及が進み、
アラビア文字やヘブライ文字を打ち込んでも、その文字が出力されるようになりました。
例えば __MS Word__ では書字方向を切り替える機能を使ってアラビア文字の混じった文書を作成できます。

![word-arabic](/public/img/word-arabic.png){alt="Arabic in MS Word" class="centered-image" style="max-width: 500px;"}

少し厄介な点は、__行ごとに書字方向を切り替えなければならない__、ということです。
もちろん可読性の観点から同一の行内に LTR/RTL が入り乱れているのはよくないと思いますが、
語学のテキストではそれをせざるを得ません。
__もし混ぜて書いてしまうとピリオドの位置がおかしくなります__。
これはピリオドはラテン文字などと共通したものを使っているからです。
もうひとつの問題は__カーソルの移動がわかりにくくなる__ことです。
例えばアラビア文字の上で [→] を押すと左に移動します。

MS Word を使わずエディタで編集するという方法もあります。
そこで生じる問題は、__環境によっては合字が正しく表示されず、
また文字どうしが重なり合って非常に見にくい__ということです。
広く使われている Gnome ターミナルは、まだアラビア文字の合字に対応していないのです。

![word-arabic](/public/img/terminal-arabic.png){alt="Arabic in Terminal" class="centered-image" style="max-width: 100%;"}

解決方法のひとつは Vim の GUI 版である GVim を使うことです。
これについては[別の記事](/ja/type-arabic.html)で書きましたので興味があればご覧ください。

またどの編集用ソフトを使ったとしても、直接アラビア文字を入力すると、
__キーボード入力のためにキーの配置を覚えるのが大変__という問題もあります。
本格的にアラビア語やヘブライ語を勉強している人は、
ブラウザなどに直接入力する過程で覚えていくでしょうが、
初学者やとりあえず使いたい人にとっては覚えることが多くて大変なのは事実です。

## LaTeX の利用

アラビア語に精通している人の可読性や検索利便性を考えると、
アラビア語を直接入力するほうが好ましいでしょう。
しかし前節で述べたような問題が生じる以上、
__もしラテン文字転写を変換できる機構があるならばそれを使うほうが現実的__だと考えています。
LaTeX にはアラビア文字を扱う [ArabTeX](https://www.ctan.org/pkg/arabtex){target="\_blank"}
というパッケージがあります。
これはアラビア語モード内で入力されたラテン文字を、
以下のようなルールに従ってアラビア文字で出力するものです。
おおまかに言うと、アンダースコア (\_) が摩擦音化、ピリオド (.) が咽頭化を表しています。
これは [Hans Wehr](https://archive.org/details/Dict_Wehr.pdf){target="\_blank"} などの辞書で使われる転記法にヒントを得たものでしょう。

<table>
<tr><th>Input</th><th>Wehr</th><th>Output</th></tr>
<tbody>
<tr><td>`a`</td><td>a</td><td>ا</td></tr>
<tr><td>`b`</td><td>b</td><td>ب</td></tr>
<tr><td>`t`</td><td>t</td><td>ت</td></tr>
<tr><td>`_t`</td><td>ṯ</td><td>ث</td></tr>
<tr><td>`^g` or `j`</td><td>ǧ</td><td>ج</td></tr>
<tr><td>`.h`</td><td>ḥ</td><td>ح</td></tr>
<tr><td>`_h` or `x`</td><td>ḫ</td><td>خ</td></tr>
<tr><td>`r`</td><td>r</td><td>ر</td></tr>
<tr><td>`d`</td><td>d</td><td>د</td></tr>
<tr><td>`_d`</td><td>ذ</td><td>ḏ</td></tr>
<tr><td>`s`</td><td>s</td><td>س</td></tr>
<tr><td>`^s`</td><td>š</td><td>ش</td></tr>
<tr><td>`.s`</td><td>ṣ</td><td>ص</td></tr>
<tr><td>`.d`</td><td>ḍ</td><td>ض</td></tr>
<tr><td>`.t`</td><td>ṭ</td><td>ط </td></tr>
<tr><td>`.z`</td><td>ẓ</td><td>ظ</td></tr>
<tr><td><code>\`</code></td><td>‘</td><td>ع</td></tr>
<tr><td>`.g`</td><td>ḡ</td><td>غ</td></tr>
<tr><td>`f`</td><td>f</td><td>ف</td></tr>
<tr><td>`q`</td><td>q</td><td>ق</td></tr>
<tr><td>`k`</td><td>k</td><td>ك</td></tr>
<tr><td>`l`</td><td>l</td><td>ل</td></tr>
<tr><td>`m`</td><td>m</td><td>م</td></tr>
<tr><td>`n`</td><td>n</td><td>ن</td></tr>
<tr><td>`h`</td><td>h</td><td>ه</td></tr>
<tr><td>`w`</td><td>w</td><td>و</td></tr>
<tr><td>`y`</td><td>y</td><td>ي</td></tr>
<tr><td>`T`</td><td>a</td><td>ة</td></tr>
</tbody>
</table>

また ArabTeX は__アラビア語で使うアラビア文字に限らず、ペルシア語やウルドゥー語など
アラビア語の文字を拡張した文字を使う言語にも対応しています__。
さらに__ヘブライ語モード__というのもあり、ヘブライ語もラテン字で入力できます。

### ArabLuaTeX

私は普段 LuaTeX を使うことが多いので、
ArabTeX の LuaTeX 対応版にあたる ArabLuaTeX を使うことが多いです。
Fontspec が使えるので、いろいろなフォントを試したりする場合はこちらが便利です。
ArabTeX と比べてまだ実装されていない機能が多いのですが、
アラビア語の範囲では問題ないと思います。

<div class="pdf-wrapper" style="margin-bottom: 20px;">
<div class="pdf-iframe">
<iframe src="/pdf.js/web/viewer.html?file=/assets/pdf/arabluatex-example.pdf#zoom=page-fit"></iframe>
</div>
</div >

```language-latex
\documentclass[usepdftitle=false]{beamer}
\usetheme{metropolis}
\usepackage{fontspec}
\usepackage{arabluatex}
\newfontfamily\arabicfont{Amiri}[%
    Script=Arabic,     % enable ligatures
    RawFeature={+anum, % use eastern arabic numerals
    +ss05}]            % put kasrah below shadda
\newfontfamily\translitfont{Linux Libertine O}[Ligatures=TeX]
\SetTranslitFont{\translitfont}
\SetTranslitStyle{\upshape}
\SetTranslitConvention{dmg} % `loc` or `dmg`
\usepackage[hiragino-pron,deluxe,expert]{luatexja-preset}
\renewcommand{\kanjifamilydefault}{\gtdefault}
\hypersetup{%
    unicode=true,
    backref=true,
    hidelinks=true,
    pdfinfo={%
        Title={アラビア文字},
        Author={アラビア太郎},
    }
}
\title{アラビア文字}
\author{アラビア太郎}
\begin{document}

\begin{frame}
\frametitle{おはよう}
アラビア語で「おはよう」は \arb[fullvoc]{.sabA.hu 'l-xayri} と言います。
発音は\arb[trans]{.sabA.hu 'l-xayri}です。
返答するときは例えば「光の朝」 \arb[fullvoc]{.sabA.hu 'l-nUri} と答えます。
発音は\arb[trans]{.sabA.hu 'l-nUri}です。

\bigskip

転記方法は\texttt{dmg} (Deutsche Morgenländische Gesellschaft)と
\texttt{loc} (Liberty of Congress)のほうがあります。
前者はダイアクリティカルマークを多く使い、
後者はそれをあまり使いません。
この文書は\texttt{dmg}で作っています。
\end{frame}

\end{document}
```

「LaTeX だとアラビア文字の入力も簡単」みたいな流れで
話を進めてきていて、いまさらこんなことを言うのは申し訳ないのですが、
上のように通常の表記では省略されている母音を自分で補える人でないと
ArabTeX (ArabLuaTeX) を扱うのは少し難しいかもしれません…。

### 日本語でも RTL をやってみる

ArabLuaTeX の中身を見るとわかりますが、
`\textdir TRT` で囲まれている部分が RTL になります。
これを使えば RTL で日本語が書けるので、少し遊んでみました。

<div class="pdf-wrapper" style="margin-bottom: 20px;">
<div class="pdf-iframe">
<iframe src="/pdf.js/web/viewer.html?file=/assets/pdf/rtl-japanese#zoom=page-fit"></iframe>
</div>
</div >

```language-latex
\documentclass[usepdftitle=false]{beamer}
\usetheme{metropolis}
\usepackage[hiragino-pron,deluxe,expert]{luatexja-preset}
\hypersetup{%
    unicode=true,
    backref=true,
    hidelinks=true,
    pdfinfo={%
        Title={右横書き},
        Author={右横書き太郎},
    }
}
\renewcommand{\kanjifamilydefault}{\gtdefault}
\newcommand\RTL[1]{\begingroup\textdir TRT #1\endgroup}
\begin{document}
\begin{frame}
\frametitle{RTL}
「\RTL{これってもしかして}」

「\RTL{書字方向が}」

「\RTL{入れ替わってる！？}」

鉤括弧は工夫したほうがよさそうですね。
\end{frame}
\end{document}
```

## まとめ

RTL の文字の混じった文書を作るときに問題になるのは以下のような点でした。

+ 行ごとに書字方向を切り替えなければならない
+ 同一行内で混ぜて書くとピリオドの位置がおかしくなる
+ カーソルの移動がわかりにくい
+ 環境によっては文字が正しく表示されない
+ キー配列を覚えるのが大変

ArabTeX や ArabLuaTeX はこれらの問題を解決します。
ただしラテン字を使う都合上、以下のような問題もあることに注意してください。

+ 母音を補って書かないといけない
+ 表示したいものの原文があってもコピペしただけでは表示できない
