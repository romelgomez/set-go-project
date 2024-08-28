#!/bin/bash

#
# Remove duplicate $PATH entries with awk command
# https://unix.stackexchange.com/a/40973
#

function clean_path() {
    echo "Remove duplicate \$PATH entries with awk command!"

    string=$PATH
    length=${#string}
    echo "The length of the PATH is $length. Before clean"

    if [ -n "$PATH" ]; then
        old_PATH=$PATH:
        PATH=
        while [ -n "$old_PATH" ]; do
            x=${old_PATH%%:*} # the first remaining entry
            case $PATH: in
            *:"$x":*) ;;        # already there
            *) PATH=$PATH:$x ;; # not there yet
            esac
            old_PATH=${old_PATH#*:}
        done
        PATH=${PATH#:}
        unset old_PATH x
    fi

    string=$PATH
    length=${#string}
    echo "The length of the PATH is $length. After clean!"
}

# clean_path
