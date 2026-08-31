local Project = {}
local list_path = vim.fn.stdpath("data") .. "/projects.txt"

function Project.select()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local state = require("telescope.actions.state")

	local list_stat = vim.loop.fs_stat(list_path)
	if not list_stat then
		return
	end
	local fd = vim.loop.fs_open(list_path, "r", list_stat.mode)
	if not fd then
		print("Failed to read projects.txt")
		return
	end
	local projects_raw = vim.loop.fs_read(fd, list_stat.size)
	if not projects_raw then
		print("Failed to read projects.txt")
		return
	end
	local list = vim.split(projects_raw, "\n")

	pickers
		.new({}, {
			prompt_title = "Project",
			finder = finders.new_table({
				results = list,
				entry_maker = function(entry)
					local name = vim.fn.fnamemodify(entry, ":t")
					return {
						display = name,
						name = name,
						value = entry,
						ordinal = name .. " " .. entry,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(_, _)
				actions.select_default:replace(function()
					local path = state.get_selected_entry().value
					vim.api.nvim_set_current_dir(path)
					require("telescope.builtin").find_files()
				end)
				return true
			end,
		})
		:find()
end

function Project.save()
	local fd = vim.loop.fs_open(list_path, "a", 438)
	if not fd then
		print("Failed to open projects.txt")
		return
	end
	vim.loop.fs_write(fd, vim.fn.getcwd() .. "\n")
	vim.loop.fs_close(fd)
end

vim.api.nvim_create_user_command("AddProject", Project.save, {})
vim.api.nvim_create_user_command("SelectProject", Project.select, {})
