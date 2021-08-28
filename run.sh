#!/usr/bin/env bash
#################################################
# A helper script to manage benchmarking stuff. #
#################################################
set -e
SUITE_NAME="$2"
export FORCE_TIMES_TO_RUN=1
installed=$(which phoronix-test-suite)

if [[ ! -f ${installed} ]]; then eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; fi

if [[ $1 = -i ]]; then
    mkdir -p "${HOME}/.phoronix-test-suite/test-suites/local/${SUITE_NAME}"
    cp -f "pts/test-suites/local/${SUITE_NAME}/suite-definition.xml" \
          "${HOME}/.phoronix-test-suite/test-suites/local/${SUITE_NAME}/suite-definition.xml"
    phoronix-test-suite install "${SUITE_NAME}"
elif [[ $1 = -r ]]; then
    echo "Start your engines..."
    sleep 1
    echo "3"
    sleep 0.1
    echo "2"
    sleep 0.1
    echo "1"
    sleep 0.1
    echo "GO!!"
    phoronix-test-suite batch-run "${SUITE_NAME}"
elif [[ $1 = -l ]]; then
    ls pts/test-suites/local/
elif [[ $1 = -b ]]; then
    mkdir -p "pts/test-suites/local/${SUITE_NAME}"
    cp -R "${HOME}/.phoronix-test-suite/test-suites/local/${SUITE_NAME}/suite-definition.xml" \
          "pts/test-suites/local/${SUITE_NAME}/suite-definition.xml"
else
    echo "Available options:"
    echo "-i: install a test suite."
    echo "-r: run a test suite."
    echo "-l: list test suites."
    echo "-b: backport test suite from pts install to benchmark git repo."
fi
