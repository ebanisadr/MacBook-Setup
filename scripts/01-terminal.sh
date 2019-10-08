#!/bin/bash

# Install xcode developer tools if we don't have them
xcode-select --install

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

# Add a link to iCloud Drive in home folder
if [ ! -e ~/iCloud\ Drive ]; then
  echo "Linking iCloud Drive to home folder"
  ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/ ~/iCloud\ Drive
fi

# Recover ssh key
if [ ! -d ~/.ssh ]; then
  mkdir ~/.ssh
fi
if [ ! -f ~/.ssh/id_rsa ]; then
  echo "No ssh key found, attempting to restore one"

  if [ -f ~/.ssh/id_rsa.pub ]; then
    rm ~/.ssh/id_rsa.pub
  fi

  cp private-data/ssh/id_rsa ~/.ssh/id_rsa
  cp private-data/ssh/id_rsa.pub ~/.ssh/id_rsa.pub
fi

# Probably not necessary after macOS Catalina
# Set up zsh
# echo "Zsh:"
# if [[ ! $(which zsh) == *local* ]]; then
#   echo "Replacing macOS default zsh with an updated version"
#   brew install zsh
#   read -s -p "Your password is required to add zsh to the system's list of shells: " sudoPW
#   echo $sudoPW | sudo -S sh -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
#   echo $sudoPW | chsh -s /usr/local/bin/zsh
# fi
# echo "Zsh is installed"

# Set up Terminal.app
echo "Terminal.app:"
if [[ ! $(defaults read com.apple.Terminal "Default Window Settings") == Default ]]; then
  echo "Custom profile not found, installing it now"
  /Applications/Utilities/Terminal.app/Contents/MacOS/Terminal ./data/Terminal/Default.terminal &
  TERM_PID=$!
  sleep 2
  kill -15 $TERM_PID
  defaults write com.apple.Terminal "Default Window Settings" Default
  defaults write com.apple.Terminal "Startup Window Settings" Default
fi
echo "Terminal.app is configured"

