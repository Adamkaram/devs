local root_files = {
  '.luarc.json',
  '.luarc.jsonc',
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
  '.git',
}
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
    { "b0o/schemastore.nvim" },
  },

  config = function()
    -- إعدادات conform
    require("conform").setup({
      formatters_by_ft = {
        -- مثال: go = { "gofmt" },

      },
    })

    -- إعدادات cmp والقدرات
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    -- تشغيل fidget (واجهة مستخدم لـ LSP)
    require("fidget").setup({})

    -- تشغيل mason
    require("mason").setup()

    -- إعدادات mason-lspconfig مع قراءة الخوادم من الملف المحدد
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(require("theprimeagen.lazy.lsp.servers")),
      handlers = {
        function(server_name) -- الإعداد الافتراضي لأي خادم
          local servers = require("theprimeagen.lazy.lsp.servers")
          -- إذا كانت هناك إعدادات خاصة بالخادم، ستُعاد من servers[server_name]
          local opts = servers[server_name] or {}
          opts.capabilities = capabilities
          opts.settings = servers[server_name] and servers[server_name].settings or nil
          opts.filetypes = servers[server_name] and servers[server_name].filetypes or nil

          require("lspconfig")[server_name].setup(opts)
        end,
      },
    })

    -- إعدادات nvim-cmp
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
      }),
    })
 vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
        map("gr", require("telescope.builtin").lsp_references, "Goto References")
        map("gi", require("telescope.builtin").lsp_implementations, "Goto Implementation")
        map("go", require("telescope.builtin").lsp_type_definitions, "Type Definition")
        map("<leader>p", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
        map("<leader>ws", require("telescope.builtin").lsp_workspace_symbols, "Workspace Symbols")
        map("<leader>Ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

        map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")

        map("<leader>v", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition in Vertical Split")

        local wk = require("which-key")
        wk.add({
          { "<leader>la", vim.lsp.buf.code_action,                           desc = "Code Action" },
          { "<leader>lA", vim.lsp.buf.range_code_action,                     desc = "Range Code Actions" },
          { "<leader>ls", vim.lsp.buf.signature_help,                        desc = "Display Signature Information" },
          { "<leader>lr", vim.lsp.buf.rename,                                desc = "Rename all references" },
          { "<leader>lf", vim.lsp.buf.format,                                desc = "Format" },
          { "<leader>li", require("telescope.builtin").lsp_implementations,  desc = "Implementation" },
          { "<leader>lw", require("telescope.builtin").diagnostics,          desc = "Diagnostics" },
          { "<leader>lc", require("theprimeagen.lazy.config.utils").copyFilePathAndLineNumber, desc = "Copy File Path and Line Number" },

          -- W = {
          --   name = "+Workspace",
          --   a = { vim.lsp.buf.add_workspace_folder, "Add Folder" },
          --   r = { vim.lsp.buf.remove_workspace_folder, "Remove Folder" },
          --   l = {
          --     function()
          --       print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          --     end,
          --     "List Folders",
          --   },
          -- },

          { "<leader>Wa", vim.lsp.buf.add_workspace_folder,                  desc = "Workspace Add Folder" },
          { "<leader>Wr", vim.lsp.buf.remove_workspace_folder,               desc = "Workspace Remove Folder" },
          {
            "<leader>Wl",
            function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            desc = "Workspace List Folders",
          }
        })

      end,
    })
    vim.diagnostic.config({
  underline = true,
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
       float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
})

-- تعريف الرموز بشكل صحيح
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

  end,
}
