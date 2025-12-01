#!/bin/bash

COMMAND="./chat_updated_command_with_dest_args.sh"
MAIN_DIRECTORY="page_links_reports/tutorial_pages/"
RFSOC_MAIN_DIRECTORY="page_links_reports/tutorial_pages/RFSOC"
STRD_URL_APP="https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/"
STRD_URL_RFSOC="https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/tutorials/rfsoc/"


# Main Tutorial Heading
"$COMMAND" "$MAIN_DIRECTORY" "${MAIN_DIRECTORY}CHAT_SH_VARS_TUT_MAIN_AGE.txt" "${STRD_URL_APP}index.html" "$STRD_URL_APP"

# RFSOC TUTORIALS
## CASPER README
"$COMMAND" "$RFSOC_MAIN_DIRECTORY" "${RFSOC_MAIN_DIRECTORY}readme.txt" "${STRD_URL_RFSOC}readme.html" "$STRD_URL_RFSOC"
