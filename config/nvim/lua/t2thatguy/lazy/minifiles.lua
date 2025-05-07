return {
    "echasnovski/mini.files",
    version = "*",

    config = function()
        require("mini.files").setup({
            mappings = {
                go_in_plus = "<CR>",
                go_out = "H",
                go_out_plus = "h",
            },
            windows = {
                max_number = 3,
                preview = true,
            },
        })
        vim.keymap.set("n", "<leader>pd", function()
            MiniFiles.open()
        end)
    end,
}
