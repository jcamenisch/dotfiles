syntax on
colorscheme delek
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab
set autoindent

set visualbell t_vb=
set incsearch
set wildmenu

nnoremap <F5> "=strftime("%a %m/%d/%Y %H:%M  ")<CR>Pa
nnoremap <C-D> :.s/^/#\~ /<CR>:.s/^#\~ #\~ //<CR>
nnoremap <C-L> "=strftime("%a %m/%d/%Y %H:%M  ")<CR>Pa
nnoremap <F4> :x<CR>
inoremap <F5> <C-R>=strftime("%a %m/%d/%Y %H:%M  ")<CR>
inoremap <C-L> <C-R>=strftime("%a %m/%d/%Y %H:%M  ")<CR>
inoremap <C-S> <ESC>:w<CR>a
inoremap <F4> <ESC>:x<CR>

if has("gui_macvim")
    let macvim_hig_shift_movement = 1
endif
