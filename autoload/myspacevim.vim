function! myspacevim#before() abort
    let g:defx_icons_enable_syntax_highlight = 1
    let g:defx_icons_column_length = 1
    let g:defx_icons_directory_icon = ''
    let g:defx_icons_mark_icon = '*'
    let g:defx_icons_copy_icon = ''
    let g:defx_icons_link_icon = ''
    let g:defx_icons_move_icon = ''
    let g:defx_icons_parent_icon = ''
    let g:defx_icons_default_icon = ''
    let g:defx_icons_directory_symlink_icon = ''
    " Options below are applicable only when using "tree" feature
    let g:defx_icons_root_opened_tree_icon = ''
    let g:defx_icons_nested_opened_tree_icon = ''
    let g:defx_icons_nested_closed_tree_icon = ''
    :set autoindent 
    :set ignorecase
    :set smartcase 
    let g:go_gopls_matcher = 'fuzzy'
    " let g:go_gopls_options=['-remote=auto','-ignore-case']
    call SpaceVim#custom#SPC('nmap',['a','g'],':LazyGit','LazyGit',1)
    call SpaceVim#custom#SPC('nnoremap', ['f', 't'], 'echom "hello world"', 'test custom SPC', 1)

endfunction
function! myspacevim#after() abort
    lua << EOF
    local golang_setup = {
      on_attach = function(client, bufnr)
        require "lsp_signature".on_attach({
          bind = true, 
          handler_opts = {
            border = "single"
          },
          zindex=30
        }, bufnr)
      end,
    }
    -- require('go').setup()
    -- require'navigator'.setup()
    require'lspconfig'.gopls.setup(golang_setup)
EOF
    call iceberg#palette#dark#create()
endfunction


" let g:go_gopls_gofumpt = v:true
