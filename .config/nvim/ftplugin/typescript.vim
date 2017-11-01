call deoplete#enable()

let g:nvim_typescript#tsimport#template = 'import { %s } from ''%s'''

nmap <Leader>i :TSType<CR>
nmap <Leader>r :TSRename<CR>
nmap K :TSDoc<CR>
nmap gd :TSTypeDef<CR>
