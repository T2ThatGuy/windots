vim.g.have_nerd_font = true
vim.showmode = false

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Indents
vim.opt.smartindent = true
vim.opt.breakindent = true

-- FS Things
vim.opt.backup = false
vim.opt.undodir = os.getenv("USERPROFILE") .. "\\.nvim\\undodir"
vim.opt.undofile = true

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Misc

-- Keeping false until I can find a better solution for
-- navigating through wrapped lines can be found
vim.opt.wrap = false

vim.opt.scrolloff = 50
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
-- vim.opt.colorcolumn = "80"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.inccommand = "split"
vim.opt.cursorline = true

