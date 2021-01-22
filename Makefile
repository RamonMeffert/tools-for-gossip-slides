NAME=0_presentation
all: $(NAME).pdf

# You want latexmk to *always* run, because make does not have all the info.
# Also, include non-file targets in .PHONY so they are run regardless of any
# file of the given name existing.
.PHONY: $(NAME).pdf all clean

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interaction=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

$(NAME).pdf: $(NAME).tex
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make $(NAME).tex

preview:
	latexmk -pvc -pdf -pdflatex="pdflatex -synctex=1 -interaction=nonstopmode" -use-make $(NAME).tex

clean:
	latexmk -CA
	
sources:
	bibtex-tidy --omit=file,abstract,rights,url,urldate,isbn,issn,location --numeric --sort=sortname,author,year --duplicates --sort-fields --encode-urls literature.bib