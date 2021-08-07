#!/bin/env bash
export FORCE_TIMES_TO_RUN

cp -f pts/test-suites/local/eg-vps/suite-definition.xml ~/.phoronix-test-suite-benchmark/test-suites/local/eg-vps/suite-definition.xml

phoronix-test-suite batch-install eg-vps
echo "INFO BEGINNING TEST RUN..."
sleep 8
phoronix-test-suite batch-run eg-vps