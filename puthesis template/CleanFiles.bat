@echo off
del *.aux
del thesis.dvi
del thesis.lof
del thesis.log
del thesis.lot
del thesis.toc
echo Files Cleaned
REM pause
latex thesis.tex
bibtex.exe thesis
latex thesis.tex
latex thesis.tex
pdflatex thesis.tex
echo Continue to read pdf.
REM pause
start thesis.pdf