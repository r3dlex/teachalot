LATEX = pdflatex --shell-escape

#You need minted and Pygments installed for the color highlighting
all:
	R --no-save < Src/exercise_351.R
	${LATEX} Src/Exercicio.tex && ${LATEX} Src/Exercicio.tex

clean:
	rm -v *.pdf
	rm -v Img/*.pdf
