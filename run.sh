#!/usr/bin/env bash
#################################################
# A helper script to manage benchmarking stuff. #
#################################################
set -e
SUITE_NAME="$2"
export FORCE_TIMES_TO_RUN=1
INSTALLED=$(which phoronix-test-suite)

# if pts ain't installed, we'll be lazy and install it via homebrew
if [[ ! -f ${INSTALLED} ]]; then eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; fi

# make sure our custom config is installed
cp -f "pts/user-config.xml" "${HOME}/.phoronix-test-suite/user-config.xml"

if [[ $1 = -i ]]; then # install the things
    mkdir -p "${HOME}/.phoronix-test-suite/test-suites/local/${SUITE_NAME}"
    cp -f "pts/test-suites/local/${SUITE_NAME}/suite-definition.xml" \
        "${HOME}/.phoronix-test-suite/test-suites/local/${SUITE_NAME}/suite-definition.xml"
    phoronix-test-suite install "${SUITE_NAME}"
elif [[ $1 = -r ]]; then # run the things
    echo "Start your engines..."
    sleep 1
    echo "3"
    sleep 0.2
    echo "2"
    sleep 0.1
    echo "1"
    sleep 0.1
    echo "GO!!"
    phoronix-test-suite batch-run "${SUITE_NAME}"
elif [[ $1 = -l ]]; then # list the currently installed things
    ls pts/test-suites/local/
elif [[ $1 = -b ]]; then # backport the new things from pts into the repo
    mkdir -p "pts/test-suites/local/${SUITE_NAME}"
    cp -R "${HOME}/.phoronix-test-suite/test-suites/local/${SUITE_NAME}/suite-definition.xml" \
        "pts/test-suites/local/${SUITE_NAME}/suite-definition.xml"
elif [[ $1 = -c ]]; then # copy remote test results to localhost for viewing
    USER=$2
    IP=$3
    CONNECTION_STRING="$USER@$IP"
    rsync -rv "$CONNECTION_STRING:/home/$USER/.phoronix-test-suite/test-results/*" .test-results/
    TEST_RESULTS=$(ls .test-results)
    echo ""; echo "Available Test Results:";
    echo "${TEST_RESULTS}"
else
    echo "Available options:"
    echo "-i: install a test suite."
    echo "-r: run a test suite."
    echo "-l: list test suites."
    echo "-c: copy test results from a remote machine for viewing."
    echo "-b: backport test suite from pts install to benchmark git repo."
fi
