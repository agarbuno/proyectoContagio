#!/bin/bash

cd sg_infectious_contact_list/

#gawk_body='BEGIN{ FS = "[ \t]+"} ; {print strftime("%c", $1), $2, $3}'
#gawk_body='BEGIN{ FS = "[ \t]+"} ; {print $1, $2, $3}'

#gawk "$gawk_body" listcontacts_2009_06_10.txt

#ls *.txt | parallel -j +0 --eta "cat {} | gawk $gwak_body > {.}.out"

cat *.txt > temp.txt 

gawk '{print strftime("%c", $1)"|"$2"|"$3}' temp.txt > dataset.txt

cut -d'|' -f1 dataset.txt | sed 's/  / /g' | sed 's/ /\|/g' > dates.txt
cut -d'|' -f2,3 dataset.txt > edges.txt
paste -d'|' dates.txt edges.txt > data.txt
cut -d'|' -f4 data.txt | awk -F':' '{print ($1 + ($2/60) + ($3/3600))+6 }' > hour.txt
paste -d'|' data.txt hour.txt > dataset.psv

rm temp.txt dataset.txt dates.txt data.txt hour.txt

mv dataset.psv ../