require("noice").setup({
    routes = {
        {
            filter = {
                event = "lsp",
                kind = "progress",
                cond = function(message)
                    local client = vim.tbl_get(message.opts, "progress", "client")
                    return client == "lua_ls"
                end,
            },
            opts = { skip = true },
        },
    },
    cmdline = {
        view = "cmdline",
    },
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
    },
})
