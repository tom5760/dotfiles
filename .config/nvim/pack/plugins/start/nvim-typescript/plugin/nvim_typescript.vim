if exists('g:nvim_typescript#loaded')
  finish
endif
let g:nvim_typescript#loaded = 1
let g:nvim_typescript#ts_version = 'typescript@2.4.0'
let g:nvim_typescript#version = '1.4.0'

let g:nvim_typescript#javascript_support =
      \ get(g:, 'nvim_typescript#javascript_support', 0)
let g:nvim_typescript#vue_support =
      \ get(g:, 'nvim_typescript#vue_support', 0)
let g:nvim_typescript#server_path =
      \ get(g:, 'nvim_typescript#_server_path', 'node_modules/.bin/tsserver')
let g:nvim_typescript#max_completion_detail =
      \ get(g:, 'nvim_typescript#max_completion_detail', 25)
let g:nvim_typescript#type_info_on_hold =
      \ get(g:, 'nvim_typescript#type_info_on_hold', 0)
let g:nvim_typescript#signature_complete =
      \ get(g:, 'nvim_typescript#signature_complete', 0)
let g:nvim_typescript#loc_list_item_truncate_after =
      \ get(g:, 'nvim_typescript#loc_list_item_truncate_after', 20)
let g:nvim_typescript#tsimport#template =
      \ get(g:, 'nvim_typescript#tsimport#template', 'import { %s } from ''%s'';')
let g:nvim_typescript#default_mappings =
      \ get(g:, 'nvim_typescript#default_mappings', 0)
let g:nvim_typescript#completion_mark =
      \ get(g:, 'nvim_typescript#completion_mark', 'TS')

let s:kind_symbols = {
    \ 'keyword': 'keyword',
    \ 'class': 'class',
    \ 'interface': 'interface',
    \ 'script': 'script',
    \ 'module': 'module',
    \ 'local class': 'local class',
    \ 'type': 'type',
    \ 'enum': 'enum',
    \ 'alias': 'alias',
    \ 'type parameter': 'type param',
    \ 'primitive type': 'primitive type',
    \ 'var': 'var',
    \ 'local var': 'local var',
    \ 'property': 'prop',
    \ 'let': 'let',
    \ 'const': 'const',
    \ 'label': 'label',
    \ 'parameter': 'param',
    \ 'index': 'index',
    \ 'function': 'function',
    \ 'local function': 'local function',
    \ 'method': 'method',
    \ 'getter': 'getter',
    \ 'setter': 'setter',
    \ 'call': 'call',
    \ 'constructor': 'constructor'
    \}

let g:nvim_typescript#kind_symbols =
      \ get(g:, 'nvim_typescript#kind_symbols', s:kind_symbols)


augroup nvim-typescript "{{{
  autocmd!
  function! s:TSSearch(query)
      let symbols = TSGetWorkspaceSymbolsFunc(a:query)
      call setloclist(0, symbols, 'r', 'Symbols')
      lopen
  endfunction
  command! -nargs=1 TSSearch call s:TSSearch(<q-args>)

  if get(g:, 'nvim_typescript#type_info_on_hold', 1)
    if get(g:, 'nvim_typescript#javascript_support', 1)
       autocmd CursorHold *.js,*.jsx TSType
    endif
    if get(g:, 'nvim_typescript#vue_support', 1)
       autocmd CursorHold *.vue TSType
    endif
    autocmd CursorHold *.ts,*.tsx TSType
  endif

  if get(g:, 'nvim_typescript#signature_complete', 1)
     autocmd CompleteDone *.ts,*.tsx TSSig
  endif

  if get(g:, 'nvim_typescript#javascript_support', 1)
    autocmd BufEnter *.js,*.jsx call nvim_typescript#DefaultKeyMap()
    autocmd BufEnter *.js,*.jsx call TSOnBufEnter()
    autocmd BufWritePost *.js,*.jsx call TSOnBufSave()
  endif
  if get(g:, 'nvim_typescript#vue_support', 1)
    autocmd BufEnter *.vue call nvim_typescript#DefaultKeyMap()
    autocmd BufEnter *.vue call TSOnBufEnter()
    autocmd BufWritePost *.vue call TSOnBufSave()
  endif
  autocmd BufEnter *.ts,*.tsx call nvim_typescript#DefaultKeyMap()
  autocmd BufEnter *.ts,*.tsx call TSOnBufEnter()
  autocmd BufWritePost *.ts,*.tsx call TSOnBufSave()

  autocmd User CmSetup call cm#sources#typescript#register()

augroup end "}}}
