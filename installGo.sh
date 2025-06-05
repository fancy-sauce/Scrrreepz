#!/bin/bash

# Most steps came from https://rafaelhart.com/2020/03/installing-golang-on-kali-linux/ I just wanted to automate the process.

# Require script to be run as root
if [[ "$EUID" -ne 0 ]]; then
  echo "This script must be run as root. Try: sudo $0" >&2
  exit 1
fi

apt update

# First, install the package
apt install -y golang

# Then add the following to your .bashrc
export GOROOT=/usr/lib/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Go home and reload ya bum. This jacks up Kali's current terminal prompt. Don't fret, just reload the terminal or close and open again.
cd ~

source .bashrc

go version

echo "If you got a Go version above, your're good to go.
