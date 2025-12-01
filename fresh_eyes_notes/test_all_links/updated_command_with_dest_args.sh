#!/bin/bash

mkdir -p $1 && [ -f $2 ] || touch $2

while IFS= read -r cmd; do
    echo "$cmd" >> $2               # write the command itself
    eval "$cmd" 2>&1 | sed 's/^/    /' >> $2   # run command and indent result
done < <(rm -f $2 | curl $3 | grep "reference external" | grep -oP '(?<=href=")[^"]*(?=")' | sed "s#^\./#$4#g" | sed "/^#/d" |  sed 's/^/curl -I /')
