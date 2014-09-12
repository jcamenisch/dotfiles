
:syntax match SectionHead /^[A-Z][a-z][a-z] \d\d\/\d\d\/\d\d\d\d \d\d:\d\d.*/ contains=Client
syntax match Client /  .*\: /
:highlight link Client Special
:highlight link SectionHead Constant

:syntax include ~/timesheets/.abbreviations.vim
