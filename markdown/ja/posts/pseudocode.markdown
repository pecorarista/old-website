<span class="text-muted">この記事中の PDF ファイルが表示されない場合は<a href="//github.com/pecorarista/website/tree/master/assets/pdf" target="_blank">こちら</a>から見ることができます．</span>

アルゴリズムやプログラミングに関する文書を書いているとき、擬似コードを書くことがあると思います。この記事では
LaTeX で擬似コードを書く方法と見た目を変更する方法をいくつか説明したいと思います。環境としては
LuaTeX を想定していますが、それ以外の場合でも若干の変更で動くと思います。

### 1. 主な使い方

まずは `algpseudocode` というパッケージを読み込みます。

```language-latex
\usepackage{algpseudocode}
```

以下のように挿入ソートのアルゴリズムを書いてみます。

```language-latex
\begin{algorithmic}[1]
    \Procedure{Insertion-Sort}{$A$}
        \For{$j = 2 \, \ldots \, A.\mathrm{length}$}
        \State{$k = A[j]$}
            \State{$i = j - 1$}
            \While{$i > 0$ and $A[i] > k$}
                \State{$A[i + 1] = A[i]$}
                \State{$i = i - 1$}
            \EndWhile
            \State{$A[i + 1] = k$}
        \EndFor
    \EndProcedure
\end{algorithmic}
```

表示されるのは以下のような擬似コードになります。

<div class="pdf-wrapper" style="margin-bottom: 20px;">
<div class="pdf-iframe">
<iframe src="/pdf.js/web/viewer.html?file=/assets/pdf/pseudocode1.pdf#zoom=page-fit"></iframe>
</div>
</div>

普段Python など `end` を明示しない言語に慣れていると少し冗長に感じるかもしれません。
そのような記号を明示したくない場合はパッケージ読込時に

```tex
\usepackage[noend]{algpseudocode}
```

のように書いておくと

<div class="pdf-wrapper" style="margin-bottom: 20px;">
<div class="pdf-iframe">
<iframe src="/pdf.js/web/viewer.html?file=/assets/pdf/pseudocode2.pdf#zoom=page-fit"></iframe>
</div>
</div>

のような Python 風の擬似コードになります。さらに`do` の記述も不要ならば、ヘッダ部分に以下のように記述します。


```tex
\algrenewcommand\algorithmicdo{}
```

いま `for` の始点と終点の間には `...` を使っていますが、もし変えたければ `algpseudocode.sty` にならい新しい制御構造 `\ForTo` を定義します。

```tex
\algnewcommand\algorithmicto{\textbf{to}}
\algdef{SE}[FOR]{ForTo}{EndFor}[2]{\algorithmicfor\ #1\ \algorithmicto\ #2\ \algorithmicdo}{\algorithmicend\ \algorithmicfor}%
```

アルゴリズム中の `\For` を新しく定義した`\ForTo` に置き換えて次のような出力を得ます。

<div class="pdf-wrapper" style="margin-bottom: 20px;">
<div class="pdf-iframe">
<iframe src="/pdf.js/web/viewer.html?file=/assets/pdf/pseudocode3.pdf#zoom=page-fit"></iframe>
</div>
</div>

新しく定義した制御構造については `[noend]` オプションが適用されないのため、要らなければ
`algtext*{EndFor}` を `\ForTo` の定義の次の行にでも書いておきましょう。

### 2. よく変更を加える項目について

行間は `\setlength{\baselineskip}{Npt}` で変更できます。

```tex
{\setlength{\baselineskip}{20pt}
\begin{algorithmic}[1]
    \Procedure{Insertion-Sort}{$A$}
    \ForTo{$j = 2$}{$A.\mathrm{length}$}
        \State{$k = A[j]$}
            \State{$i = j - 1$}
            \While{$i > 0$ and $A[i] > k$}
                \State{$A[i + 1] = A[i]$}
                \State{$i = i - 1$}
            \EndWhile
            \State{$A[i + 1] = k$}
        \EndFor
    \EndProcedure
\end{algorithmic}
}
```

<div class="pdf-wrapper" style="margin-bottom: 20px;">
<div class="pdf-iframe">
<iframe src="/pdf.js/web/viewer.html?file=/assets/pdf/pseudocode4.pdf#zoom=page-fit"></iframe>
</div>
</div>


フォントはヘッダ部で以下のように書くと変更できます。

```latex
\usepackage{luatexja-fontspec}
\newfontfamily\algfont{DejaVu Sans Mono}
\makeatletter
\renewcommand{\ALG@beginalgorithmic}{\algfont}
\makeatother
```

<div class="pdf-wrapper" style="margin-bottom: 20px;">
<div class="pdf-iframe">
<iframe src="/pdf.js/web/viewer.html?file=/assets/pdf/pseudocode5.pdf#zoom=page-fit"></iframe>
</div>
</div>

この例では出てきませんが `\Return` には行番号が振られないようになっています。
あったほうがよいならば再定義する必要があります。

```latex
\let\oldReturn\Return
\renewcommand{\Return}{\State\oldReturn}
```

### 3. 最後に

自分の好みのデザインとその出力です。

```latex
documentclass[12pt]{beamer}
\usepackage{amsmath}
\usepackage[noend]{algpseudocode}
\usefonttheme{professionalfonts}
\setbeamertemplate{navigation symbols}{}
\usepackage{luatexja-fontspec}
\newfontfamily\algfont{Linux Libertine O}
\makeatletter
\renewcommand{\ALG@beginalgorithmic}{\algfont}
\makeatother
\algnewcommand\algorithmicto{\textbf{to}}
\algdef{SE}[FOR]{ForTo}{EndFor}[2]{\algorithmicfor\ #1\ \algorithmicto\ #2\ \algorithmicdo}{\algorithmicend\ \algorithmicfor}%
\algrenewcommand\algorithmicdo{}
\let\oldReturn\Return
\renewcommand{\Return}{\State\oldReturn}
\algtext*{EndFor}
\algrenewcommand\alglinenumber[1]{{\ttfamily#1:}}
\begin{document}
\begin{frame}
\begin{center}
\begin{minipage}[t]{0.7\textwidth}
{\setlength{\baselineskip}{17pt}
\begin{algorithmic}[1]
    \Procedure{Insertion-Sort}{$A$}
    \ForTo{$j = 2$}{$A.\mathrm{length}$}
        \State{$k = A[j]$}
            \State{$i = j - 1$}
            \While{$i > 0$ and $A[i] > k$}
                \State{$A[i + 1] = A[i]$}
                \State{$i = i - 1$}
            \EndWhile
            \State{$A[i + 1] = k$}
        \EndFor
    \EndProcedure
\end{algorithmic}
}
\end{minipage}
\end{center}
\end{frame}
\end{document}
```

<div class="pdf-wrapper" style="margin-bottom: 20px;">
<div class="pdf-iframe">
<iframe src="/pdf.js/web/viewer.html?file=/assets/pdf/pseudocode6.pdf#zoom=page-fit"></iframe>
</div>
</div>
