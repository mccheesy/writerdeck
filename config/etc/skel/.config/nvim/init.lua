-- Place this file at: config/etc/skel/.config/nvim/init.lua

-- Basic Neovim configuration for a focused writerdeck.

-- Set up options using vim.opt for a cleaner syntax
vim.opt.compatible = false      -- Be iMproved, required
vim.opt.filetype = "off"        -- Required to load filetype plugins correctly

-- --- Plugin Management (using vim-plug as an example) ---
-- If you don't want any plugins, you can remove this entire section.
-- For Lua-native plugin managers like lazy.nvim, the setup would be different.
-- To install plugins, run `:PlugInstall` inside Neovim after the first launch.
-- If you choose to use lazy.nvim, you would typically replace this section entirely.
-- Example for vim-plug (still using Vimscript functions via vim.cmd):
vim.cmd('call plug#begin("~/.local/share/nvim/plugged")')
-- vim.cmd('Plug "tpope/vim-sensible"')    -- Sensible defaults for Vim
-- vim.cmd('Plug "dracula/vim", { "as": "dracula" }') -- Example colorscheme (install with :PlugInstall)
-- vim.cmd('Plug "nvim-tree/nvim-web-devicons"') -- For file icons (requires a Nerd Font patched font)
-- vim.cmd('Plug "nvim-lualine/lualine.nvim"') -- For a customizable status line
vim.cmd('call plug#end()')

-- --- General Neovim Settings for Writing ---
vim.opt.encoding = "utf-8"            -- Use UTF-8 for all character encoding
vim.opt.termguicolors = true          -- Enable true color support in Ptyxis
vim.opt.number = true                 -- Show absolute line numbers
vim.opt.relativenumber = true         -- Show relative line numbers (useful for motions like 5j)
vim.opt.autoindent = true             -- Automatically indent new lines
vim.opt.smartindent = true            -- Smarter auto-indentation
vim.opt.tabstop = 4                   -- A tab character is 4 spaces wide
vim.opt.shiftwidth = 4                -- Auto-indentation is 4 spaces wide
vim.opt.expandtab = true              -- Use spaces instead of tabs
vim.opt.softtabstop = 4               -- Backspace over spaces as if they were tabs
vim.opt.wrap = true                   -- Wrap lines that exceed the window width
vim.opt.textwidth = 80                -- Set preferred text width for prose (e.g., 80 columns)
vim.opt.colorcolumn = "81"            -- Highlight column 81 to visually indicate textwidth (optional)
vim.opt.spell = true                  -- Enable spell check
vim.opt.spelllang = "en_us"           -- Set spell check language to US English
vim.opt.scrolloff = 8                 -- Keep 8 lines of context above/below the cursor when scrolling
vim.opt.showmatch = true              -- Show matching brackets/parentheses
vim.opt.ignorecase = true             -- Ignore case when searching
vim.opt.smartcase = true              -- Use smart case search: if search pattern contains uppercase, search case-sensitively
vim.opt.cursorline = true             -- Highlight the current line
vim.opt.signcolumn = "yes"            -- Always show the sign column (for linters, git signs, etc.)

-- --- Colorscheme (uncomment and adjust if you install one) ---
-- vim.cmd('colorscheme dracula') -- Example: requires 'dracula/vim' plugin

-- --- Keybindings (examples) ---
-- Lua mappings use vim.keymap.set(mode, lhs, rhs, opts)
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true, desc = 'Save current buffer' })
vim.keymap.set('n', '<C-q>', ':qa!<CR>', { noremap = true, silent = true, desc = 'Quit all buffers (force)' })
vim.keymap.set('n', '<leader>s', ':w<CR>', { noremap = true, silent = true, desc = 'Leader + s to save' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true, desc = 'Leader + q to quit current buffer' })

-- --- Basic Cloud Sync Function (using rclone) ---
-- This function is now defined in Lua.
-- It can be called manually (e.g., `:lua SyncToCloud()`)
-- or mapped to a keybinding for quick syncing.
local function SyncToCloud()
  print("Syncing documents to cloud with rclone...")
  -- vim.fn.system() runs a shell command and returns its output.
  -- 'silent' prevents Neovim from printing the command itself.
  -- Replace 'remote:writerdeck_backup' with your configured rclone remote and path.
  vim.fn.system('rclone sync /home/writer/documents remote:writerdeck_backup --progress')
  vim.cmd('redraw!') -- Redraw the screen to clear the shell command output
  print("Cloud sync complete!")
end

-- Example: Map <leader>S to call the sync function
vim.keymap.set('n', '<leader>S', '<cmd>lua SyncToCloud()<CR>', { noremap = true, silent = true, desc = 'Sync documents to cloud' })

-- Optional: Auto-sync on buffer write (use with caution on slow networks or large files)
-- vim.api.nvim_create_autocmd('BufWritePost', {
--   pattern = '*',
--   callback = SyncToCloud,
--   desc = 'Auto-sync documents to cloud on save',
-- })

