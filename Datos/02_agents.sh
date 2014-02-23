#!/bin/bash

cd sg_infectious_contact_list/

awk_body='{print $2"\n" $3}'

ls *.txt | parallel -j +0 --eta "cat {} | awk '$awk_body' | sort | uniq | wc -l > {.}.out"

cat *.out > agents.out

awk 'BEGIN {sum = 1}; {print sum++ "|" $1}' agents.out > agents.psv

rm *.out

mv agents.psv ../