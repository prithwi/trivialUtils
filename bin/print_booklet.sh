#!/bin/bash
# Utility to convert a FILE to booklet print ready
# $Id: $


FILE=$(echo $1 | sed 's/.pdf//')

echo "$ pdfcrop $FILE.pdf --margins 12"
pdfcrop $FILE.pdf --margins 12

echo "pdfbook $FILE-crop.pdf --suffix final"
pdfbook $FILE-crop.pdf --suffix final

echo "Book written to $FILE-crop-final.pdfcrop-final"
echo "Cleaning up .."
rm $FILE-crop.pdf
echo "Finished"
