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

function M.open() end

function M.save() end

return M
