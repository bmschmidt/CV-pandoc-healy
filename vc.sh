#!/bin/sh
# This is file 'vc' from the vc bundle for TeX.
# The original file can be found at CTAN:support/vc.
# This file is Public Domain.

# Parse command line options.
full=0
mod=0
while [ -n "$(echo $1 | grep '-')" ]; do
    case $1 in 
       -f ) full=1 ;;
       -m ) mod=1 ;;
       *  ) echo 'usage: vc [-f] [-m]'
            exit 1
    esac
    shift
done
# English locale.
LC_ALL=C
git --no-pager log -1 HEAD --pretty=format:"Hash: %H%nAbr. Hash: %h%nParent Hashes: %P%nAbr. Parent Hashes: %p%nAuthor Name: %an%nAuthor Email: %ae%nAuthor Date: %ai%nCommitter Name: %cn%nCommitter Email: %ce%nCommitter Date: %ci%n" |gawk -v script=log -v full=$full -f vc-git.awk > vc.tex
if [ "$mod" = 1 ]
then
  git status |gawk -v script=status -f vc-git.awk >> vc.tex
fi
