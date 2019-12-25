set nocompatible

let g:is_gui = has('gui_running') || has('gui_vimr')
let g:is_mac = has('macunix') || has('mac')

let mapleader = ","

let $VIMDIR = expand('~/.config/nvim')

if is_mac
  let g:python_host_prog = '/usr/local/bin/python2'
  let g:python3_host_prog = '/usr/local/bin/python3'
endif

" OCaml stuff
runtime! opam.vim
let s:ocp_indent_dir = g:opam_share_dir . "/ocp-indent/vim"
let s:ocp_index_dir = g:opam_share_dir . "/ocp-index/vim"
let s:merlin_dir = g:opam_share_dir . "/merlin/vim"

let s:dein_cache_path = expand('~/.cache/dein')
let s:dein_dir = s:dein_cache_path . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~ '/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  execute 'set runtimepath+=' . fnamemodify(s:dein_dir, ':p')
endif

if dein#load_state(s:dein_cache_path)
  call dein#begin(s:dein_cache_path)

  call dein#add(s:dein_dir)

  call dein#load_toml('~/.config/nvim/dein.toml')

  if isdirectory(s:ocp_indent_dir)
    call dein#add(s:ocp_indent_dir, { 'on_ft': 'ocaml', 'name': 'ocp_indent', 'depends': 'vim-ocaml' })
  endif
  if isdirectory(s:ocp_index_dir)
    call dein#add(s:ocp_index_dir, { 'on_ft': 'ocaml', 'name': 'ocp_index', 'depends': 'ocp_indent' })
    call dein#add(s:merlin_dir, { 'on_ft': 'ocaml', 'depends': 'ocp_index' })
  else
    call dein#add(s:merlin_dir, { 'on_ft': 'ocaml' })
  endif

  call dein#end()
  call dein#save_state()
endif

" fzf - Fuzzy find
" let $FZF_DEFAULT_OPTS .= ' --inline-info'
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --exclude .git'
if is_mac && is_gui
  nnoremap <D-p> :FZF<CR>
  inoremap <D-p> <C-o>:FZF<CR>
  vnoremap <D-p> <ESC>:FZF<CR>
  nnoremap <D-S-p> :Buffers<CR>
  inoremap <D-S-p> <C-o>:Buffers<CR>
  nnoremap <D-A-p> :GFiles<CR>
  nnoremap <D-A-S-p> :GFiles?<CR>
endif
nnoremap <C-p> :FZF<CR>
nnoremap <Leader>l :Lines<CR>
nnoremap <Leader>L :BLines<CR>
nnoremap <Leader>rg :Rg <C-r><C-w><CR>
nnoremap <Leader>RG :Rg <C-r><C-r><CR>
vnoremap <Leader>rg y:Rg <C-r>"<CR>
" nnoremap <Leader>ag :Ag <C-r><C-w><CR>
vmap <Leader>f <Leader>rg
nnoremap <Leader>` :Marks<CR>
nnoremap <Leader>§ :Marks<CR>
" imap <C-x><C-k> <Plug>(fzf-complete-word)
imap <C-x><C-f> <Plug>(fzf-complete-path)
imap <C-x><C-j> <Plug>(fzf-complete-file-ag)
imap <C-x><C-l> <Plug>(fzf-complete-line)

" airline
if is_gui
  let g:airline_theme = 'onedark_modified'
else
  let g:airline_theme = 'powerlineish'
endif
" let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#branch#enabled = 1
" let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#coc#enabled = 1
" let g:airline#extensions#tagbar#enabled = 1
" let g:airline_skip_empty_sections = 1

" commentary
if is_mac && is_gui
  nmap <D-/> gcc
  imap <D-/> <C-o>gcc
  vmap <D-/> gc
endif

" vim-easy-align
nmap ga <Plug>(EasyAlign)
vmap ga <Plug>(EasyAlign)

" vim-easymotion
" let g:EasyMotion_smartcase = 1
" nmap s <Plug>(easymotion-s2)
" nmap S <Plug>(easymotion-s)
" vmap <Leader>s <Plug>(easymotion-s2)
" vmap <Leader>S <Plug>(easymotion-s)
" vmap s <Plug>(easymotion-s2)
" imap <C-s> <C-o><Plug>(easymotion-s2)
" nmap f <Plug>(easymotion-fl)
" nmap F <Plug>(easymotion-Fl)
" vmap f <Plug>(easymotion-fl)
" vmap F <Plug>(easymotion-Fl)
" nmap <A-f> <Plug>(easymotion-f)
" nmap <A-F> <Plug>(easymotion-F)
" vmap <A-f> <Plug>(easymotion-f)
" vmap <A-F> <Plug>(easymotion-F)

" nnoremap <Leader><A-f> f
" nnoremap <Leader><A-F> F

" vim-sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1

" vim-open-url
" (default is gB)
nmap <Leader>o <Plug>(open-url-browser)
" open on GitHub
vnoremap <Leader>gh y:OpenURL https://github.com/<C-r>"<CR>

" indentLine
let g:indentLine_concealcursor = "nc"
let g:indentLine_conceallevel = 1
let g:indentLine_char = '▏'

" syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_error_symbol = '✗'
" let g:syntastic_style_error_symbol = 'S✗'
" let g:syntastic_warning_symbol = '!'
" let g:syntastic_style_warning_symbol = 'S!'
" if is_gui
"   let g:syntastic_full_redraws = 0
" endif
" " let g:syntastic_ocaml_checkers = ['merlin']

" ale
let g:ale_virtualtext_cursor = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '!'
let g:ale_sign_info = 'i'
let g:ale_set_balloons = 0
nmap <Leader>af <Plug>(ale_fix)
" nmap <Leader>al <Plug>(ale_lint)
" nmap <Leader>ad <Plug>(ale_detail)
" nmap <Leader>ah <Plug>(ale_hover)
" nmap <Leader>ar <Plug>(ale_find_references)
" nmap <Leader>agd <Plug>(ale_go_to_definition_in_split)
" nmap <Leader>agD <Plug>(ale_go_to_definition)
" nmap gd <Plug>(ale_go_to_definition_in_split)
" nmap gD <Plug>(ale_go_to_definition)
" nmap <LocalLeader>t <Plug>(ale_hover)
" imap <C-t> <Plug>(ale_hover)
" nmap <LocalLeader>f <Plug>(ale_find_references)
" nmap <Leader>a, <Plug>(ale_next_wrap)
" nmap <Leader>a. <Plug>(ale_previous_wrap)
let g:ale_linters = {}
let g:ale_linters_explicit = 1
let g:ale_disable_lsp = 1

" " deoplete
" let g:deoplete#enable_at_startup = 1

" coc.nvim
nnoremap <silent> <LocalLeader>t :call CocAction('doHover')<CR>
nnoremap <silent> <LocalLeader>ct :call CocAction('doHover')<CR>
nmap <silent> <LocalLeader>f <Plug>(coc-references)
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gD :call CocAction('jumpDefinition', 'split')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gY :call CocAction('jumpTypeDefinition', 'split')<CR>
nmap <silent> <LocalLeader>r <Plug>(coc-rename)
nnoremap <silent> <Space>c :<C-u>CocList commands<CR>
nnoremap <silent> <Space>o :<C-u>CocList outline<CR>
nnoremap <silent> <Space>s :<C-u>CocList -I symbols<CR>
nmap <silent> <Space>v <Plug>(coc-range-select)
vmap <silent> <Space>v <Plug>(coc-range-select)
nmap <LocalLeader>ca <Plug>(coc-codeaction)
nmap <LocalLeader>qf <Plug>(coc-fix-current)

" echodoc
" let g:echodoc#enable_at_startup = 1
" let g:echodoc#type = 'floating'

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" vim-move
let g:move_map_keys = 0
vmap <Leader><A-j> <Plug>MoveBlockDown
vmap <Leader><A-k> <Plug>MoveBlockUp
vmap <Leader><A-h> <Plug>MoveBlockLeft
vmap <Leader><A-l> <Plug>MoveBlockRight
nmap <Leader><A-j> <Plug>MoveLineDown
nmap <Leader><A-k> <Plug>MoveLineUp
if is_mac && is_gui
  nmap <D-A-Down> <Plug>MoveLineDown
  nmap <D-A-Up> <Plug>MoveLineUp
  vmap <D-A-Down> <Plug>MoveBlockDown
  vmap <D-A-Up> <Plug>MoveBlockUp
  vmap <D-A-Left> <Plug>MoveBlockLeft
  vmap <D-A-Right> <Plug>MoveBlockRight
endif

nnoremap <space> <NOP>

nnoremap <C-g>d gd
nnoremap <C-g>D gD

set completeopt-=preview

set noshowmode

inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" remove trailing newlines from a register
nnoremap <silent> <Leader>n :call setreg(v:register,
      \substitute(getreg(v:register), '\n\+$', '', 'g'))<CR>

" insert char
nnoremap <Leader>i i_<Esc>r
nnoremap <Leader>I a_<Esc>r

nnoremap <silent> <BS> "_X
nnoremap <silent> <S-BS> "_x

vnoremap <silent> // y/<C-R>"<CR>

nnoremap Y y$

inoremap <silent> <C-.> <Esc>

" command history
nnoremap q: <NOP>
nnoremap <Leader><Leader>q: q:

" ex mode
nnoremap Q <NOP>
nnoremap <Leader><Leader><C-q>Q Q

" remove trailing whitespace
nnoremap <silent> <Leader><C-w>
      \ :let _s=@/ <Bar>
      \ :%s/\s\+$//e <Bar>
      \ :let @/=_s <Bar>
      \ :nohl <Bar>
      \ :unlet _s<CR>

nnoremap <silent> <C-;> :let @/=''<CR>
inoremap <silent> <C-;> <C-o>:let @/=''<CR>

nnoremap <silent> <C-\> :b#<CR>

nnoremap ' `
nnoremap ` '

" duplicate line
nnoremap <silent> <Leader>d :t.<CR>

nnoremap <silent> <A-l> :lopen<CR>
nnoremap <silent> <A-L> :lclose<CR>
nnoremap <silent> <C-l> :ll<CR>
nnoremap <silent> <A-q> :copen<CR>
nnoremap <silent> <A-Q> :cclose<CR>
nnoremap <silent> Q :cc<CR>

nnoremap <silent> <A-Left> <C-w><Left>
nnoremap <silent> <A-Right> <C-w><Right>
nnoremap <silent> <A-Up> <C-w><Up>
nnoremap <silent> <A-Down> <C-w><Down>

nnoremap <silent> <A-S-Left> <C-w>H
nnoremap <silent> <A-S-Right> <C-w>L
nnoremap <silent> <A-S-Up> <C-w>K
nnoremap <silent> <A-S-Down> <C-w>J

" close other windows
nnoremap <silent> <A-o> <C-w>o
" to tab
nnoremap <silent> <A-t> <C-w>T
" close
nnoremap <silent> <A-c> <C-w>c

nnoremap <silent> <A--> <C-w>-
nnoremap <silent> <A-=> <C-w>+
nnoremap <silent> <A-.> <C-w>>
nnoremap <silent> <A-,> <C-w><
nnoremap <silent> <C-A-=> <C-w>=
" nnoremap <silent> <C-A--> <C-w>_
" nnoremap <silent> <C-A-\> <C-w>|

" insert newline without automatic comment insertion
nnoremap <silent> <A-]>
      \ :let save_fmt=&formatoptions<CR>
      \:setlocal formatoptions-=cro<CR>
      \o<C-c>
      \:execute "setlocal formatoptions=" . save_fmt<CR>
      \:unlet save_fmt<CR>
      \i

imap <silent> <A-]> <Esc><A-]>

nnoremap <Leader><Leader><Leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>

nnoremap <Leader><Leader><Leader>m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nnoremap <Leader><Leader><Leader>M :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nnoremap <Leader><Leader><Leader>t :set noexpandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nnoremap <Leader><Leader><Leader>T :set noexpandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>

if is_mac && is_gui
  nnoremap <silent> <D-A-Left> :tabp<CR>
  inoremap <silent> <D-A-Left> <Esc>:tabp<CR>
  vnoremap <silent> <D-A-Left> <Esc>:tabp<CR>
  nnoremap <silent> <D-A-Right> :tabn<CR>
  inoremap <silent> <D-A-Right> <Esc>:tabn<CR>
  vnoremap <silent> <D-A-Right> <Esc>:tabn<CR>

  for i in range(1, 9)
    execute "nnoremap <silent> <D-" . i . "> :tabn " . i . "<CR>"
    execute "inoremap <silent> <D-" . i . "> <Esc>:tabn " . i . "<CR>"
  endfor

  nnoremap <silent> <D-Left> ^
  inoremap <silent> <D-Left> <C-c>I
  vnoremap <silent> <D-Left> ^
  nnoremap <silent> <D-Right> g_
  inoremap <silent> <D-Right> <End>
  vnoremap <silent> <D-Right> g_
  nnoremap <silent> <D-Up> gg
  inoremap <silent> <D-Up> <C-Home>
  vnoremap <silent> <D-Up> gg
  nnoremap <silent> <D-Down> G
  inoremap <silent> <D-Down> <C-End>
  vnoremap <silent> <D-Down> G

  nnoremap <silent> <D-BS> v0d
  inoremap <silent> <D-BS> <C-o>v0d

  nnoremap <silent> <D-]> >>
  inoremap <silent> <D-]> <C-t>
  vnoremap <silent> <D-]> >
  nnoremap <silent> <D-[> <<
  inoremap <silent> <D-[> <C-d>
  vnoremap <silent> <D-[> <

  nnoremap <silent> <D-S-d> :t.<CR>
  inoremap <silent> <D-S-d> <C-o>:t.<CR>

  " select word
  nnoremap <silent> <D-d> viw
endif

runtime! vault.vim

set concealcursor="nc"
set conceallevel=1
set listchars+=conceal:∘

set nostartofline

set scrolloff=1

set foldmethod=indent
set foldlevelstart=6

set ssop-=options

set signcolumn=yes

" set title

set hidden

set number
set relativenumber
set wrap
set showbreak=↳
set showmatch
set visualbell

set hlsearch
set smartcase
set ignorecase
set incsearch

set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set expandtab
set autoindent

set ruler
set whichwrap+=<,>,[,]
set backspace=indent,eol,start

set wildmode=longest,list

set cc=80

" set cursorline

set list
set lazyredraw

set tagcase=smart

set updatetime=300

syntax on

" SpellBad       xxx cterm=underline ctermfg=204 gui=underline guifg=#E06C75
" SpellCap       xxx ctermfg=173 guifg=#D19A66

highlight link ALEError SpellBad
highlight link ALEWarning SpellCap

if is_gui
  let g:onedark_terminal_italics = 1
  augroup colorextend
    autocmd!
    function Highlighting()
      call onedark#extend_highlight("SpellBad", {
            \"gui": "undercurl",
            \"fg": { "gui": "NONE" },
            \"bg": { "gui": "NONE" },
            \"sp": { "gui": "#e06c75" }
            \})

      highlight! ALEVirtualTextError gui=bold,italic cterm=bold ctermfg=204 guifg=#dd7186
      highlight! ALEVirtualTextWarning gui=bold,italic cterm=bold ctermfg=173 guifg=#d19a66

      highlight! CocWarningVirtualText gui=italic cterm=bold ctermfg=130 guifg=#c36c00
      highlight! CocErrorVirtualText gui=italic cterm=bold ctermfg=204 guifg=#c30000
      highlight! CocErrorFloat guifg=#ff5d64
      highlight! link CocErrorHighlight SpellBad
      highlight! link CocWarningHighlight SpellCap

      highlight! Sneak ctermfg=15 ctermbg=201 guifg=#ff0000 guibg=#000000
      highlight clear SneakLabel

      " highlight Pmenu ctermbg=237 ctermfg=white
      " highlight PmenuSel ctermbg=220 ctermfg=black
      " highlight PmenuSbar ctermbg=233
      " highlight PmenuThumb ctermbg=7
    endfunction
    autocmd ColorScheme * call Highlighting()
  augroup END
  colorscheme onedark
else
  highlight link GitGutterAdd DiffAdd
  highlight link GitGutterChange DiffChange
  highlight link GitGutterDelete DiffDelete
endif

set exrc
set secure
