#!/bin/env bash
export FORCE_TIMES_TO_RUN=1
set -eu
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
SUITE_NAME="$1"

mkdir -p ~/.phoronix-test-suite/test-suites/local/"${SUITE_NAME}"/
cp -f pts/test-suites/local/"${SUITE_NAME}"/suite-definition.xml ~/.phoronix-test-suite/test-suites/local/"${SUITE_NAME}"/suite-definition.xml

phoronix-test-suite install "${SUITE_NAME}"
echo "BEGINNING TEST RUN..."
sleep 5
phoronix-test-suite batch-run "${SUITE_NAME}"
