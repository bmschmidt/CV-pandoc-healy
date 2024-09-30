
all: vc.tex validate_yaml long_CV.pdf short_CV.pdf resume_CV.pdf

SchmidtCV.pdf:
	cp long_CV.pdf $@

validate_yaml:
	@python3 -c 'import yaml,sys;yaml.safe_load(sys.stdin)' < curriculum_vitae.yaml

%_CV.pdf: curriculum_vitae.yaml vc.tex
	echo "" | pandoc -f markdown --template template_for_$*_CV.tex --metadata-file curriculum_vitae.yaml --pdf-engine xelatex -o $@

vc.tex: curriculum_vitae.yaml
	sh vc.sh

hrm:
# Years should have en-dashes, which damned if I'm going to do it
# on my own.
	perl -pi -e 'if ($$_=~/cite\{/) {s/\\_/_/g}; s/(\d{4})-([Pp]resent|\d{4})/$$1--$$2/g' $@;

clean:
	-rm -f *CV.aux *CV.bcf *CV.log *CV.out *CV.run.xml *CV.pdf short_CV.tex long_CV.tex *CV.bbl *CV.blg *yaml_CV.md