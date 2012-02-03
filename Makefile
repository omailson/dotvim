help:
	@echo "symlink    Create symbolic links to vimrc and dotvimrc"
	@echo "commandt   Compiles the command-t plugin"

commandt:
	cd vim/bundle/command-t/ruby/command-t/;\
		ruby extconf.rb;\
		make clean && make

helptags:
	@test -e vimrc\
		&& vim -u vimrc -c 'Helptags|quit'\
		&& echo "Documentation files created"\
		|| echo "Cannot find vimrc. Did you run ./configure.sh?"

symlink:
	ln -s ~+/vimrc ~/.vimrc
