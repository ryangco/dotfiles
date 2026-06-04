local dap = require("dap")
local dapui = require("dapui")

require("mason-nvim-dap").setup({
	automatic_setup = true,
	handlers = {},
	ensure_installed = { "delve" },
})

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
	controls = {
		icons = {
			pause = "⏸",
			play = "▶",
			step_into = "⏎",
			step_over = "⏭",
			step_out = "⏮",
			step_back = "b",
			run_last = "▶▶",
			terminate = "⏹",
			disconnect = "⏏",
		},
	},
})

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

require("nvim-dap-virtual-text").setup({
	display_callback = function(variable)
		local name = string.lower(variable.name)
		local value = string.lower(variable.value)
		if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
			return "*****"
		end
		if #variable.value > 15 then
			return " " .. string.sub(variable.value, 1, 15) .. "... "
		end
		return " " .. variable.value
	end,
})

local elixir_ls_debugger = vim.fn.exepath("elixir-ls-debugger")
if elixir_ls_debugger ~= "" then
	dap.adapters.mix_task = {
		type = "executable",
		command = elixir_ls_debugger,
	}
	dap.configurations.elixir = {
		{
			type = "mix_task",
			name = "phoenix server",
			task = "phx.server",
			request = "launch",
			projectDir = "${workspaceFolder}",
			exitAfterTaskReturns = false,
			debugAutoInterpretAllModules = false,
		},
	}
end

require("dap-go").setup()

-- Keymaps
local map = vim.keymap.set
map("n", "<leader>dB", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Breakpoint Condition" })
map("n", "<leader>db", function()
	dap.toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
map("n", "<leader>dc", function()
	dap.continue()
end, { desc = "Run/Continue" })
map("n", "<leader>da", function()
	dap.continue({ before = get_args })
end, { desc = "Run with Args" })
map("n", "<leader>dC", function()
	dap.run_to_cursor()
end, { desc = "Run to Cursor" })
map("n", "<leader>dg", function()
	dap.goto_()
end, { desc = "Go to Line (No Execute)" })
map("n", "<leader>di", function()
	dap.step_into()
end, { desc = "Step Into" })
map("n", "<leader>dj", function()
	dap.down()
end, { desc = "Down" })
map("n", "<leader>dk", function()
	dap.up()
end, { desc = "Up" })
map("n", "<leader>dl", function()
	dap.run_last()
end, { desc = "Run Last" })
map("n", "<leader>do", function()
	dap.step_out()
end, { desc = "Step Out" })
map("n", "<leader>dO", function()
	dap.step_over()
end, { desc = "Step Over" })
map("n", "<leader>dP", function()
	dap.pause()
end, { desc = "Pause" })
map("n", "<leader>dr", function()
	dap.repl.toggle()
end, { desc = "Toggle REPL" })
map("n", "<leader>ds", function()
	dap.session()
end, { desc = "Session" })
map("n", "<leader>dt", function()
	dap.terminate()
end, { desc = "Terminate" })
map("n", "<leader>dw", function()
	require("dap.ui.widgets").hover()
end, { desc = "Widgets" })
map("n", "<leader>du", function()
	dapui.toggle({})
end, { desc = "Dap UI" })
map("n", "<leader>dd", function()
	dapui.open({ reset = true })
end, { desc = "UI Reset" })
map({ "n", "v" }, "<leader>de", function()
	dapui.eval()
end, { desc = "Eval" })
