" based on http://github.com/jferris/config_files/blob/master/vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


""" Vundle management of modules
filetype on                    " required for osx vim
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'msanders/snipmate.vim'
Bundle 'kien/ctrlp.vim'

" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" ...


filetype plugin indent on     " required! 
""" Vundle section done



set encoding=utf-8
set showcmd             " display incomplete commands

" , is the leader character
let mapleader = ","

set nobackup
set nowritebackup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

set showmode
set cursorline
set ttyfast
"set relativenumber
"set undofile

" Don't load the pi_paren plugin to do brace matching
" http://vimdoc.sourceforge.net/htmldoc/pi_paren.html
let loaded_matchparen = 1

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running"))
  syntax on
  set hlsearch

  " use spacebar to turn off highlighting
  nnoremap <silent> <space> :noh<return>
  " Hide search highlighting
  map <Leader>h :set invhls <CR>
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  augroup filetypes
    au!
    autocmd BufNewFile,BufRead *.txt setfiletype text
    autocmd BufRead,BufNewFile *.thrift setfiletype thrift
    autocmd BufRead,BufNewFile *.bcf setfiletype perl
    autocmd BufRead,BufNewFile *.phpt setfiletype php

    " Enable soft-wrapping for text files
    autocmd FileType tex,text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist spell spelllang=en_us
    " For all text files set 'textwidth' to 72 characters.
    autocmd FileType text setlocal textwidth=72
    autocmd FileType tex setlocal textwidth=72
    autocmd FileType python setlocal shiftwidth=4
    autocmd FileType java setlocal shiftwidth=4


    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    " Automatically load .vimrc source when saved
    autocmd BufWritePost .vimrc source $MYVIMRC
  augroup END

  fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
  endfun


  augroup whitespace
    " kill any trailing whitespace on save
    autocmd FileType c,cabal,cpp,haskell,javascript,php,python,readme,text,tex,ocaml,perl,java,thrift
      \ autocmd BufWritePre <buffer>
      \ :call <SID>StripTrailingWhitespaces()
  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" if has("folding")
  " set foldenable
  " set foldmethod=syntax
  " set foldlevel=1
  " set foldnestmax=2
  " set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
" endif

"" Whitespace
" Switch wrap off for everything
set nowrap                      " don't wrap lines
set tabstop=8                   " keepin' it real
set shiftwidth=2                " indentation is two spaces
set expandtab                   " use spaces, not tabs
set smarttab
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" Display extra whitespace: use ",s" to toggle back and forth
set listchars=tab:>-,trail:·
nmap <silent> <leader>s :set nolist!<CR>


" case only matters with mixed case expressions
set incsearch		" do incremental searching
set ignorecase          " case insensitive searching...
set smartcase           " ... unless there is at least one capital letter

" Always display the status line
set laststatus=2

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>tn :tabnew<CR>

" Open a new vertical split
nnoremap <Leader>w <C-w>v<C-w>l

" Easy split navigation
" Navigate splits by using ctrl-<direction>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>


" No Help, please
nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

" Local config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=coverage
endif

" Color scheme
"colorscheme vividchalk
"highlight NonText guibg=#060606
"highlight Folded  guibg=#0A0A0A guifg=#9090D0
colorscheme molokai

" Numbers
set nonumber
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
set tags=tags;/

let g:fuf_splitPathMatching=1

" Open URL
command! -bar -nargs=1 OpenURL :!open <args>
function! OpenURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
	  exec "!open \"" . s:uri . "\""
  else
	  echo "No URI found in line."
  endif
endfunction
map <Leader>u :call OpenURL()<CR>

"" Fix indenting for pasting, by using <F5>
"nnoremap <F5> :set invpaste paste?<Enter>
"imap <F5> <C-O><F5>
"set pastetoggle=<F5>

"" Instead, use a variable to explicitly track the paste mode
let paste_mode = 0              " 0 = normal, 1 = paste
func! Paste_on_off()
  if g:paste_mode == 0
    set paste
    let g:paste_mode = 1
  else
    set nopaste
    let g:paste_mode = 0
  endif
  return
endfunc
nnoremap <silent> <F5> :call Paste_on_off()<CR>
set pastetoggle=<F5>


" Start scrolling 3 lines before the edge
set scrolloff=3

set visualbell

" Don't use Ex mode, use W(rap) for formatting
map W gq

" Quick recording macro.  Record with "qq" and playback with "Q"
nnoremap Q @q

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Use sane regexes
nnoremap / /\v
vnoremap / /\v


map <F12> :Gblame<CR>
map <F11> :Gstatus<CR>
map <F10> :NERDTreeToggle<CR>
imap <F10> <Esc>:NERDTreeToggle<CR>

" Settings for Syntastic
""set statusline+=%#warningmsg#
""set statusline+=%{SyntasticStatuslineFlag()}
""set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=0
let g:syntastic_auto_loc_list=0

" Highlight any text beyond 80cols
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Highlight tabs, so that we don't put any into source code
syn match tab display "\t"
hi link tab Error

"" mappings for Command-T
" use double percent sign in command mode to expand to curdir
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

"" Fix the color settings in vim
"set t_Co=256
"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dm

" Settings for CtrlP
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
  \ }
let g:ctrlp_working_path_mode = 2
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
