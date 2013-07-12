%
%  kuthesis.cls  2013-06-26  James Wobser
%  puthesis class (Purdue University Thesis) originally created by Mark Senn  http://engineering.purdue.edu/~mark
%
%  INDEX: Kettering University thesis document class
%
%  DESCRIPTION:
%
%    This is a LaTeX document class for Kettering University theses.
%	 It is adapted from the Purdue University Thesis Document Class.
%
%	 The March 31, 2011 revision of the formatting guide, around which this class is designed, is hosted at the following location:
%	 https://docs.google.com/file/d/0BwVFnCFUFeqTdXYxLTd3cHFPRUE/edit?usp=sharing
%
%	 Kettering University students should compare this guide to the most recent revision available on KuQuest.
%
%  USAGE:
%
%    See http://engineering.purdue.edu/~mark/puthesis for more information.
%
% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kuthesis}[2013/06/26 Kettering University thesis class]
\RequirePackage{ifthen}
\RequirePackage{endnotes}
\RequirePackage{pulongtable}
\RequirePackage{rotating}
\RequirePackage{lscape}
%\RequirePackage{mathptmx} %Math Times New Roman Package

\newcommand{\ifthen}[2]{\ifthenelse{#1}{#2}{}}

\makeatletter

\def\@@number{\string##}

\newcount{\@@i}
\newcounter{@@tcount}
\newcounter{@@volume}
\newcounter{last@@volume}
\newcounter{save@@page}
\newlength{\@@captionwidth}  
\newlength{\@@parindent}  \setlength{\@@parindent}{\parindent}
\newlength{\@@padding}
\newlength{\@@tlength}
\newlength{\@@ulength}
\newcommand{\@@dept}{me}
\newcommand{\set@@dept}[1]{\renewcommand{\@@dept}{#1}}

\newcommand{\@@Repeat}[2]{%
    \@@i=0
    \loop
        \ifnum\@@i<#2
        #1
        \advance\@@i by 1
    \repeat
}

\newcommand{\@@blankpage}{%
  \clearpage
  \mbox{}\clearpage
}

\newcommand{\articlepages}[1]{%
    \@@Repeat{\@@blankpage}{#1}
}

\newif\if@@more
\@@moretrue
\newcommand{\articleinclude}[1]{%
    \def\@@t{#1}
    \@@i=0
    \loop
        \advance\@@i by 1
        \def\@@u{\@@t\the\@@i.eps}
        \immediate\write16{\@@u}
        \IfFileExists{\@@u}{\noindent\includegraphics[width=\textwidth]{\@@u}\newpage}{\@@morefalse}
        \if@@more\repeat
}

\set@@dept{me}
\newcommand{\pendnotes}{}
\DeclareOption{endnotes}{%
  \let\footnote=\endnote
  \renewcommand{\pendnotes}{%
    \newpage
    \begingroup
      \setlength{\parindent}{0.5truein}
      \setlength{\parskip}{1.5ex}
      \renewcommand{\enotesize}{\normalsize}
      \theendnotes
    \endgroup
  }
}
\newcommand{\@@type}{thesis}
\newboolean{@@uglyheadings}
\setboolean{@@uglyheadings}{false}
\newboolean{@@unset}
\newcommand{\@@optionbibstyle}{}
\newcommand{\set@@optionbibstyle}[1]{\renewcommand{\@@optionbibstyle}{#1}\addtocounter{@@tcount}{1}}
\DeclareOption{ama}{\set@@optionbibstyle{ama}}
\DeclareOption{apacite}{\set@@optionbibstyle{apacite}}
\DeclareOption{apalike}{\set@@optionbibstyle{apalike}}
\newif\if@openbib
\@openbibfalse
%
\newboolean{@@nonchapterblankpages}
\setboolean{@@nonchapterblankpages}{false}
%
\newboolean{@@chapterblankpages}
\setboolean{@@chapterblankpages}{false}
%
\newboolean{@@coversheets}
\setboolean{@@coversheets}{true}
%
\newboolean{number@@all@@volumes}
\setboolean{number@@all@@volumes}{false}

\setcounter{@@tcount}{0}
\ProcessOptions
\newcommand{\IW}[1]{\immediate\write16{#1}}
{
  \catcode`\+=13
  \def+{\space}
  \ifnum\value{@@tcount}>1
    \IW{}
    \IW{You may specify only one citation/bibliography style from the below list:}
    \IW{++++apacite}
    \IW{++++apalike}
    \IW{ABORTING...}
    \IW{}
    \stop
  \fi
}
\LoadClass[12pt,twoside]{report}[2004/02/16]

\renewcommand*\l@section{\@dottedtocline{1}{\smalltocskip}{1.5em}{2.3em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{\smalltocskip}{3.8em}{3.2em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{\smalltocskip}{7.0em}{4.1em}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{\smalltocskip}{10em}{5em}}
\renewcommand*\l@subparagraph{\@dottedtocline{5}{\smalltocskip}{12em}{6em}}
\renewcommand*\l@figure{\@dottedtocline{1}{\bigtocskip}{0em}{2.3em}}
\renewcommand*\l@table{\@dottedtocline{1}{\bigtocskip}{0em}{2.3em}}

\def\AppendixFigure{\relax}
\def\AppendixTable{\relax}
\def\@@bibname{LIST OF REFERENCES}
\def\@@deptbibstyle{unsrt}
\def\@@coversheetspace{\vfill}
\def\@@evenfoot{\hfil\textrm{\thepage}\hfil}
\def\@@evenhead{}
\newboolean{@@figurecaptions}
\setboolean{@@figurecaptions}{false}
\def\@@oddfoot{\hfil\textrm{\thepage}\hfil}
\def\@@oddhead{}
\def\@@sectionbaselinestretch{\relax}
\def\@@sectionseries{\bfseries}
\def\@@startthebibliography{\coversheet{\@@bibname}}
\def\@@startvita{\coversheet{\@@vitaname}}
\def\@@subsectionbaselinestretch{\relax}
\def\@@subsectionseries{\bfseries}
\def\@@subsubsectionbaselinestretch{\relax}
\def\@@subsubsectionseries{\bfseries}
\def\@@t{\relax}
\def\@@thebibliographyparsep{\relax}

\ifthen{\equal{me}{\@@dept}}
  {
    \ifthenelse{\equal{\@@optionbibstyle}{apa}}
      {\def\@@deptbibstyle{apa}}
      {\ifthenelse{\equal{\@@optionbibstyle}{jfm2}}
        {\def\@@deptbibstyle{jfm2}}
        {\def\@@deptbibstyle{pumeunsrt}}
      }
    \def\fnum@table{\tablename~\thetable.~}
    \setboolean{@@figurecaptions}{true}
  }
  
\AtBeginDocument{
  \RequirePackage{notoccite}%
	}

\AtEndDocument{}

\newenvironment{cland}
  {\begin{landscape}\hbox\bgroup\hss\vbox\bgroup}
  {\egroup\hss\egroup\end{landscape}}

\newenvironment{lquotation}
  {\begin{quotation}\renewcommand{\baselinestretch}{1}\reset@font}
  {\end{quotation}}

\newcommand{\coversheet}[1]{
  {
    \ifthen{\boolean{@@coversheets}}
      {
        \ifthenelse{\boolean{@@chapterblankpages}}
          {\clearpage} %% ! {\cleardoublepage}
          {\clearpage}
        \pagestyle{empty}
        \mbox{}
        \@@coversheetspace
        \begin{center}
          #1
        \end{center}
        \vfill
        \newpage
        \addtocounter{page}{-1}
      }
    \@@NotTableOfContents
  }
}

\renewcommand{\rmdefault}{ptm}
\setlength{\paperheight}{11truein}
\setlength{\paperwidth}{8.5truein}
\renewcommand*{\baselinestretch}{2}
\setlength{\topmargin}{0truein}
\setlength{\headsep}{0pt}
\setlength{\parindent}{0.5truein}
\setlength{\evensidemargin}{0.5truein}
\setlength{\oddsidemargin}{0.5truein}
\setlength{\textheight}{9truein}
\setlength{\textwidth}{6truein}
\setlength{\footskip}{.5truein}
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000
\pagenumbering{arabic}
\newcommand{\@@NotTableOfContents}{%
  \renewcommand*{\@evenhead}{\@@evenhead}
  \renewcommand*{\@oddhead}{\@@oddhead}
  \renewcommand*{\@evenfoot}{\@@evenfoot}
  \renewcommand*{\@oddfoot}{\@@oddfoot}
}

\@@NotTableOfContents
\settoheight{\headheight}{- ivx1 -}
% \setlength{\headsep}{0.5truein}
\addtolength{\headsep}{-\headheight}
% \addtolength{\headsep}{-0.0625truein}
\newcommand*{\@@TitleAuthor}{\relax}
\newcommand*{\@@AbstractAuthor}{\relax}
\renewcommand*{\author}[2]{%
  \renewcommand*{\@@TitleAuthor}{#1}%
  \renewcommand*{\@@AbstractAuthor}{#2}%
}
\newcommand*{\@@Campus}{Flint}
\newcommand*{\@@Campus@Input}{Flint}


\newcommand*{\@@EmployerAdvisor}{Employer Advisor}
\newcommand*{\employeradvisor}[1]{\renewcommand*{\@@EmployerAdvisor}{Employer Advisor - #1}}
\newcommand*{\@@FacultyAdvisor}{Faculty Advisor}
\newcommand*{\facultyadvisor}[1]{\renewcommand*{\@@FacultyAdvisor}{Faculty Advisor - #1}}
\newcommand*{\@@TitleDegree}{\relax}
\newcommand*{\@@AbstractDegree}{\relax}
\newcommand*{\@@DegreeMonth}{\relax}
\newcommand*{\@@DegreeYear}{\relax}
\newcommand*{\kudegree}[4]{%
  \renewcommand*{\@@TitleDegree}{#1}%
  \renewcommand*{\@@AbstractDegree}{#2}%
  \renewcommand*{\@@DegreeMonth}{#3}%
  \renewcommand*{\@@DegreeYear}{#4}%
}
\newcommand*{\@@EmployerName}{\relax}
\newcommand*{\employer}[1]{\renewcommand*{\@@EmployerName}{#1}}
\newcommand*{\@@AreaOfStudy}{\relax}
\newcommand*{\areaofstudy}[1]{\renewcommand*{\@@AreaOfStudy}{#1}}
\newcommand*{\@@MajorProf}{\relax}
\newcommand*{\majorprof}[1]{\renewcommand*{\@@MajorProf}{Major Professor: #1}}
\newcommand*{\majorprofs}[1]{\renewcommand*{\@@MajorProf}{Major Professors: #1}}
\newcommand*{\@@Title}{\relax}
\renewcommand*{\title}[1]{\renewcommand*{\@@Title}{#1}}
\renewcommand*{\maketitle}
  {
    {
      \renewcommand*{\baselinestretch}{2} \reset@font
      \setcounter{save@@page}{\value{page}}
      \begin{titlepage}
        \begin{center}
        {\bfseries \uppercase\expandafter{\@@Title}}\\
		\vspace{0.25\normalbaselineskip}
        \ifthen{\(\boolean{number@@all@@volumes} \and \value{last@@volume}>1\) \or \value{@@volume}>1}
          {
            \begin{center}
              VOLUME \the@@volume
            \end{center}
          }
          A thesis written at\\
		  {\bfseries \uppercase\expandafter{\@@EmployerName}}\\
		  and submitted to\\
		  {\bfseries \uppercase\expandafter{Kettering University}}\\
        \renewcommand*{\baselinestretch}{1} \reset@font
		\vspace{2\baselineskip}
          in partial fulfillment\\
          of the requirements for the\\
          degree of\\
		  \vspace{1\baselineskip}
          {\bfseries \uppercase\expandafter{\@@TitleDegree}}\\
		  \vspace{1\baselineskip}
		\renewcommand*{\baselinestretch}{2} \reset@font
		  by\\
          {\bfseries \uppercase\expandafter{\@@TitleAuthor}}\\
		  \@@DegreeMonth\ \@@DegreeYear\\
        \end{center}
		\vfill{%
			\hfill
			\begin{tabular}{@{}p{3in}@{}}
			\\ \hline \\[-1.25\normalbaselineskip]
			Author\\
			\\ \hline \\[-1.25\normalbaselineskip]
			\@@EmployerAdvisor \\
			\\ \hline \\[-1.25\normalbaselineskip]
			\@@FacultyAdvisor
			\end{tabular}
		}
      \end{titlepage}
      \setcounter{page}{\value{save@@page}}
      \ifthen{\value{@@volume}=0 \or \value{@@volume}=1}
        {\setcounter{page}{2}}
    }
  }
  
  \newcommand*{\makedisclaimer}{\relax}
  \renewcommand*{\makedisclaimer}
  {
    {
      \renewcommand*{\baselinestretch}{2} \reset@font
      {\@@nonchapter{next}{Disclaimer}{n}{0pt}}%
	  %\begin{center}
        %{\bfseries \uppercase{Disclaimer}}
	
		%\vspace{1\normalbaselineskip}
        %\end{center}
		
		This thesis is submitted as partial and final fulfillment of the cooperative work experience requirements of Kettering University needed to obtain a \@@TitleDegree\ Degree.
		
		The conclusions and opinions expressed in this thesis are those of the writer and do not necessarily represent the position of Kettering University or \@@EmployerName, or any of its directors, officers, agents or employees with respect to the matters discussed.
		
      }
    }
	
\newcommand*{\makepreface}{\relax}
  \renewcommand*{\makepreface}
  {
    {
      \renewcommand*{\baselinestretch}{2} \reset@font
      {\@@nonchapter{next}{Preface}{n}{0pt}}%
	  %\begin{center}
        %{\bfseries \uppercase{Disclaimer}}
	
		%\vspace{1\normalbaselineskip}
        %\end{center}
		
		This thesis represents thet capstone of my five years combined academic work at Kettering University and job experience at \@@EmployerName. Academic experiences in \@@AreaOfStudy\ proved to be valuable assets while I developed this thesis and addressed the problem it concerns.
		
		Although this thesis represents the compilation of my own efforts, I would like to acknowledge and extend my sincere gratitude to the following persons for their valuable time and assistance, without whom the completion of this thesis would not have been possible:
		
		\vspace*{0.5\baselineskip}		
		\renewcommand*{\baselinestretch}{1} \reset@font
		\input{acknowledgements.tex}
		\renewcommand*{\baselinestretch}{2} \reset@font
      }
    }
  
  
  
\newenvironment{dedication}%
  {%
    \newpage
    \mbox{}
    \vfil
    \begin{center}%
  }%
  {%
    \end{center}%
    \vfil
    \eject
    \@@NotTableOfContents
  }
\newboolean{@@inother}
\setboolean{@@inother}{false}
  % #1 "next" or "odd": start on next or next odd page?
  % #2 what to print at top of page
  % #3 "y" or "n": put in table of contents?
  % #4 amount of extra space to put after heading at top of page
\newcommand{\@@nonchapter}[4]{{%
  %\@@NotTableOfContents
  \bgroup
    \setboolean{@@inother}{true}
    \renewcommand{\large}{}%
    \renewcommand{\bf}{}%
    \chapter*{\bfseries{\uppercase{#2}}}
    {\addcontentsline{toc}{chapter}{\uppercase{#2}}}
  \egroup
  \vspace{#4}
}}


\newenvironment{acknowledgments}%
  {\@@nonchapter{next}{ACKNOWLEDGMENTS}{n}{0pt}}%
  {}
\newenvironment{preface}%
  {\@@nonchapter{next}{PREFACE}{n}{0pt}}%
  {}
\renewcommand*{\tableofcontents}{
  \@@nonchapter{odd}{TABLE OF CONTENTS}{n}{0pt}
  {\leftskip=0pt \noindent\hbox to\textwidth{\hfil Page}\par}
  {%
%   \renewcommand*{\@oddhead}{%
%     \hfil\textrm{\hfil oddhead a \thepage}%
%     \renewcommand*{\@oddhead}{\hfil oddhead b \thepage}%
%   }
%   \renewcommand*{\@evenhead}{%
%     \hfil\textrm{\hfil evenhead a \thepage}%
%     \renewcommand*{\@evenhead}{\hfil evenhead b \thepage}%
%   }
    \output={
      \let \par \@@par
      \ifnum \outputpenalty<-\@M
        \@specialoutput
      \else
        \@makecol
        \@opcol
        \@startcolumn
        \@whilesw \if@fcolmade \fi
          {%
           \@opcol\@startcolumn}%
      \fi
      \ifnum \outputpenalty>-\@Miv
        \ifdim \@colroom<1.5\baselineskip
          \ifdim \@colroom<\textheight
            \@latex@warning@no@line{Text page \thepage\space
              contains only floats}%
            \@emptycol
          \else
            \global \vsize \@colroom
          \fi
        \else
          \global \vsize \@colroom
        \fi
      \else
        \global \vsize \maxdimen
      \fi
      {\leftskip=0pt \noindent\hbox to\textwidth{\hfil Page}\par}
    }
    \renewcommand{\baselinestretch}{1}\reset@font
    \@starttoc{toc}
  }
}
\ifthen{\equal{che}{\@@dept}\or \equal{ece}{\@@dept}\or \equal{hsci}{\@@dept}\or \equal{me}{\@@dept}}
  {%
    \def\numberline#1{\hb@xt@\@tempdima{#1\hfil}}
    \renewcommand*\l@figure{\@dottedtocline{1}{\bigtocskip}{0em}{2.3em}}
    \renewcommand*\l@table{\@dottedtocline{1}{\bigtocskip}{0em}{2.3em}}
  }
\def\bigtocskip{0.5\baselineskip plus.2\p@}
\def\smalltocskip{0pt}
\def\@dottedtocline#1#2#3#4#5#6{%
  \ifnum #1>\c@tocdepth
  \else
    \vskip #2
    {%
      \leftskip #3
      \rightskip \@tocrmarg
      \parfillskip -\rightskip
      \parindent #3
      \@afterindenttrue
      \interlinepenalty\@M
      \leavevmode
      \@tempdima #4
      \advance\@tempdima \@@padding
      \advance\leftskip \@tempdima
      \hbox{}\hskip -\leftskip
      #5\nobreak
      \leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep mu$}\hfill
      \nobreak
      \renewcommand{\@pnumwidth}{1.55em}
      \setlength{\@@tlength}{\@pnumwidth}
      \settowidth{\@@ulength}{\reset@font \rm #6}
      \ifdim \@@ulength>\@@tlength
        \hbox to\@@ulength{\hfil\reset@font \rm #6}\par
      \else
        \hbox to\@@tlength{\hfil\reset@font \rm #6}\par
      \fi
    }%
  \fi
}
\renewcommand*{\listoftables}{
  \@@nonchapter{next}{LIST OF TABLES}{y}{0pt}
  {\leftskip=0pt \noindent\hbox to\textwidth{Table\hfil Page}\par}
  {%
    \output={
      \let \par \@@par
      \ifnum \outputpenalty<-\@M
        \@specialoutput
      \else
        \@makecol
        \@opcol
        \@startcolumn
        \@whilesw \if@fcolmade \fi
          {%
           \@opcol\@startcolumn}%
      \fi
      \ifnum \outputpenalty>-\@Miv
        \ifdim \@colroom<1.5\baselineskip
          \ifdim \@colroom<\textheight
            \@latex@warning@no@line{Text page \thepage\space
              contains only floats}%
            \@emptycol
          \else
            \global \vsize \@colroom
          \fi
        \else
          \global \vsize \@colroom
        \fi
      \else
        \global \vsize \maxdimen
      \fi
      {\leftskip=0pt \noindent\hbox to\textwidth{Table\hfil Page}\par}
    }
    \renewcommand{\baselinestretch}{1}\reset@font
    \@starttoc{lot}
  }
}
\renewcommand{\listoffigures}{
  \@@nonchapter{next}{LIST OF FIGURES}{y}{0pt}
  {\leftskip=0pt \noindent\hbox to\textwidth{Figure\hfil Page}\par}
  {%
    \output={
      \let \par \@@par
      \ifnum \outputpenalty<-\@M
        \@specialoutput
      \else
        \@makecol
        \@opcol
        \@startcolumn
        \@whilesw \if@fcolmade \fi
          {%
           \@opcol\@startcolumn}%
      \fi
      \ifnum \outputpenalty>-\@Miv
        \ifdim \@colroom<1.5\baselineskip
          \ifdim \@colroom<\textheight
            \@latex@warning@no@line{Text page \thepage\space
              contains only floats}%
            \@emptycol
          \else
            \global \vsize \@colroom
          \fi
        \else
          \global \vsize \@colroom
        \fi
      \else
        \global \vsize \maxdimen
      \fi
      {\leftskip=0pt \noindent\hbox to\textwidth{Figure\hfil Page}\par}
    }
    \renewcommand{\baselinestretch}{1}\reset@font
    \@starttoc{lof}
  }
}
\newcommand{\@@startlist}[1]{
  \@@nonchapter{odd}{#1}{y}{0pt}%
  \setlength{\LTleft}{\parindent}%
  \setlength{\LTright}{0truein}%
  %% ! change to \setlength[\@@tlength}{\textwidth - \LTleft - \LTright - 2*\tabcolsep - 1truein} later
  \setlength{\@@tlength}{\textwidth}
  \addtolength{\@@tlength}{-\LTleft}
  \addtolength{\@@tlength}{-\LTright}
  \addtolength{\@@tlength}{-\tabcolsep}
  \addtolength{\@@tlength}{-\tabcolsep}
  \addtolength{\@@tlength}{-1truein}
}



\newenvironment{symbols}%
  {%
    \@@startlist{SYMBOLS}
    \begin{longtable}{lp{\@@tlength}}%
  }
  {\end{longtable}}
\newenvironment{abbreviations}
  {
    \@@startlist{ABBREVIATIONS}
    \begin{longtable}{lp{\@@tlength}}%
  }
  {\end{longtable}}
\newenvironment{nomenclature}
  {
    \@@startlist{NOMENCLATURE}
    \begin{longtable}{lp{\@@tlength}}%
  }
  {\end{longtable}}
\renewenvironment{glossary}
  {
    \@@startlist{GLOSSARY}
    \begin{longtable}{lp{\@@tlength}}%
  }
  {\end{longtable}}
\renewenvironment{abstract}%
  {%
    \@@nonchapter{next}{ABSTRACT}{y}{0pt}
    {%
      \renewcommand*{\baselinestretch}{1.0}\reset@font
      \vspace*{\baselineskip}
      \vbox{
        \noindent
        \@@AbstractAuthor~\@@AbstractDegree,
        Purdue University,
        \@@DegreeMonth\ %
        \@@DegreeYear.
        {%
          \renewcommand*{\\}{}%
          \@@Title.
        }
        \ifthenelse{\isundefined{\@@OverrideMajorProf}}
          {\@@MajorProf\ifthen{\equal{me}{\@@dept}}{, School of Mechanical Engineering}.}
          {\@@OverrideMajorProf}
      }
      \vspace*{\baselineskip}
      \par
    }
  }%
  {\par}
  

\newboolean{@@inchapters}
\setboolean{@@inchapters}{false}

% % % % % % % % % % % % % % % % % % % % %
% 			CHAPTER COMMANDS   			%
% % % % % % % % % % % % % % % % % % % % %
\renewcommand{\chapter}{%
  \clearpage
  \@@NotTableOfContents
  \global\@topnum\z@
  \@afterindenttrue
  \secdef \@chapter \@schapter
}

\def\@chapter[#1]#2{%
  \ifnum \c@secnumdepth >\m@ne
    \refstepcounter{chapter}%
	\renewcommand{\thechapter}{\Roman{chapter}}
    \typeout{\@chapapp\space\thechapter.}%
    \setboolean{@@unset}{false}\addcontentsline{toc}{chapter}{\protect\numberline{\thechapter.}\uppercase{#1}}
    \ifthen{\boolean{@@unset}}
      {\addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}#1}}
	\fi
	\chaptermark{#1}%
	\@makechapterhead{#2}
  \@afterheading
  \ifthen{\not \boolean{@@inchapters}}
    {
      \pagenumbering{arabic}%
      \@@inchapterstrue
    }
}
\def\@makechapterhead#1{%
  %\@@makechapterheadspacea
  {\centering
    \@@makechapterhead{#1}
    \endgraf
  }
  \@@makechapterheadspaceb
}
\def\@makeschapterhead#1{%
  %\@@makeschapterheadspacea
  {\centering
    \ifthenelse{\equal{ce}{\@@dept}}
      {\large\bf\uppercase{#1}}
      {\large\bf #1}
    \endgraf
  }
  \@@makeschapterheadspaceb
}

\def\@@makechapterhead#1{\bf\thechapter.\ \ \uppercase{#1}}
\def\@@makechapterheadspacea{\vspace*{0pt}}
\def\@@makechapterheadspaceb{\vspace*{1\normalbaselineskip}}
\def\@@makeschapterheadspacea{\vspace*{0pt}}
\def\@@makeschapterheadspaceb{\vspace*{1\normalbaselineskip}}
	
% % % % % % % % % % % % % % % % % % % % %
% 		END OF CHAPTER COMMANDS   		%
% % % % % % % % % % % % % % % % % % % % %

% % % % % % % % % % % % % % % % % % % % %
% 			SECTIONING COMMANDS			%
% % % % % % % % % % % % % % % % % % % % %
\def\@@makesectionhead#1{\bf\underline{#1}}
\def\@@makesectionheadspacea{\vspace*{0pt}}
\def\@@makesectionheadspaceb{\vspace*{0pt}}

\renewcommand{\section}{%
  \@@NotTableOfContents
  \global\@topnum\z@
  \@afterindenttrue
  \secdef \@section \@ssection
  }

\def\@section[#1]#2{
	\refstepcounter{section}
    \addcontentsline{toc}{section}{#1}
    \sectionmark{#1}%
	\@makesectionhead{#2}
	\@afterheading
}

\def\@makesectionhead#1{%
  \@@makesectionheadspacea
   {\noindent
	\@@makesectionhead{#1}
	\endgraf
   }
  \@@makesectionheadspaceb
  }

% % % % % % % % % % % % % % % % % % % % %
% 		END OF SECTIONING COMMANDS		%
% % % % % % % % % % % % % % % % % % % % %

% % % % % % % % % % % % % % % % % % % % %
% 			SUBSECTIONING COMMANDS		%
% % % % % % % % % % % % % % % % % % % % %
\def\@@makesubsectionhead#1{\bf\underline{#1}}
\def\@@makesubsectionheadspacea{\vspace*{0pt}}
\def\@@makesubsectionheadspaceb{\vspace*{0pt}}

\renewcommand{\subsection}{%
  \@@NotTableOfContents
  \global\@topnum\z@
  \@afterindenttrue
  \secdef \@subsection \@ssubsection
  }

\def\@subsection[#1]#2{
	\endgraf
	\refstepcounter{subsection}
    \addcontentsline{toc}{subsection}{#1}
    \subsectionmark{#1}%
	\@makesubsectionhead{#2}
	\@afterheading
}

\def\@makesubsectionhead#1{%
  \@@makesubsectionheadspacea
   {\indent
	\@@makesubsectionhead{#1}
	\endgraf
   }
  \@@makesubsectionheadspaceb
  }

% % % % % % % % % % % % % % % % % % % % %
% 		END OF SUBSECTIONING COMMANDS	%
% % % % % % % % % % % % % % % % % % % % %


\def\@startsection#1#2#3#4#5#6{%
  \if@noskipsec
    \leavevmode
  \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty{\@secpenalty}%
    \addvspace{\@tempskipa}%
  \fi
  \@ifstar
    {\@ssect{#3}{#4}{#5}{#6}}%
    {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}%
}
\newenvironment{cabstract}{\begin{quote}\textbf{Abstract}\quad}{\end{quote}}
\newtheorem{definition}{Definition}[section]
\newtheorem{observation}{Observation}[section]
\newsavebox{\proofbox}
\sbox{\proofbox}{\rule{7pt}{7pt}}
\newtheorem{Proof}{Proof}
\renewcommand{\theProof}{}
\newenvironment{proof}{\begin{Proof}\rm}{\hfill \usebox{\proofbox} \end{Proof}}
\newtheorem{proposition}{Proposition}[section]
\newtheorem{theorem}{Theorem}[section]
	
	
% \renewcommand{\subsection}{%
  % \@startsection
    % {subsection}%
    % {2}%
    % {\z@}%
    % {24pt}% \@plus -1ex \@minus -.2ex}%
    % {12pt}% 1.5ex \@plus .2ex}%
    % {\@@subsectionbaselinestretch\reset@font\@@subsectionseries}%
% }

\renewcommand{\subsubsection}{
  \@startsection
    {subsubsection}%
    {3}%
    {\z@}%
    {24pt}% \@plus -1ex \@minus -.2ex}%
    {12pt}% 1.5ex \@plus .2ex}%
    {\@@subsubsectionbaselinestretch\reset@font\@@subsubsectionseries}%
}
\ifthen{\equal{mse}{\@@dept}}
  {
    \def\undertext#1{$\underline{\hbox{#1}}$}
    \newbox{\@@Strut}
    \renewcommand{\subsubsection}[1]{
      \refstepcounter{subsubsection}
      \vspace{6truept}
      \subsubsectionmark{#1}
      \noindent \undertext{\vphantom{gjpqy}\thesubsubsection. #1}\newline\nopagebreak
      \addcontentsline{toc}{subsubsection}{\protect\numberline{\csname thesubsubsection\endcsname}#1}%
      \nopagebreak\indent
    }
  }

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \edef\@svsec{\csname the#1\endcsname\hskip 1em}%
  \fi
  \ifthen{\equal{che}{\@@dept}}
    {%
      \ifnum #2=3
        \refstepcounter{#1}%
        \edef\@svsec{\csname the#1\endcsname\hskip 1em}%
      \fi
    }%
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6\relax
      \@hangfrom{\hskip #3\relax\@svsec}%
      {\interlinepenalty \@M #8\par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth
      \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7%
    }%
  \else
    \def\@svsechd{%
      #6%
      \hskip #3\relax
      \@svsec #8\csname #1mark\endcsname
      {#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth
        \else
          \protect\numberline{\csname the#1\endcsname}
        \fi
        #7%
      }%
    }%
  \fi
  \@xsect{#5}%
}
\renewcommand*{\l@chapter}{\@dottedtocline{0}{\bigtocskip}{0em}{1.4em}}
\ifthen{\equal{ece}{\@@dept}\or \equal{hsci}{\@@dept}}
  {\renewcommand{\figurename}{Fig.}}
\renewcommand{\fnum@figure}{\figurename~\thefigure.}
\renewcommand{\fnum@table}{\tablename~\thetable}
\newboolean{@@centercaption}
\renewcommand{\caption}{%
  \setboolean{@@centercaption}{true}
  \refstepcounter\@captype \@dblarg{\@caption\@captype}%
}
\newcommand\bcaption{%
  \setboolean{@@centercaption}{true}
  \refstepcounter\@captype \@dblarg{\@caption\@captype}%
}
\long\def\@makecaption#1#2{%
  \vspace*{\abovecaptionskip}
  \ifthenelse{\boolean{@@centercaption}}  % center caption
    {
      \setlength{\@@captionwidth}{\textwidth}
      \addtolength{\@@captionwidth}{-4\@@parindent}
      \ifthenelse{\equal{figure}{\@captype} \or \boolean{@@figurecaptions}}
        {
          \sbox\@tempboxa{#1 #2}%
          \renewcommand{\baselinestretch}{1.0}\reset@font
          \ifdim \wd\@tempboxa >\hsize
            \centerline{\parbox[t]{\@@captionwidth}{#1 #2}}
          \else
            \centerline{#1 #2}%
          \fi
        }
        {
          \renewcommand{\baselinestretch}{1.0}\reset@font
          \centerline{#1}
          \sbox\@tempboxa{#2}%
          \ifdim \wd\@tempboxa >\hsize
            \centerline{\parbox[t]{\@@captionwidth}{#2}}
          \else
            \centerline{#2}%
          \fi
        }
      \vspace*{\belowcaptionskip}
    }
    {
      \setlength{\topsep}{0pt}
      \setlength{\parskip}{0pt}
      \setlength{\partopsep}{0pt}
      \begin{quote}
        \renewcommand{\\}{}
        \renewcommand{\baselinestretch}{1.0}\reset@font
        \ifthenelse{\equal{aae}{\@@dept}}
          {#1. #2\par}
          {
            \ifthenelse{\equal{table}{\@captype}}
              {\hfil\strut #1\hfil\break #2\par}
              {#1 #2\par}
          }
      \end{quote}
    }
  \vskip\belowcaptionskip
}
\setlength\belowcaptionskip{5\p@}
\long\def\@makefntext#1{%
  \baselineskip=12pt
  \noindent
  \@makefnmark #1%
}
\ifthenelse{\equal{}{\@@optionbibstyle}}
  {\newcommand{\@@bibstyle}{\@@deptbibstyle}}
  {\newcommand{\@@bibstyle}{\@@optionbibstyle}}

\ifthen{\equal{abbrv}{\@@bibstyle}}
  {
    \renewcommand{\bibname}{{\normalsize\rm LIST OF REFERENCES}}
    \bibliographystyle{abbrv}
  }

\ifthen{\equal{abbrvnat}{\@@bibstyle}}
  {
    \RequirePackage[sort]{natbib}
    \renewcommand{\bibname}{{\normalsize\rm LIST OF REFERENCES}}
    \bibliographystyle{abbrvnat}
  }

\ifthen{\equal{aer}{\@@bibstyle}}
  {
    \RequirePackage{harvard}
    \bibliographystyle{aer}
  }


\ifthen{\equal{agsm}{\@@bibstyle}}
  {
    \RequirePackage{cite}
    \RequirePackage{harvard}
    \bibliographystyle{agsm}
  }

\ifthen{\equal{aip}{\@@bibstyle}}
  {
    \RequirePackage{cite}
    \RequirePackage{revtex}
    \renewcommand{\bibname}{{\normalsize\rm LIST OF REFERENCES}}
    \bibliographystyle{aip}
  }

\ifthen{\equal{alpha}{\@@bibstyle}}
  {
    \RequirePackage{cite}
    \bibliographystyle{alpha}
  }

\ifthen{\equal{ama}{\@@bibstyle}}
{
    \RequirePackage{cite}
    \bibliographystyle{ama}
}

\ifthen{\equal{apacite}{\@@bibstyle}}
  {
    \RequirePackage{apacite}
    \bibliographystyle{apacite}
  }

\ifthen{\equal{apalike}{\@@bibstyle}}
  {
    \RequirePackage{apalike}
    \bibliographystyle{apalike}
  }

\ifthen{\equal{astron}{\@@bibstyle}}
  {
    \RequirePackage{astron}
    \bibliographystyle{astron}
  }

\ifthen{\equal{chicago}{\@@bibstyle}}
  {
    \RequirePackage{natbib}
    \bibliographystyle{chicago}
  }

\ifthen{\equal{ieee}{\@@bibstyle}}
  {
    \RequirePackage{cite}
    \bibliographystyle{ieee}
  }

\ifthen{\equal{ieeetr}{\@@bibstyle}}
  {
    \RequirePackage{cite}
    \bibliographystyle{ieeetr}
  }

\ifthen{\equal{jfm}{\@@bibstyle}}
  {
    \RequirePackage{natbib}
    \bibliographystyle{jfm}
  }

\ifthen{\equal{jfm2}{\@@bibstyle}}
  {
    \RequirePackage{natbib}
    \bibliographystyle{jfm2}
  }

\ifthen{\equal{kluwer}{\@@bibstyle}}
  {
    \RequirePackage{harvard}
    \bibliographystyle{kluwer}
  }

\ifthen{\equal{phaip}{\@@bibstyle}}
  {
    \bibliographystyle{phaip}
  }

\ifthen{\equal{pumeunsrt}{\@@bibstyle}}
  {
    \RequirePackage{cite}
    \bibliographystyle{pumeunsrt}
  }

\ifthen{\equal{plain}{\@@bibstyle}}
  {
    \RequirePackage{cite}
    \bibliographystyle{plain}
  }

\ifthen{\equal{plainnat}{\@@bibstyle}}
  {
    \RequirePackage{natbib}
    \renewcommand{\bibname}{{\normalsize\rm LIST OF REFERENCES}}
    \bibliographystyle{plainnat}
  }

\ifthen{\equal{unified}{\@@bibstyle}}
{
    \RequirePackage{natbib}
    \bibliographystyle{unified}
    \def\@@bibname{{\normalsize\rm REFERENCES}}
 }

\ifthen{\equal{unsrt}{\@@bibstyle}}
  {
    \RequirePackage{cite}
    \bibliographystyle{unsrt}
  }

\ifthen{\equal{unsrtnat}{\@@bibstyle}}
  {
    \RequirePackage{natbib}
    \renewcommand{\bibname}{{\normalsize\rm LIST OF REFERENCES}}
    \bibliographystyle{unsrtnat}
  }

\renewenvironment{thebibliography}[1]
  {
    \@@startthebibliography
    \@@nonchapter{odd}{\@@bibname}{y}{24pt}
    \list
      {\@biblabel{\arabic{enumiv}}}%
      {%
        \settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \if@openbib
          \advance\leftmargin\bibindent
          \itemindent -\bibindent
          \listparindent \itemindent
          \parsep \z@
        \fi
        \@@thebibliographyparsep
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand{\theenumiv}{\arabic{enumiv}}%
        \baselineskip=12pt
      }%
    \if@openbib
      \renewcommand{\newblock}{\par}
    \else
      \renewcommand{\newblock}{\hskip .11em \@plus.33em \@minus.07em}%
    \fi
    \sloppy\clubpenalty4000\widowpenalty4000%
    \sfcode`\.=\@m
  }
  {}
\newboolean{@@inappendix}
\newcommand{\@@appendixname}{Appendix}
\renewcommand{\appendix}{\par
  \setboolean{@@inappendix}{true}
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \coversheet{\uppercase\expandafter{\@@appendixname}}
  \renewcommand{\@chapapp}{\appendixname}%
  \renewcommand{\thechapter}{\Alph{chapter}}
}
\newcommand{\@@appendicesname}{Appendices}
\newcommand{\appendices}{\par
  \setboolean{@@inappendix}{true}
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \coversheet{\uppercase\expandafter{\@@appendicesname}}
  \renewcommand{\@chapapp}{\appendixname}%
  \renewcommand{\thechapter}{\Alph{chapter}}
}
\newcommand{\@@vitaname}{VITA}
\newenvironment{vita}
  {
    \@@startvita
    \@@nonchapter{odd}{\@@vitaname}{y}{0pt}%
  }
  {}
\def\@starttoc#1{%
  \begingroup
    \@input{\jobname.#1}%
    \if@filesw \expandafter\newwrite\csname tf@#1\endcsname
      \immediate\openout \csname tf@#1\endcsname \jobname.#1\relax
    \fi
    \global\@nobreakfalse
  \endgroup
}
\newcommand{\num}[1]{\ensuremath{#1}}
\newcommand{\ten}[1]{\ensuremath{{}\cdot 10^{#1}}}

\setcounter{topnumber}{10}
\renewcommand{\topfraction}{1}
\setcounter{bottomnumber}{10}
\renewcommand{\bottomfraction}{1}
\setcounter{totalnumber}{10}
\renewcommand{\textfraction}{0}
\renewcommand{\floatpagefraction}{0}

\setlength{\floatsep}{18pt plus 3pt minus 3pt}
\setlength{\textfloatsep}{30pt plus 3pt minus 6pt}
\setlength{\intextsep}{18pt plus 3pt minus 3pt}
\setlength{\dblfloatsep}{18pt plus 3pt minus 3pt}
\setlength{\dbltextfloatsep}{30pt plus 3pt minus 6pt}

\newcommand{\Baselinestretch}[1]{\renewcommand{\baselinestretch}{#1}\reset@font}

\def\volume{
  \addtocounter{@@volume}{1}
  \write\@auxout{\string\setcounter{last@@volume}{\the@@volume}}
  \ifthen{\(\boolean{number@@all@@volumes} \and \value{last@@volume}>1\) \or \value{@@volume}>1}
    {
      \addtocontents{toc}{\string\vskip\string\baselineskip \noindent VOLUME \the@@volume}
    }
  %\maketitle
}

    \def\fnum@figure{\figurename~\thefigure.~}
    \def\fnum@table{\tablename~\thetable.~}
  

\makeatother

\raggedbottom
