%!TEX TS-program = xelatex
%!TEX encoding = UTF-8 Unicode
%

%% vukf.cls
%% Copyright 2011 Linas Valiukas
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Linas Valiukas.
%
% This work consists of the files vukf.cls, vukfbibtex.bst and
% vukfbibtex_nat.bst

% Requires XeTeX (because of the Times New Roman font)
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{vukf}[2011/08/26 v1.0 Komunikacijos fakultetas]

% FIXME kabutės
% FIXME bibliografinės nuorodos
% FIXME referato puslapis (ypač skaičiai)
% FIXME turinys (taškas po numerio, uppercase)
% FIXME "Bibliografinių nuorodų sąrašas" nepasispaudžia
% FIXME įvairiose vietose gale padėti tašką, jeigu nepadėtas
% FIXME prieš footnote/citatą ištrinti tarpą, jeigu jis ten padėtas (arba vice versa)
% FIXME "normalus" lentelių package'as
% FIXME \appendix
% FIXME "booktabs" lentelėms
% FIXME išsiaiškinti su "natbib" (http://win.ua.ac.be/~nschloe/content/top-10-latex-modules)

\LoadClass[12pt,a4paper,oneside]{article}
\special{papersize=210mm,297mm}

% Conditionals
\RequirePackage{ifxetex}
\RequirePackage{ifpdf}

% Geometry
\ifxetex
	\usepackage[xetex,top=2cm,bottom=2cm,left=3cm,right=1cm,paper=a4paper,layout=a4paper]{geometry}
\else
	\usepackage[top=2cm,bottom=2cm,left=3cm,right=1cm,paper=a4paper,layout=a4paper]{geometry}
\fi

\RequirePackage[lithuanian]{babel}

% Encoding
\ifxetex
	% noop - UTF8 by default
\else
	\RequirePackage[utf8]{inputenc}
\fi

% graphicx
\ifpdf
	\usepackage[pdftex]{graphicx}
\else
	\usepackage[dvips]{graphicx}
\fi

% Times New Roman, kai naudojamas XeTeX
\ifxetex
	\RequirePackage{fontspec}
	\defaultfontfeatures{Mapping=tex-text}	% Ilgas brūkšnys
	\setmainfont{Times New Roman}			% Times New Roman
\else

	% FIXME replace with:
	% \usepackage{mathptmx}
	% \usepackage[scaled=.90]{helvet}
	% \usepackage{courier}
	\RequirePackage{pslatex}				% Times
	
	% FIXME replace with:
	% \usepackage{mathptmx}
	% \usepackage[scaled=.90]{helvet}
	% \usepackage{courier}
	\RequirePackage{times}
	
	\RequirePackage[L7x]{fontenc}
\fi

% URL'ai
\RequirePackage[hyphens]{url}
\urlstyle{same}

% 1,5 tarpas tarp eilučių
\RequirePackage{setspace}
\setstretch{1.44}

% Pirma eilutė atitraukiama per 1 cm
\setlength{\parindent}{1cm}

% Pirma eilutė irgi indentuojama
\RequirePackage{indentfirst}

% "Subtiliai pagražina" rezultatą
\ifxetex
	% noop
\else
	\RequirePackage{microtype}
\fi

% Glosarijus
\RequirePackage[toc,xindy]{glossaries}
\makeglossaries

% (LTPlius.sty) Kadangi skaičių trupmeninės dalys atskiriamos
% kableliu, po jo standartiškai dedamas tarpelis nepageidaujamas
\RequirePackage{icomma}

\RequirePackage{lastpage}

% Links
\ifpdf
	\usepackage[pdftex,pdfborder=0,breaklinks,baseurl=http://,pdfpagemode=None,pdfstartview=XYZ,pdfstartpage=1]{hyperref}
	\hypersetup{
		pdfauthor   = \@vukfAuthorLastName, \@vukfAuthorFirstName,%
		pdftitle    = \title,%
		pdfkeywords = \vukfKeywords,%
		pdfcreator  = \LaTeX,%
		pdfproducer = \LaTeX}
\else
	\ifxetex
		\usepackage[xetex,breaklinks]{hyperref}
	\else
		\usepackage[dvips,breaklinks]{hyperref}
	\fi
\fi

% Puslapio numeris dešinėje
\RequirePackage{fancyhdr}
\setlength{\headheight}{0pt}
\fancyhf{} % clear all header and footers
\renewcommand{\headrulewidth}{0pt} % remove the header rule
\rfoot{\small\thepage}
\pagestyle{fancy}

% ---------------------

%
% Rašto darbų tipai
%

% Mokslinis esė
\DeclareOption{mokslinis-ese}{
	\def\@vukfType{Mokslinis esė}
	\def\@vukfTypeEn{Scientific essay}
}

% Referatas
\DeclareOption{referatas}{
	\def\@vukfType{Referatas}
	\def\@vukfTypeEn{Paper}
}

% Tyrimo / projekto ataskaita
\DeclareOption{projekto-ataskaita}{
	\def\@vukfType{Projekto ataskaita}
	\def\@vukfTypeEn{Project report}
}

% Žurnalistinio žanro kūrinys (žurfakas)
\DeclareOption{zurnalistinis-kurinys}{
	\def\@vukfType{Žurnalistinis kūrinys}
}

% Praktikos ataskaita
\DeclareOption{praktikos-ataskaita}{
	\def\@vukfType{Praktikos ataskaita}
}

% Individualios užduoties ataskaita (žurfakas)
\DeclareOption{individualios-uzduoties-ataskaita}{
	\def\@vukfType{Individualios užduoties ataskaita}
}

% Kursinis darbas
\DeclareOption{kursinis-darbas}{
	\def\@vukfType{Kursinis darbas}
	\def\@vukfTypeEn{Study}
}

% Semestrinis magistro mokslo tiriamasis rašto darbas
\DeclareOption{magistro-rasto-darbas}{
	\typeout{}
}

% Bakalauro baigiamojo darbo kūrybinė dalis (žurfakas)
\DeclareOption{bakalauro-baigiamojo-darbo-kurybine-dalis}{
	\def\@vukfType{Bakalauro baigiamojo darbo kūrybinė dalis}
	\def\@vukfTypeEn{Final bachelor degree work}
}

% Bakalauro baigiamasis darbas
\DeclareOption{bakalauro-baigiamasis-darbas}{
	\def\@vukfType{Bakalauro baigiamasis darbas}
	\def\@vukfTypeEn{Study}	% FIXME
}

% Baigiamasis magistro darbas
\DeclareOption{magistro-baigiamasis-darbas}{
	\def\@vukfType{Magistro baigiamasis darbas}
	\def\@vukfType{Study}	% FIXME
}

\ProcessOptions\relax


% ---------------------

%
% Papildomi antraštinio lapo kintamieji
%

% Fakulteto padalinys (pvz. "Žurnalistikos institutas")
\newcommand{\vukfDivision}[1]{\def\@vukfDivision{#1}}

% Fakulteto padalinys angliškai (pvz. "Institute of journalism")
\newcommand{\vukfDivisionEn}[1]{\def\@vukfDivisionEn{#1}}

% Autoriaus vardas (pvz. "Linas")
\newcommand{\vukfAuthorFirstName}[1]{\def\@vukfAuthorFirstName{#1}}

% Autoriaus pavardė (pvz. "Valiukas")
\newcommand{\vukfAuthorLastName}[1]{\def\@vukfAuthorLastName{#1}}

% Autoriaus aprašymas (pvz. "Žurnalistikos bakalauro studijų programos \\ I kurso I grupės studentas")
\newcommand{\vukfAuthorDescription}[1]{\def\@vukfAuthorDescription{#1}}

% Rašto darbo pavadinimas angliškai (pvz. "Mass media channels in mobile devices")
\newcommand{\vukfTitleEn}[1]{\def\@vukfTitleEn{#1}}

% Reikšminiai žodžiai (pvz. "žiniasklaida, informacinės technologijos, mobilieji telefonai, Apple iPhone, Java, prekės ženklai")
\newcommand{\vukfKeywords}[1]{\def\@vukfKeywords{#1}}

% Reikšminiai žodžiai angliškai (pvz. "mass media, information technology, mobile phones, Apple iPhone, Java, brand names")
\newcommand{\vukfKeywordsEn}[1]{\def\@vukfKeywordsEn{#1}}

% Darbo vadovas (pvz. "lekt. Dž. Paršonis")
\newcommand{\vukfSupervisor}[1]{\def\@vukfSupervisor{#1}}

% Autoriaus ženklas - tik baigiamuosiuose darbuose (pvz. "Va 001")
\newcommand{\vukfAuthorSign}[1]{\def\@vukfAuthorSign{#1}}

% UDK indeksas - tik baigiamuosiuose darbuose (pvz. "659.1:663/664")
\newcommand{\vukfUDK}[1]{\def\@vukfUDK{#1}}


% ---------------------

%
% "Sekcijos"
%

% Antraštė atitraukiama kaip pastraipos pradžia.
\renewcommand\section{\@startsection{section}{1}{\parindent}%
	{3.25ex \@plus1ex \@minus.2ex}%
	{1.5ex plus .2ex}%
	{\normalfont\normalsize\bfseries\centering\MakeUppercase}}

\renewcommand\subsection{\@startsection{subsection}{2}{\parindent}%
	{3.25ex \@plus1ex \@minus.2ex}%
	{1.5ex plus .2ex}%
	{\normalfont\normalsize\bfseries\centering}}

\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\parindent}%
	{3.25ex \@plus1ex \@minus.2ex}%
	{1.5ex plus .2ex}%
	{\normalfont\normalsize\bfseries\centering}}

\renewcommand\paragraph{\@startsection{paragraph}{4}{\parindent}%
	{3.25ex \@plus1ex \@minus.2ex}%
	{1.5ex plus .2ex}%
	{\normalfont\normalsize\bfseries\centering}}

\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
	{3.25ex \@plus1ex \@minus.2ex}%
	{1.5ex plus .2ex}%
	{\normalfont\normalsize\bfseries\centering}}

% Taškas po numerio
\renewcommand*{\@seccntformat}[1]{%
  \csname the#1\endcsname.\quad
}

% Section'as naujame puslapyje
\let\oldsection\section
\renewcommand\section{%
	\newpage
	\oldsection
}

% Įvadas
\newcommand{\vukfIntroduction}{
	\phantomsection
	\addcontentsline{toc}{section}{Įvadas}
	\section*{Įvadas}
}

% Išvados
\newcommand{\vukfConclusion}{
	\phantomsection
	\addcontentsline{toc}{section}{Išvados}
	\section*{Išvados}
}

% Priedai
\newcounter{numberOfAddendums}
\setcounter{numberOfAddendums}{0}
\newcommand{\vukfAddendum}[1]{
	\phantomsection
	\addtocounter{numberOfAddendums}{1}
	\addcontentsline{toc}{section}{\arabic{numberOfAddendums} priedas. #1}
	\section*{\arabic{numberOfAddendums} priedas. #1}
}



% ---------------------

%
% Antraštinis lapas
%

\renewcommand\maketitle{
	\begin{titlepage}
  
		\begin{center}
		{
			Vilniaus universiteto \\Komunikacijos fakulteto \\\@vukfDivision\par
		}
		\end{center}
		
		\vspace{6em}

		\begin{center}
		{
			\large\@author\normalsize \\
			\@vukfAuthorDescription
		}
		\end{center}

		\vspace{5em}
		
		\begin{center}
		{
			\large\textbf{\MakeUppercase\@title}\normalsize \\
			\@vukfType
		}
		\end{center}
		
		\vspace{11em}

		\begin{flushright}
		{
			Darbo vadovas \@vukfSupervisor
		}
		\end{flushright}
		
		\vspace{11em}

		\begin{center}
		{
			Vilnius, \the\year
		}
		\end{center}

	  	\vfil\null
	\end{titlepage}
	\setcounter{footnote}{0}

	\pagebreak
}


% ---------------------

%
% Lydraštis
%

\newcommand{\makeVuKfCoverLetter}{
	\setlength{\parindent}{0cm}
	\begin{tabular}{ | p{15cm} | }
		\hline
		\emph{Pildo bakalauro baigiamojo darbo kūrybinės dalies autorius} \\ \hline
		\@author \\[-10pt]
		
		\tiny{(bakalauro baigiamojo darbo kūrybinės dalies autoriaus vardas, pavardė)} \\
		\\
		\@title \\[-10pt]
		\tiny{(bakalauro baigiamojo darbo kūrybinės dalies pavadinimas lietuvių kalba)} \\
		\\
		\@vukfTitleEn \\[-10pt]
		\tiny{(bakalauro baigiamojo darbo kūrybinės dalies pavadinimas anglų kalba)} \\
		\hline
		
		\textbf{Patvirtinu, kad bakalauro baigiamojo darbo kūrybinė dalis parengta savarankiškai, nepažeidžiant kitiems asmenims priklausančių autorių teisių, visas darbas ar jo dalis nebuvo panaudota kitose aukštosiose mokyklose.} \\
		\hrulefill \\[-10pt]
		\tiny{(bakalauro baigiamojo darbo kūrybinės dalies autoriaus parašas)} \\ \hline
		
		\textbf{Sutinku, kad bakalauro baigiamojo darbo kūrybinė dalis būtų naudojama neatlygintinai 5 metus Vilniaus universiteto Komunikacijos fakulteto studijų procese.} \\
		\hrulefill \\[-10pt]
		\tiny{(bakalauro baigiamojo darbo kūrybinės dalies autoriaus parašas)} \\ \hline
		
		\emph{Pildo bakalauro baigiamojo darbo kūrybinės dalies vadovas} \\ \hline
		
		\begin{tabular}{ l l }
			\textbf{Bakalauro baigiamojo darbo kūrybinę dalį ginti} & \hrulefill \\[-10pt]
			& \tiny{(įrašyti – leidžiu arba neleidžiu)} \\
		\end{tabular}
		
		\begin{tabular}{ l l }
			\rule{3cm}{0.4pt} & \hrulefill \\[-10pt]
			\tiny{(data)} & \tiny{(bakalauro baigiamojo darbo kūrybinės dalies vadovo parašas)} \\
		\end{tabular}
		
		\\ \hline
		
		\emph{Pildo instituto / katedros, kuruojančios studijų programą, specialistė} \\ \hline
		
		\textbf{Bakalauro baigiamojo darbo kūrybinė dalis įregistruota} \\
		\hrulefill \\[-10pt]
		\tiny{(instituto / katedros, kuruojančios studijų programą, pavadinimas)} \\
		
		\begin{tabular}{ l l }
			\rule{3cm}{0.4pt} & \hrulefill \\[-10pt]
			\tiny{(data)} & \tiny{(instituto/  katedros specialistės parašas)} \\
		\end{tabular}
		
		\\ \hline
		
		\emph{Pildo instituto / katedros, kuruojančios studijų programą, vadovas} \\ \hline
		
		\begin{tabular}{ l l }
			\textbf{Recenzentu skiriu} & \rule{7cm}{0.4pt} \\[-10pt]
			& \tiny{(recenzento vardas, pavardė)} \\
		\end{tabular}
		
		\begin{tabular}{ l l }
			\rule{3cm}{0.4pt} & \hrulefill \\[-10pt]
			\tiny{(data)} & \tiny{(instituto / katedros vadovo parašas)} \\
		\end{tabular}
		
		\\ \hline
		
		\emph{Pildo recenzentas} \\ \hline
		
		\textbf{Darbą recenzuoti gavau.}
		\vspace{15pt}
		\begin{tabular}{ l l }
			\rule{3cm}{0.4pt} & \hrulefill \\[-10pt]
			\tiny{(data)} & \tiny{(recenzento parašas)} \\
		\end{tabular}
		
		\\ \hline
		
	\end{tabular}
	\setlength{\parindent}{1cm}
	
	\setcounter{footnote}{0}

	\pagebreak
	\newpage
}


% ---------------------

%
% Turinys
%

\RequirePackage[titles]{tocloft}
\RequirePackage[overload]{textcase}

% change section headers and page numbers to normal instead of bold font
\renewcommand{\cftsecfont}{%
	\normalfont
}
\renewcommand{\cftsecpagefont}{%
	\normalfont
}

% use leader dots with section headers (by default, only the subsections had them)
\renewcommand{\cftsecleader}{%
	\cftdotfill{\cftdotsep}
}

\renewcommand{\cftsecaftersnum}{.}
\renewcommand{\cftsubsecaftersnum}{.}
\renewcommand{\cftsubsubsecaftersnum}{.}
\renewcommand{\cftparaaftersnum}{.}
\renewcommand{\cftsubparaaftersnum}{.}

\setlength{\cftbeforesecskip}{0em}
\setlength{\cftsecindent}{0em}
\setlength{\cftsecnumwidth}{3em}

\setlength{\cftbeforesubsecskip}{0em}
\setlength{\cftsubsecindent}{0em}
\setlength{\cftsubsecnumwidth}{3em}

\setlength{\cftbeforesubsubsecskip}{0em}
\setlength{\cftsubsubsecindent}{0em}
\setlength{\cftsubsubsecnumwidth}{3em}

\setlength{\cftbeforeparaskip}{0em}
\setlength{\cftparaindent}{0em}
\setlength{\cftparanumwidth}{3em}

\setlength{\cftbeforesubparaskip}{0em}
\setlength{\cftsubparaindent}{0em}
\setlength{\cftsubparanumwidth}{3em}


\renewcommand\tableofcontents{
	\pagebreak
	
	% Puslapių numeravimas prasideda čia
	\setcounter{page}{2}
	
	% Turinys su viengubu intervalu tarp eilučių
	\section*{\normalfont\normalsize
		TURINYS
	}
	
	\@starttoc{toc}
	
	\pagebreak
	\newpage
}


% ---------------------

%
% Referato lapai
%

% Referato lapas
\newenvironment{vukfAbstract}
{
	% Before
	\section*{REFERATO LAPAS}
	
	\textbf{\@vukfAuthorLastName, \@vukfAuthorFirstName}
	
	% FIXME neįskaičiuojamas priedų lapų skaičius
	% FIXME nesuskaičiuojamas bibliografinių nuorodų skaičius
	\addtolength{\leftskip}{1cm}
	\@title : \MakeLowercase\@vukfType / \@author ; mokslinis vadovas \@vukfSupervisor ; Vilniaus universitetas. Komunikacijos fakultetas. \@vukfDivision. -- Vilnius, \the\year. -- \pageref{LastPage}, [0] lap. : lent. -- Mašinr. -- Santr. angl.
	%-- Bibliogr.: lap. \pageref{bibliographyStart}--\pageref{bibliographyEnd} (43 pavad.).
	\\
	
	\addtolength{\leftskip}{-1cm}
	\setlength{\parindent}{0cm}
	\textbf{Reikšminiai žodžiai:} \@vukfKeywords.\\
	\setlength{\parindent}{1cm}
}{
	% After
	\pagebreak
	\newpage
}

% Referato lapas anglų kalba
\newenvironment{vukfAbstractEn}
{	
	% Before
	\textbf{\@vukfAuthorLastName, \@vukfAuthorFirstName}

	% FIXME neįskaičiuojamas priedų lapų skaičius
	% FIXME nesuskaičiuojamas bibliografinių nuorodų skaičius
	\addtolength{\leftskip}{1cm}
	\@vukfTitleEn : \MakeLowercase\@vukfTypeEn / \@author ; research director \@vukfSupervisor ; Vilnius university. Faculty of communication. \@vukfDivisionEn. -- Vilnius, \the\year. -- \pageref{LastPage}, [0] p. : lent. -- Mašinr. -- Santr. angl.
	%-- Bibliogr.: p. \pageref{bibliographyStart}–\pageref{bibliographyEnd} (43 pavad.).
	\\

	\addtolength{\leftskip}{-1cm}
	\setlength{\parindent}{0cm}
	\textbf{Keywords:} \@vukfKeywordsEn.\\
	\setlength{\parindent}{1cm}
}{
	% After
	\pagebreak
	\newpage
}


% ---------------------

%
% Citatos
%

\let\orig@quote\quote
\let\endorig@quote\endquote
\renewenvironment*{quote}
	{\begin{orig@quote}\begin{itshape}}
	{\end{itshape}\end{orig@quote}}

\let\old@quotation\quotation
\let\endold@quotation\endquotation
\renewenvironment*{quotation}
	{\begin{old@quotation}\begin{itshape}}
	{\end{itshape}\end{old@quotation}}

% ---------------------

%
% Bibliografija
%

% (VU MIF) Literatūros sąrašą įtraukiame į turinį, nustatome jo stilių
\let\oldbibliography\bibliography
\renewcommand{\bibliography}[1]{%

	\nocite{*}	% Spausdiname ir tekste nepaminėtus šaltinius (visą biblioteką)
	
	\renewcommand{\refname}{BIBLIOGRAFINIŲ NUORODŲ SĄRAŠAS}%
	\cleardoublepage%
	\addcontentsline{toc}{section}{Bibliografinių nuorodų sąrašas}%
	\bibliographystyle{vukfbibtex}%

	\label{bibliographyStart}%
	\oldbibliography{#1}%
	\label{bibliographyEnd}
}

% Nuorodų sąraše nebus laužtinių skliaustų
\newcounter{numberOfBibliographyEntries}
\makeatletter
\renewcommand\@biblabel[1]{%
	\addtocounter{numberOfBibliographyEntries}{1}
	\hfill #1.%
}
\makeatother
