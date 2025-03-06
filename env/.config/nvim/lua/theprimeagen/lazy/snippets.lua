return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- follow latest release.
        build = "make install_jsregexp", -- install jsregexp (optional!)
        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            local ls = require("luasnip")
            ls.filetype_extend("javascript", { "jsdoc" })

            -- Expand snippet
            vim.keymap.set({ "i" }, "<C-s>e", function() ls.expand() end, { silent = true, desc = "Expand snippet" })

            -- Jump forward in snippet placeholders
            vim.keymap.set({ "i", "s" }, "<C-s>;", function() ls.jump(1) end, { silent = true, desc = "Jump to next snippet placeholder" })
            -- Jump backward in snippet placeholders
            vim.keymap.set({ "i", "s" }, "<C-s>,", function() ls.jump(-1) end, { silent = true, desc = "Jump to previous snippet placeholder" })

            -- Change choice if available
            vim.keymap.set({ "i", "s" }, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true, desc = "Change snippet choice" })
        end,
    }
}

