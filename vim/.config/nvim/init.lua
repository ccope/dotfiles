local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

require('packer').startup(function(use)
-- Plugins
  -- Eye candy
  --use 'nanotech/jellybeans.vim'
  use({
    'themercorp/themer.lua',
    config = function()
      require("themer").setup({
          colorscheme = "jellybeans"
      })
    end
  })
  --use 'rktjmp/lush.nvim'
  --use 'kabouzeid/nvim-jellybeans'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  --use 'NTBBloodbath/galaxyline.nvim'
  -- Open files at line, ex: vim foo.rs:32
  use 'bogado/file-line'
  -- Load settings in .editorconfig files
  use 'editorconfig/editorconfig-vim'
  use 'vimlab/split-term.vim'
  --use 'cloudhead/neovim-fuzzy'
  use 'tpope/vim-abolish'
  use 'tpope/vim-surround'
  -- VCS
  use 'tpope/vim-fugitive'
  --use 'mhinz/vim-signify'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'ruanyl/vim-gh-line'
  -- File browsing/search
  use 'scrooloose/nerdtree'
  -- TODO: Remove skim if I fully switch to Telescope
  -- skim depends on the rust packages skim and ripgrep
  --use { 'ibhagwan/fzf-lua',
  --  requires = {
  --    'vijaymarupudi/nvim-fzf',
  --    'kyazdani42/nvim-web-devicons' } -- optional for icons
  --}
  -- Markdown viewer
  use 'greyblake/vim-preview'
  -- Chef scripts
  --use 't9md/vim-chef'
  -- Javascript
  --use 'pangloss/vim-javascript'
  -- Ruby
  --use 'skalnik/vim-vroom'
  --use 'tpope/vim-rbenv'
  --use 'vim-ruby/vim-ruby'
  -- Go
  --use 'fatih/vim-go'
  -- Tmux
  use 'christoomey/vim-tmux-navigator'
  -- Toml
  use 'cespare/vim-toml'
  use 'hashivim/vim-terraform'
  --SQL
  use 'shmup/vim-sql-syntax'
  --SVG
  --use 'jasonshell/vim-svg-indent'
  -- YAML
  --use 'tarekbecker/vim-yaml-formatter'
  -- NEW LUA/LSP HOTNESS
  use 'kyazdani42/nvim-web-devicons'
  use { 'nvim-lua/popup.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'nvim-telescope/telescope-ui-select.nvim'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'rafamadriz/friendly-snippets'

  use 'simrat39/rust-tools.nvim'

  use 'mfussenegger/nvim-dap'
end)

vim.g.airline_theme = 'jellybeans'
vim.g.airline_powerline_fonts = 1
--vim.cmd [[colorscheme themer_jellybeans]]



-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- luasnip setup
local luasnip = require 'luasnip'

--BEGIN nvim-cmp
-- Setup nvim-cmp.
local cmp = require'cmp'
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end


cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
  end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
--cmp.setup.filetype('gitcommit', {
--  sources = cmp.config.sources({
--    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--  }, {
--    { name = 'buffer' },
--  })
--})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--END nvim-cmp

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)

local nvim_lsp = require('lspconfig')
local util = require('lspconfig/util')
local path = util.path
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts) --Interferes with vim-tmux-navigator
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv via poetry in workspace directory.
  local match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
  if match ~= '' then
    local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
    return path.join(venv, 'bin', 'python')
  end

  -- Fallback to system Python.
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

require('rust-tools').setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities
  }
})

nvim_lsp['ccls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  }
}

nvim_lsp['pylsp'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = function(client)
      client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  end,
  flags = {
    debounce_text_changes = 150,
  }
}

nvim_lsp['gopls'].setup{
  on_attach = on_attach,
  capabilities = capabilities
}

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        -- To disable a keymap, put [map] = false
        -- So, to not map "<C-n>", just put
        ["<C-l>"] = false,
      },
    }
  },
  extensions = {
    "ui-select"
  }
}

-- require'fzf-lua'.setup({fzf_bin = 'sk'})

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)

vim.o.title = true
vim.o.termguicolors = true
vim.o.hidden = true
vim.o.modeline = false
vim.o.completeopt='menu,menuone,noselect'
--TODO: Switch to LSP folding after https://github.com/neovim/neovim/pull/14306
vim.wo.foldmethod = 'expr'
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldenable=false
vim.o.guifont = "SauceCodePro Nerd Font Mono:h10"



vim.cmd [[
  au FileType puppet setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4
  au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4
  au FileType ruby setlocal tabstop=2 expandtab shiftwidth=2
  au FileType xml setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4
  au FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
  augroup filetypedetect
      au BufRead,BufNewFile *.h set filetype=c
      "au BufRead,BufNewFile *.ts set filetype=javascript
      "au BufRead,BufNewFile *.tsx set filetype=javascript
  augroup END
  "inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  "inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  " Auto-close doc window
  autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif
]]

-- Change leader to space
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader=" "
vim.g.maplocalleader=" "


--vim.g.python_host_prog = "/usr/bin/python"
--vim.g.python3_host_prog = "/home/cam/.pyenv/shims/python3"
vim.g.gh_open_command = 'xdg-open '

vim.g.terraform_fold_sections = 1


vim.g.EditorConfig_exclude_patterns = "['fugitive://.*']"

-- Set GDB leader
-- vim.g.ConqueGdb_Leader = '\'
-- vim.g.ConqueGdb_GdbExe = "rust-gdb"
-- vim.g.lldb_map_Lbreakpoint = "\b"
-- vim.g.lldb_map_Lcontinue = "\c"
-- vim.g.lldb_map_Lprint = "\p"
-- vim.g.lldb_map_Lrun = "\r"
-- vim.g.lldb_map_Lstep = "\s"
-- vim.g.lldb_map_Lstepin = "\i"

-- Custom Functions
vim.cmd [[
  function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  endfunction
  com! DiffSaved call s:DiffWithSaved()
]]

--nnoremap <leader>fx :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"<CR>
vim.cmd [[
  function! DoPrettyXML()
    " save the filetype so we can restore it later
    let l:origft = &ft
    set ft=
    " delete the xml header if it exists. This will
    " permit us to surround the document with fake tags
    " without creating invalid xml.
    1s/<?xml .*?>//e
    " insert fake tags around the entire document.
    " This will permit us to pretty-format excerpts of
    " XML that may contain multiple top-level elements.
    0put ='<PrettyXML>'
    $put ='</PrettyXML>'
    silent %!xmllint --format -
    " xmllint will insert an <?xml?> header. it's easy enough to delete
    " if you don't want it.
    " delete the fake tags
    2d
    $d
    " restore the 'normal' indentation, which is one extra level
    " too deep due to the extra tags we wrapped around the document.
    silent %<
    " back to home
    1
    " restore the filetype
    exe "set ft=" . l:origft
  endfunction
  command! PrettyXML call DoPrettyXML()
]]


