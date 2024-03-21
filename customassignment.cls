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

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{customassignment}[2024/03/21 v1.0 customassignment]

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

%-------------------------------------------------------------------------------
% Custom commands
%-------------------------------------------------------------------------------
\newcommand{\logo}{Logo}

\newcommand{\course}{Course}
\newcommand{\term}{Term}
\newcommand{\docent}{Docent}
\newcommand{\tai}{Teaching assistant 1}
\newcommand{\taii}{Teaching assistant 2}

\newcommand{\sheetname}{Assignment sheet}
\newcommand{\sheetnumber}{1}
\newcommand{\assignmentname}{Assignment}

\newcommand{\license}{License}
\newcommand{\colophon}{Colophon}

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
\newcommand{\headstyle}{\tiny}
\newcommand{\footstyle}{\tiny}
\makeoddhead{plain}{}{\headstyle\license}{}
\makeevenhead{plain}{}{\headstyle\license}{}
\makeoddfoot{plain}{\footstyle\colophon}{}{\footstyle\thepage}
\makeevenfoot{plain}{\footstyle\colophon}{}{\footstyle\thepage}

%-------------------------------------------------------------------------------
% Title
%-------------------------------------------------------------------------------
\renewcommand{\maketitle}{%
    \begin{center}
        \logo\par
        {\small\course\\\term\par}
        {\small\docent\\\tai\\\taii\par}
        \vspace{2\baselineskip}
        {\LARGE\bfseries\sheetname~\sheetnumber}
    \end{center}
}

%-------------------------------------------------------------------------------
% Sections
%-------------------------------------------------------------------------------
\renewcommand\thesection{\assignmentname~\arabic{section}}

%-------------------------------------------------------------------------------
% Lists
%-------------------------------------------------------------------------------
\setlist{leftmargin=*}
\setlist[enumerate, 1]{label=\theenumi), ref=\emph{\theenumi}}
