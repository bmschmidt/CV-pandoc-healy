# Structured data Curriculum Vita.

## Inspirations

These are templates designed to do four things:

1. Make a nice [Latex CV modeled on Kieran Healy's template](https://github.com/kjhealy/kjh-vita).
2. Do it with a clean `.sty` file that separates out content from style, copied from [James Keirstead's model](https://github.com/jkeirstead/jk-vita/tree/master/content)
3. Follow's [Mattia Tezzele's strategy of storing the CV as structured YAML data that can be easily reconfigured, and then compiling the document out of that YAML using Pandoc.](http://mrzool.cc/writing/typesetting-automation/)
4. Simulataneously allow you to keep up alternate CVs (for instance, a 'short' two-page CV) from a single file.

I've drifted far enough from any of those that it doesn't quite make sense to treat this repo as a fork (of either Healy or Keirstead).

[Here's **an example** of the CV output by this repository.](http://benschmidt.org/SchmidtCV.pdf)

## Usage

`make` to build my CV in short and long form. Though I don't know why you'd want to build my CV.

### Repurposing.

You could change around some of the details in the YAML file and build
your own CV. It's likely that you'll also need to define a biblatex
citation bibliography somewhere (which is done in the first part of
the YAML block. And you'd probably need to fudge around with the 


## Additions

The basic `.sty` file is from Keirstead, with a few portions (the funky little Twitter icon from fontawesome) folded back in from Healy's CV.

Like Keirstead, I use latex for citations. (You don't have to; it can also just guess at the format from YAML data, although the Pandoc DSL for doing so makes for pretty inscrutable code.) In mine, that means that certain fields allow the presence of a 'citekey' indicator.

I usually use the `biblatex-chicago` plugin, which (among other things that I've never gotten biblatex to do) properly differentiates newspaper articles from journal articles. Because of that `biblatex-chicago` dependency, you'll need to export a `.bib` file that matches biblatex-chicago's expectations or change the citation language around a bit. I've written a [biblatex-chicago translator for Zotero; you can pull that from my fork of the Zotero translators library](https://github.com/bmschmidt/translators).

## Shortcomings

There are some complications.

1. Ideally this wouldn't be using biblatex-chicago; it would just use of CSL with pandoc-style keys. But AFAIK, you can put a pandoc-style key into the YAML metadata, only into the body text.
2. Pandoc can't load a yaml file, so instead the CV is stored as a Markdown file with a huge YAML header and no body text. This is a little kludgy, but works perfectly fine.
4. For some types (eg, talks) the YAML categories are pretty clear. For others (eg, "Public History") there's just a single entry on 'item.' For nothing is "year" separately defined as a key, which might be nice.
5. I have no defined style for which items must end with a period and which not. You'll have to proofread. 

## Next steps.

### Pandoc-citeproc processing.

In my desire to use less latex, I'd much rather be using pandoc and a custom-defined CSL than biblatex. I'm sure that's possible: I just don't know how. See above on how you can't put a pandoc-style citation into YAML metadata. I'm sure there's an obvious solution that I'm missing here.

### YAML pre-processing

The real point of using YAML here is that we ciykd use Python to do some useful pre-processing. This might mean integrity checks for different item types, sorting by date, or anything else.

I've currently hard-wired in this distinction between "academic" and "general audience" publications through the tags field. But the YAML could actual be reconfigured to automatically nest the two things from an original flat-level file.

The short CV might be identified by having a tag that specifies if something is worth including on a two-page CV.

### NSF-style CV

If I keep doing NSF grants, it would be good to have something that makes things in their nutty style.

### Standardize **everything**

Really, what this *should* be is a standard YAML form for describing academic accomplishments which could then be parsed in all sorts of ways. The YAML structure could drive an "upcoming talks" widget on a website that would use fields (like time of day) inappropriate for a CV. It could generate annual reports for departmental review. It could automatically add citations of everything you write to each one of your future papers.

