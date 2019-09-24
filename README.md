# Structured data Curriculum Vita.

## Inspirations

These are templates designed to do four things:

1. Make a nice [Latex CV modeled on Kieran Healy's template](https://github.com/kjhealy/kjh-vita).
2. Do it with a clean `.sty` file that separates out content from style, copied from [James Keirstead's adaptation of Healy's CV](https://github.com/jkeirstead/jk-vita/tree/master/content)
3. Follow [Mattia Tezzele's strategy of storing the CV as structured YAML data that can be easily reconfigured, and then compiling the document out of that YAML using Pandoc.](http://mrzool.cc/writing/typesetting-automation/)
4. Simultaneously allow you to keep up alternate CVs (for instance, a 'short' two-page CV and a 'complete' longer version) from a single set of metadata, so you can edit a single file and change both.

The last is the most important; it means that I can have a short CV for grants and a long CV for keeping track of everything generated off the same base data; this is otherwise hard.

I've drifted far enough from any of those that it doesn't quite make sense to treat this repo as a fork (of either Healy or Keirstead).

[Here's **an example** of the CV output by this repository.](http://benschmidt.org/SchmidtCV.pdf) Note that you won't be able to build this locally from the repo without a copy of my personal `.bib` file, which stores publications; you'll need to create your own and specify the location in the obvious spot in "curriculum_vitae.yaml".

## Usage

`make` to build my CV in short and long form, sans citations. Though I don't know why you'd want to build my CV.

### Repurposing.

You could change around some of the details in the YAML file and build
your own CV. It's likely that you'll also need to define a biblatex
citation bibliography somewhere (which is done in the first part of
the YAML block). And you'd probably need to fudge around with the latex to change
to citation parameters of your choice; and potentially remake the individual blocks along
the model I give here.

## Additions

The basic `.sty` file is from Keirstead, with a few portions (the funky little Twitter icon from fontawesome) folded back in from Healy's CV.

Like Keirstead, I use latex for citations. (You don't have to; it can also just guess at the format from YAML data, although the Pandoc DSL for doing so makes for pretty inscrutable code.) In mine, that means that certain fields allow the presence of a 'citekey' indicator.

I use the `biblatex-chicago` plugin, which (among other things that I've never gotten biblatex to do) properly differentiates newspaper articles from journal articles. (In general, I've found base biblatex inscrutable for all sorts of humanities-style citations). Because of that `biblatex-chicago` dependency, you'll need to export a `.bib` file that matches biblatex-chicago's expectations, or change the citation package in the latex template file. If you want biblatex-chicago form Zotero, I've written a [biblatex-chicago translator for Zotero; you can pull that from my fork of the Zotero translators library](https://github.com/bmschmidt/translators).

## Shortcomings

There are some complications.

1. Ideally this wouldn't be using biblatex-chicago; it would just use some type of CSL with pandoc-style keys. But AFAICT, you can put a pandoc-style key into the YAML metadata, only into the body text.
2. For some types (eg, talks) the YAML categories are pretty clear. For others (eg, "Public History") there's just a single entry on 'item.' For nothing is "year" separately defined as a key, which might be nice.
3. I have no defined style for which items must end with a period and which not. You'll have to proofread. 

## Next steps.

### Pandoc-citeproc processing.

In my desire to use less latex, I'd much rather be using pandoc and a custom-defined CSL than biblatex. I'm sure that's possible: I just don't know how. See above on how you can't put a pandoc-style citation into YAML metadata. I'm sure there's an obvious solution that I'm missing here.

### YAML pre-processing

An advantage of using YAML here is that we could use Python or another scripting language to do some useful pre-processing. This might mean
  * integrity checks for different item types
  * sorting by date
  * or anything else.

Keirstead uses R for this purpose; parsing YAML in R sounds a little yucky to me. So python it should be; but for now I like that there's no scripting outside of the pandoc DSL, which is one of the weakest DSLs I've seen. 

I've currently hard-wired in this distinction between "academic" and "general audience" publications through the tags field. But the YAML could actual be reconfigured to automatically nest the two things from an original flat-level file, which would be much cleaner.

### NSF-style CV

If I keep doing NSF grants, it would be good to have something that makes things in their nutty style.

### Standardize **everything**

Really, what this *should* be is a standard YAML form for describing academic accomplishments which could then be parsed in all sorts of ways. The YAML structure could drive an "upcoming talks" widget on a jekyll that would use fields (like time of day) inappropriate for a CV. It could generate annual reports for departmental review. It could automatically add citations of everything you write to each one of your future papers, boosting your k-score.

With sufficiently advanced machine learning, maybe it could even fetch your articles using a DOI, generate and submit new articles in the same style, thus freeing up more of your time to work on polishing your CV instead of doing any actual goddamn work for once.

