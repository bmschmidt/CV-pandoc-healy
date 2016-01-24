all: CV.pdf

#pdf:   clean $(PDFS)
#html:  clean $(HTML)

CV.pdf: CV.tex
	xelatex CV
	biber CV
	xelatex CV
	xelatex CV

CV.tex: yaml_CV.md template_for_long_CV.tex
	# Pandoc does the initial compilation to tex; we let latex handle the actual bibliography
	# and pdf creation.
	pandoc --template=./template_for_long_CV.tex -t latex yaml_CV.md > CV.tex
	# Citekeys get screwed up by pandoc which escapes the underscores.
	# Years should have en-dashes.	
	perl -pi -e 'if ($$_=~/cite\{/) {s/\\_/_/g}; s/(\d{4})-([Pp]resent|\d{4})/$$1--$$2g/' CV.tex;

clean:
	rm -f CV.aux CV.bcf CV.log CV.out CV.run.xml CV.pdf CV.tex

