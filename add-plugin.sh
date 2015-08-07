#!/bin/bash

# Add a new plugin
# Usage: ./add-plugin.sh plugin_name repository_url

if [ "$#" -ne 2 ]
then
	echo "Invalid number of parameters"
	exit 1
fi

git submodule add "$2" "plugins/$1"
ln -s ../../plugins/"$1"/ vim/bundle/"$1"
make helptags
