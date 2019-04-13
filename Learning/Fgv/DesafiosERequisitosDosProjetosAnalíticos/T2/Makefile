LATEX_OUTPUT_DIR = Gen
LATEX_SRC_DIR = Src/Tex
R_SRC_DIR = Src/R
PDFLATEX_OPTIONS = -output-directory $(LATEX_OUTPUT_DIR) -shell-escape

all:
	#make images
	make trabalho

images:
	R --no-save < $(R_SRC_DIR)/script.R

trabalho:
	mkdir -pv $(LATEX_OUTPUT_DIR)
	cp -v $(LATEX_SRC_DIR)/referencias.bib $(LATEX_OUTPUT_DIR)
	TEXINPUTS="$(LATEX_SRC_DIR):" TEXMFOUTPUT="$(LATEX_OUTPUT_DIR):" pdflatex $(PDFLATEX_OPTIONS) $(LATEX_SRC_DIR)/trabalho.tex
	#BIBINPUTS="$(LATEX_SRC_DIR):" TEXMFOUTPUT="$(LATEX_OUTPUT_DIR):" bibtex Gen/trabalho
	TEXINPUTS="$(LATEX_SRC_DIR):" TEXMFOUTPUT="$(LATEX_OUTPUT_DIR):" pdflatex $(PDFLATEX_OPTIONS) $(LATEX_SRC_DIR)/trabalho.tex

clean:
	rm -frv Gen/*
