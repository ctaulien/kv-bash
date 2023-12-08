#!/bin/bash

cd $(dirname ${0})

source ../kv-bash
LINE=0

VERBOSE="$2"

FAIL="\e[01;31mFAIL\e[0m"
OK="\e[01;32mOK\e[0m"

while IFS= read -r i
do
    LINE=$(( $LINE + 1 ))
    [[ "$i" =~ ^\ *\# ]] && { echo "$i"; continue; }
    [[ "$i" =~ ^\ *$ ]] && { echo "$i"; continue; }

    expect="${i%:*}"
    key="${i##*:}"

    if [[ ! "${expect}" =~ ^(ok|fail)$ ]]
    then
        echo -e "[$FAIL] line $LINE: invalid expectation '$expect' for key ${key}"
        continue;
    fi

    if kv_validate_key "$key"
    then
        [ "${expect}" == "fail" ] && {
            echo -e "[$FAIL] line $LINE: expected to fail, but was ok: ${key}"
            [ "$VERBOSE" == "-vv" ] && kv_validate_key "$key" 1
        } || {
            [ "$VERBOSE" ] && echo -e "[ $OK ] line $LINE: expected to pass: ${key} "
        }
    else
        [ "${expect}" == "ok" ] && {
            echo -e "[$FAIL] line $LINE: expected to pass, but failed: ${key}"
            [ "$VERBOSE" == "-vv" ] && kv_validate_key "$key" 1
        } || {
            [ "$VERBOSE" ] && echo -e "[ $OK ] line $LINE: expected to fail: ${key} "
        }
    fi
done <"${1}"

exit 0