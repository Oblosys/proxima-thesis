@echo off         
rem runLatexUltraEditVerbose <top-level latex document file without extension> <source file> <linenr>  
rem for calling from editor, with current line indication in yap
rem current directory will be source directory, so cd ..
echo Running  latex verbose on %1.tex from source %2:%3
cd ..

latex %1.tex -src-specials=cr -halt-on-error -include-directory TexSources -include-directory Styles -include-directory TexOutput -output-directory TexOutput
IF %ERRORLEVEL%==0 set texerr=0
IF %ERRORLEVEL%==1 set texerr=1
rem store errorlevel so we can use it after copy. In case of file not found, latex happily returns level 0  :-(
IF %texerr%==1 echo .
IF %texerr%==1 echo ******************** Latex ERROR ********************

copy TexOutput\%1.dvi texSources\latest.dvi > nul:
rem dvi is copied to source directory, so yap can find eps pictures and tex sources

rem yap:  --find-src-special=<line><filepath>
IF %texerr%==0 yap texSources\latest.dvi --single-instance --find-src-special=%3%2
rem IF %texerr%==0 yap texSources\latest.dvi --single-instance



