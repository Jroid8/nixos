local timer = vim.loop.new_timer()
if timer == nil then
	return
end
local enabled = true
local trigger = function()
	if
		vim.bo.modifiable
		and enabled
		and vim.bo.buftype == ""
		and vim.api.nvim_buf_get_name(0) ~= ""
		and vim.bo.filetype ~= "dirbuf"
	then
		timer:start(
			1500,
			0,
			vim.schedule_wrap(function()
				if vim.fn.mode() == "n" or vim.fn.mode() == "t" then
					vim.cmd("silent wa")
				end
			end)
		)
	end
end
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, { callback = trigger })
vim.api.nvim_create_user_command("AutoSaveToggle", function()
	enabled = not enabled
end, {})
