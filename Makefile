all: CV.pdf

#pdf:   clean $(PDFS)
#html:  clean $(HTML)

CV.pdf: CV.tex
	xelatex CV
	biber CV
	xelatex CV
	xelatex CV

yaml_CV.md: curriculum_vitae.yaml
# Pandoc can't actually read YAML, just YAML block in
# Markdown. So we fudge it.
	echo "---" > $@
	cat $< >> $@
	echo "..." >> $@

CV.tex: yaml_CV.md template_for_long_CV.tex
# Pandoc does the initial compilation to tex; we then latex handle the actual bibliography
# and pdf creation.
	pandoc --template=./template_for_long_CV.tex -t latex yaml_CV.md > CV.tex
# Citekeys get screwed up by pandoc which escapes the underscores.
# Years should have en-dashes, which damned if I'm going to do it
# on my own.
	perl -pi -e 'if ($$_=~/cite\{/) {s/\\_/_/g}; s/(\d{4})-([Pp]resent|\d{4})/$$1--$$2/g' CV.tex;

clean:
	rm -f CV.aux CV.bcf CV.log CV.out CV.run.xml CV.pdf CV.tex CV.bbl CV.blg yaml_CV.md

