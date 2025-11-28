#!/bin/bash

while IFS= read -r cmd; do
    echo "$cmd" >> ./output.txt               # write the command itself
    eval "$cmd" 2>&1 | sed 's/^/    /' >> ./output.txt   # run command and indent result
done < <(rm ./output.txt | curl https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/tutorials/rfsoc/tut_platform.html | grep "reference external" | grep -oP '(?<=href=")[^"]*(?=")' | sed 's#^\./#https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/tutorials/rfsoc/#g' | sed 's/^/curl -I /')
