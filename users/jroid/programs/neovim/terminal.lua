local Term = {}

function Term.run(term)
	require("toggleterm.terminal").Terminal:new(term):toggle()
end

Term.repls = {
	sh = "bash",
	python = "python",
	lua = "lua",
	javascript = "node",
	javascriptreact = "node",
	rust = "evcxr",
	java = "jshell",
}

function Term.open_repl()
	local shell = Term.repls[vim.bo.filetype]
	if not shell then
		return
	end
	Term.run({ cmd = shell, direction = "float" })
end

Term.testerCmds = { rust = "cargo test", java = "mvn test -q" }
Term.testerFiles = {
	Makefile = "make test",
}

function Term.run_tests()
	local tester = Term.testerCmds[vim.bo.filetype]
	for f, c in pairs(Term.testerFiles) do
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
function Term.exec_current_buf()
	local executor = nil
	local firstline = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]
	local execstat = vim.loop.fs_stat(".exec")
	if Term.current_exec_override then
		executor = Term.current_exec_override
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
	if not Term.current_exec_override and not execstat then
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

function Term.make_term_buf(_)
	vim.opt_local.nu = false
	vim.opt_local.rnu = false
	vim.opt_local.signcolumn = "no"
	vim.fn.jobstart({ "/bin/fish" }, { term = true })
	vim.fn.feedkeys("i")
end

Term.current_exec_override = nil
function Term.exec_override(args)
	print(args.args)
	Term.current_exec_override = args.args
end

vim.api.nvim_create_user_command("TermBuf", Term.make_term_buf, {})
vim.api.nvim_create_user_command("ExecOverride", Term.exec_override, {})
vim.keymap.set("n", "<leader>r", Term.exec_current_buf, { desc = "run current buffer" })
vim.keymap.set("n", "<leader>tl", Term.open_repl, { desc = "open the REPL for current buffer's language" })
vim.keymap.set("n", "<leader>tl", Term.run_tests, { desc = "run tests" })
