" vim beginners mode: disables arrow keys so you can get used to hjkl.
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Shortcuts to work with windows
nnoremap <left> <C-W><
nnoremap <right> <C-W>>
nnoremap <C-W>s <C-W>s<C-W>j
nnoremap <C-W>v <C-W>v<C-W>l
nnoremap <C-W><C-V> <C-W>v<C-W>l

" Visual move between lines
nnoremap <down> gj
nnoremap <up> gk

" Horizontal scroll
nnoremap <C-h> 3zh
nnoremap <C-l> 3zl

" Vertical scroll
nnoremap <C-j> 3gj
nnoremap <C-k> 3gk

" Inserir uma linha abaixo do cursor e continuar no modo normal
map ,o o<Esc>
map <Return> o<Esc>k
map ,O O<Esc>

" Opposite of Shift+J
nmap K i<CR><Esc>k$hl

" Sometimes I type Lw instead of :w
nmap Lw :w

" Change from -> to .
nmap ,. xr.
" Change from . to ->
nmap ,> xi-><ESC>h

" Append the word under cursor to search terms
nmap ,/w /<up>\\|\<<C-R><C-W>\><CR>N

" Helper search to resolve merge conflicts
nmap ,/m /<<<<<<<\\|=======\\|>>>>>>><CR>

" Easier way to copy/paste from an external program
map ,- "*
map ,= "+
map <F11> "*
map <S-F11> "+

" 0 vai para o inicio da linha. ^ faz o mesmo, mas pula os espaços/tabs iniciais
map 0 ^

" Change tabs
map <C-Left> gT
map <C-Right> gt
inoremap <C-Left> <Esc>gT
inoremap <C-Right> <Esc>gt

" Move a line of text using ALT+[Up/Down]
nmap <A-Down> mz:m+<cr>`z
nmap <A-Up> mz:m-2<cr>`z
vmap <A-Down> :m'>+<cr>`<my`>mzgv`yo`z
vmap <A-Up> :m'<-2<cr>`>my`<mzgv`yo`z

if MySys() == "mac"
    nmap <Esc><Esc>[B mz:m+<cr>`z
    nmap <Esc><Esc>[A mz:m-2<cr>`z
    vmap <Esc><Esc>[B :m'>+<cr>`<my`>mzgv`yo`z
    vmap <Esc><Esc>[A :m'<-2<cr>`>my`<mzgv`yo`z
endif

" Turn spell check on/off
map <F1> :call SpellCheckToggle()<CR>

" Toggle line number
map <F3> :call LineNumberToggle()<CR>

" Reload all opened files
nmap <F5> :tabdo windo edit<CR>

map ,n :call ShowNumberStatus()<CR>


"""" PLUGINS
"" NERDTree
map <F2> :NERDTreeToggle<CR>
map <S-F2> :NERDTreeFind<CR>

"" A
nmap <F4> :A<CR>

"" Tagbar
nnoremap <F8> :TagbarToggle<CR>

"" Bookmarking
map ,bb :ToggleBookmark<CR>
map ,bn :NextBookmark<CR>
map ,bp :PreviousBookmark<CR>

"" GitGutter
nnoremap ]g :GitGutterNextHunk<CR>
nnoremap [g :GitGutterPrevHunk<CR>
