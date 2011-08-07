" url: http://aurelio.net/doc/coluna/coluna-09.vim
"
" http://aurelio.net/doc/coluna
" coluna do aur�lio 09 [maio/2001]
" vim (um vimrc diferente)
"
" original em http://aurelio.net/doc/coluna/coluna-09.vim
"
" ol�s. creio que o  vim  n�o precisa de  apresenta��o n�o � mesmo? pois
" bem,  ent�o que tal explorarmos aquele mundo  misterioso que o arquivo
" de configra��o  ~/.vimrc  nos apresenta? o que � um vimrc?  oras, este
" texto todo � um vimrc!  copie-o para seu  $HOME  e incremente seu vim.
" ah! aproveite e leia este texto direto no vim, para ficar colorido.
"
" como j� pudemos perceber, linhas que come�am com aspas s�o coment�rios
" e nelas podemos soltar o verbo e colocar todo tipo de  informa��o �til
" para a manuten��o deste arquivo. ent�o vamos l�.
"
" para aumentar a esperteza e memoriza��o do vim, podemos ter um arquivo
" ~/.viminfo que guardar� dados �teis como seu hist�rico de pesquisas /,
" linha de comando :, marcas `, registradores, entre outros. ent�o com o
" viminfo �  poss�vel copiar uma  linha qualquer (yy),  sair do arquivo,
" abrir um OUTRO arquivo e colar (p) aquela linha copiada anteriormente.
" voc� pode inclusive nesse intervalo  desligar a m�quina e ficar um m�s
" de f�rias, que ao voltar o vim  ainda saber� qual foi a linha copiada.
" n�o tem contra-indica��es. USE!
"
" a segunda linha � uma gambiarra para que ao abrir um arquivo, o cursor
" j� fique na  posi��o que estava na  �ltima vez que ele foi  editado. o
" viminfo guarda a posi��o de TODOS os arquivos que voc� editou.
"
set viminfo='10,\"30,:20,%,n~/.viminfo
au BufReadPost * if line("'\"")|execute("normal `\"")|endif

" o vim possui uma linguagem de programa��o pr�pria,  onde podemos fazer
" fun��es, e at� aplicativos inteiros, como o  vine (leitor de e-mail) e
" o jogo sokoban.vim. mais info sobre o assunto consulte www.vim.org.
"
" mas, como j�  temos que fazer  nossos pr�prios programas, temos op��es
" mais acess�veis para automatizar tarefas,  como o mapeamento. aqui vai
" um mapeamento  exclusivo do  modo de inser��o (note o i no come�o) que
" faz a  fun��o de completa��o autom�tica  de palavras, procurando-as no
" pr�prio arquivo. � f�cil de usar e nos poupa tempo, al�m da certeza de
" que a palavra completada est� grafada corretamente. ent�o temos:
"
" F7: completa uma palavra
" F8: d� seq��ncia a essa palavra
"
" os mapeamentos foram  gravados nas teclas F7 e F8,  mas poderia ser em
" qualquer outra. suponha que voc� se chame Z�zimo Gwinch Wurstalinewski
" e digitou seu nome numa parte do texto. depois em outra parte do mesmo
" texto, voc� precisa colocar seu nome novamente. � trabalheira.
"
" mas como voc�  tem esse supermapeamento,  simplesmente digita Z�<F7> e
" surpresa! seu primeiro nome foi completado. e para fazer o resto, voc�
" continua completando as palavras seguintes com a tecla <F8>, ent�o com
" Z�<F7><F8><F8>, l� est� seu nome completo. imbat�vel.
"
" isso � muito muito �til ao programar, completando nomes de vari�veis e
" fun��es,  geralmente longos e  dif�ceis,  e que voc� repete  em v�rias
" partes do programa.
"
imap <F7> <c-n>
imap <F8> <c-x><c-n>

" e se voc� tem certos textos  que sempre tem que ficar  digitando, como
" seu nome completo, seu email, seu endere�o,  fa�a abrevia��es, que s�o
" completadas automaticamente enquanto voc� as digita.
"
" use abrevia��es para textos normais, para comandos use mapeamentos.
"
iab zgw Z�zimo Gwinch Wurstalinewski
iab @@  zozimo@wurstalinewski.com.br

" e como o capitalismo nos obriga a produzir em velocidade insalubre, ao
" salvar e/ou sair de um arquivo, � comum na pressa digitar o `w` ou `q`
" em mai�sculas, pois voc� ainda n�o soltou o dedo do  shift que apertou
" para fazer os dois pontos :.
"
" mas n�o se desespere!  at� para os problemas econ�micos mundiais o vim
" tem a solu��o! basta usarmos abrevia��es para a linha de comando (Cab)
"
cab W  w
cab Wq wq
cab wQ wq
cab WQ wq
cab Q  q

" um mapeamento � na verdade uma  seq��ncia de teclas que voc� apertaria
" normalmente no vim,  para fazer a tarefa.  o ENTER � representado  por
" <cr>, um  crtl+y vira <c-y> e se o  mapeamento exceder uma linha, voc�
" pode quebr�-la e come�ar a pr�xima com um escape \.
"
" um cuidado especial  deve ser tomado ao nomear um mapeamento, para n�o
" usar  letras ou nomes  que j� s�o  comandos do vim.  para evitar isso,
" sempre inicie o nome de um  mapeamento com uma v�rgula. no exemplo, ao
" digitar ,d no modo de comando (n�o � inser��o) aparecer� a data atual.
"
map ,d :r!date<cr>
      \:s/ \(...\) \(..\).*\(....\)$/, \2 de \1 de \3/<cr>
      \:nohl<cr>

" e tem uma dica boa para os  programadores  de plant�o. coment�rios num
" programa s�o  excelentes, mas  na hora da  sua manuten��o,  eles podem
" atrapalhar, pois voc� queria ver s� o c�digo.
"
" para resolver este problema, vamos fazer um  truque no vim. que tal se
" pintarmos os coment�rios de preto para que fiquem invis�veis?  podemos
" fazer isso redefinindo o componente da cor da sintaxe.  ah! e quem usa
" fundo branco (argh) vai ter que trocar `black` por `white`.
"
" e como somos chiques ainda criamos uma fun��o vim pra fazer o servi�o.
" a CommOnOff()  oculta/mostra os coment�rios, alternando.  o resum�o do
" que ela faz �: se a vari�vel global  'hiddcomm'  n�o existir, a cria e
" oculta os coment�rios. se j� existir, restaura os coment�rios. por fim
" definimos um mapeamento esperto no F11 para chamar nossa fun��o.
"
" dica: se voc� est� lendo este arquivo no vim, experimente agora mesmo!
"   :so %
"   F11
"   F11
"
fu! CommOnOff()
  if !exists('g:hiddcomm')
    let g:hiddcomm=1 | hi Comment ctermfg=black guifg=black
  else
    unlet g:hiddcomm | hi Comment ctermfg=cyan  guifg=cyan term=bold
  endif
endfu
map <F11> :call CommOnOff()<cr>

" e j� que estamos mexendo com a sintaxe,  que tal trocar a cor do texto
" daquela sele��o que aparece quando voc� procura algo com o comando / ?
" � f�cil, basta definir a cor do componente da sintaxe. ah sim, a op��o
" hls (veja abaixo) deve estar ativa.
" 
" voc� pode colocar as cores que quiser, em ingl�s. note que � ctermBG e
" FG, de  background e foreground  (fundo e letra). e veja  tamb�m que o 
" IncSearch (busca enquanto voc� digita) � invertido!
"
hi    Search ctermbg=green ctermfg=black
hi IncSearch ctermbg=black ctermfg=cyan

" no vim temos diversas op��es para  modificar seu comportamento atrav�s
" do comando set. para ver  todas as op��es  dispon�veis, fa�a :set all.
" diversas  op��es j� v�em  ligadas por  padr�o, ent�o vamos  ver apenas
" algumas mais diferentes.
"
" � sempre bom associar a abrevia��o da  op��o com o nome em ingl�s para
" ficar mais f�cil a  memoriza��o.  no caso das op��es de busca  abaixo,
" seus nomes completos s�o:
"   IncrementedSearch, HighLightedSearch, IgnoreCase e SmartCaSe
"
set is hls ic scs  "op��es espertas de busca
set sm             "ShowMatch: mostra o in�cio do bloco rec�m fechado
set sw=1           "ShiftWidth: n�mero de colunas para o comando >
set ruler          "r�gua: mostra a posi��o do cursor
set shm=filmnrwxt  "SHortMessages: encurta as mensagem da r�gua
set wildmode=longest,list  "para completa��o do TAB igual ao bash

" a configura��o  necess�ria para que as  cores funcionem no  modo texto
" geralmente j� � feita no  vimrc do sistema, mas caso ela n�o esteja l�
" aqui est�o as linhas m�gicas que trar�o a alegria das cores de volta a
" sua vida:
"
set background=dark
if has("terminfo")
  set t_Co=8
  set t_Sf=[3%p1%dm
  set t_Sb=[4%p1%dm
else
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" mas como acima s�  dissemos ao vim 'voc� pode usar cores', agora falta
" dizermos: 'use cores'. este comando liga a  sintaxe, que � respons�vel
" por,  dependendo do tipo  de arquivo,  reconhecer e colorir  as v�rias
" estruturas do texto, como por exemplo <b>tags</b> num HTML.
"
syn on

" outra funcionalidade extremamente  interessante � o autocomando, que �
" executado  automaticamente  dependendo do  nome ou tipo do arquivo, no
" seu carregamento ou sa�da do editor.
"
" se voc� tem um arquivo com uma extens�o qualquer, como .xyz e quer que
" o vim o interprete como um arquivo HTML,  diga para o vim configurar o
" ft (FileType)  ao abrir um arquivo novo  (BufNewFile)  ou j� existente
" (BufRead) com essa extens�o.
"
au BufNewFile,BufRead *.xyz set ft=html
" 
" ou ainda,  se for um arquivo  de um tipo  j� reconhecido pelo vim, use
" diretamente a op��o FileType. vamos usar de exemplo a linguagem python
" onde os TABs indicam os blocos de comandos, ent�o � legal `v�-los`.
"
" para isso definimos uma  regra r�pida de sintaxe chamada `pythonTAB` e
" a ela associamos a cor azul. al�m disso definimos algumas op��es com o
" comando set e  para fechar,  trocamos a cor  das "strings" para verde,
" porque aquele rosinha � muito palha. 
"
au FileType python syn match pythonTAB '\t\+'
au FileType python hi pythonTAB ctermbg=blue
au FileType python set ts=4 tw=80 noet
au FileType python hi pythonString ctermfg=darkgreen

" e p-p-por hoje � s� p-pessoal.
"
" --
" este texto pode ser copiado livremente na �ntegra ou em parte, desde que
" indicado o endere�o do original: http://aurelio.net/coluna
