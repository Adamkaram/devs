
return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open Git status", noremap = true, silent = true })

    local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd("BufWinEnter", {
      group = ThePrimeagen_Fugitive,
      pattern = "*",
      callback = function()
        if vim.bo.ft ~= "fugitive" then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false, silent = true }
        vim.keymap.set("n", "<leader>p", function()
          vim.cmd.Git('push')
        end, vim.tbl_extend("force", opts, { desc = "Push changes" }))

        -- rebase always
        vim.keymap.set("n", "<leader>P", function()
          vim.cmd.Git({ 'pull', '--rebase' })
        end, vim.tbl_extend("force", opts, { desc = "Pull with rebase" }))

        -- NOTE: Allows setting the branch for pushing and tracking if needed
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", vim.tbl_extend("force", opts, { desc = "Push with tracking" }))
      end,
    })

    vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>", { desc = "Get diff from left", noremap = true, silent = true })
    vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>", { desc = "Get diff from right", noremap = true, silent = true })
  end
}
