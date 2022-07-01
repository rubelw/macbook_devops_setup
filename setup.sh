!/usr/bin/env bash

# This is part of a larger script for setting a mac for python development.
set -e

# Shared functions

pretty_print() {
  printf "\n%b\n" "$1"
}
# 
pretty_print "Here we go..."

if ! [ -x "$(command -v brew)" ]; then

    # Homebrew installation

    if ! command -v brew &>/dev/null; then
      pretty_print "Installing Homebrew, an OSX package manager, follow the instructions..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

      if ! grep -qs "recommended by brew doctor" ~/.zshrc; then
        pretty_print "Put Homebrew location earlier in PATH ..."
          printf '\n# recommended by brew doctor\n' >> ~/.zshrc
          printf 'export PATH="/usr/local/bin:$PATH"\n' >> ~/.zshrc
          export PATH="/usr/local/bin:$PATH"
      fi
    else
      pretty_print "You already have Homebrew installed...good job!"
    fi

    # Homebrew OSX libraries

    pretty_print "Updating brew formulas"
        brew update

    pretty_print "Installing GNU core utilities..."
        brew install coreutils

    pretty_print "Installing GNU find, locate, updatedb and xargs..."
        brew install findutils

    pretty_print "Installing the most recent verions of some OSX tools"
        brew tap homebrew/dupes
        brew install homebrew/dupes/grep

    printf 'export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"' >> ~/.zshrc
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi


# Install git

if ! [ -x "$(command -v git)" ]; then
    echo 'Error: git is not installed.' >&2
    echo -n "Would you like to install git.  "
    DEFAULT="y"
    read -e -p "Proceed [Y/n/q]:" PROCEED
    # adopt the default, if 'enter' given
    PROCEED="${PROCEED:-${DEFAULT}}"
    # change to lower case to simplify following if
    PROCEED="${PROCEED,,}"
    # condition for specific letter
    if [ "${PROCEED}" == "q" ] ; then
      echo "Quitting"
      exit
    # condition for non specific letter (ie anything other than q/y)
    # if you want to have the active 'y' code in the last section
    elif [ "${PROCEED}" != "y" ] ; then
      echo "Not Proceeding"
    else
      echo "Proceeding"
      # do proceeding code in here
    fi
else
    echo "Git is already installed"
fi

