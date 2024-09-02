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

\ProvidesClass{customassignment}[2024/09/02 v1.6.1 customassignment]

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
\RequirePackage{pgfplots}
\RequirePackage{subcaption}
\RequirePackage{tabularx}
\RequirePackage{tikz}
\RequirePackage[default]{fontsetup}
\DisemulatePackage{titlesec}
\RequirePackage[explicit]{titlesec}

%-------------------------------------------------------------------------------
% Helpers
%-------------------------------------------------------------------------------
% Taken from https://tex.stackexchange.com/a/63233
\ExplSyntaxOn
\DeclareExpandableDocumentCommand{\IfNoValueOrEmptyTF}{mmm}{%
    \IfNoValueTF{#1}{#2}{\tl_if_empty:nTF {#1} {#2} {#3}}}
\ExplSyntaxOff

\NewDocumentCommand\abbrassignmentlabel{}{assignment}
\NewDocumentCommand\abbrfigurelabel{}{figure}
\NewDocumentCommand\abbrtablelabel{}{table}
\NewDocumentCommand\labelassignment{m}{\label{\abbrassignmentlabel:#1}}
\NewDocumentCommand\labelfigure{m}{\label{\abbrfigurelabel:#1}}
\NewDocumentCommand\labeltable{m}{\label{\abbrtablelabel:#1}}
\NewDocumentCommand\refassignment{m}{\assignmentname~\ref{\abbrassignmentlabel:#1}}
\NewDocumentCommand\reftfigure{m}{\figurename~\ref{\abbrfigurelabel:#1}}
\NewDocumentCommand\reftable{m}{\tablename~\ref{\abbrtablelabel:#1}}

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
\settrimmedsize{297mm}{210mm}{*}
\settrims{0mm}{0mm}
\setxlvchars[\normalfont\normalsize]
\setlxvchars[\normalsize\normalfont]
\settypeblocksize{*}{1.4\lxvchars}{1.618}
\setbinding{0mm}
%\setlrmargins{26.25mm}{*}{*}
%\setulmargins{26.25mm}{*}{*}
%\setlrmargins{*}{*}{1.618}
%\setulmargins{*}{*}{1.618}
\setlrmargins{*}{*}{1}
\setulmargins{*}{*}{1}
\setheadfoot{\onelineskip}{3\onelineskip}
\checkandfixthelayout

%-------------------------------------------------------------------------------
% Paragraphs
%-------------------------------------------------------------------------------
\setlength{\parindent}{0em}
\setlength{\parskip}{6pt}

%-------------------------------------------------------------------------------
% Pages
%-------------------------------------------------------------------------------
\NewDocumentCommand\licensestyle{}{\tiny}
\NewDocumentCommand\pagenumberstyle{}{\small}
\NewDocumentCommand\colophonstyle{}{\tiny}
\makeoddhead{plain}{}{\licensestyle\license}{}
\makeevenhead{plain}{}{\licensestyle\license}{}
\makeoddfoot{plain}{\colophonstyle\colophon}{}{\pagenumberstyle\thepage}
\makeevenfoot{plain}{\colophonstyle\colophon}{}{\pagenumberstyle\thepage}

%-------------------------------------------------------------------------------
% Title
%-------------------------------------------------------------------------------
\RenewDocumentCommand\maketitle{}{%
    \begin{center}
        \logo\par
        {\small\course\\\term\par}
        {\small\docent\\\tas\par}
        \vspace{2\baselineskip}
        {\LARGE\bfseries\sheetname~\sheetnumber}
    \end{center}
}

%-------------------------------------------------------------------------------
% Sections
%-------------------------------------------------------------------------------
\maxsecnumdepth{subsection}
\renewcommand\thesection{\arabic{section}}
\titleformat{\section}{\large\bfseries\raggedright}{\assignmentname~\thesection}{0.5em}{\IfNoValueOrEmptyTF{#1}{}{(#1)}}
\titleformat{\subsection}[runin]{\large\raggedright}{(\thesubsection)}{0em}{}

%-------------------------------------------------------------------------------
% Lists
%-------------------------------------------------------------------------------
\setlist{leftmargin=*}
\setlist[enumerate, 1]{label=\theenumi), ref=\emph{\theenumi}}
