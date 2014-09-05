let run_bundle_install = 0
 
if !isdirectory(expand("~/.vim/bundle/vundle/"))
  silent !echo "Installing Vundle..."
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let run_bundle_install = 1
endif
 
set nocompatible
filetype off
 
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
 
Bundle "gmarik/vundle"
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-vinegar'


if run_bundle_install == 1
  :BundleInstall

  silent !echo ""
  silent !echo "Vim is now ready."
  :cq
endif

" Misc
set nowrap                                  " I don't always wrap lines...
set linebreak                               " ...but when I do, I wrap whole words.
set t_Co=256                                " Support for xterm with 256 colors (gets overriden in .gvimrc)
set ruler                                   " Show ruler
set listchars=trail:.,tab:>-,eol:¬          " Change the invisible characters
set noswapfile                              " Don't create annoying *.swp files
set number                                  " Line numbers on
set scrolloff=5                             " Start scrolling the file 5 lines before the end of the window
set spelllang=en_us                         " Set default spelling language to English
set hidden                                  " Allow hiding buffers with unsaved changes
set wildmenu                                " Make tab completion act more like bash
set wildmode=list:longest                   " Tab complete to longest common string, like bash
set showcmd                                 " Display an incomplete command in the lower right corner
set showmode                                " Show current mode down the bottom
set laststatus=2                            " Always show the status line
set history=10000
set autoread
set noerrorbells

autocmd FileType gitcommit set spell        " Turn on spell check in Git commits.

" Treat dashed words as whole words in stylesheets
autocmd Filetype css,scss,sass setlocal iskeyword+=-

" Remove trailing whitespace from source files
autocmd FileType awk,b,c,cfg,chaskell,conf,config,cpp,crontab,cucumber,d,django,dtd,dtml,eiffel,erlang,eruby,gitconfig,haml,haskell,html,java,javacc,javascript,liquid,lisp,lua,make,markdown,objc,ocaml,pascal,perl,perl6,php,phtml,plsql,python,r,ruby,sass,scheme,scss,sh,smarty,sql,tcl,tcsh,vim,xhtml,xml,xsd,xslt,yaml,zsh autocmd BufWritePre <buffer> :%s/\s\+$//e

" Searching
set hlsearch                                " Highlight searches
set incsearch                               " Highlight search results instantly
set ignorecase                              " Ignore case
set smartcase                               " Override 'ignorecase' option if the search contains upper case characters.

filetype plugin indent on                   " Enable automatic filetype detection, filetype-specific plugins/indentation

" Indentation
set shiftwidth=2                            " Number of spaces to use in each autoindent step
set tabstop=2                               " Two tab spaces
set softtabstop=2                           " Number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab                               " Spaces instead of tabs for better cross-editor compatibility
set autoindent                              " Keep the indent when creating a new line
set smarttab                                " Use shiftwidth and softtabstop to insert or delete (on <BS>) blanks
set cindent                                 " Recommended seting for automatic C-style indentation
set autoindent                              " Automatic indentation in non-C files

set visualbell t_vb=

" Don't add the comment prefix when I hit enter or o/O on a comment line.
set formatoptions-=or

" Colorscheme
syntax enable
highlight SignColumn ctermbg=8
colorscheme delek
highlight LineNr term=bold ctermfg=2 ctermbg=0


" Use % to jump to matching begin/end of blocks as well as brackets/parens
runtime macros/matchit.vim

" Set wildcard ignore for ctrlp and ack/ag
set wildignore+=*/tmp/*,vendor/bundle/*,*.so,*.swp,*.zip,*.png,*.jpg,*.jpeg,*.gif,.gitkeep

let g:ctrlp_custom_ignore = {'dir': '\v[\/]vendor\/bundle$' }

" Use powerline font in airline
let g:airline_powerline_fonts = 1

" More textobj-ruby bindings
let g:textobj_ruby_more_mappings = 1

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

if filereadable(expand("~/.vimrc.after"))
  source ~/.vimrc.after
endif

set runtimepath^=~/.vim/bundle/ctrlp.vim



nnoremap <C-d> s/^/#\~ /<CR>:.s/^#\~ #\~ //<CR>
nnoremap <C-l> "=strftime("%a %m/%d/%Y %H:%M  ")<CR>Pa
inoremap <C-l> <C-R>=strftime("%a %m/%d/%Y %H:%M  ")<CR>
inoremap <C-s> <ESC>:w<CR>a
map <C-q><C-q> :q!<CR>
imap <C-q><C-q> <ESC>:q!<CR>
map <C-q> :q<CR>
imap <C-q> <ESC>:q<CR>
map <C-x> :x<CR>
imap <C-x> <ESC>:x<CR>

imap jj <Esc>

if has("gui_macvim")
    let macvim_hig_shift_movement = 1
endif

" This stuff doesn't work. I don't know why.
" (It works when entered from within vim after startup)
if !empty($TMUX)
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

if has("gui_macvim")
    let macvim_hig_shift_movement = 1
endif

" Splits
set splitbelow         " Split below
set splitright         " Vsplit right
set winminheight=0

" Make pasting work without indentation in terminal
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
endif
