local popup = require("plenary.popup")

M = {}

TodoManager_win_id = nil
TodoManager_bufh = nil

local function get_config()
	return {
		save_on_toggle = true,
	}
end

local function close_menu(force_save)
	force_save = force_save or false
	local config = get_config()

	if config.save_on_toggle or force_save then
		-- TODO: Save
	end

	vim.api.nvim_win_close(TodoManager_win_id, true)

	TodoManager_win_id = nil
	TodoManager_bufh = nil
end

local function create_window()
	local config = get_config()
	local width = config.width or 80
	local height = config.height or 40
	local borderchars = config.borderchars or { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
	local bufnr = vim.api.nvim_create_buf(false, false)

	local TodoManager_win_id, win = popup.create(bufnr, {
		title = "TodoManager",
		highlight = "TodoManagerWindow",
		line = math.floor(((vim.o.lines - height) / 2) - 1),
		col = math.floor((vim.o.columns - width) / 2),
		minwidth = width,
		minheight = height,
		borderchars = borderchars,
	})

	vim.api.nvim_win_set_option(win.border.win_id, "winhl", "Normal:TodoManagerBorder")

	return {
		bufnr = bufnr,
		win_id = TodoManager_win_id,
	}
end

function M.toggle_popup(contents)
	if TodoManager_win_id ~= nil and vim.api.nvim_win_is_valid(TodoManager_win_id) then
		close_menu()
		return
	end

	local win_info = create_window()
	local config = get_config()

	TodoManager_win_id = win_info.win_id
	TodoManager_bufh = win_info.bufnr

	vim.api.nvim_win_set_option(TodoManager_win_id, "number", true)
	vim.api.nvim_buf_set_name(TodoManager_bufh, "todo-manager")
	vim.api.nvim_buf_set_lines(TodoManager_bufh, 0, #contents, false, contents)
	vim.api.nvim_buf_set_option(TodoManager_bufh, "filetype", "markdown")
	vim.api.nvim_buf_set_option(TodoManager_bufh, "bufhidden", "delete")

	vim.api.nvim_buf_set_keymap(
		TodoManager_bufh,
		"n",
		"q",
		"<Cmd>lua require('TodoManager.ui').toggle_popup()<CR>",
		{ silent = true }
	)
end

return M
