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
    call SpaceVim#custom#SPC('nmap',['m'],':Legendary','Legendary',1)
    call SpaceVim#custom#SPC('nmap',['a','f'],':Telescope find_files',"Telescope find_files",1)
    call SpaceVim#custom#SPC('nmap',['a','r'],':Telescope live_grep',"Telescope live_grep",1)
    call SpaceVim#custom#SPC('nmap',['a','b'],':Telescope buffers',"Telescope buffers",1)
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
    require('lspconfig').gopls.setup(golang_setup)
    require("bookmarks").setup()
    -- require('smoothcursor').setup()

    require('legendary').setup({
      keymaps = {
        -- map keys to a command
        { '<leader>ff', ':Telescope find_files\n', description = 'Find files' },
        { '<leader>fg', ':Telescope live_grep\n', description = 'Live grep' },
        { '<leader>lg', ':LazyGit\n', description = 'LazyGit' },

        -- map keys to a function
        { '<leader>h', function() print('hello world!') end, description = 'Say hello' },
        -- keymaps have opts.silent = true by default, but you can override it
        { '<leader>s', ':SomeCommand<CR>', description = 'Non-silent keymap', opts = { silent = false } },
        -- create keymaps with different implementations per-mode
        {
          '<leader>c',
          { n = ':LinewiseCommentToggle<CR>', x = ":'<,'>BlockwiseCommentToggle<CR>" },
          description = 'Toggle comment'
        },
        -- create item groups to create sub-menus in the finder
        -- note that only keymaps, commands, and functions
        -- can be added to item groups
        {
          -- groups with same itemgroup will be merged
          itemgroup = 'short ID',
          description = 'A submenu of items...',
          icon = '',
          keymaps = {
            -- more keymaps here
          },
        },
      },
      commands = {
        -- easily create user commands
        { ':SayHello', function() print('hello world!') end, description = 'Say hello as a command' },
        {
          -- groups with same itemgroup will be merged
          itemgroup = 'short ID',
          -- don't need to copy the other group data because
          -- it will be merged with the one from the keymaps table
          commands = {
            -- more commands here
          },
        },
      },
      funcs = {
        -- Make arbitrary Lua functions that can be executed via the item finder
        { function() doSomeStuff() end, description = 'Do some stuff with a Lua function!' },
        {
          -- groups with same itemgroup will be merged
          itemgroup = 'short ID',
          -- don't need to copy the other group data because
          -- it will be merged with the one from the keymaps table
          funcs = {
            -- more funcs here
          },
        },
      },
      autocmds = {
        -- Create autocmds and augroups
        { 'BufWritePre', vim.lsp.buf.format, description = 'Format on save' },
        {
          name = 'MyAugroup',
          clear = true,
          -- autocmds here
        },
      },
    })

EOF
    call iceberg#palette#dark#create()
endfunction


" let g:go_gopls_gofumpt = v:true
