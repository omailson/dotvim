all: commandt helptags

commandt:
	cd vim/bundle/command-t/ruby/command-t/;\
		ruby extconf.rb;\
		make clean && make

helptags:
	@test -e vimrc\
		&& vim -u vimrc -c 'Helptags|quit'\
		&& echo "Documentation files created"\
		&& ./ignore_tags.sh\
		|| echo "Cannot find vimrc. Did you run ./configure.sh?"

install:
	@ln -s ~+/vimrc ~/.vimrc\
		&& echo "dotvim successfully installed"\
		|| echo "can't install dotvim"

uninstall:
	@test -L ~/.vimrc\
		&& rm ~/.vimrc\
		&& echo "~/.vimrc successfully removed"\
		|| echo "Can't remove ~/.vimrc (the only installed file)"
