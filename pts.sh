#!/bin/env bash
set -eu
if [[ ! -d "/home/linuxbrew" ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.profile"
fi
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install php
brew install phoronix-test-suite
yes y | phoronix-test-suite

cp -f pts/user-config.xml ~/.phoronix-test-suite-benchmark/user-config.xml
cp -rf pts/test-suites/local/* ~/.phoronix-test-suite/test-suites/local/