#!/bin/bash

# Install Homebrew if we don't have it
echo "Homebrew:"
if test ! $(which brew); then
echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
echo "Homebrew is installed and configured"

# Install Yarn if we don't have it
echo "Yarn:"
if test ! $(which yarn); then
echo "Installing homebrew..."
  brew install yarn
fi
echo "Yarn is installed and configured"
