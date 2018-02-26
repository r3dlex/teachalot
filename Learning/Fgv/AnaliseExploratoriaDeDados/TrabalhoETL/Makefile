LATEX_OUTPUT_DIR = Gen
LATEX_IMAGES_INPUT_DIR = Image
LATEX_OUTPUT_IMAGE_DIR = $(LATEX_OUTPUT_DIR)/Image
LATEX_SRC_DIR = Src/Tex
R_SRC_DIR = Src/R
PDFLATEX_OPTIONS = -output-directory $(LATEX_OUTPUT_DIR) -shell-escape
VECTOR_IMAGES = $(shell ls $(LATEX_IMAGES_INPUT_DIR)/*.svg)
INKSCAPE_INPUT_OPTIONS = -E
INKSCAPE_OUTPUT_OPTIONS = --export-ignore-filters --export-ps-level=3
SUFFIX_SVG = .svg

all:
	make images
	make trabalho

images:
	#R --no-save < $(R_SRC_DIR)/script.R
	mkdir -pv $(LATEX_OUTPUT_IMAGE_DIR)
	$(foreach vector_image, $(VECTOR_IMAGES), inkscape $(vector_image) $(INKSCAPE_INPUT_OPTIONS) $(LATEX_OUTPUT_IMAGE_DIR)/$(shell basename -s $(SUFFIX_SVG) $(vector_image)).eps $(INKSCAPE_OUTPUT_OPTIONS);)

trabalho:
	mkdir -pv $(LATEX_OUTPUT_DIR)
	cp -v $(LATEX_SRC_DIR)/referencias.bib $(LATEX_OUTPUT_DIR)
	TEXINPUTS="$(LATEX_SRC_DIR):" TEXMFOUTPUT="$(LATEX_OUTPUT_DIR):" pdflatex $(PDFLATEX_OPTIONS) $(LATEX_SRC_DIR)/trabalho.tex
	#BIBINPUTS="$(LATEX_SRC_DIR):" TEXMFOUTPUT="$(LATEX_OUTPUT_DIR):" bibtex Gen/trabalho
	TEXINPUTS="$(LATEX_SRC_DIR):" TEXMFOUTPUT="$(LATEX_OUTPUT_DIR):" pdflatex $(PDFLATEX_OPTIONS) $(LATEX_SRC_DIR)/trabalho.tex

clean:
	rm -frv Gen/*
