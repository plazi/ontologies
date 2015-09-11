#!/bin/bash
# shell script to produce rdf/xml from n3
if [ "$#" == 0 ]; then
  echo "usage: $0 [filename].n3"
  exit 0
fi

fullfile=$1
filename=$(basename "$fullfile")
extension="${filename##*.}"
filename="${filename%.*}"
#echo $filename $extension
if [ "$extension" == "n3" ]; then

   curl --data-urlencode  content@$fullfile http://rdf-translator.appspot.com/convert/n3/xml/content > $filename.xml
   echo "" >> $filename.xml 
   comment="<!- xml generated from ""$fullfile"" by rdf-translator.appspot.com on " 
   now=`date`
   endc=" -->"
   comment=${comment}$now$endc
   echo $comment  >> $filename.xml

else
 echo "$fullfile must be an N3 file with extension 'n3'"
fi
