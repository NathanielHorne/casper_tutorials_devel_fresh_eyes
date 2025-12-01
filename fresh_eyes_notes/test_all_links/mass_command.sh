#!/bin/bash

LINK_COMMAND="./test_link_command.sh"
ERROR_COMMAND=(grep -Pzo 'curl -I [^\n]+(?:\n(?!curl -I )[^\n]*)*?(?:(?!HTTP\/1\.1 200 OK).)*(?=curl -I|\Z)')


MAIN_DIRECTORY="page_links_reports/tutorial_pages/"
STRD_URL_APP="https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/"

RFSOC_MAIN_DIRECTORY="page_links_reports/tutorial_pages/RFSOC/"
RFSOC_STRD_URL="https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/tutorials/rfsoc/"

# Main Tutorial Heading
printf "MAIN TUTORIAL PAGE\n"
"$LINK_COMMAND" "$MAIN_DIRECTORY" "${MAIN_DIRECTORY}index.txt" "${STRD_URL_APP}index.html" "$STRD_URL_APP" |  "${ERROR_COMMAND[@]}" "${MAIN_DIRECTORY}index.txt" > "${MAIN_DIRECTORY}index_errors.txt"

# RFSOC TUTORIALS
[ -f "${RFSOC_MAIN_DIRECTORY}total_errors.txt" ] && rm -rf "${RFSOC_MAIN_DIRECTORY}total_errors.txt" 
touch "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
printf "RFSOC TUTORIALS\n"

## CASPER README
printf "\tCASPER README\n"
"$LINK_COMMAND" "$RFSOC_MAIN_DIRECTORY" "${RFSOC_MAIN_DIRECTORY}readme.txt" "${RFSOC_STRD_URL}readme.html" "$RFSOC_STRD_URL" | "${ERROR_COMMAND[@]}" "${RFSOC_MAIN_DIRECTORY}readme.txt" > "${RFSOC_MAIN_DIRECTORY}readme_errors.txt"
printf "\n" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
printf '%.0s-' {1..80} >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
printf "CASPER README\n" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
cat "${RFSOC_MAIN_DIRECTORY}readme_errors.txt" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"

## GETTING STARTED
printf "\tGETTING_STARTED\n"
"$LINK_COMMAND" "$RFSOC_MAIN_DIRECTORY" "${RFSOC_MAIN_DIRECTORY}tut_getting_started.txt" "${RFSOC_STRD_URL}tut_getting_started.html" "$RFSOC_STRD_URL" | "${ERROR_COMMAND[@]}" "${RFSOC_MAIN_DIRECTORY}tut_getting_started.txt" > "${RFSOC_MAIN_DIRECTORY}tut_getting_started_errors.txt"
printf "\n" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
printf '%.0s-' {1..80} >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
printf "GETTING STARTED\n" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
cat "${RFSOC_MAIN_DIRECTORY}tut_getting_started_errors.txt" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"

## TUTORIAL 1
printf "\tTUTORIAL 1\n"
"$LINK_COMMAND" "$RFSOC_MAIN_DIRECTORY" "${RFSOC_MAIN_DIRECTORY}tut_platform.txt" "${RFSOC_STRD_URL}tut_platform.html" "$RFSOC_STRD_URL" | "${ERROR_COMMAND[@]}" "${RFSOC_MAIN_DIRECTORY}tut_platform.txt" > "${RFSOC_MAIN_DIRECTORY}tut_platform_errors.txt"
printf "\n" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
printf '%.0s-' {1..80} >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
printf "TUTORIAL 1\n" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
cat "${RFSOC_MAIN_DIRECTORY}tut_platform_errors.txt" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"

## TUTORIAL 2
printf "\tTUTORIAL 2\n"
"$LINK_COMMAND" "$RFSOC_MAIN_DIRECTORY" "${RFSOC_MAIN_DIRECTORY}tut_rfdc.txt" "${RFSOC_STRD_URL}tut_rfdc.html" "$RFSOC_STRD_URL" | "${ERROR_COMMAND[@]}" "${RFSOC_MAIN_DIRECTORY}tut_rfdc.txt" > "${RFSOC_MAIN_DIRECTORY}tut_rfdc_errors.txt"
printf "\n" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
printf '%.0s-' {1..80} >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
printf "TUTORIAL 2\n" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
cat "${RFSOC_MAIN_DIRECTORY}tut_rfdc_errors.txt" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"

## TUTORIAL 3-1
printf "\tTUTORIAL 3-1\n"
"$LINK_COMMAND" "$RFSOC_MAIN_DIRECTORY" "${RFSOC_MAIN_DIRECTORY}tut_dac.txt" "${RFSOC_STRD_URL}tut_dac.html" "$RFSOC_STRD_URL" | "${ERROR_COMMAND[@]}" "${RFSOC_MAIN_DIRECTORY}tut_dac.txt" > "${RFSOC_MAIN_DIRECTORY}tut_dac_errors.txt"
printf "\n" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
printf '%.0s-' {1..80} >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
printf "TUTORIAL 3-1\n" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
cat "${RFSOC_MAIN_DIRECTORY}tut_dac_errors.txt" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"

## TUTORIAL 3-2
printf "\tTUTORIAL 3-2\n"
"$LINK_COMMAND" "$RFSOC_MAIN_DIRECTORY" "${RFSOC_MAIN_DIRECTORY}tut_spec.txt" "${RFSOC_STRD_URL}tut_spec.html" "$RFSOC_STRD_URL" | "${ERROR_COMMAND[@]}" "${RFSOC_MAIN_DIRECTORY}tut_spec.txt" > "${RFSOC_MAIN_DIRECTORY}tut_spec_errors.txt"
printf "\n" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
printf '%.0s-' {1..80} >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
printf "TUTORIAL 3-2\n" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
cat "${RFSOC_MAIN_DIRECTORY}tut_spec_errors.txt" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"

## TUTORIAL 4
printf "\tTUTORIAL 4\n"
"$LINK_COMMAND" "$RFSOC_MAIN_DIRECTORY" "${RFSOC_MAIN_DIRECTORY}tut_100g.txt" "${RFSOC_STRD_URL}tut_100g.html" "$RFSOC_STRD_URL" | "${ERROR_COMMAND[@]}" "${RFSOC_MAIN_DIRECTORY}tut_100g.txt" > "${RFSOC_MAIN_DIRECTORY}tut_100g_errors.txt"
printf "\n" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
printf '%.0s-' {1..80} >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
printf "TUTORIAL 4\n" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
cat "${RFSOC_MAIN_DIRECTORY}tut_100g_errors.txt" >> "${RFSOC_MAIN_DIRECTORY}total_errors.txt"
