#!/bin/bash

# Implement try-catch statements in bash scripts

export ERR_BAD=100
export ERR_WORSE=101
export ERR_CRITICAL=102


function try()
{
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set +e
}

function throw()
{
    exit $1
}

function catch()
{
    export exception_code=$?
    (( $SAVED_OPT_E )) && set +e
    return $exception_code
}

function throwErrors()
{
    set -e
}

function ignoreErrors()
{
    set +e
}
