#!/bin/bash
#Downloads files from XKC

start_range=$1
end_range=$2
#echo $end_range 

#ensure range is within limits and has arguments
if [ $# -lt 2 ]; then
  echo "Usage: $0 start_range end_range"
  exit
fi

if [ $start_range -gt $end_range ]; then
  echo "start_range cannot be after end_range"
  exit
fi

let range=$end_range-$start_range

if [ $range -gt 20 ]; then
  echo "Range, i.e. end_range - start_range, cannot be greater than 20"
  exit
fi

#download pages
if [ $start_range = $end_range ] ; then
  curl -s 'http://xkcd.com/'$start_range'/' -o '#1.html'
else
  curl -s 'http://xkcd.com/['$start_range-$end_range']/' -o '#1.html'
fi

#if egrep -w -q "404 - Not Found" *.html  ; then
 # echo "1 or more of your images could not be downloaded"
  #rm *.html
#fi

#find image location
grep -oh 'http://imgs.xkcd.com/comics/.*png' *.html > url.txt
grep -oh 'http://imgs.xkcd.com/comics/.*jpg' *.html > url2.txt

#checks if no images are available for download, exits if so
if [[ -s url.txt ]] ; then 
:
elif [[ -s url2.txt ]] ; then
:
else
  echo "No selected images are available for download"
  rm url*
  rm *.html
  exit
fi

#checks for 404 error
if egrep -w -q "404 - Not Found" *.html ; then
  echo "1 or more of your images could not be downloaded"
fi

#create file to downlowd to
mkdir -p ./xkdc_comics

#download images
sort -u url.txt | wget -q -P ./xkdc_comics -i- > extra.txt
sort -u url2.txt | wget -q -P ./xkdc_comics -i- > extra.txt

#create .tar file
tar czf xkdc_comics.tar xkdc_comics

#remove extra files
rm -r ./xkdc_comics
rm *.html
rm url.txt
rm url2.txt
rm extra.txt

exit
