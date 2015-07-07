LATEX = pdflatex -interaction nonstopmode -file-line-error
RM = rm -f

all: document.pdf

.PHONY: all clean clean-document clean-document-build

clean: clean-document

document.pdf: document.tex
	$(MAKE) clean-$(@:.pdf=) # if the pdftex build fails fatally, we don’t want the old pdf laying around and confusing the user
	-$(LATEX) $< 2>&1 > /dev/null # initial build
#	-makeglossaries $(@:.pdf=) # initial glossary
#	-$(LATEX) $< 2>&1 > /dev/null # include glossary in document
#	-makeglossaries $(@:.pdf=) # include glossary cross-refs in glossary
	-$(LATEX) $< # add glossary to TOC

spell: document.tex
	hunspell -t -d de_DE,en_US document.tex

clean-document: clean-document-build
	-$(RM) document.pdf

clean-document-build:
	-$(RM) document.aux document.glg document.glo document.gls document.ist document.log document.out document.toc document.synctex.gz
