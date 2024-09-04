% Copyright 2024–present Lars Schütz
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Lars Schütz.
%
% This work consists of the file customassignment.cls.

\ProvidesClass{customassignment}[2024/09/04 v1.23 customassignment]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions\relax

\LoadClass[%
    article,
    11pt,
    a4paper,
]{memoir}

%-------------------------------------------------------------------------------
% Packages
%-------------------------------------------------------------------------------
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amstext}
\RequirePackage{amsthm}
\RequirePackage{booktabs}
\RequirePackage{babel}
\RequirePackage{ccicons}
\RequirePackage{enumitem}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{metalogo}
\RequirePackage{nicematrix}
\RequirePackage{pgfplots}
\RequirePackage{subcaption}
\RequirePackage{tabularx}
\RequirePackage{tcolorbox}
\RequirePackage{tikz}
\PassOptionsToPackage{math-style=ISO,bold-style=ISO}{unicode-math}
\RequirePackage[default]{fontsetup}
\DisemulatePackage{titlesec}
\RequirePackage{titlesec}

%-------------------------------------------------------------------------------
% Helpers
%-------------------------------------------------------------------------------
% Taken from https://tex.stackexchange.com/a/63233
\ExplSyntaxOn
\DeclareExpandableDocumentCommand{\IfNoValueOrEmptyTF}{mmm}{%
    \IfNoValueTF{#1}{#2}{\tl_if_empty:nTF{#1}{#2}{#3}}}
\ExplSyntaxOff

\NewDocumentCommand\resetstyle{}{\rmfamily\upshape\mdseries}

%-------------------------------------------------------------------------------
% Custom commands
%-------------------------------------------------------------------------------
\NewDocumentCommand\logo{}{Logo}

\NewDocumentCommand\course{}{Course}
\NewDocumentCommand\term{}{Term}
\NewDocumentCommand\docent{}{Docent}
\NewDocumentCommand\tas{}{Teaching assistant~1\\teaching assistant~2\\\ldots\\teaching assistant~$n$}

\NewDocumentCommand\sheetname{}{Assignment sheet}
\NewDocumentCommand\sheetnumber{}{1}
\NewDocumentCommand\assignmentname{}{Assignment}

\NewDocumentCommand\license{}{License}
\NewDocumentCommand\colophon{}{Colophon}

%-------------------------------------------------------------------------------
% Overall layout
%-------------------------------------------------------------------------------
\linespread{1.05}
\isopage[11]%
\setlrmargins{*}{*}{1}
\checkandfixthelayout

%-------------------------------------------------------------------------------
% Paragraphs
%-------------------------------------------------------------------------------
\setlength{\parindent}{0em}
\setlength{\parskip}{6pt}

%-------------------------------------------------------------------------------
% Pages
%-------------------------------------------------------------------------------
\NewDocumentCommand\licensestyle{}{\resetstyle\tiny}
\NewDocumentCommand\pagenumberstyle{}{\resetstyle\small}
\NewDocumentCommand\colophonstyle{}{\resetstyle\tiny}
\makeoddhead{plain}{}{\licensestyle\license}{}
\makeevenhead{plain}{}{\licensestyle\license}{}
\makeoddfoot{plain}{\colophonstyle\colophon}{}{\pagenumberstyle\thepage}
\makeevenfoot{plain}{\colophonstyle\colophon}{}{\pagenumberstyle\thepage}

%-------------------------------------------------------------------------------
% Title
%-------------------------------------------------------------------------------
\NewDocumentCommand\logostyle{}{}
\NewDocumentCommand\coursestyle{}{}
\NewDocumentCommand\termstyle{}{}
\NewDocumentCommand\titlestyle{}{}
\NewDocumentCommand\docentstyle{}{}
\NewDocumentCommand\tasstyle{}{}

\NewDocumentCommand\beforetitleskip{}{\bigskip\medskip}

\NewDocumentCommand\assignmenttitle{}{\sheetname~\sheetnumber}

\NewDocumentCommand\maketitlealpha{}{%
    \RenewDocumentCommand\logostyle{}{\resetstyle\footnotesize}
    \RenewDocumentCommand\coursestyle{}{\resetstyle\footnotesize}
    \RenewDocumentCommand\termstyle{}{\resetstyle\footnotesize}
    \RenewDocumentCommand\titlestyle{}{\resetstyle\LARGE\bfseries}
    \RenewDocumentCommand\docentstyle{}{\resetstyle\footnotesize}
    \RenewDocumentCommand\tasstyle{}{\resetstyle\footnotesize}
    \begin{center}
        {\logostyle\logo\\}
        {\coursestyle\course\\}
        {\termstyle\term\par}
        {\docentstyle\docent\\}
        {\tasstyle\tas\par}
        {\titlestyle\beforetitleskip\assignmenttitle}
    \end{center}
}

\RenewDocumentCommand\maketitle{}{\maketitlealpha}

%-------------------------------------------------------------------------------
% Sections
%-------------------------------------------------------------------------------
\maxsecnumdepth{subsection}
\renewcommand\thesection{\arabic{section}}
\titlelabel{\assignmentname~\thetitle\quad}
\titleformat*{\section}{\large\bfseries\raggedright}
\titleformat*{\subsection}{\normalsize\bfseries\raggedright}

%-------------------------------------------------------------------------------
% Captions
%-------------------------------------------------------------------------------
\NewDocumentCommand\floatcaptionstyle{}{\resetstyle\small}
\captionnamefont{\floatcaptionstyle}
\captiontitlefont{\floatcaptionstyle}

%-------------------------------------------------------------------------------
% Lists
%-------------------------------------------------------------------------------
\setlist{nosep}
\newlist{subtasks}{enumerate}{1}
\setlist[subtasks]{label=(\alph*),ref=\emph{\alph*},leftmargin=*}

%-------------------------------------------------------------------------------
% Solutions
%-------------------------------------------------------------------------------
\NewDocumentCommand\solutionname{}{Solution}
\NewDocumentEnvironment{solution}{+b}{
    \begin{tcolorbox}[
            title=\solutionname,
            colback=technikblau!3!basisweiss,
            colframe=technikblau,
            sharp corners
        ]
        #1
    \end{tcolorbox}
}{}

%-------------------------------------------------------------------------------
% Cross referencing
%-------------------------------------------------------------------------------
\NewDocumentCommand\abbrassignmentlabel{}{ass}
\NewDocumentCommand\abbrfigurelabel{}{fig}
\NewDocumentCommand\abbrtablelabel{}{tab}
\NewDocumentCommand\abbrequationlabel{}{eq}
\NewDocumentCommand\labass{m}{\label{\abbrassignmentlabel:#1}}
\NewDocumentCommand\labfig{m}{\label{\abbrfigurelabel:#1}}
\NewDocumentCommand\labtab{m}{\label{\abbrtablelabel:#1}}
\NewDocumentCommand\labeq{m}{\label{\abbrequationlabel:#1}}
\NewDocumentCommand\refass{m}{\assignmentname~\ref{\abbrassignmentlabel:#1}}
\NewDocumentCommand\reffig{m}{\figurename~\ref{\abbrfigurelabel:#1}}
\NewDocumentCommand\reftab{m}{\tablename~\ref{\abbrtablelabel:#1}}
\NewDocumentCommand\refeq{m}{(\ref{\abbrequationlabel:#1})}

%-------------------------------------------------------------------------------
% Translations
%-------------------------------------------------------------------------------
% It is important not to insert a space in the following statement,
% because otherwise it could end up in the header or footer when using
% \leftmark or \rightmark.
\addto\captionsngerman{%
    \RenewDocumentCommand\assignmentname{}{Aufgabe}%
    \RenewDocumentCommand\solutionname{}{Lösung}%
}
