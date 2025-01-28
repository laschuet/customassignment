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

\ProvidesClass{customassignment}[2025/01/28 v2.3 customassignment]

\newif\if@showsolutions\@showsolutionsfalse
\DeclareOption{showsolutions}{\@showsolutionstrue}
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
\RequirePackage{babel}
\RequirePackage{ccicons}
\RequirePackage{enumitem}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{metalogo}
\RequirePackage{nicematrix}
\RequirePackage{pgfplots}
\RequirePackage{refcount}
\RequirePackage{subcaption}
\RequirePackage[breakable]{tcolorbox}
\RequirePackage{tikz}
\PassOptionsToPackage{math-style=ISO,bold-style=ISO}{unicode-math}
\RequirePackage[default]{fontsetup}

%-------------------------------------------------------------------------------
% Helpers
%-------------------------------------------------------------------------------
\NewDocumentCommand\resetstyle{}{\rmfamily\upshape\mdseries}
\ExplSyntaxOn
\cs_set_eq:NN\IfEmptyTF\tl_if_blank:nTF
\ExplSyntaxOff

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
\renewcommand\thesubsection{\alph{subsection}}
\setsecheadstyle{\large\bfseries\raggedright}
\setsubsecheadstyle{\normalsize\raggedright}
\setbeforesubsecskip{1.25ex plus 1ex minus 0.2ex}
\setaftersubsecskip{-1em}
\setsechook{\setsecnumformat{\assignmentname~\csname the##1\endcsname\quad}}
\setsubsechook{\setsecnumformat{(\csname the##1\endcsname)}}

%-------------------------------------------------------------------------------
% Captions
%-------------------------------------------------------------------------------
\NewDocumentCommand\floatcaptionstyle{}{\resetstyle\small}
\captionnamefont{\floatcaptionstyle}
\captiontitlefont{\floatcaptionstyle}

%-------------------------------------------------------------------------------
% Lists
%-------------------------------------------------------------------------------
\setlist{nosep,leftmargin=*}

%-------------------------------------------------------------------------------
% Solutions
%-------------------------------------------------------------------------------
\NewDocumentCommand\solutionname{}{Solution}
\NewDocumentEnvironment{solution}{+b}{%
    \begingroup
    \if@showsolutions
        \begin{tcolorbox}[
                title=\solutionname,
                colback=technikblau!3!basisweiss,
                colframe=technikblau,
                sharp corners,
                breakable
            ]
            #1
        \end{tcolorbox}
    \else
        \setbox0=\vbox{
            \hsize=\linewidth
            \parindent=0pt
            \baselineskip=0pt
            #1
        }%
    \fi
    \endgroup
}{}

%-------------------------------------------------------------------------------
% Points
%-------------------------------------------------------------------------------
\NewDocumentCommand\pointname{}{Point}
\NewDocumentCommand\pointsname{}{Points}
\NewDocumentCommand\bonusname{}{Bonus}

\NewDocumentCommand\sectionpoints{}{\ref{sectionpoints.\thesection}}
\NewDocumentCommand\sectionpointsvalue{}{\getrefnumber{sectionpoints.\thesection}}
\NewDocumentCommand\sectionpointswithname{O{}}{%
    \IfEmptyTF{#1}
    {(\sectionpoints~\ifnum\sectionpointsvalue=1\pointname\else\pointsname\fi)}
    {(\sectionpoints~\ifnum\sectionpointsvalue=1\pointname\else\pointsname\fi, #1)}
}

\NewDocumentCommand\subsectionpoints{}{\ref{subsectionpoints.\thesection.\thesubsection}}
\NewDocumentCommand\subsectionpointsvalue{}{\getrefnumber{subsectionpoints.\thesection.\thesubsection}}
\NewDocumentCommand\subsectionpointswithname{O{}}{%
    \IfEmptyTF{#1}
    {(\subsectionpoints~\ifnum\subsectionpointsvalue=1\pointname\else\pointsname\fi)}
    {(\subsectionpoints~\ifnum\subsectionpointsvalue=1\pointname\else\pointsname\fi, #1)}
}

\NewDocumentCommand\sectionextrapoints{}{\ref{sectionextrapoints.\thesection}}
\NewDocumentCommand\sectionextrapointsvalue{}{\getrefnumber{sectionextrapoints.\thesection}}
\NewDocumentCommand\sectionextrapointswithname{O{}}{%
    \IfEmptyTF{#1}
    {(\sectionextrapoints~\ifnum\sectionextrapointsvalue=1\pointname\else\pointsname\fi)}
    {(\sectionextrapoints~\ifnum\sectionextrapointsvalue=1\pointname\else\pointsname\fi, #1)}
}

\NewDocumentCommand\totalpoints{}{\ref{totalpoints}}
\NewDocumentCommand\totalpointsvalue{}{\getrefnumber{totalpoints}}
\NewDocumentCommand\totalpointswithname{}{(\totalpoints~\ifnum\totalpointsvalue=1\pointname\else\pointsname\fi)}

\NewDocumentCommand\bonus{m}{%
    \IfNoValueTF{#1}
    {(\bonusname)}
    {(#1~\bonusname)}
}

\makeatletter
\NewDocumentCommand\@sectionpoints{}{0}
\NewDocumentCommand\@subsectionpoints{}{0}
\NewDocumentCommand\@sectionextrapoints{}{0}
\NewDocumentCommand\@totalpoints{}{0}

\NewDocumentCommand\points{m}{%
    \xdef\@sectionpoints{\fpeval{\@sectionpoints + #1}}%
    \xdef\@subsectionpoints{\fpeval{\@subsectionpoints + #1}}%
    \xdef\@totalpoints{\fpeval{\@totalpoints + #1}}%
    (#1)%
}

\NewDocumentCommand\extrapoints{m}{%
    \xdef\@sectionextrapoints{\fpeval{\@sectionextrapoints + #1}}%
    (#1)%
}

\NewDocumentCommand\@writesectionpoints{}{%
    \protected@write\@auxout{}{%
        \string\newlabel{sectionpoints.\thesection}{{\@sectionpoints}{\thepage}}%
    }%
}

\NewDocumentCommand\@writesubsectionpoints{}{%
    \protected@write\@auxout{}{%
        \string\newlabel{subsectionpoints.\thesection.\thesubsection}{{\@subsectionpoints}{\thepage}}%
    }%
}

\NewDocumentCommand\@writesectionextrapoints{}{%
    \protected@write\@auxout{}{%
        \string\newlabel{sectionextrapoints.\thesection}{{\@sectionextrapoints}{\thepage}}%
    }%
}

\let\oldsection\section
\RenewDocumentCommand\section{m}{%
  \ifnum\value{section} > 0
      \@writesectionpoints%
      \@writesubsectionpoints%
      \@writesectionextrapoints%
      \xdef\@sectionpoints{0}%
      \xdef\@subsectionpoints{0}%
      \xdef\@sectionextrapoints{0}%
  \fi
  \oldsection{#1}%
 }

\let\oldsubsection\subsection
\RenewDocumentCommand\subsection{m}{%
    \ifnum\value{subsection} > 0
        \@writesubsectionpoints%
        \xdef\@subsectionpoints{0}%
    \fi
    \oldsubsection{#1}%
}

\AtEndDocument{%
    \@writesectionpoints%
    \@writesubsectionpoints%
    \@writesectionextrapoints%
    \protected@write\@auxout{}{%
        \string\newlabel{totalpoints}{{\@totalpoints}{\thepage}}%
    }%
}
\makeatother

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
    \RenewDocumentCommand\pointsname{}{Punkte}%
    \RenewDocumentCommand\pointname{}{Punkt}%
}
