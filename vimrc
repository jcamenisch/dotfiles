let vim_home=$XDG_CONFIG_HOME."/vim"
let bundle_home=vim_home."/bundle"
let &rtp=vim_home.",".&rtp.",".bundle_home."/Vundle.vim"

set nocompatible
filetype off

call plug#begin(vim_home.'/plugged')
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'

" Plug 'fatih/vim-go'
Plug 'ElmCast/elm-vim'
Plug 'elixir-lang/vim-elixir'
Plug 'plasticboy/vim-markdown'
" Plug 'tpope/vim-markdown'
" Plug 'Valloric/YouCompleteMe'
Plug 'w0rp/ale'
Plug 'Shutnik/jshint2.vim'

Plug 'ngmy/vim-rubocop'
Plug 'tpope/vim-rails'

" Plugins for TypeScript
Plug 'HerringtonDarkholme/yats'            " Syntax highlighting
"Plug 'Quramy/vim-js-pretty-template'      " Syntax highlighting inside template strings
Plug 'Shougo/vimproc.vim', {'do' : 'make'} " Required by tsuquyomi
Plug 'Quramy/tsuquyomi'                    " Autocompletion and IDE features

Plug 'Chiel92/vim-autoformat'
Plug 'amadeus/vim-mjml'
Plug 'nvie/vim-flake8'
Plug 'psf/black'
call plug#end()

" Auto-format all the things
"au BufWrite * :Autoformat
" More setup: https://github.com/Chiel92/vim-autoformat

" A.L.E. settings https://vimawesome.com/plugin/ale
let g:ale_fix_on_save = 1
" let g:ale_fixers = {
" \  'go': [
" \    'goimports'
" \  ],
" \}


" Go settings
" let g:go_fmt_options = '-s'
"This is the typical approach to setting up goimports, but it doesn't support
"the -s flag:
"let g:go_fmt_command = 'goimports'
":autocmd BufWritePre *.go :%!goimports

" RuboCop settings
let g:vimrubocop_config = './.rubocop.yml'

" Markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2

" JSHint settings
let jshint2_read = 1
let jshint2_save = 1

" Misc
set mouse=a
if has("mouse_sgr")
  set ttymouse=sgr
elseif !has('nvim')
  set ttymouse=xterm2
end
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
" set ignorecase                              " Ignore case
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

" Mappings for fzf
nmap <C-p> :FZF<CR>
xmap <C-p> :FZF<CR>
imap <C-p> <ESC>:FZF<CR>

" Insert mode completion
" Why don't these work?
imap <C-x><C-k> <plug>(fzf-complete-word)
imap <C-x><C-f> <plug>(fzf-complete-path)
imap <C-x><C-j> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

" More textobj-ruby bindings
let g:textobj_ruby_more_mappings = 1

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

if filereadable(expand("~/.vimrc.after"))
  source ~/.vimrc.after
endif

set runtimepath^=~/.vim/bundle/ctrlp.vim



let mapleader = " "
nmap <Leader>g :Ggrep

map <C-l> "=strftime("%a %m/%d/%Y %H:%M  ")<CR>Pa
imap <C-l> <C-R>=strftime("%a %m/%d/%Y %H:%M  ")<CR>
map <C-s><C-s> :w<CR>
imap <C-s> <ESC>:w<CR>a
imap <C-v> <ESC>"*P

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
"if &term =~ "xterm.*"
"let &t_ti = &t_ti . "\e[?2004h"
"let &t_te = "\e[?2004l" . &t_te
"function XTermPasteBegin(ret)
"set pastetoggle=<Esc>[201~
"set paste
"return a:ret
"endfunction
"map <expr> <Esc>[200~ XTermPasteBegin("i")
"imap <expr> <Esc>[200~ XTermPasteBegin("")
"endif
