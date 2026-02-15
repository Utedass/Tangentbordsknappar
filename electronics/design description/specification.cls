%% LaTeX document class for formatting electronics specifications.
%%
%% Original Copyright 2020 Petteri Aimonen
%% https://github.com/PetteriAimonen/latex-datasheet-template/
%%
%% Modified in 2026 by Jonatan Gezelius
%%
%% --------------------------------------------------------------------------
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.
%% 
%% This work has the LPPL maintenance status "maintained".
%% 
%% This is a modified version of datasheet.cls, renamed to specification.cls
%% 
%% This work consists of the file specification.cls and the example
%% document example.tex.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{specification}[2026/02/15 LaTeX document class for specifications]

% The class is based on the article class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% TODO: Maybe remove these requires, if they are more related to content
% Useful symbol and color definitions
\RequirePackage{gensymb}
\RequirePackage{xcolor}

% TODO: Maybe remove these requires, if they are more related to content
% These packages allow full-width tables and combining cells in tables.
\RequirePackage{multirow}
\RequirePackage{tabularx}
\RequirePackage{threeparttable}

% Align figure and table captions to left.
\RequirePackage[font=bf, skip=5pt, justification=raggedright, format=hang, singlelinecheck=off]{caption}

% Format hyperlinks as blue and set PDF title based on \title{} in the document.
\RequirePackage[pdfusetitle]{hyperref}
\hypersetup{
    pdftex,
    breaklinks=true,
    colorlinks=true,
    linkcolor=.,
    urlcolor=blue
}

% Configure page margins
\RequirePackage{geometry}
\geometry{left=2cm, top=2cm, right=2cm, bottom=3cm}

% Command \companylogo{} can be used in document to specify a logo for the first page.
\gdef\@companylogo{}
\newcommand{\companylogo}[1]{\gdef\@companylogo{#1}}

% Command \revision{} can be used to include a document revision number in footer.
\gdef\@revision{}
\newcommand{\revision}[1]{\gdef\@revision{#1}}

% First page title layout is defined here
\renewcommand{\maketitle}{%
    \twocolumn[%
        {\@companylogo}\\
        \vspace{1cm}\\
        {\Huge\sffamily\bfseries\@title}\\
        \noindent\rule{\textwidth}{1pt}
        \medskip
        ]%
        \pagestyle{normalpage}
        \thispagestyle{firstpage}
}

\renewcommand{\maketitle}{
  {\Huge\@companylogo}\\                    % Logo
  \vspace{1cm}\\                       % Vertical spacing
  {\Huge\sffamily\bfseries\@title}\\   % Title
  \noindent\rule{\textwidth}{1pt}      % horizontal rule
  \medskip
  \pagestyle{normalpage}
  \thispagestyle{firstpage}
}

% First page has footer but no header
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\fancypagestyle{firstpage}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0.5pt}
    \fancyfoot[L]{\@revision}
    \fancyfoot[C]{\@author}
    \fancyfoot[R]{Page \thepage\ of \pageref{LastPage}}
}

% Rest of the pages have both header and footer
\fancypagestyle{normalpage}{
    \renewcommand{\headrulewidth}{0.5pt}
    \renewcommand{\footrulewidth}{0.5pt}
    \fancyhead[L]{\@companylogo}
    \fancyhead[C]{\slshape\@title}
    \fancyhead[R]{\@revision}
    \fancyfoot[L]{\@author}
    \fancyfoot[C]{}
    \fancyfoot[R]{Page \thepage\ of \pageref{LastPage}}
}

% No line above footnotes
\renewcommand\footnoterule{}

% Section header size and spacing
\renewcommand{\section}{%
    \@startsection
    {section}{1}{0pt}{-3.5ex plus -2ex minus -1ex}%
    {2.5ex plus .5ex}{\Large\bfseries\sffamily}%
}

% Tell LaTeX to look in "figures/" relative to the main document
\RequirePackage{graphicx}
\graphicspath{{figures/}}

% Spacing between paragraphs
\setlength{\parskip}{2ex plus 0.5ex minus 0.2ex}
\setlength{\parindent}{0pt}

% Spacing for tables.
% Other alternative is to use booktabs package, but I think normal LaTeX tables
% are more fitting in the usual data sheet style.
\renewcommand{\arraystretch}{1.5}
\newcommand{\thickhline}{\noalign {\ifnum 0=`}\fi \hrule height 1pt \futurelet \reserved@a \@xhline}

% No numbering for section titles
\setcounter{secnumdepth}{0}

% Prepare the use of multicol
\RequirePackage{multicol}
\setlength{\columnsep}{1cm}

% Generic column block for multicol
% Usage:
%   \begin{colblock}[figure] ... \caption{My caption} \label{...} \end{colblock}
%   \begin{colblock}[table] ... \caption{My caption} \label{...} \end{colblock}
\newenvironment{colblock}[1][figure] % optional arg defaults to "figure"
  {%
    \par\medskip%
    \noindent%
    \minipage{\linewidth}%
    \centering%
    \def\colblocktype{#1} % store type
    % redefine \caption inside this block to automatically use \captionof
    %\renewcommand{\caption}[1]{\captionof{\colblocktype}{##1}}%
  }
  {%
    \endminipage %
    \par\medskip %
  }