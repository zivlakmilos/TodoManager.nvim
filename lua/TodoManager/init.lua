local ui = require("TodoManager.ui")

M = {}

function M.setup(config)
	if not config then
		config = {}
	end
	local curDir = vim.fn.getcwd()
	print("Hello World!")
	print(curDir)
end

function M.open_dates()
	local contents = {}
	ui.toggle_popup(contents)
end

function M.open_status()
	local contents = {}
	ui.toggle_popup(contents)
end

return M
