#!/bin/bash

echo -e '\n\033[31;1mWARNING\033[m'
cat << EOF
You're installing Mailson Lira's vim configuration
Please, be adivised that I'm not responsible for any damage to your previous
vim settings.

EOF

echo -ne "\033[1mDo you wish to continue? [Y/n] \033[m"
read dotvim_opt_continue

if [ "$dotvim_opt_continue" = "Y" -o "$dotvim_opt_continue" = "y" -o -z "$dotvim_opt_continue" ];
then
	echo "You chose to stay :)"
	echo
else
	echo "Bye :("
	exit
fi

## Configure paths
echo "I just need to ask a few questions:"

# Backup dir
echo
cat << EOF
About backup files:
If you ever noticed, vim creates a backup file with a '~' in the end on the
same directory of your edited file.
This is annoying sometimes and if you wish, vim can put all those file in a
separate folder of your choice. That's what I'm asking you.

EOF
echo "Where you want to put your vim backup files?"
echo "Type . (dot) to not use this feature."
echo -ne "\033[1mBackup path [~/.vim_local/backup] \033[m"
read dotvim_opt_backup

if [ -z "$dotvim_opt_backup" ];
then
	dotvim_opt_backup="~/.vim_local/backup"
fi

# Swap dir
echo
cat << EOF
About swap files:
You probably know about swap files. Those with an .swp extension that vim
creates when you open a file.
What you may not know is that you can save them in a spearate directory as
well.

EOF
echo "Where you want to put your vim swap files?"
echo "Type . (dot) to not use this feature."
echo -ne "\033[1mSwap path [~/.vim_local/tmp] \033[m"
read dotvim_opt_tmp

if [ -z "$dotvim_opt_tmp" ];
then
	dotvim_opt_tmp="~/.vim_local/tmp"
fi

echo
echo "Configuring your vimrc ..."
if [ -e vimrc ]
then
	echo "error: vimrc already exists. Please remove it and try again."
	exit 1
fi
cat << EOF >> vimrc
fun! MySys()
	return "linux"
endfun

"" dotvim settings
" dotvim path
let g:dotvim_path = "`pwd`"
EOF

if [ "$dotvim_opt_backup" != "." ]; then
	eval mkdir -p "$dotvim_opt_backup"
cat << EOF >> vimrc
" directory to store backup files
let g:dotvim_backupdir = "`echo "$dotvim_opt_backup"`"
EOF
fi

if [ "$dotvim_opt_tmp" != "." ]; then
	eval mkdir -p "$dotvim_opt_tmp"
cat << EOF >> vimrc
" directory to store temp files
let g:dotvim_tmpdir = "`echo "$dotvim_opt_tmp"`"
EOF
fi

cat << EOF >> vimrc

"" Portable mode.
" Set to 1 if you already have another vim environment configured to the user
" and want to use this configuration instead.
if !exists("g:dotvim_portable")
	let g:dotvim_portable = 0
endif

exe "source ".g:dotvim_path."/dotvimrc.vim"
EOF

cat << EOF

This step is over but we're not done yet.
Now you need to run 'make' to start using these settings.

EOF
