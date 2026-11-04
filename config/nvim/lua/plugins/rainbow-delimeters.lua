return {
	"HiPhish/rainbow-delimiters.nvim",
	config = function()
		local rainbow_delimiters = require 'rainbow-delimiters'
		vim.g.rainbow_delimiters = {
			strategy = {
				[""] = rainbow_delimiters.strategy["local"],
				vim = rainbow_delimiters.strategy["local"],
			},
			query = {
				[""] = "rainbow-delimiters",
				lua = "rainbow-blocks",
			},
			priority = {
				[""] = 110,
				lua = 210,
			},
			highlight = {
				"RainbowDelimiterRed",
				"RainbowDelimiterYellow",
				"RainbowDelimiterBlue",
				"RainbowDelimiterOrange",
				"RainbowDelimiterGreen",
				"RainbowDelimiterViolet",
				"RainbowDelimiterCyan",
			},
		}

		-- Fix plugin bug: get_parser can return nil without error for filetypes
		-- that map to a treesitter lang name but have no parser installed.
		-- Replace the plugin's FileType autocmd with a guarded version.
		vim.api.nvim_clear_autocmds({ group = 'TSRainbowDelimits', event = 'FileType' })
		local rd_lib = require('rainbow-delimiters.lib')
		local rd_config = require('rainbow-delimiters.config')
		vim.api.nvim_create_autocmd('FileType', {
			group = 'TSRainbowDelimits',
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)
				if not rd_config.enabled_for(lang) then return end
				local ok, parser = pcall(vim.treesitter.get_parser, args.buf, lang)
				if not ok or not parser then return end
				rd_lib.attach(args.buf)
			end,
		})
	end,
}
