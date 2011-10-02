syntax on
set tabstop=4     " quantos colunas um tab vai ter (apertando a tecla TAB)
set shiftwidth=4  " idem, mas é usando >> ou <<
set autoindent    " indentação automática
set ignorecase    " ignora maiúsculas na busca
set smartcase     " exceto quando buscamos por um termo em maiúscula
set mouse=a       " usa o mouse em qualquer lugar. seleção visual do vim com o mouse
set showcmd       " mostra o comando digitado (eg: digitando :set filetype neste arquivo, mostra filetype=vim)
set wildmenu      " no modo de comando, ao teclar TAB, completa o que foi escrito mostrando as opções em um menu
set number        " mostra os numeros das linhas

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

if has("gui_running")
	set lines=99 columns=999
endif


set listchars=tab:>-,trail:.,nbsp:%,eol:$,extends:>,precedes:< " configuração do list. digite :set list para ver alguns caracteres não imprimíveis

" set expandtab " Usa espaço ao invés de TAB
" set noexpandtab " Desativa o expandtab

" Destaca a palavra buscada. 
" Use :noh para desativar temporariamente (é reativado na busca seguinte)
set hlsearch

" Não destaca os () [] {}
"let loaded_matchparen=1
" Mudando a cor de destaque dos () [] {}. A cor cyan é muito chegay
" highlight MatchParen ctermbg=red guibg=magenta
" highlight Search ctermbg=brown ctermfg=white

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
map ,O O<Esc>

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


