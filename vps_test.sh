#!/bin/env bash
export FORCE_TIMES_TO_RUN=1
set -eu
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

mkdir -p ~/.phoronix-test-suite/test-suites/local/eg-vps/
cp -f pts/test-suites/local/eg-vps/suite-definition.xml ~/.phoronix-test-suite/test-suites/local/eg-vps/suite-definition.xml

phoronix-test-suite batch-install eg-vps
echo "INFO BEGINNING TEST RUN..."
sleep 8
phoronix-test-suite batch-run eg-vps
