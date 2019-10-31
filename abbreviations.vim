" Abbreviations can be expanded by either hiting <Space> after the alias or using Ctrl-] (the latter prevents a trailing space at the end)

" Expand color escape chars. Use this to colorize texts using echo -e
" The <delete> is necessary due to the autoclose plugin (it adds a ] to close the first [)
iabbrev 033m \033[m<delete><Left>
