vim.g.mapleader = " ";

vim.keymap.set("i", "jf", "<ESC>")
vim.keymap.set("i", "<S-CR>", "<ESC>O")
vim.keymap.set("n", "<leader>q", ":try | quit | catch /E37:/ | wq | endtry<CR><CR>", { desc = "Save and quit" })
vim.keymap.set("v", "/r", "\"hy:%s/<C-r>h//g<left><left>", { desc = "Replace selected" })
vim.keymap.set("v", "/m", "\"hy:%s/<C-r>h/<C-r>h/g<left><left>", { desc = "Modify selected" })

vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv-gv", { silent = true })
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv-gv", { silent = true })

vim.keymap.set({ "i", "c", "t" }, "<C-h>", "<Left>")
vim.keymap.set({ "i", "c", "t" }, "<C-j>", "<Down>")
vim.keymap.set({ "i", "c", "t" }, "<C-k>", "<Up>")
vim.keymap.set({ "i", "c", "t" }, "<C-l>", "<Right>")

for _, k in pairs({ "h", "j", "k", "l" }) do
	local action = "<Cmd>wincmd " .. k .. "<CR>"
	local key = "<A-" .. k .. ">"
	vim.keymap.set({ "i", "n", "t" }, key, action)
end

vim.keymap.set("n", "<A-,>", "<C-w><")
vim.keymap.set("n", "<A-.>", "<C-w>>")
vim.keymap.set("n", "<A-=>", "<C-w>+")
vim.keymap.set("n", "<A-->", "<C-w>-")

vim.keymap.set("n", "<leader>jh", ":setlocal hlsearch!<CR>", { desc = "Toggle search hightlights", silent = true })
vim.keymap.set("n", "<leader>jr", ":setlocal rnu!<CR>", { desc = "Toggle search highlights", silent = true })
vim.keymap.set("n", "<leader>js", ":setlocal spell!<CR>", { desc = "Toggle spell checking", silent = true })

vim.keymap.set("n", "<leader>c", ":bd<CR>", { desc = "Delete buffer", silent = true })

vim.keymap.set("n", "<leader>jq", function()
	for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "qf" then
			vim.cmd("cclose")
			return
		end
	end
	vim.cmd("copen")
end, { desc = "Toggle quickfix list window" })
