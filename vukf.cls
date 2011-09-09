%!TEX TS-program = xelatex
%!TEX encoding = UTF-8 Unicode
%
% Requires XeTeX (because of the Times New Roman font)
%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{vukf}[2011-08-26 v1.0 Komunikacijos fakultetas]

% FIXME kabutės
% FIXME bibliografinės nuorodos
% FIXME referato puslapis (ypač skaičiai)
% FIXME turinys (taškas po numerio, uppercase)
% FIXME "Bibliografinių nuorodų sąrašas" nepasispaudžia
% FIXME įvairiose vietose gale padėti tašką, jeigu nepadėtas
% FIXME prieš footnote/citatą ištrinti tarpą, jeigu jis ten padėtas (arba vice versa)
% FIXME "normalus" lentelių package'as

\LoadClass[12pt,a4paper,oneside]{article}
\special{papersize=210mm,297mm}
\usepackage[top=2cm, bottom=2cm, left=3cm, right=1cm, paper=a4paper, layout=a4paper]{geometry}

\RequirePackage[utf8]{inputenc}
\RequirePackage[lithuanian]{babel}

\RequirePackage{url}
\urlstyle{same}

% 1,5 tarpas tarp eilučių
\RequirePackage{setspace}
\setstretch{1.44}

% Pirma eilutė atitraukiama per 1 cm
\setlength{\parindent}{1cm}

% Pirma eilutė irgi indentuojama
\RequirePackage{indentfirst}

% Glosarijus
\RequirePackage[toc,xindy]{glossaries}
\makeglossaries

% (LTPlius.sty) Kadangi skaičių trupmeninės dalys atskiriamos
% kableliu, po jo standartiškai dedamas tarpelis nepageidaujamas
\RequirePackage{icomma}

\RequirePackage{pslatex}
\RequirePackage{lastpage}
\RequirePackage{hyperref}
\RequirePackage{fontspec}
\defaultfontfeatures{Mapping=tex-text}	% Ilgas brūkšnys
\setmainfont{Times New Roman}

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

% Žurnalistinio žanro kūrinys
\DeclareOption{zurnalistinis-kurinys}{
	\typeout{}
}

% Praktikos ataskaita
\DeclareOption{praktikos-ataskaita}{
	\typeout{}
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

% Baigiamasis bakalauro darbas
\DeclareOption{baigiamasis-bakalauro-darbas}{
	\typeout{}
}

% Baigiamasis magistro darbas
\DeclareOption{baigiamasis-magistro-darbas}{
	\typeout{}
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
			Vilniaus universiteto \\
			Komunikacijos fakulteto \\
			\@vukfDivision\par
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

\setlength{\cftbeforeparasecskip}{0em}
\setlength{\cftparasecindent}{0em}
\setlength{\cftparasecnumwidth}{3em}

\setlength{\cftbeforesubparasecskip}{0em}
\setlength{\cftsubparasecindent}{0em}
\setlength{\cftsubparasecnumwidth}{3em}


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
	\@title: \MakeLowercase\@vukfType / \@author; mokslinis vadovas \@vukfSupervisor; Vilniaus universitetas. Komunikacijos fakultetas. \@vukfDivision. – Vilnius, \the\year. – \pageref{LastPage} [0] lap.: lent. – Mašinr. – Santr. angl. – Bibliogr.: p. \pageref{bibliographyStart}–\pageref{bibliographyEnd} (43 pavad.).
	\\\\
	\textbf{Reikšminiai žodžiai:} \@vukfKeywords
	\\
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
	\@vukfTitleEn: \MakeLowercase\@vukfTypeEn / \@author; research director \@vukfSupervisor; Vilnius university. Faculty of communication. \@vukfDivisionEn. – Vilnius, \the\year. – \pageref{LastPage} [0] lap.: lent. – Mašinr. – Santr. angl. – Bibliogr.: p. \pageref{bibliographyStart}–\pageref{bibliographyEnd} (43 pavad.).
	\\\\
	\textbf{Keywords:} \@vukfKeywords
	\\
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
