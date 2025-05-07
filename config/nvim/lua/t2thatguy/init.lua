require("t2thatguy.set")
require("t2thatguy.remaps")
require("t2thatguy.lazy_init")
require("t2thatguy.utils")

function SetThemeFromName(name)
    name = name or "catppuccin"
    vim.cmd.colorscheme(name)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetThemeFromName()
