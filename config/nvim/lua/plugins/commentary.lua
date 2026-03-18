return {
	"tpope/vim-commentary",
	config = function()
		vim.keymap.set("n", "<leader>/", ":Commentary<cr>")
        vim.keymap.set("v", "<leader>/", ":Commentary<cr>")
	end,
}
