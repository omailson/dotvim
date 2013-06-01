#!/bin/bash

# Add doc/tags to the ignore list of submodules

MODULES_LIST="bookmarking pastie snipmate.vim syntaxrange"

for m in $MODULES_LIST
do
	echo "/doc/tags" > .git/modules/plugins/"$m"/info/exclude
done

echo ".netrwhist" > .git/modules/plugins/AutoClose/info/exclude
