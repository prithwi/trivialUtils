#!/bin/bash

# $Id: $

FILE=$(echo $1 | sed 's/.pdf//')

echo "$ pdfcrop $FILE.pdf --margins 12"
pdfcrop $FILE.pdf --margins 12

echo "$ pdftops $FILE-crop.pdf"
pdftops $FILE-crop.pdf

echo "$ psbook $FILE-crop.ps book-$FILE.ps"
psbook $FILE-crop.ps book-$FILE.ps

echo "ps2pdf book-$FILE.ps book-$FILE.pdf"
ps2pdf book-$FILE.ps book-$FILE.pdf

echo "$ pdfnup book-$FILE.pdf --nup 2x1"
pdfnup book-$FILE.pdf --nup 2x1

echo "pdftk book-$FILE-2x1.pdf cat 1-endE output ready-$FILE.pdf"
pdftk book-$FILE-2x1.pdf cat 1-endE output ready-$FILE.pdf

echo "$FILE-crop.pdf $FILE-crop.ps book-$FILE.ps book-$FILE.pdf book-$FILE-2x1.pdf"
rm $FILE-crop.pdf $FILE-crop.ps book-$FILE.ps book-$FILE.pdf book-$FILE-2x1.pdf

