-- Snippet setup
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})
luasnip.filetype_extend("elixir", { "eelixir" })
luasnip.filetype_extend("ruby", { "rails" })
luasnip.filetype_extend("javascriptreact", { "html" })
luasnip.filetype_extend("typescriptreact", { "html" })

-- CMP setup
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = { completeopt = "menu,menuone,noinsert" },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"]     = cmp.mapping.select_next_item(),
    ["<C-p>"]     = cmp.mapping.select_prev_item(),
    ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
    ["<C-y>"]     = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<C-l>"] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),
    ["<C-h>"] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
    { name = "codeium" },
    { name = "supermaven" },
    { name = "emoji" },
    { name = "digraphs" },
    { name = "dictionary", keyword_length = 3 },
    { name = "lazydev",    group_index = 0 },
    { name = "render-markdown" },
  }),
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline({
    ["<TAB>"] = { c = false },
  }),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline", max_item_count = 10 },
  }),
  matching = { disallow_symbol_nonprefix_matching = false },
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline({
    ["<TAB>"] = { c = false },
  }),
  sources = {
    { name = "buffer", max_item_count = 10 },
  },
})
