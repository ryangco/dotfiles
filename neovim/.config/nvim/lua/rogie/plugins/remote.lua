return {
	{
		"moyiz/git-dev.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>gd",
				function()
					local repo = vim.fn.input("Repository name / URI: ")
					if repo ~= "" then
						require("git-dev").open(repo)
					end
				end,
				desc = "Git[d]ev Open a remote git repository",
			},
		},
		opts = {
			cd_type = "tab",
			opener = function(dir, _, selected_path)
				vim.cmd("tabnew")
				vim.cmd("Neotree " .. dir)
				if selected_path then
					vim.cmd("edit " .. selected_path)
				end
			end,
		},
	},
	{
		"amitds1997/remote-nvim.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true,
	},
}
