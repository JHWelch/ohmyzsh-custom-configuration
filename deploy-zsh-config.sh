#!/bin/bash

# Checking if Zsh is installed
if ! zsh --version > /dev/null 2>&1; then
	echo "Zsh is not installed. Please install Zsh and Oh My Zsh before deploying"
fi

# Checking for required commands
if ! realpath ./ > /dev/null 2>&1; then
	if  brew help > /dev/null 2>&1; then
		echo "Install coreutils from Homebrew"
		brew install coreutils
	else
		echo "Coreutils not installed, brew not installed. Please Install Homebrew."
		exit 1
	fi
fi

ZSH_CUSTOM_DIR="$HOME/.oh-my-zsh/custom/"

# Creates symlinks for all files in a folder that match a given extension.
function write_symlinks()
{
	FILES=("$@")
	((last_index=${#FILES[@]} - 1))
	EXTENSION=${FILES[last_index]}
	unset FILES[last_index]

	for f in " ${FILES[@]}"
	do
		if [[ "$f" ==  *"$EXTENSION" ]]; then
			FILENAME=$(echo $f | cut -c3-)
			SYM_LINK="$ZSH_CUSTOM_DIR$FILENAME"
			if [ ! -e "$SYM_LINK" ]; then	
				echo "Creating symlink for $FILENAME"
				full_path=$(realpath $f)
				eval "ln -s $full_path $SYM_LINK"
			else
				echo "Skipping $FILENAME, symlink already exists"
			fi
		fi
	done
}

# Create symlinks for base dir and themes
BASEDIR=./*
THEME_DIR=./themes/*
write_symlinks $BASEDIR ".zsh" 
write_symlinks $THEME_DIR ".zsh-theme"

echo "---Cloning plugin repos---"
PLUGIN_REPOS=$(grep -o '^[^#]*' ./plugins/repos | sed  '/^$/d')
PLUGINS="plugins"
cd "$ZSH_CUSTOM_DIR$PLUGINS"
for repo in $PLUGIN_REPOS
do
	git clone $repo
done
