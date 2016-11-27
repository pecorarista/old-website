
こうするとわかりやすい。

```tex
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
