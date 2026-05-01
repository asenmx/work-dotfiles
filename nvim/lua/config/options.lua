vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 100
vim.opt.hlsearch = false
vim.opt.title= true
vim.opt.incsearch = true
vim.opt.colorcolumn = "120"
vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.timeoutlen = 5000
-- Disable netrw
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Preview substitutions live, as you type!
vim.opt.winborder = "rounded" -- Use rounded borders for windows
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
-- vim.opt.cursorline = true


local diagnostic_signs = {
    [vim.diagnostic.severity.ERROR] = "",
    [vim.diagnostic.severity.WARN] = "",
    [vim.diagnostic.severity.INFO] = "",
    [vim.diagnostic.severity.HINT] = "󰌵",
}

local shorter_source_names = {
    ["Lua Diagnostics."] = "Lua",
    ["Lua Syntax Check."] = "Lua",
}

function diagnostic_format(diagnostic)
    return string.format(
        "%s %s (%s): %s",
        diagnostic_signs[diagnostic.severity],
        shorter_source_names[diagnostic.source] or diagnostic.source,
        diagnostic.code,
        diagnostic.message
    )
end

vim.diagnostic.config({
    virtual_text = {
        spacing = 4,
        prefix = "",
        format = diagnostic_format,
    },
    signs = {
        text = diagnostic_signs,
    },
    underline = true,
    severity_sort = true,
})
