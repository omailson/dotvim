scriptencoding utf-8
set encoding=utf8
set nocompatible  " not compatible to Vi

" Set where the vim folder is located. It's useful if you put your plugins in
" a folder other than ~/.vim
if g:dotvim_portable
	exe "set runtimepath=".g:dotvim_path."/vim,".$VIMRUNTIME
else
	exe "set runtimepath=".g:dotvim_path."/vim,".&runtimepath
endif

" Include pathogen
call pathogen#infect(g:dotvim_path."/vim/bundle")

" Space, tabs, etc
set tabstop=4     " quantos colunas um tab vai ter (apertando a tecla TAB)
set shiftwidth=4  " idem, mas é usando >> ou <<
set autoindent    " indentação automática
set expandtab     " use spaces instead of tabs

" Search options
set hlsearch      " highlight search
set incsearch     " incremental search
set ignorecase    " ignora maiúsculas na busca
set smartcase     " exceto quando buscamos por um termo em maiúscula

" Visual options
set mouse=a       " mouse everywhere
set guioptions-=m " removes gVim's menubar
set guioptions-=T " removes gVim's toolbar

" Misc. options
set showcmd       " mostra o comando digitado (eg: digitando :set filetype neste arquivo, mostra filetype=vim)
set wildmenu      " no modo de comando, ao teclar TAB, completa o que foi escrito mostrando as opções em um menu
set exrc          " enable per-directory .vimrc files
set secure        " disable unsafe commands in local .vimrc files
set backup
set noshowmatch   " disable matching parenthesis jump
set wildignore=*.o,*.obj,moc_*.cpp,qrc_*.cpp
set nowrap        " do not wrap lines by default

syntax on
filetype plugin indent on

if version >= 703
	set number          " show absolute line number for the current line
	set relativenumber  " show line number relative to current position
else
	set number
endif

" configuração do list. 
" digite :set list para ver alguns caracteres não imprimíveis
set listchars=tab:▸\ ,trail:·,nbsp:%,eol:¬,extends:→,precedes:← 

if MySys() == "windows"
	set guifont=DejaVu_Sans_Mono:h10:cANSI
	set backspace=indent,eol,start
	set encoding=utf-8
	set fileencodings=utf-8
endif

" VISUAL BEHAVIOR
"" Color scheme
if ! has("gui_running")
    if !exists("g:dotvim_vi") || !g:dotvim_vi
        set background=dark
        set t_Co=256
        colorscheme peaksea
    else
        colorscheme desert
    endif
else
    set background=light
    colorscheme solarized
endif

"" Status line
hi User1 ctermbg=black ctermfg=yellow
if g:colors_name == "peaksea"
    hi StatusLine ctermbg=yellow
endif

highlight clear SignColumn

"" Cursor line
" Highlight line under cursor
" Must be set after colors
" set cursorline
if g:colors_name == "peaksea"
    highlight CursorLine cterm=NONE ctermbg=black gui=NONE guibg=#001100
endif

" Status line of awesome
" Taken from http://github.com/lrvick/dotvim 
set laststatus=2
set statusline=         " clear statusline for vim reload
set statusline+=%f     " filename/path
set statusline+=%y    " filetype
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] " file format
set statusline+=%h      " help file flag
set statusline+=%1*
set statusline+=%m      " modified flag
set statusline+=%0*
set statusline+=%r      " read only flag
set statusline+=[%{strftime(\"\%d\/\%m\/\%Y\ \%T\",getftime(expand(\"\%\%\")))}]  " Last Modified
set statusline+=%=      " left/right seperator
set statusline+=C:%c-    " cursor column
set statusline+=L:%l/%L   " cursor line/total lines
function! FileSize()
	let bytes = getfsize(expand("%:p"))
	if bytes <= 0
		return ""
	endif
	if bytes < 1024
		return bytes
	elseif bytes < 1048576
		return (bytes / 1024) . "K"
	else
		return (bytes / 1048576) . "M"
	endif
endfunction

if exists("g:dotvim_backupdir")
	exe "set backupdir=".g:dotvim_backupdir
endif

if exists("g:dotvim_tmpdir")
	exe "set directory=".g:dotvim_tmpdir
endif

" Acho que é para gravar marcas, registradores e afins.
if MySys() == "linux"
	set viminfo='10,\"30,:20,%,n~/.viminfo
elseif MySys() == "windows"
	set viminfo='10,\"30,:20,%,nC:/Users/mailson/_viminfo
endif

" Jumps to last known position of the recently opened file
au BufReadPost * if &ft != "gitcommit" && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Save as super user
command Wsudo :execute ':silent w !sudo tee % > /dev/null' | :edit!
" Avoid accidentally saving as super user
command W :w

command! -nargs=* Identation call DoTabs( '<args>' )

fun! DoTabs (arg)
    if len(a:arg) == 0
        setlocal list!
    elseif a:arg == "t"
        setlocal noexpandtab
    elseif a:arg == "s"
        setlocal expandtab
    elseif a:arg == "2"
        setlocal ts=2 sw=2
    elseif a:arg == "4"
        setlocal ts=4 sw=4
    endif
endfun

""""""""""""""""""""""""""""""""""""""""
" Funções                              "
""""""""""""""""""""""""""""""""""""""""
" Retorna uma lista de caracteres em um range específico.
" eg: RangeChar('a', 'c') retorna a lista ['a', 'b', 'c']
fun! RangeChar (first, last)
	return map(range(char2nr(a:first), char2nr(a:last)), 'nr2char(v:val)')
endfun

fun! ShowNumberStatus()
	let number = expand("<cword>")
	echo "<".number."> ".ThousandsSeparator(number).", ".printf("0x%X", number).", ".printf("0%o", number)
endfun

" 1 12 123 1234 12345 123456 1234567 123456789 1234567890
fun! ThousandsSeparator(nr)
	let number = a:nr
	let start = -3
	let end = -1

	let r = ""
	while abs(end) <= len(number)
		if end == -1
			let r = number[(start):(end)] 
		else
			let r = number[(start):(end)] .".". r
		endif

		let start -= 3
		let end -= 3
	endwhile

	return r
endfun

" Retorna a palavra que está abaixo do cursor.
" O cursor é movido de posição, mas retornamos com ele para o lugar de origem
" eh o mesmo que expand("<cWORD>")
fun! GetWord()
	let save_cursor = getpos('.')
	normal bye
	let word = getreg()
	call setpos('.', save_cursor)
	return word
endfun

" testes
map ,m :echo GetWord()<cr>

fun! SpellCheckToggle()
	if &spell
		if &spelllang == "en"
			setlocal spelllang=pt
			echo "Português"
		else
			setlocal nospell
			echo "No spell"
		endif
	else
		setlocal spell
		setlocal spelllang=en
		echo "English"
	endif
endfun

fun! LineNumberToggle()
	if &relativenumber
		setlocal number
	elseif &number
		setlocal relativenumber
	endif
endfun

" PLUGINS

"" Haskell Mode
" use ghc functionality for haskell files
au BufRead *.hs compiler ghc

" configure browser for haskell_doc.vim
if MySys() == "linux"
	let g:haddock_browser = "/usr/bin/chromium"
endif

au FileChangedRO * set noreadonly

"" Python
au FileType python setlocal softtabstop=4
au FileType python setlocal expandtab
au FileType python map <F6> :!./% <Enter><Enter>

"" QML
au BufRead,BufNewFile *.qml map <F6> :!qmlviewer % <Enter><Enter>
au BufRead,BufNewFile *.qml setlocal softtabstop=4
au BufRead,BufNewFile *.qml setlocal expandtab

"" CSS
au FileType css let @a='yyplct-moz0yyplct-ms0yyplct-o0yypdf-'

"" Java
au FileType java setlocal noexpandtab

"" Shell
au FileType sh setlocal noexpandtab

"" Command-T
let g:CommandTMaxHeight=15

"" Lodgeit
let g:lodgeit_host = "10.60.5.222:8081"

"" TComment
let g:tcomment_types = {'qml': '// %s', 'plaintex': '%% %s', 'cuda': '// %s', 'cmake': '# %s'}

"" Tagbar
let g:tagbar_autofocus = 1

exe "source ".g:dotvim_path."/keymaps.vim"
