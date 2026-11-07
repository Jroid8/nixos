local M = {}

local firstRun = true
function M.run(term)
	if firstRun then
		require("lz.n").trigger_load("toggleterm.nvim")
		firstRun = false
	end
	require("toggleterm.terminal").Terminal:new(term):toggle()
end

M.repls = {
	sh = "bash",
	python = "python",
	lua = "lua",
	javascript = "node",
	javascriptreact = "node",
	rust = "evcxr",
	java = "jshell",
}

function M.open_repl()
	local shell = M.repls[vim.bo.filetype]
	if not shell then
		return
	end
	M.run({ cmd = shell, direction = "float" })
end

M.testerCmds = { rust = "cargo test", java = "mvn test -q" }
M.testerFiles = {
	Makefile = "make test",
}

function M.run_tests()
	local tester = M.testerCmds[vim.bo.filetype]
	for f, c in pairs(M.testerFiles) do
		if io.open(f, "r") then
			tester = c
			break
		end
	end
	if not tester then
		return
	end
	vim.cmd("wa")
	vim.cmd('TermExec go_back=0 cmd="' .. tester .. '" direction=horizontal')
end

local executors = {
	sh = "bash %",
	bash = "bash %",
	python = "python %",
	lua = "lua %",
	javascript = "node %",
	typescript = "node -r /usr/lib/node_modules/@swc-node/register %",
	rust = "cargo run -q",
	java = "java %",
	c = "gcc % && ./a.out",
	dart = "dart %",
}
local executeFiles = {
	["run.sh"] = "bash run.sh",
	Makefile = "make run",
	["package.json"] = "npm start",
	["pom.xml"] = "mvn compile exec:java -q -e",
}
function M.exec_current_buf()
	local executor = nil
	local firstline = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]
	local execstat = vim.loop.fs_stat(".exec")
	if M.current_exec_override then
		executor = M.current_exec_override
	elseif execstat then
		local fd = vim.loop.fs_open(".exec", "r", execstat.mode)
		if fd then
			local content = vim.loop.fs_read(fd, execstat.size)
			if content and string.sub(content, -1, -1) == "\n" then
				content = string.sub(content, 0, -2)
			end
			executor = content
		end
	elseif executors[vim.bo.filetype] then
		executor = executors[vim.bo.filetype]
	elseif vim.startswith(firstline, "#!") then
		executor = string.sub(firstline, 3, -1) .. " %"
	end
	if not M.current_exec_override and not execstat then
		for f, c in pairs(executeFiles) do
			local opened = io.open(f, "r")
			if opened ~= nil then
				executor = c
				break
			end
		end
	end
	if not executor then
		return
	end
	vim.cmd("wa")
	vim.cmd('TermExec go_back=0 cmd="' .. executor .. '" direction=horizontal')
end

M.current_exec_override = nil
function M.exec_override(args)
	print(args.args)
	M.current_exec_override = args.args
end

vim.api.nvim_create_user_command("ExecOverride", M.exec_override, {})
vim.keymap.set("n", "<leader>r", M.exec_current_buf, { desc = "run current buffer" })
vim.keymap.set("n", "<leader>lr", M.open_repl, { desc = "open the REPL for current buffer's language" })
vim.keymap.set("n", "<leader>lt", M.run_tests, { desc = "run tests" })
