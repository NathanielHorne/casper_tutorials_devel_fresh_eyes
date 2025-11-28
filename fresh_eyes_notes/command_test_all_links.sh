#!/bin/bash

while IFS= read -r cmd; do
    echo "$cmd" >> fresh_eyes_notes/output.txt               # write the command itself
    eval "$cmd" 2>&1 | sed 's/^/    /' >> fresh_eyes_notes/output.txt   # run command and indent result
done < <(curl https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/tutorials/rfsoc/tut_platform.html | grep "reference external" | grep -oP '(?<=href=")[^"]*(?=")' | sed 's#\./#https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/tutorials/rfsoc/#g' | sed 's/^#/https:\/\/casper-toolflow.readthedocs.io\//g' | sed 's/^/curl -I /')

