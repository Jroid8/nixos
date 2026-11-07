vim.api.nvim_create_user_command("TermBuf", function(_)
	vim.opt_local.nu = false
	vim.opt_local.rnu = false
	vim.opt_local.signcolumn = "no"
	vim.fn.jobstart({ "fish" }, { term = true })
	vim.fn.feedkeys("i")
end, {})
