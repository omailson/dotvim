" Define o sistema atual que está sendo usado.
" Algumas configurações dependem do sistema e essa função vai indicar qual
" delas deve ser usada.
fun! MySys()
	return "linux"
endfun

" Arquivo .vimrc comum a todos os sistemas
let g:dotvim_path = "/home/mailson/Dropbox/vim/"
let g:dotvim_backupdir = "~/.vim_local/backup"
let g:dotvim_tmpdir = "~/.vim_local/tmp"
let g:dotvim_viminfo = "~/.viminfo"
