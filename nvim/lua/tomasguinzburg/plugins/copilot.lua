return {
	'zbirenbaum/copilot.lua',
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = { enabled = false },
			layout = {
				position = "bottom",
				ratio = 0.4,
			},
			suggestion = { enabled = false },
			filetypes = {
				yaml = false,
				markdown = false,
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
			copilot_node_command = 'node',
			server_opts_overrides = {},
		})
	end,
}
