set nocompatible  " not compatible to Vi
set tabstop=4     " quantos colunas um tab vai ter (apertando a tecla TAB)
set shiftwidth=4  " idem, mas é usando >> ou <<
set autoindent    " indentação automática
set ignorecase    " ignora maiúsculas na busca
set smartcase     " exceto quando buscamos por um termo em maiúscula
set mouse=a       " usa o mouse em qualquer lugar. seleção visual do vim com o mouse
set showcmd       " mostra o comando digitado (eg: digitando :set filetype neste arquivo, mostra filetype=vim)
set wildmenu      " no modo de comando, ao teclar TAB, completa o que foi escrito mostrando as opções em um menu
set exrc          " enable per-directory .vimrc files
set secure        " disable unsafe commands in local .vimrc files
set cursorline    " highlight line under cursor
set guioptions-=m " removes gVim's menubar
set guioptions-=T " removes gVim's toolbar
syntax on

if version >= 703
	set relativenumber  " show line number relative to current position
else
	set number
endif

" vim beginners mode: disables arrow keys so you can get used to hjkl.
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" you know those times when you open a file with reaaaally long lines and when you try to go to the line bellow, you find out that line is actually the current line? so you have jump letter by letter, word by word to get on that position. that's really frustrating. well not anymore. try using j or k to jump between lines and then use gj or gk and see the difference. you'll be thankful for that new discovery.
" sabe quando você abre um arquivo com aquelas linhas enormes e quando você tenta ir para a linha de baixo você descobre que na verdade aquela linha é a mesma em que você está? então você tem que pular letra por letra, palavra por palavra, até chegar na posição que você queria. isso é muito frustrante. quer dizer, não mais. tente usar j ou k para andar por estas linhas, e depois gj ou gk e veja a diferença. você vai ficar agradecido por essa nova descoberta.
nnoremap j gj
nnoremap k gk


" peaksea colorscheme
if ! has("gui_running")
	set t_Co=256
endif

if MySys() == "linux"
	set background=dark
	colors peaksea
endif

set backup
if MySys() == "linux"
	set backupdir=~/.vim_local/backup  " 
	set directory=~/.vim_local/tmp     " coloco em outra pasta, pois não precisa sincronizar os .swp

	" When vimrc is edited, reload it
	" autocmd! bufwritepost vimrc source ~/.vimrc
elseif MySys() == "windows"
	set guifont=DejaVu_Sans_Mono:h10:cANSI
	set backspace=indent,eol,start
	set encoding=utf-8
	set fileencodings=utf-8
endif

set listchars=tab:▸\ ,trail:·,nbsp:%,eol:¬,extends:→,precedes:← " configuração do list. digite :set list para ver alguns caracteres não imprimíveis
" set expandtab " Usa espaço ao invés de TAB
" set noexpandtab " Desativa o expandtab

" Destaca a palavra buscada. 
" Use :noh para desativar temporariamente (é reativado na busca seguinte)
set hlsearch
set incsearch

" Não destaca os () [] {}
"let loaded_matchparen=1
" Mudando a cor de destaque dos () [] {}. A cor cyan é muito chegay
" highlight MatchParen ctermbg=red guibg=magenta
" highlight Search ctermbg=brown ctermfg=white
highlight CursorLine cterm=NONE ctermbg=black gui=NONE guibg=#001100

" Acho que é para gravar marcas, registradores e afins.
" E a segunda linha é para deixar o cursor na posição que estava da última vez
if MySys() == "linux"
	set viminfo='10,\"30,:20,%,n~/.viminfo
elseif MySys() == "windows"
	set viminfo='10,\"30,:20,%,nC:/Users/mailson/_viminfo
endif
au BufReadPost * if line("'\"")|execute("normal `\"")|endif

" ativando plugins de programacao
" melhor linha ever. transforma seu vim em uma IDE. Use o comando CTRL+X+O
" para completar as linhas de código
filetype plugin indent on

" Fechando o comentário automaticamente
iab /* /*<Space>*/<Left><Left><Left>
"iab ( ()<Left>
" Para retirar o espaço de dentro dos parenteses, chame ( + CTRL-[
" ou use a funcao abaixo
" iab ( (%)<Esc>F%s<c-o>:call getchar()<CR>
"iab [ []<Left>

""""""""""""""""""""""""""""""""""""""""
" Mapeamentos                          "
""""""""""""""""""""""""""""""""""""""""
" Inserir uma linha abaixo do cursor e continuar no modo normal
map ,o o<Esc>
map <Return> o<Esc>k
map ,O O<Esc>
map OM O<Esc>
" The above mapping is a <S-Return>

" ?? muito chato digitar ''+p para colar texto da área de transferência
" + é Shift+=, mas ter que apertar o shift é dose. Por isso o =
" - é a tecla que está do lado do =
map ,- "*
map ,= "+

" 0 vai para o inicio da linha. ^ faz o mesmo, mas pula os espaços/tabs iniciais
map 0 ^

" problema do meu teclado
" imap m<BackSpace> ,
" imap M<BackSpace> <
" imap ,<BackSpace> .
" imap <BS> //  if getline('.')[col('.') - 1] ==? 'm'

" Wordwise Ctrl-Y in insert mode
noremap! <C-Y> <Esc>klyEjpa

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
" Tive que usar Ctr-V Alt-j para fazer o caractere j
" Se colocar <A-j> nao funciona
nmap <A-Down> mz:m+<cr>`z
nmap <A-Up> mz:m-2<cr>`z
vmap <A-Down> :m'>+<cr>`<my`>mzgv`yo`z
vmap <A-Up> :m'<-2<cr>`>my`<mzgv`yo`z

map <F2> :NERDTreeToggle<CR>
map <S-F2> :NERDTreeFind<CR>

" Trocar de aba
map <C-Left> gT
map <C-Right> gt
inoremap <C-Left> <Esc>gT
inoremap <C-Right> <Esc>gt

map ,n :call ShowNumberStatus()<CR>

" You don't need to open a protected file with sudo vim anymore.
" Just type :wsudo and the file will be saved.
cab wsudo w !sudo tee %

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

""""""""""""""""""""""""""""""""""""""""
" Haskell Mode (plugin)                "
""""""""""""""""""""""""""""""""""""""""
" use ghc functionality for haskell files
au BufRead *.hs compiler ghc

" configure browser for haskell_doc.vim
if MySys() == "linux"
	let g:haddock_browser = "/usr/bin/chromium"
endif


""""""""""""""""""""""""""""""""""""""""
" Python Mode (plugin)                 "
""""""""""""""""""""""""""""""""""""""""
au FileType python setlocal softtabstop=4
au FileType python setlocal expandtab

""""""""""""""""""""""""""""""""""""""""
" QML                                  "
""""""""""""""""""""""""""""""""""""""""
" au BufRead,BufNewFile *.qml setfiletype javascript
au BufRead,BufNewFile *.qml map <F6> :!qmlviewer % <Enter><Enter>
au BufRead,BufNewFile *.qml setlocal softtabstop=4
au BufRead,BufNewFile *.qml setlocal expandtab


