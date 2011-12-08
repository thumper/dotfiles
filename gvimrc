set lines=40 columns=100
set guioptions-=T " hide toolbar

if has('macunix')
  "colorscheme getafe
  set guifont=Menlo:h18
elseif has('unix')
  set guifont=Monospace\ 12
endif

