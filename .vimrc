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

ab oh: Overhead:
ab cf: Character First:
ab er: Eyereach Productions:
ab sa: Shepherd Automotive:
ab tr: Tobacco Road: 
ab ur: Uprooting Anger:
ab pb: Phonebooth.com:
ab rsr: Rebecca's Silver Rose:
ab hpc: Heritage Pres.:

nnoremap <F5> "=strftime("%a %m/%d/%Y %H:%M  ")<CR>Pa
nnoremap <C-D> :.s/^/#\~ /<CR>:.s/^#\~ #\~ //<CR>
inoremap <F5> <C-R>=strftime("%a %m/%d/%Y %H:%M  ")<CR>
inoremap <C-S> <ESC>:w<CR>a
inoremap <F4> <ESC>:x<CR>
nnoremap <F4> :x<CR>

if has("gui_macvim")
    let macvim_hig_shift_movement = 1
endif
