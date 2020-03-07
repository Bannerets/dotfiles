if !exists('g:ocaml_loaded') && executable('opam')
  let g:ocaml_loaded = 1

  let s:opam_share_dir =
        \ substitute(system('opam config var share'), '[\r\n]*$', '', '')

  let s:ocp_indent_dir = s:opam_share_dir . '/ocp-indent/vim'
  let s:ocp_index_dir = s:opam_share_dir . '/ocp-index/vim'
  let s:merlin_dir = s:opam_share_dir . '/merlin/vim'

  if executable('ocp-indent')
    execute 'set rtp^=' . s:ocp_indent_dir
  endif

  if executable('ocp-index')
    execute 'set rtp+=' . s:ocp_index_dir
  endif

  if executable('ocamlmerlin')
    execute 'set rtp+=' . s:merlin_dir
    execute 'helptags ' . s:merlin_dir . '/doc'
    execute 'source ' . s:merlin_dir . '/plugin/*.vim'
  endif
endif

let g:ale_ocaml_ols_executable = 'ocamlmerlin-lsp'
" let b:ale_linters = ['merlin']
" let b:ale_linters = ['ols']
let b:ale_fixers = ['ocp-indent']

let no_ocaml_maps = 1

nmap <silent><buffer> <LocalLeader>s <Plug>OCamlSwitchEdit
nmap <silent><buffer> <LocalLeader>S <Plug>OCamlSwitchNewWin
" nmap <silent><buffer> <C-x> <Plug>OCamlSwitchEdit
" nmap <silent><buffer> <A-x> <Plug>OCamlSwitchNewWin

let g:merlin_disable_default_keybindings = 1

" nmap <buffer> <LocalLeader>r <Plug>(MerlinRename)

nmap <buffer> <LocalLeader>y :MerlinYankLatestType<CR>

" nmap <silent><buffer> <LocalLeader>f :MerlinOccurrences<CR>

imap <silent><buffer> <C-t> <C-o>:MerlinTypeOf<CR>

map <silent><buffer> <LocalLeader>mt :MerlinTypeOf<CR>
map  <silent><buffer> <LocalLeader>t :MerlinTypeOf<CR>
map  <silent><buffer> <LocalLeader>n :MerlinGrowEnclosing<CR>
map  <silent><buffer> <LocalLeader>p :MerlinShrinkEnclosing<CR>
vmap <silent><buffer> <LocalLeader>t :MerlinTypeOfSel<CR>

" nmap <silent><buffer> gd :MerlinLocate<CR>

nmap <buffer> <LocalLeader>T :MerlinTypeOf<space>
nmap <buffer> <LocalLeader>gd :MerlinLocate<space>

nmap <silent><buffer> <A-;> :MerlinClearEnclosing<CR>

" doesn't work well
" let g:ocaml_folding = 1

setlocal foldmethod=indent

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
