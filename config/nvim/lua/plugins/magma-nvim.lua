return {
	"dccsillag/magma-nvim",
	version = "*",
	build = ":UpdateRemotePlugins",
	lazy = false,
	keys = {
		{
			"<leader>r",
			"<cmd>MagmaEvaluateOperator<CR>",
			desc = "Evaluate given operator",
			{
				noremap = true,
				expr = true,
				silent = true,
			},
		},
	},
	config = function()
		vim.cmd("nnoremap <silent><expr> <leader>r  :MagmaEvaluateOperator<CR>")
		vim.cmd("nnoremap <silent>       <leader>rr :MagmaEvaluateLine<CR>")
		vim.cmd("xnoremap <silent>       <leader>r  :<C-u>MagmaEvaluateVisual<CR>")
		vim.cmd("nnoremap <silent>       <leader>rc :MagmaReevaluateCell<CR>")
		vim.cmd("nnoremap <silent>       <leader>rd :MagmaDelete<CR>")
		vim.cmd("nnoremap <silent>       <leader>ro :MagmaShowOutput<CR>")

		vim.cmd("let g:magma_automatically_open_output = v:false")
	end,
}
-- return {'dccsillag/magma-nvim',
--   config = function ()
--     require('magma-nvim').setup()
--   vim.cmd("nnoremap <silent><expr> <LocalLeader>r  :MagmaEvaluateOperator<CR>")
--   vim.cmd("nnoremap <silent>       <LocalLeader>rr :MagmaEvaluateLine<CR>")
--   vim.cmd("xnoremap <silent>       <LocalLeader>r  :<C-u>MagmaEvaluateVisual<CR>")
--   vim.cmd("nnoremap <silent>       <LocalLeader>rc :MagmaReevaluateCell<CR>")
--   vim.cmd("nnoremap <silent>       <LocalLeader>rd :MagmaDelete<CR>")
--   vim.cmd("nnoremap <silent>       <LocalLeader>ro :MagmaShowOutput<CR>")

--   vim.cmd("let g:magma_automatically_open_output = v:false")

-- function MagmaInitPython()
--     vim.cmd[[
--     :MagmaInit python3
--     :MagmaEvaluateArgument a=5
--     ]]
-- end

-- function MagmaInitCSharp()
--     vim.cmd[[
--     :MagmaInit .net-csharp
--     :MagmaEvaluateArgument Microsoft.DotNet.Interactive.Formatting.Formatter.SetPreferredMimeTypesFor(typeof(System.Object),"text/plain");
--     ]]
-- end

-- function MagmaInitFSharp()
--     vim.cmd[[
--     :MagmaInit .net-fsharp
--     :MagmaEvaluateArgument Microsoft.DotNet.Interactive.Formatting.Formatter.SetPreferredMimeTypesFor(typeof<System.Object>,"text/plain")
--     ]]
-- end

-- vim.cmd[[
-- :command MagmaInitPython lua MagmaInitPython()
-- :command MagmaInitCSharp lua MagmaInitCSharp()
-- :command MagmaInitFSharp lua MagmaInitFSharp()
-- ]]
-- end,
-- }
