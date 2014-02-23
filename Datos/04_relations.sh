#!/bin/bash

cd sg_infectious_contact_list/

awk_body='{if($1<$2) print $1,$2;else print $2,$1}'

ls *.txt | parallel -j +0 --eta "cat {} | cut -f2,3 | awk '$awk_body' | sort | uniq | wc -l > {.}.out"

cat *.out > relations.out

awk 'BEGIN {sum = 1}; {print sum++ "|" $1}' relations.out > relations.psv

rm *.out

mv relations.psv ../