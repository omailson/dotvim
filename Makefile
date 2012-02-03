help:
	@echo "symlink    Create symbolic links to vimrc and dotvimrc"
	@echo "commandt   Compiles the command-t plugin"

commandt:
	cd vim/bundle/command-t/ruby/command-t/;\
		ruby extconf.rb;\
		make clean && make

symlink:
	ln -s ~+/dotvimrc.vim ~/.vimrc
	ln -s ~+/vimrc ~/.dotvimrc
