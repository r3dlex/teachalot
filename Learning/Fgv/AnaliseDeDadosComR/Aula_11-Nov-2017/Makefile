LATEX = pdflatex --shell-escape

#You need minted and Pygments installed for the color highlighting
all:
	R --no-save < Src/mba_salaries.R
#	${LATEX} Src/Exercicio.tex && ${LATEX} Src/Exercicio.tex

clean:
	rm -v *.pdf
	rm -v Img/*.pdf

trabalho:
	pdflatex Src/Tex/trabalho.tex
	bibtex trabalho.aux
	pdflatex Src/Tex/trabalho.tex
