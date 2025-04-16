
return {
  -- سيرفر JSON
  jsonls = {
    settings = {
      json = {
        schema = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },

  -- Terraform
  terraformls = {
    cmd = { "terraform-ls" },
    arg = { "server" },
    filetypes = { "terraform", "tf", "terraform-vars" },
  },

  -- Lua
  lua_ls = {
    settings = {
      Lua = {
           format = {
                                    enable = true,
                                    -- Put format options here
                                    -- NOTE: the value should be STRING!!
                                    defaultConfig = {
                                        indent_style = "space",
                                        indent_size = "2",
                                    }
                                },
        workspace = {
          checkThirdParty = false,
          library = {
            "${3rd}/luv/library",
            unpack(vim.api.nvim_get_runtime_file("", true)),
          },
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },

  -- Bash
  bashls = {
    filetypes = { "sh", "zsh" },
  },

  -- Vimscript
  vimls = {
    filetypes = { "vim" },
  },

  -- TypeScript (تقدر تستخدمه بدل tsserver أو تعدل اسمه لو حابب)
  ts_ls = {},

  -- Go
  gopls = {},

  -- Python
  pyright = {},

  -- Solidity
  solidity_ls_nomicfoundation = {},

  -- YAML
  yamlls = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml" },
  },

  -- ZLS (لغة Zig) - هنا دمجنا إعداداتك المتقدمة
  zls = {
    root_dir = function(fname)
      return require("lspconfig").util.root_pattern(".git", "build.zig", "zls.json")(fname)
    end,
    settings = {
      zls = {
        enable_inlay_hints = true,
        enable_snippets = true,
        warn_style = true,
      },
    },
  },

  -- C/C++
  clangd = {},

  -- Markdown
  marksman = {},

  -- Rust Analyzer (عشان عندك rust_analyzer في اللستة)
  rust_analyzer = {},
}
