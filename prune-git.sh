#!/usr/bin/env bash

# Script created to study more about CLI tools using shell script (bash).
# Reference:
# https://www.redhat.com/sysadmin/arguments-options-bash-scripts

# https://explainshell.com/explain?cmd=set+-eu
set -eu

help () {
    # Display Help
    echo "Clean your local branches, leaving only the main branch."
    echo
    echo "Syntax: script [-h|-b]"
    echo "options:"
    echo "h     Print this help."
    echo "b     Define the name of the main branch."
    echo "v     Toggle verbosity."
}

verbose () {
    set -x
}

while getopts ":hvb:" option; do
    case $option in
        h) # display help
            help
            exit 0;;
        v) # toggle verbosity
            verbose;;
        b) # run the main script
            MAIN_BRANCH="${OPTARG}";;
        \?) # invalid option
            echo "Error: Invalid option."
            echo "Use the -h to print the help manual."
            exit 1;;
    esac
done

git checkout "${MAIN_BRANCH}"
# fetch the latest from git
git fetch
# see the list of local git branches
# git branch
# delete all local branches that have been merged to main branch
git branch --merged "${MAIN_BRANCH}" |\
    grep -v "^\* ${MAIN_BRANCH}" |\
    xargs -n 1 -r git branch -d
