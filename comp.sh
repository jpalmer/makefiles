#!/bin/bash
#compile the latex file given as the first argument
FILE=$1
PDFFILE=`echo $FILE | sed 's/.tex/.pdf/g'`
AUXFILE=`echo $FILE | sed 's/.tex/.aux/g'`
pdflatex $FILE  || (echo failure ; rm $PDFFILE ; exit 1) #first compile
bibtex $AUXFILE
pdflatex $FILE
#final compile
Result=`pdflatex $FILE`

echo "--------------------"
echo "Warnings"
echo "$Result" | grep -o 'Warning.*\|[a-x]*\.tex' #for multi-line files show which file has the warning
echo "--------------------"
pdfinfo $PDFFILE | grep -i pages #note this can be > 40 (some sections are allowed to be longer than  page but only count as 1 - particularly bibliography
echo "--------------------"

