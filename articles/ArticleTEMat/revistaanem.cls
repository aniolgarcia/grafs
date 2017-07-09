%% revistaanem.cls
%% Copyright 2016 Asociación Nacional de Estudiantes de Matemáticas
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
%   http://www.latex-project.org/lppl/
% And version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is
%   Comisión de publicaciones de la
%   Asociación Nacional de Estudiantes de Matemáticas
%   mailto:publicaciones@anemat.com
%
% This work consists of the file revistaanem.cls

% Este archivo establece el formato de la revista TEMat de la ANEM. 
% Su uso es necesario cuando se quiera enviar un artículo a TEMat para su publicación.
% Para usarlo, cargar la clase escribiendo el comando \documentclass{revistaanem}.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{revistaanem}[2017/04/19 v1.3.0 Revista ANEM]

\def\@classname{revistaanem}
\RequirePackage{xkeyval}

%
%%%%%%%%%% CONFIGURACIONES BÁSICAS
%
\RequirePackage{letltxmacro}
\RequirePackage{ifxetex,ifluatex,ifpdf} % Estas cosas hacen falta para que los distintos compiladores funcionen todos igual de bien.
\newif\ifxetexorluatex % a new conditional starts as false
\ifnum 0\ifxetex 1\fi\ifluatex 1\fi>0
   \xetexorluatextrue
\fi

\newif\if@ANEM@standalone % Permite generar pequeñas partes del texto de acuerdo al formato.
\DeclareOptionX{standalone}{\@ANEM@standalonetrue}

\newif\if@ANEM@anon % Permite obtener una versión anonimizada del documento (necesario para enviar a revisores).
\DeclareOptionX{anon}{\@ANEM@anontrue}
\DeclareOptionX{anonimo}{\@ANEM@anontrue}
\DeclareOptionX{anonymous}{\@ANEM@anontrue}
\DeclareOptionX{revision}{\@ANEM@anontrue}
\DeclareOptionX{review}{\@ANEM@anontrue}
\newif\if@ANEM@authorset

\newif\if@ANEM@extracommands
\DeclareOptionX{extracommands}{\@ANEM@extracommandstrue}

\ProcessOptionsX

\ifluatex
\IfFileExists{shellesc.sty}{\RequirePackage{shellesc}}{}
\IfFileExists{luatex85.sty}{\RequirePackage{luatex85}}{}
\fi

\if@ANEM@standalone
\PassOptionsToPackage{dvipsnames}{xcolor}
\PassOptionsToClass{10pt}{standalone}
\LoadClassWithOptions{standalone}
\else
\LoadClass[10pt,leqno]{article}
\fi   

\RequirePackage{afterpackage}
\RequirePackage{calc}
\RequirePackage{etoolbox}
\providecommand{\ANEM@ISSN}{XXXX-XXXX}

\newcommand{\ANEM@pub@num}{N}
\newcommand{\ANEM@pub@year}{AAAA}
\providecommand{\nombrerevista}{TEMat}
%
%%%%%%%%%% FUENTES %%%%%%%%%%
%

\ifxetexorluatex
  \RequirePackage[leqno]{amsmath}
  \RequirePackage{amssymb,amsthm}
  \RequirePackage[T1]{fontenc} % para matemáticas con erewhon...
  
  \RequirePackage[no-math]{fontspec}
  \defaultfontfeatures[\rmfamily]{Numbers={Monospaced,Lining}}
  \defaultfontfeatures[\rmfamily,\sffamily]{Ligatures=TeX}
  \setmainfont{Erewhon}[
    Extension=.otf,
    UprightFont=*-Regular,
    ItalicFont=*-Italic,
    BoldFont=*-Bold,
    BoldItalicFont=*-BoldItalic,
    SlantedFont=*-RegularSlanted,
    BoldSlantedFont=*-BoldSlanted,
    Scale=1.0,
  ]

  \setmonofont{Inconsolatazi4}[
    AutoFakeSlant,
    BoldItalicFeatures={FakeSlant},
    StylisticSet={1,3},
    Extension=.otf,
    UprightFont=*-Regular,
    BoldFont=*-Bold,
    Scale=1.0,
    HyphenChar=None,
  ]
  
  \RequirePackage[scaled=0.96,semibold]{cabin}

\else
  \RequirePackage[scaled=0.96,semibold]{cabin}
  \RequirePackage[scaled=1.0]{erewhon}
  \RequirePackage[varqu,varl,scaled=1.0]{inconsolata} % la fuente para las letras tipo máquina de escribir
  %% Si decidimos usar otro tipo de letra, sería interesante que existiera alguna variante OpenType para la gente que use XeLaTeX o LuaLaTeX. No es estrictamente necesario, pero sería altamente recomendable. Erewhon es un ejemplo de ello.
  %% Luego ya adaptaremos el documentclass para que en función del compilador que se use cargue una cosa u otra. 
  \RequirePackage[T1]{fontenc}       % Uses 'T1' font encoding.
  \RequirePackage[utf8]{inputenc}    % Uses unicode characters.
  \RequirePackage[leqno]{amsmath}
  \RequirePackage{amssymb,amsthm}

\@ifpackagelater{inconsolata}{2016/12/31}{}{% %corrección cutre y rápida para las tildes en la i para versiones viejas de Erewhon con pdfLaTeX...
 \def\activedotlessi{\def\i{i}}
 \let\textscOrig=\textsc
 \def\textsc{\bgroup\activedotlessi{}\textscA}
 \def\textscA#1{\textscOrig{#1}\egroup}
 \appto{\scshape}{\activedotlessi}
}
\fi

\RequirePackage[erewhon,timesmathacc,varbb,bigdelims,slantedGreek,scaled=1.046]{newtxmath} % para que las matemáticas queden bien con Erewhon

%%% Correcciones de matemáticas

\newif\if@ANEM@mathastext
\ifxetexorluatex
  \@ifpackagelater{fontspec}{2016/02/01}{\@ANEM@mathastexttrue}{}
\else
  \@ANEM@mathastexttrue
\fi

\RequirePackage{l3regex,xparse}

\if@ANEM@mathastext
  \RequirePackage[subdued,defaultrm,noplusnominus,noequal,noparenthesis,nodigits,italic,nosmalldelims]{mathastext}
  \MTsetmathskips{f}{1mu}{0.8mu}
  \MTsetmathskips{j}{1mu}{0.5mu}
  \Mathastext[erewhon]
  \MTversion{erewhon}

  \RequirePackage{stackengine,scalerel}

\ExplSyntaxOn
\NewDocumentCommand{\@altaccent}{O{}mm} % see http://tex.stackexchange.com/a/256209/117845
 {
  \global\expandafter\providecommand\csname #3#2\endcsname[1]{\ThisStyle{\setbox0=\hbox{$\SavedStyle##1$}%
  \ensurestackMath{%
  \stackon[\dimexpr-.5pt-4\LMpt#1]{\SavedStyle##1}{%
    \SavedStyle\kern.35\ht0\csname orig#2\endcsname{}}}} %ensurestackMath
}%providecommand
\expandafter\renewcommand\csname #2\endcsname[1]{%
  \tl_if_blank:nF { ##1 }
   {
    \regex_match:nnTF { \A \w \Z } { ##1 }
     {
       \csname #3#2\endcsname{##1}%
     }
     {
       \ifcat\noexpand##1\relax% % see http://tex.stackexchange.com/a/165908/117845
       \ifx##1\imath%
       \csname #3#2\endcsname{##1}%
       \else%
       \csname orig#2\endcsname{##1} %% probably greek letter
       \fi%
       \else% %%% multiletter
       \csname orig#2\endcsname{##1}
       \fi%
     }
   }
 }
 }
\ExplSyntaxOff

\let\origgrave=\grave
\@altaccent{grave}{alt}

\let\origacute=\acute
\@altaccent{acute}{alt}

\let\orighat=\hat
\@altaccent{hat}{alt}

\let\origwidehat=\widehat
\@altaccent{widehat}{alt}

\let\origtilde=\tilde
\@altaccent{tilde}{alt}

\let\origbar=\bar
\@altaccent{bar}{alt}

\let\origbreve=\breve
\@altaccent{breve}{alt}

\let\origdot=\dot
\@altaccent{dot}{alt}

\let\origddot=\ddot
\@altaccent{ddot}{alt}

\let\origcheck=\check
\@altaccent{check}{alt}

\let\origvec=\vec
\@altaccent{vec}{alt}

\@ifpackagelater{newtxmath}{2016/03/01}{
\let\origdddot=\dddot
\@altaccent{dddot}{alt}
\let\origddddot=\ddddot
\@altaccent{ddddot}{alt}
}{
\let\origdddot=\dddot
\@altaccent[+4\LMpt]{dddot}{alt}
\let\origddddot=\ddddot
\@altaccent[+4\LMpt]{ddddot}{alt}
}

\let\origoverrightarrow=\overrightarrow
\@altaccent[+4\LMpt]{overrightarrow}{alt}

\let\origoverleftrightarrow=\overleftrightarrow
\@altaccent[+4\LMpt]{overleftrightarrow}{alt}


\fi % if@ANEM@mathastext

\ifxetexorluatex
\else
\ifpdf
\newcommand\bmmax{2}
\fi % pdf
\fi % xetexorluatex

\RequirePackage{bm}

\if@ANEM@extracommands
\newcommand*\diff{\mathop{}\!\mathrm{d}}
\fi

\if@ANEM@standalone
\else
\RequirePackage{thmtools}

\providecommand\applycommand[1]{\csname #1\endcsname}

\ifxetex
\ClassWarning{revistaanem}{Estás usando XeTeX, que da algunos problemas con el paquete microtype (por algún motivo). Mejor usa LuaLaTeX o pdfLaTeX. Gracias.}
% \RequirePackage{microtype}
\else
\ifpdf
  \RequirePackage{microtype}
\fi
\fi
\fi %% @ANEM@standalone

%
%%%%%%%%%%% SOPORTE DE IDIOMAS
%
\RequirePackage[english,spanish]{babel}
\spanishsignitems

\newcommand{\extranj}[2]{\emph{\foreignlanguage{#1}{#2}}}

\if@ANEM@mathastext
  \ifxetexorluatex
    \accentedoperators
  \else
    \ifcsname es@op@ac@base\endcsname
      \def\es@op@ac@base#1{\text{\'{#1}}}
      \accentedoperators
    \else
      \unaccentedoperators
    \fi
  \fi% %if@ANEM@mathastext
\else
  \unaccentedoperators
\fi

\AfterPackage{tikz}{
  \usetikzlibrary{babel}
}

\RequirePackage{csquotes}

%
%%%%%%%%%% MATEMÁTICAS
%
\RequirePackage{mleftright}       % Correcciones de espaciado.
\RequirePackage[makeroom]{cancel} % Opciones de cancelación en matemáticas
\usepackage[mode=math]{siunitx}
\sisetup{%
exponent-product={\ensuremath{\cdot}},
inter-unit-product={\,},
output-decimal-marker={,}
}

\RequirePackage{mathtools}
\newtagform{ANEM@math@number}{\fontsize{9pt}{9pt}\selectfont\sffamily (\bfseries}{\mdseries)}
\usetagform{ANEM@math@number}

\newcommand\ANEM@eqref[1]{(\ref{#1})}

\let\eqref\ANEM@eqref

%
%%%%%%%%%% IMÁGENES
%
\RequirePackage{graphicx}

\if@ANEM@standalone
\else

\RequirePackage{caption}
\RequirePackage{subcaption}

\captionsetup{labelfont={sf,bf}}

%
%%%%%%%%%% ESTRUCTURA DE LA PÁGINA
%

\RequirePackage[backend=biber,
  bibstyle=numeric,
  citestyle=numeric-comp,
  sorting=nyvt,
  natbib=true,
  sortcites=true,
  maxbibnames=99,
  maxcitenames=3,
  minnames=1,
  autocite=plain,
  uniquelist=false,
  date=comp
]{biblatex}

% \RequirePackage[biblatex=true]{embrac}
% \appto{\citesetup}{\upshape}
\def\bibleftbracket{\textup{[}\begingroup\upshape}
\def\bibrightbracket{\endgroup\textup{]}}

\DeclareFieldFormat{eprint:hal}{%
  \ifhyperref
      {\textsc{hal}: \href{\haltourl#1}{\nolinkurl{#1}}}
      {\nolinkurl{#1}}}

\DeclareSourcemap{
  \maps[datatype=bibtex]{
    \map{
      \step[fieldsource=howpublished, fieldtarget=note]
      \step[fieldsource=journaltitle,
        match=\regexp{\b([A-Z]{1}[A-Za-z0-9]*)\b}, replace={{}{$1}}]
    }
    \map{
      \step[fieldsource=doi,final]
      \step[fieldset=url,null]
      \step[fieldset=eprint,null]
    }
    \map{
      \step[fieldsource=eprint,final]
      \step[fieldset=url,null]
    }
  }
}

\DeclareSourcemap{
  \maps[datatype=bibtex]{
    \map[overwrite]{
      \step[fieldsource=author,
            match=\regexp{\x{0131}\x{0300}},
            replace=\regexp{\x{00EC}}] % i grave
      \step[fieldsource=author,
            match=\regexp{\x{0131}\x{0301}},
            replace=\regexp{\x{00ED}}] % i acute
      \step[fieldsource=author,
            match=\regexp{\x{0131}\x{0302}},
            replace=\regexp{\x{00EE}}] % i circumflex
      \step[fieldsource=author,
            match=\regexp{\x{0131}\x{0303}},
            replace=\regexp{\x{0129}}] % i tilde
      \step[fieldsource=author,
            match=\regexp{\x{0131}\x{0304}},
            replace=\regexp{\x{012B}}] % i macron
      \step[fieldsource=author,
            match=\regexp{\x{0131}\x{0306}},
            replace=\regexp{\x{012D}}] % i breve
      \step[fieldsource=author,
            match=\regexp{\x{0131}\x{0308}},
            replace=\regexp{\x{00EF}}] % i diaeresis
      \step[fieldsource=author,
            match=\regexp{\x{0131}\x{0309}},
            replace=\regexp{\x{1EC9}}] % i hook above
      \step[fieldsource=author,
            match=\regexp{\x{0131}\x{030C}},
            replace=\regexp{\x{01D0}}] % i caron
      \step[fieldsource=author,
            match=\regexp{\x{0131}\x{030F}},
            replace=\regexp{\x{0209}}] % i double grave
      \step[fieldsource=author,
            match=\regexp{\x{0131}\x{0311}},
            replace=\regexp{\x{020B}}] % i inverted breve
    }
  }
}

% \let\ANEM@dollar=$ % para corregir el coloreado de sintaxis en algunos editores...

\DeclareNameAlias{sortname}{last-first}
\DeclareNameAlias{default}{last-first}
\DefineBibliographyStrings{spanish}{andothers={\emph{et~al}\adddot}}
\DeclareFieldFormat[thesis]{title}{\mkbibemph{#1}\addperiod}

\@ifpackagelater{biblatex}{2016/03/03}
{%
\renewcommand*{\mkbibnamefamily}[1]{%
  \ifmknamesc{\textsc{#1}}{#1}}
}{%
\renewcommand*{\mkbibnamelast}[1]{%
  \ifmknamesc{\textsc{#1}}{#1}}
}

\renewcommand*{\mkbibnameprefix}[1]{%
  \ifboolexpr{ test {\ifmknamesc} and test {\ifuseprefix} }
    {\textsc{#1}}
    {#1}}

\def\ifmknamesc{%
  \ifboolexpr{ test {\ifbibliography}
               and ( test {\ifcurrentname{author}}
                     or ( test {\ifnameundef{author}}
                          and test {\ifcurrentname{editor}} ) ) }}


\RequirePackage[]{geometry}

\geometry{
  twoside,
  a4paper,
  inner=2.7cm,
  outer=2.7cm,
  top=3.2cm,
  headsep=0.7cm,
  bottom=3.2cm,
  footskip=1cm,
}
\fi

\RequirePackage[dvipsnames]{xcolor} % Permite escribir texto de colores

\if@ANEM@standalone
\else
\RequirePackage{enumitem}
\setlist[description]{font=\sffamily}
\setlist[enumerate]{font=\upshape\sffamily}

\RequirePackage[bf,sf]{titlesec}

% ver http://tex.stackexchange.com/a/300259/117845
\@ifpackagelater{titlesec}{2016/03/21}{%
}{%
\@ifpackagelater{titlesec}{2016/03/15}{%
\patchcmd{\ttlh@hang}{\parindent\z@}{\parindent\z@\leavevmode}{}{}%
\patchcmd{\ttlh@hang}{\noindent}{}{}{}%
}%
}

\titleformat{\section}{\fontsize{15}{17}\selectfont\sffamily\bfseries}{\thesection.}{0.5em}{}{} % Define estilo y espaciado de títulos de secciones.
\titlespacing{\section}{0pt}{1.7em plus 0.2em minus 0.3em}{0.5em plus 0.1em minus 0.1em}

\titleformat{\subsection}{\fontsize{13}{15}\selectfont\sffamily\bfseries}{\thesubsection.}{0.5em}{}{} % Define estilo y espaciado de títulos de subsecciones.
\titlespacing{\subsection}{0pt}{1.5em plus 0.1em minus 0.2em}{0.5em plus 0.1em minus 0.1em}

\titleformat{\subsubsection}{\fontsize{11}{13}\selectfont\sffamily\bfseries}{\thesubsubsection.}{0.5em}{}{} % Define estilo y espaciado de títulos de subsubsecciones.
\titlespacing{\subsubsection}{0pt}{1.4em plus 0.1em minus 0.2em}{0.5em plus 0.1em minus 0.1em}

\RequirePackage{fancyhdr} % Necesario para las cabeceras y los pies de página
\fancypagestyle{ANEM@normal}{%
\fancyhf{}%
\fancyhead[LE]{\@shorttitle} % En páginas pares, a la izquierda, título del artículo en la cabecera.
\fancyfoot[LE]{\thepage}     % En páginas pares, a la izquierda, número de página en el pie de página.
\if@ANEM@anon
\fancyfoot[CE]{EN REVISIÓN}
\fi
\fancyfoot[RE]{\url{http://temat.anemat.com/}} % En páginas pares, a la derecha, enlace a la web en el pie de página.

\fancyhead[RO]{\@utorescabecera} % En páginas pares, a la derecha, apellidos de los autores en la cabecera.
\fancyfoot[LO]{\nombrerevista, \ANEM@pub@num~(\ANEM@pub@year)} % En páginas impares, a la izquierda, TEMat, volumen y año en el pie de página.
\fancyfoot[CO]{ISSN\@: \ANEM@ISSN} % En páginas impares, en el centro, ISSN en el pie de página.
\fancyfoot[RO]{\thepage} % En páginas impares, a la derecha, número de página en el pie de página.
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}
}
\pagestyle{ANEM@normal}

\LetLtxMacro{\orig@title}{\title}
\def\@titulo#1#2{%
\ifx\\#1\\%
\gdef\@shorttitle{#2}%
\else%
\gdef\@shorttitle{#1}%
\fi%
\gdef\@title{#2}%
}

\newcommand{\titulo}[2][]{\@titulo{#1}{#2}}

\def\title#1{%
\def\@shorttitle{Usa el comando \textbackslash{}titulo[Título corto]\{Título completo\}}
\def\@title{Por favor, usa el comando \texttt{\textbackslash{}titulo[Título corto]\{Título completo\}} para indicar el título}
\ClassWarning{revistaanem}{USA EL COMANDO '\noexpand\titulo' PARA LOS TITULOS!!}
}

%
%%%%%%%%%% ENLACES Y TAL
%
\RequirePackage[colorlinks=true,unicode]{hyperref} % Crea hipervínculos entre los elementos del documento creado.
\RequirePackage[spanish]{cleveref} % Permite hacer referencias a elementos del documento y crea los hipervínculos.
\crefname{section}{sección}{secciones}
\Crefname{section}{Sección}{Secciones}
\hypersetup{
  colorlinks,
  linkcolor={red!50!black},
  citecolor={blue!40!black},
  urlcolor={blue!40!black},
  pdfview=FitH,
  pdfstartview=FitH,
}

\ifluatex
\g@addto@macro\UrlSpecials{%
  \do\`{\mbox{\UrlFont\char`\`}}%
  \do\'{\mbox{\UrlFont\char`\'}}%
  \do\l{\mbox{\UrlFont\char`\l}}%
}
\fi

\providecommand{\email}[1]{\href{mailto:#1}{\nolinkurl{#1}}}

%
%%%%%%%%%% Bibliografía y referencias
%
\let\ANEM@biblio@list\empty
\let\ANEMaddSectionBIB\addsectionbib
\def\ANEM@add@biblio#1{
\ifx\biblio@list\empty
\expandafter\def\expandafter\ANEM@biblio@list\expandafter{%
#1%
}
\else
\expandafter\def\expandafter\ANEM@biblio@list\expandafter{%
\ANEM@biblio@list, #1
}
\fi
\ANEMaddSectionBIB{#1}
}

\newcommand{\nuevabibliografia}[1]{%
\ANEM@add@biblio{#1}
}

\let\old@autoref@ANEM=\autoref
\let\autoref=\cref
\let\Autoref=\Cref

%
%%%%%%%%%% AUTORES %%%%%%%%%%
%
\LetLtxMacro{\orig@uthor}{\author}
\def\author#1{%
\orig@uthor{Por favor, usa el comando \texttt{\textbackslash{}autor\{\}}, uno por autor}

\ClassWarning{revistaanem}{USA EL COMANDO '\noexpand\autor' PARA LOS AUTORES!!}
}

\let\@utores\empty
\let\@utorespdf\empty
\let\@utorescabecera\empty

\def\@utor#1#2#3#4{
  \textsf{\textmd{\mbox{#1} \mbox{#2}}}
  \\
  {\small#3}
  \ifx\\#4\\%
  %
  \else%
    \\
    {\footnotesize\href{mailto:#4}{\nolinkurl{#4}}}
  \fi
}

\def\add@utor#1#2#3#4{%
\if@ANEM@authorset
\expandafter\def\expandafter\@utores\expandafter{%
  \@utores
  \and
  \@utor{#1}{#2}{#3}{#4}
}
\expandafter\def\expandafter\@utorespdf\expandafter{%
\@utorespdf, #1 #2%
}
\expandafter\gdef\expandafter\@utorescabecera\expandafter{%
\@utorescabecera, #2%
}
\else
\expandafter\def\expandafter\@utores\expandafter{%
  \@utor{#1}{#2}{#3}{#4}
}
\expandafter\def\expandafter\@utorespdf\expandafter{%
#1 #2%
}
\expandafter\gdef\expandafter\@utorescabecera\expandafter{%
#2%
}
\fi
\@ANEM@authorsettrue
\orig@uthor{\@utores}
}

\newcommand{\autor}[4][]{%
  \if@ANEM@anon
    \add@utor{Documento}{anonimizado para revisión}{Persona de algún lugar}{}
    \@ANEM@authorsetfalse
  \else
    \add@utor{#2}{#3}{#4}{#1}%
  \fi
}

%
%%%%%%%%%% ENTORNOS MATEMÁTICOS %%%%%%%%%%
%

%% Para definir entornos "iguales" a otros (alias)
\newcommand{\@liasenv}[2]{\newenvironment{#1}[1][\empty]{\ifx##1\empty\begin{#2}\else\begin{#2}[{##1}]\fi}{\end{#2}\ignorespacesafterend}}

\newcommand{\ifnotext@alias}[2]{%
\sbox0{#1}%
\ifdim\wd0=0pt%
\begin{#2}% if #1 is empty
\else%
\begin{#2}[#1]% if #1 is not empty
\fi%
}

\newcommand{\@@liasenv}[2]{\@liasenv{#1}{#2}\@liasenv{#1*}{#2*}}

\DeclareRobustCommand{\emth}{%
  \DeclareRobustCommand{\em}{%
    \@nomath \em \ifdim \fontdimen \@ne \font >\z@ \eminnershape \else \slshape \fi}%
  \em}

%% Estilo para teoremas, lemas, proposiciones...
\declaretheoremstyle[ % Permite definir un nuevo estilo de entorno
  spaceabove=6pt, spacebelow={4pt minus 1 pt plus 1 pt}, % Establece el espaciado por encima y debajo.
  headfont=\normalfont\sffamily\bfseries, % Establece el tipo de fuente en la cabecera.
  notefont=\normalfont, % Si hay una nota (autor, año, lo que sea), establece el estilo de fuente de esa nota.
  notebraces={(}{)}, % Establece el delimitador de la nota.
  headpunct={\normalfont.}, % Establece la puntuación con la que termina la cabecera.
  postheadspace={0.8em}, % Establece el espaciado entre cabecera y cuerpo.
  bodyfont=\emth, % Establece la fuente del cuerpo.
]{ANEMteorema} % Se le da un nombre al estilo definido, para llamarlo más tarde.

\declaretheorem[style=ANEMteorema,
  name=Teorema,
  refname={teorema,teoremas},
  Refname={Teorema,Teoremas},
]{teorema}
\declaretheorem[style=ANEMteorema,
  name=Teorema,
  numbered=no,
  refname={teorema,teoremas},
  Refname={Teorema,Teoremas}]{teorema*}
\@@liasenv{thm}{teorema}
\@@liasenv{theorem}{teorema}
\@@liasenv{theo}{teorema}
\@@liasenv{teo}{teorema}
\@@liasenv{teor}{teorema}


%%%% USO RESTRINGIDO
\declaretheorem[style=ANEMteorema,
  name=Teorema,
  refname={teorema,teoremas},
  Refname={Teorema,Teoremas},
]{teoremaletra}
\renewcommand{\theteoremaletra}{\Alph{teoremaletra}}
\@liasenv{theoremletters}{teoremaletra}


\declaretheorem[style=ANEMteorema,
  numberlike=teorema,
  name=Lema,
  refname={lema,lemas},
  Refname={Lema,Lemas}]{lema}
\declaretheorem[style=ANEMteorema,
  numbered=no,
  name=Lema,
  refname={lema,lemas},
  Refname={Lema,Lemas}]{lema*}
\@@liasenv{lem}{lema}
\@@liasenv{lemm}{lema}
\@@liasenv{lemma}{lema}
\declaretheorem[style=ANEMteorema,
  numberlike=teoremaletra,
  name=Lema,
  refname={lema,lemas},
  Refname={Lema,Lemas},
]{lemaletra}
\renewcommand{\thelemaletra}{\Alph{lemaletra}}
\@liasenv{lemmaletters}{lemaletra}

\declaretheorem[style=ANEMteorema,
  numberlike=teorema,
  name=Corolario,
  refname={corolario,corolarios},
  Refname={Corolario,Corolarios}]{corolario}
\declaretheorem[style=ANEMteorema,
  numbered=no,
  name=Corolario,
  refname={corolario,corolarios},
  Refname={Corolario,Corolarios}]{corolario*}
\@@liasenv{corollary}{corolario}
\@@liasenv{corol}{corolario}
\@@liasenv{coroll}{corolario}
\@@liasenv{cor}{corolario}
\@@liasenv{coro}{corolario}
\declaretheorem[style=ANEMteorema,
  numberlike=teoremaletra,
  name=Corolario,
  refname={corolario,corolarios},
  Refname={Corolario,Corolarios},
]{corolarioletra}
\renewcommand{\thelemaletra}{\Alph{corolarioletra}}
\@liasenv{corollaryletters}{corolarioletra}

\declaretheorem[style=ANEMteorema,
  numberlike=teorema,
  name=Proposición,
  refname={proposición,proposiciones},
  Refname={Proposición,Proposiciones}]{proposicion}
\declaretheorem[style=ANEMteorema,
  numbered=no,
  name=Proposición,
  refname={proposición,proposiciones},
  Refname={Proposición,Proposiciones}]{proposicion*}
\@@liasenv{prop}{proposicion}
\@@liasenv{propo}{proposicion}
\@@liasenv{propos}{proposicion}
\@@liasenv{proposit}{proposicion}
\@@liasenv{proposition}{proposicion}
\declaretheorem[style=ANEMteorema,
  numberlike=teoremaletra,
  name=Proposición,
  refname={proposición,proposiciones},
  Refname={Proposición,Proposiciones},
]{proposicionletra}
\renewcommand{\thelemaletra}{\Alph{proposicionletra}}
\@liasenv{propositionletters}{proposicionletra}

\declaretheorem[style=ANEMteorema,
  numberlike=teorema,
  name=Propiedad,
  refname={propiedad,propiedades},
  Refname={Propiedad,Propiedades}]{propiedad}
\declaretheorem[style=ANEMteorema,
  numbered=no,
  name=Propiedad,
  refname={propiedad,propiedades},
  Refname={Propiedad,Propiedades}]{propiedad*}
\@@liasenv{propi}{propiedad}
\@@liasenv{proper}{propiedad}
\@@liasenv{property}{propiedad}
\@@liasenv{propty}{propiedad}
\declaretheorem[style=ANEMteorema,
  numberlike=teoremaletra,
  name=Propiedad,
  refname={propiedad,propiedades},
  Refname={Propiedad,Propiedades},
]{propiedadletra}
\renewcommand{\thelemaletra}{\Alph{propiedadletra}}
\@liasenv{propertyletters}{propiedadletra}

\declaretheorem[style=ANEMteorema,
  numberlike=teorema,
  name=Conjetura,
  refname={conjetura,conjeturas},
  Refname={Conjetura,Conjeturas}]{conjetura}
\declaretheorem[style=ANEMteorema,
  numbered=no,
  name=Conjetura,
  refname={conjetura,conjeturas},
  Refname={Conjetura,Conjeturas}]{conjetura*}
\@@liasenv{conj}{conjetura}
\@@liasenv{conjecture}{conjetura}
\@@liasenv{conjec}{conjetura}
\@@liasenv{conjet}{conjetura}
\@@liasenv{conje}{conjetura}

\declaretheorem[style=ANEMteorema,
  numberlike=teorema,
  name=Hecho,
  refname={hecho,hechos},
  Refname={Hecho,Hechos}]{hecho}
\declaretheorem[style=ANEMteorema,
  numbered=no,
  name=Hecho,
  refname={hecho,hechos},
  Refname={Hecho,Hechos}]{hecho*}
\@@liasenv{fact}{hecho}

\declaretheorem[style=ANEMteorema,
  name=Criterio,
  refname={criterio,criterios},
  Refname={Criterio,Criterios}]{criterio}
\declaretheorem[style=ANEMteorema,
  numbered=no,
  name=Criterio,
  refname={criterio,criterios},
  Refname={Criterio,Criterios}]{criterio*}
\@@liasenv{criterion}{criterio}

\declaretheorem[style=ANEMteorema,
  name=Axioma,
  refname={axioma,axiomas},
  Refname={Axioma,Axiomas}]{axioma}
\declaretheorem[style=ANEMteorema,
  numbered=no,
  name=Axioma,
  refname={axioma,axiomas},
  Refname={Axioma,Axiomas}]{axioma*}
\@@liasenv{axiom}{axioma}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Estilo para definiciones, ejemplos...
\declaretheoremstyle[
  spaceabove=6pt, spacebelow={4pt minus 1 pt plus 1 pt},
  headfont=\normalfont\sffamily\bfseries,
  notefont=\normalfont, notebraces={(}{)},
  headpunct={\normalfont.}, postheadspace={0.8em},
  bodyfont=\normalfont,
]{ANEMdefinicion}

\declaretheorem[style=ANEMdefinicion,
  name=Definición,
  refname={definición,definiciones},
  Refname={Definición,Definiciones}]{definicion}
\declaretheorem[style=ANEMdefinicion,
  numbered=no,
  name=Definición,
  refname={definición,definiciones},
  Refname={Definición,Definiciones}]{definicion*}
\@@liasenv{defn}{definicion}
\@@liasenv{defi}{definicion}
\@@liasenv{definition}{definicion}
\@@liasenv{defin}{definicion}
\@@liasenv{define}{definicion}

\declaretheorem[style=ANEMdefinicion,
  name=Ejemplo,
  refname={ejemplo,ejemplos},
  Refname={Ejemplo,Ejemplos}]{ejemplo}
\declaretheorem[style=ANEMdefinicion,
  numbered=no,
  name=Ejemplo,
  refname={ejemplo,ejemplos},
  Refname={Ejemplo,Ejemplos}]{ejemplo*}
\@@liasenv{example}{ejemplo}
\@@liasenv{exmp}{ejemplo}
\@@liasenv{exa}{ejemplo}
\@@liasenv{ex}{ejemplo}
\@@liasenv{exam}{ejemplo}
\@@liasenv{examp}{ejemplo}
\@@liasenv{ejem}{ejemplo}
\@@liasenv{ejm}{ejemplo}
\@@liasenv{ejemp}{ejemplo}
\@@liasenv{ej}{ejemplo}

\declaretheorem[style=ANEMdefinicion,
  name=Ejercicio,
  refname={ejercicio,ejercicios},
  Refname={Ejercicio,Ejercicios}]{ejercicio}
\declaretheorem[style=ANEMdefinicion,
  numbered=no,
  name=Ejercicio,
  refname={ejercicio,ejercicios},
  Refname={Ejercicio,Ejercicios}]{ejercicio*}
\@@liasenv{exercise}{ejercicio}
\@@liasenv{exe}{ejercicio}
\@@liasenv{ejerc}{ejercicio}
\@@liasenv{ejer}{ejercicio}

\declaretheorem[style=ANEMdefinicion,
  numberlike=ejercicio,
  name=Problema,
  refname={problema,problemas},
  Refname={Problema,Problemas}]{problema}
\declaretheorem[style=ANEMdefinicion,
  numbered=no,
  name=Problema,
  refname={problema,problemas},
  Refname={Problema,Problemas}]{problema*}
\@@liasenv{problem}{problema}
\@@liasenv{prob}{problema}

\declaretheorem[style=ANEMdefinicion,
  numberlike=ejercicio,
  name=Pregunta,
  refname={pregunta,preguntas},
  Refname={Pregunta,Preguntas}]{pregunta}
\declaretheorem[style=ANEMdefinicion,
  numbered=no,
  name=Pregunta,
  refname={pregunta,preguntas},
  Refname={Pregunta,Preguntas}]{pregunta*}
\@@liasenv{question}{pregunta}
\@@liasenv{quest}{pregunta}
\@@liasenv{preg}{pregunta}

\declaretheorem[style=ANEMdefinicion,
  name=Hipótesis,
  refname={hipótesis,hipótesis},
  Refname={Hipótesis,Hipótesis}]{hipotesis}
\declaretheorem[style=ANEMdefinicion,
  numbered=no,
  name=Hipótesis,
  refname={hipótesis,hipótesis},
  Refname={Hipótesis,Hipótesis}]{hipotesis*}
\@@liasenv{hipot}{hipotesis}
\@@liasenv{hypothesis}{hipotesis}
\@@liasenv{hypoth}{hipotesis}

\declaretheorem[style=ANEMdefinicion,
  name=Observación,
  refname={observación,observaciones},
  Refname={Observación,Observaciones}]{observacion}
\declaretheorem[style=ANEMdefinicion,
  numbered=no,
  name=Observación,
  refname={observación,observaciones},
  Refname={Observación,Observaciones}]{observacion*}
\@@liasenv{obs}{observacion}
\@@liasenv{observation}{observacion}
\@@liasenv{remark}{observacion}

\declaretheorem[style=ANEMdefinicion,
  name=Convención,
  refname={convención,convenciones},
  Refname={Convención,Convenciones}]{convencion}
\declaretheorem[style=ANEMdefinicion,
  numbered=no,
  name=Observación,
  refname={convención,convenciones},
  Refname={Convención,Convenciones}]{convencion*}
\@@liasenv{conven}{convencion}
\@@liasenv{convention}{convencion}

\declaretheoremstyle[
  spaceabove=6pt, spacebelow={4pt minus 1 pt plus 1 pt},
  headfont=\normalfont\sffamily\bfseries,
  notefont=\normalfont, notebraces={(}{)},
  headpunct={\normalfont.}, postheadspace={0.8em},
  bodyfont=\normalfont,
  postheadhook={\hspace{0mm}\newline\nopagebreak},
]{ANEMalgoritmo}
\declaretheorem[style=ANEMalgoritmo,
  name=Algoritmo,
  refname={algoritmo,algoritmos},
  Refname={Algoritmo,Algoritmos},
]{algoritmo}
\declaretheorem[style=ANEMalgoritmo,
  numbered=no,
  name=Algoritmo,
  refname={algoritmo,algoritmos},
  Refname={Algoritmo,Algoritmos},
]{algoritmo*}
\@@liasenv{algorithm}{algoritmo}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Estilo para notas, observaciones, notación...
\declaretheoremstyle[
  spaceabove=6pt, spacebelow={4pt minus 1 pt plus 1 pt},
  headfont=\sffamily\itshape,
  notefont=\normalfont,
  headpunct={\normalfont.}, postheadspace={0.8em},
  bodyfont=\normalfont,
  notebraces={(}{)},
]{ANEMnota}

\declaretheorem[style=ANEMnota,
  name=Nota,
  refname={nota,notas},
  Refname={Nota,Notas}]{nota}
\declaretheorem[style=ANEMnota,
  numbered=no,
  name=Nota,
  refname={nota,notas},
  Refname={Nota,Notas}]{nota*}
\@@liasenv{note}{nota}

\declaretheorem[style=ANEMnota,
  numbered=no,
  name=Notación,
  refname={notación,notaciones},
  Refname={Notación,Notaciones}]{notacion}
\declaretheorem[style=ANEMnota,
  numbered=no,
  name=Notación,
  refname={notación,notaciones},
  Refname={Notación,Notaciones}]{notacion*}
\@@liasenv{notation}{notacion}
\@@liasenv{notac}{notacion}

\declaretheorem[style=ANEMnota,
  name=Afirmación,
  refname={afirmación,afirmaciones},
  Refname={Afirmación,Notas}]{afirmacion}
\declaretheorem[style=ANEMnota,
  numbered=no,
  name=Afirmación,
  refname={afirmación,afirmaciones},
  Refname={Afirmación,Afirmaciones}]{afirmacion*}
\@@liasenv{afirm}{afirmacion}
\@@liasenv{claim}{afirmacion}

\declaretheorem[style=ANEMnota,
  name=Caso,
  refname={caso,casos},
  Refname={Caso,Casos}]{caso}
\declaretheorem[style=ANEMnota,
  numbered=no,
  name=Caso,
  refname={caso,casos},
  Refname={Caso,Casos}]{caso*}
\@@liasenv{case}{caso}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Estilo para las demostraciones...
\newlength{\space@length}
\let\proof\relax
\let\endproof\relax
\declaretheoremstyle[
  spaceabove=6pt, spacebelow={4pt minus 1 pt plus 1 pt},
  headfont=\sffamily\itshape,
  notefont=\sffamily\itshape,
  headpunct={\normalfont.}, postheadspace={0.8em},
  bodyfont=\normalfont,
  notebraces={}{},
  headformat={\ifnotext@proof{\NOTE}},
]{ANEMdemostracion}
\declaretheorem[style=ANEMdemostracion,
  name=Demostración,
  numbered=no,
  qed=\ensuremath{\blacksquare}
]{demostracion}
\@liasenv{demostracion*}{demostracion}
\@@liasenv{proof}{demostracion}
\@@liasenv{demo}{demostracion}
\@@liasenv{dem}{demostracion}

\declaretheorem[style=ANEMdemostracion,
  name=Solución,
  numbered=no,
  qed=\ensuremath{\blacksquare}
]{solucion}
\@liasenv{solucion*}{solucion}
\@@liasenv{sol}{solucion}
\@@liasenv{solution}{solucion}

\newcommand{\ifnotext@proof}[1]{%
\sbox0{#1}%
\ifdim\wd0=0pt%
{\NAME}% if #1 is empty
\else%
{\settowidth{\space@length}{\ }\hskip-\space@length\NOTE}% if #1 is not empty
\fi%
}

%
%%%%%%%%%%%%%%% TRADUCCIONES ALGORITMOS
%
\AfterPackage{algpseudocode}{%
  \algrenewcommand\algorithmicwhile{\textbf{\textsf{mientras}}}
  \algrenewcommand\algorithmicdo{\textbf{\textsf{hacer}}}
  \algrenewcommand\algorithmicif{\textbf{\textsf{si}}}
  \algrenewcommand\algorithmicelse{\textbf{\textsf{en caso contrario}}}
  \algrenewcommand\algorithmicthen{\textbf{\textsf{entonces}}}
  \algrenewcommand\algorithmicfor{\textbf{\textsf{para}}}
  \algrenewcommand\algorithmicforall{\textbf{\textsf{para cada}}}
  \algrenewcommand\algorithmicrepeat{\textbf{\textsf{repetir}}}
  \algrenewcommand\algorithmicuntil{\textbf{\textsf{hasta}}}
  \algrenewcommand\algorithmicprocedure{\textbf{\textsf{subrutina}}}
  \algrenewcommand\algorithmicfunction{\textbf{\textsf{función}}}
  \algrenewcommand\algorithmicloop{\textbf{\textsf{bucle}}}
  \algrenewcommand\algorithmicend{\textbf{\textsf{fin}}}
  \algrenewcommand\algorithmicrequire{\textbf{\textsf{Precondición}}}
  \algrenewcommand\algorithmicensure{\textbf{\textsf{Postcondición}}}

  \algrenewtext{If}[1]{\algorithmicif\ #1, \algorithmicthen}
  \algrenewtext{ElsIf}[1]{\algorithmicelse, \algorithmicif\ #1, \algorithmicthen}
}

%
%%%%%%%%%%%%%%% PORTADA
%

\newcommand{\@msc}{\empty}
\newcommand{\msc}[1]{%
\renewcommand{\@msc}{#1}
}

\newcommand{\cl@ve}{\empty}
\newcommand{\keywords}[1]{%
\renewcommand{\cl@ve}{#1}
}

\let\ANEM@agradecimientos=\empty
\newcommand{\fech@recepcion}{1 de enero de 1970}
\newcommand{\fech@aceptacion}{BORRADOR}
\let\old@nd=\and
\def\and{%
\par%
}

\renewenvironment{abstract}{%
\ifx\ANEM@biblio@list\empty%
\else%
\newrefsection[\ANEM@biblio@list]
\fi%
\newgeometry{
inner=2.3cm,
outer=2.3cm,
top=3cm,
bottom=3cm
}%
%
\thispagestyle{empty}
~
\vspace{8cm plus 1cm minus 3.5cm}

\begingroup
\centering%
\parbox{0.9\textwidth}{\centering%
\fontsize{20}{22}\selectfont%
\sffamily\bfseries%
\@title%
}%
\par
\endgroup

\vspace{1cm plus 0.2cm minus 0.2cm}
\vfill

\begin{minipage}[t]{0.34\textwidth}
\begingroup
\setlength{\parindent}{0pt}
\setlength{\parskip}{1em}
\begin{flushright}
\@author
\end{flushright}
\endgroup
\end{minipage}\hfill
\begin{minipage}[t]{0.6\textwidth}
\begingroup
\setlength{\parindent}{0pt}
\setlength{\parskip}{0.5em plus 0.1em minus 0.1em}
\small \textsf{\textbf{\abstractname:}}\hspace{0.7em plus 0.1em minus 0.2em}
}{%
\par
\begin{flushleft}
\textsf{\textbf{Palabras clave:}}\hspace{0.7em plus 0.1em minus 0.2em}\cl@ve
\par
\textsf{\textbf{MSC2010:}}\hspace{0.7em plus 0.1em minus 0.2em}\@msc
\par
\textsf{\textit{Recibido:}}\hspace{0.7em plus 0.1em minus 0.2em}\fech@recepcion
\\
\textsf{\textit{Aceptado:}}\hspace{0.7em plus 0.1em minus 0.2em}\fech@aceptacion
\end{flushleft}
\endgroup
\end{minipage}
\ifx\ANEM@agradecimientos\empty
\else
\par
\vspace{1em}
\begingroup
\small
\centering%
\parbox{0.85\textwidth}{
\setlength{\parindent}{-1.75em}
\setlength{\parskip}{0.5em plus 0.1em minus 0.1em}
\textsf{\textbf{Agradecimientos:}}\hspace{0.7em plus 0.1em minus 0.2em}\setlength{\parindent}{0pt}\ANEM@agradecimientos
}
\par
\endgroup
\fi

\hypersetup{%
  pdftitle={\protect\@title},
  pdfauthor={\@utorespdf},
  pdfkeywords={\protect\cl@ve},
  pdfsubject={(MSC 2010) \protect\@msc},
  pdfinfo={%
  }
}

\@ANEM@authorsetfalse
\clearpage
\restoregeometry
}

\newcommand{\agradecimientos}[1]{%
  \if@ANEM@anon
  \else
  \def\ANEM@agradecimientos{#1}%
  \fi
}

\if@ANEM@anon
\def\ANEM@agradecimientos{%
Agradecimientos ocultos (si los hubiere) para la revisión mediante doble ciego.
}
\fi

\newenvironment{resumen}{\begin{abstract}}{\end{abstract}}

\RequirePackage{standalone}

\ifluatex
\def\sa@buildgraphic#1{%
    \ifnum\pdf@shellescape=0
        \PackageError{standalone}{Shell escape needed to create graphic! Use the '-shell-escape' option.}{}%
    \else
        \begingroup
        \edef\file{#1}%
        \edef\outfile{\file\sa@graphicext}%
        \edef\filemodbefore{\csname pdffilemoddate\endcsname{\outfile}}%
        \let\latex\sa@build@latex
        \let\latexoptions\sa@build@latexoptions
        \let\buildjobname\sa@build@jobname
        \sa@setquote
        \let\quote\sa@build@quote
        \immediate\write18{\sa@build@command}%
        \ifx\sa@build@postcommand\@empty\else
            \immediate\write18{\sa@build@postcommand}%
        \fi
        \IfFileExists{\outfile}{%
            \edef\filemodafter{\csname pdffilemoddate\endcsname{\outfile}}%
            \ifx\filemodbefore\filemodafter
                \expandafter\ifx\csname pdffilemoddate\endcsname\relax
                    \global\sa@buildsuccesstrue
                \else
                    \global\sa@buildsuccessfalse
                \fi
            \else
                \global\sa@buildsuccesstrue
            \fi
        }{%
            \global\sa@buildsuccessfalse
        }%
        \endgroup
    \fi
}
\fi

\newcommand*{\imagentikz}[2][]{\includestandalone[mode=buildnew,#1]{#2}}
\ifpdf
\newcommand*{\imagenpstricks}[2][]{\includestandalone[mode=buildnew,build={latex=xelatex},#1]{#2}}

\else
\newcommand*{\imagenpstricks}[2][]{\includestandalone[mode=buildnew,#1]{#2}}
\fi % pdf

\IfFileExists{anemextra.sty}{\RequirePackage{anemextra}}{}

\fi %% @ANEM@standalone

\newcommand*{\my@test@sl}{sl}
\newcommand*{\my@test@it}{it}

%%%%%% Correcciones matemáticas incompatibles con tikz. Parecen menos necesarias con mathastext.
%% \let\oldm@th=$
%% \let\mydoll@r=$
%% \def\my@testtoken{\my@testtoken}
  %% \catcode`\$=\active
  %% \begingroup
  %% \lccode`\~=`\$ %
  %% \lowercase{\endgroup
  %% \def~#1~{%
  %%   \ifx\my@testtoken#1\my@testtoken%
  %%   \mydoll@r\mydoll@r%
  %%   \else%
  %%   \oldm@th%
  %%   \ifx\f@shape\my@test@sl%
  %%   \kern0.14em#1\kern-0.005em%
  %%   \else
  %%   \ifx\f@shape\my@test@it%
  %%   \kern0.14em#1\kern-0.005em%
  %%   \else%
  %%   #1%
  %%   \fi%
  %%   \fi%
  %%   \oldm@th%
  %%   \fi%
  %% }%
  %% }%

\AtBeginDocument{
  \setlength{\parindent}{0pt}
  \if@ANEM@standalone
  \else
    \setlength{\parskip}{0.5em plus 0.2em minus 0.12em}
  \fi

  \let\programbox\relax
  \let\endprogrambox\relax
}
