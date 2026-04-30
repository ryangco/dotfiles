vim.cmd([[cab cc CodeCompanion]])
require("codecompanion").setup({
  display = {
    action_palette = {
      provider = "snacks",
    },
  },
  strategies = {
    chat = { adapter = "myAnthropic", model = "claude-sonnet-4-6" },
    inline = { adapter = "myAnthropic", model = "claude-sonnet-4-6" },
    cmd = { adapter = "myAnthropic", model = "claude-sonnet-4-6" },
  },
  adapters = {
    http = {
      myAnthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = {
            api_key = "cmd:cat /home/myuser/secrets/ANT_API_KEY.txt",
          },
          schema = {
            model = {
              default = "claude-sonnet-4-6",
            },
          },
        })
      end,
    },
    gemini = function()
      return require("codecompanion.adapters").extend("gemini", {
        env = {
          api_key = "cmd:cat ~/secrets/GEMINI_API_KEY.txt",
        },
        schema = {
          model = {
            default = "gemini-2.5-flash-preview-04-17",
          },
        },
      })
    end,
    openai = function()
      return require("codecompanion.adapters").extend("openai", {
        env = {
          api_key = "cmd:cat ~/secrets/OAI_API_KEY.txt",
        },
        schema = {
          model = {
            default = "gpt-5.1",
          },
        },
      })
    end,
    llama3 = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "deepseek-r1",
        schema = {
          model = {
            default = "deepseek-r1",
          },
        },
      })
    end,
    lmsDevstral = function()
      return require("codecompanion.adapters").extend("openai_compatible", {
        env = {
          url = "http://127.0.0.1:1234",
          api_key = "lm-studio",
          chat_url = "/v1/chat/completions",
          models_endpoint = "/v1/models",
        },
        schema = {
          model = {
            default = "mistralai/devstral-small-2-2512",
          },
          temperature = {
            order = 2,
            mapping = "parameters",
            type = "number",
            optional = true,
            default = 0.8,
            desc = "Sampling temperature between 0 and 2.",
            validate = function(n)
              return n >= 0 and n <= 2, "Must be between 0 and 2"
            end,
          },
        },
      })
    end,
    lmsQwen = function()
      return require("codecompanion.adapters").extend("openai_compatible", {
        env = {
          url = "http://127.0.0.1:1234",
          api_key = "lm-studio",
          chat_url = "/v1/chat/completions",
          models_endpoint = "/v1/models",
        },
        schema = {
          model = {
            default = "qwen/qwen3-vl-8b",
          },
          temperature = {
            order = 2,
            mapping = "parameters",
            type = "number",
            optional = true,
            default = 0.8,
            desc = "Sampling temperature between 0 and 2.",
            validate = function(n)
              return n >= 0 and n <= 2, "Must be between 0 and 2"
            end,
          },
        },
      })
    end,
  },
})

-- Keymaps
vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { nowait = true, desc = "Code Companion Actions" })
vim.keymap.set({ "n", "v" }, "<LocalLeader>aa", "<cmd>CodeCompanionChat Toggle<cr>",
  { nowait = true, desc = "Code Companion Toggle Chat" })
vim.keymap.set({ "n", "v" }, "<LocalLeader>ac", "<cmd>CodeCompanionActions<cr>",
  { nowait = true, desc = "Code Companion Actions" })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { nowait = true, desc = "Code Companion Add to Chat" })
