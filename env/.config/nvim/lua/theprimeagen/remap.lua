local opts = { noremap = true, silent = true }
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Return to files menu", noremap = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down", noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up", noremap = true, silent = true })

vim.keymap.set("n", "J", "mzJz", { desc = "Join lines (keep cursor)", noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half-page and center", noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half-page and center", noremap = true, silent = true })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)", noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)", noremap = true, silent = true })
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>", { desc = "Restart LSP", noremap = true, silent = true })

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end, { desc = "Start VimWithMe", noremap = true, silent = true })
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end, { desc = "Stop VimWithMe", noremap = true, silent = true })

-- clipboard stuff
-- (هذه الخريطة تم تعليقها لتفادي التكرار، ويمكنك إلغاء التعليق إذا رغبت)
-- vim.keymap.set("n", "YY", '"+yy', { desc = "Yank current line to system clipboard", noremap = true, silent = true })
-- vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to system clipboard", noremap = true, silent = true })
vim.keymap.set("n", "YU", '"+p', { desc = "Paste from system clipboard", noremap = true, silent = true })

-- paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dp', { desc = "Paste without yanking", noremap = true, silent = true })
vim.keymap.set("v", "P", '"_dP', { desc = "Paste without yanking", noremap = true, silent = true })

-- copy everything between { and } including the brackets
-- p puts text after the cursor,
-- P puts text before the cursor.
vim.keymap.set("n", "YY", "va{Vy", vim.tbl_extend("force", opts, { desc = "Select block between {}" }))

-- Exit on jj and jk
vim.keymap.set("i", "jj", "<ESC>", vim.tbl_extend("force", opts, { desc = "Exit insert mode with 'jj'" }))
vim.keymap.set("i", "jk", "<ESC>", vim.tbl_extend("force", opts, { desc = "Exit insert mode with 'jk'" }))

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking in visual block", noremap = true, silent = true })

-- next greatest remap ever : asbjornHaland
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard", noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard", noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete without yanking", noremap = true, silent = true })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode (Ctrl+C)", noremap = true, silent = true })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Q", noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Open tmux sessionizer", noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format with LSP", noremap = true, silent = true })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Go to next quickfix error", noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Go to previous quickfix error", noremap = true, silent = true })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Go to next location", noremap = true, silent = true })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Go to previous location", noremap = true, silent = true })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search & replace word under cursor", noremap = true, silent = true })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable", silent = true, noremap = true })

vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", { desc = "Insert error check block", noremap = true, silent = true })
vim.keymap.set("n", "<leader>ea", "oassert.NoError(err, \"\")<Esc>F\";a", { desc = "Insert assert error", noremap = true, silent = true })
vim.keymap.set("n", "<leader>ef", "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj", { desc = "Insert log fatal error", noremap = true, silent = true })
vim.keymap.set("n", "<leader>el", "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i", { desc = "Insert log error", noremap = true, silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>", { desc = "Edit packer config", noremap = true, silent = true })
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Run cellular automaton", noremap = true, silent = true })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "Source current file", noremap = true, silent = true })

-- write file in current directory
vim.keymap.set("n", "<C-n>", ":w %:h/", vim.tbl_extend("force", opts, { desc = "Write file in current directory" }))
-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", vim.tbl_extend("force", opts, { desc = "Select all text" }))
-- ctrl + x to cut full line
vim.keymap.set("n", "<C-x>", "dd", vim.tbl_extend("force", opts, { desc = "Cut (delete) current line" }))
-- Split line with X
vim.keymap.set("n", "X", ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>", { desc = "Split line", silent = true, noremap = true })

-- search current buffer
vim.keymap.set("n", "<leader>q", ":Telescope current_buffer_fuzzy_find<CR>", vim.tbl_extend("force", opts, { desc = "Search current buffer" }))

-- Navigate buffers
vim.keymap.set("n", "<Right>", ":bnext<CR>", vim.tbl_extend("force", opts, { desc = "Go to next buffer" }))
vim.keymap.set("n", "<Left>", ":bprevious<CR>", vim.tbl_extend("force", opts, { desc = "Go to previous buffer" }))

