#!/bin/bash
# Utility to convert a FILE to booklet print ready
# $Id: $
PROG_NAME=$(basename $0)
PRINTER="laser"
USAGE="Usage: ${PROG_NAME} [-P printer] file"

# Checking the presence of at least the required parameter
if [ ${#} == 0 ];then
    echo $USAGE
    exit 2
fi

# Parsing option parameters
while getopts ":P:" opt; do
  case $opt in
      P)
          if [[ -z "${OPTARG}" ]];then
              echo $USAGE
              exit 2
          fi
          PRINTER=${OPTARG}
          ;;
      \?)
          echo $USAGE
          exit 1;;
  esac
done
shift $((OPTIND - 1))
# Handing over to mandatory parameters
# .............................................

# Parsing mandatory parameters
if [ ${#} == 0 ];then
    echo $USAGE
    exit 2
fi
FILE=${1%.pdf}
echo "Using file: ${FILE} and printer: ${PRINTER}"

# Removing whitespace
echo "$ pdfcrop $FILE.pdf --margins 12"
pdfcrop $FILE.pdf --margins 12

# Stopping execution if file not present
if [ $? != 0 ];then
    echo $USAGE
    exit 2
fi

# Booklet printing
echo "pdfbook $FILE-crop.pdf --suffix final"
pdfbook $FILE-crop.pdf --suffix final

echo "Book written to $FILE-crop-final.pdf"
echo "Cleaning up .."
rm $FILE-crop.pdf

# Printing option
echo -ne "Print the file?[Y/N]:"
read option
if [ "$option" == 'y' -o  "$option" == "Y" ] 
then
    echo "$ lpr -P $PRINTER -o landscape $FILE-crop-final.pdf"
    lpr -P $PRINTER -o landscape $FILE-crop-final.pdf
fi
echo "Finished"
exit 1
#*************************************************************
