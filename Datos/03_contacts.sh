#!/bin/bash

cd sg_infectious_contact_list/

ls *.txt | parallel -j +0 --eta "cat {} | wc -l > {.}.out"

cat *.out > contacts.out

awk 'BEGIN {sum = 1}; {print sum++ "|" $1}' contacts.out > contacts.psv

rm *.out

mv contacts.psv ../