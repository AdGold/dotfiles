vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Indenting
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Autocommands for FileType settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typescript", "javascript" },
	callback = function()
        vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end,
})

-- vim.cmd("inoremap jk <esc>")
-- vim.cmd("nnoremap <C-m> <C-v>")
-- vim.cmd("nnoremap <leader>m <C-v>")
vim.keymap.set("n", "<C-m>", "<C-v>", { noremap = true })
vim.keymap.set("i", "jk", "<esc>", { noremap = true })
vim.keymap.set("n", "<leader>m", "<C-v>", { noremap = true })

-- Clipboard stuff

-- Default anyway
-- vim.cmd("nnoremap Y y$")
-- vim.keymap.set("n", "Y", "y$", { noremap = true })

-- Allow Ctrl Shift C/V for copy/pasting to system
-- vim.cmd('vnoremap <silent> <C-c> "+y')
-- vim.cmd('nnoremap <silent> <C-c> "+y')
-- vim.cmd('vnoremap <silent> <C-v> "+p')
-- vim.cmd('nnoremap <silent> <C-v> "+p')
-- vim.cmd('inoremap <silent> <C-v> <ESC>"+pa')
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true })
vim.keymap.set("n", "<C-c>", '"+y', { noremap = true })
vim.keymap.set("v", "<C-v>", '"+p', { noremap = true })
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true })
vim.keymap.set("i", "<C-v>", '<ESC>"+pa', { noremap = true })

-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://superuser.com/q/310417/736190
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
vim.keymap.set("n", "cc", '"_cc')
vim.keymap.set("x", "c", '"_c')

-- Break inserted text into smaller undo units when we insert some punctuation chars.
local undo_ch = { ",", ".", "!", "?", ";", ":" }
for _, ch in ipairs(undo_ch) do
	vim.keymap.set("i", ch, ch .. "<c-g>u")
end

vim.g.background = "light"

vim.opt.swapfile = false

vim.opt.number = true
vim.opt.relativenumber = true

-- Allow copying across SSH for plus register
-- Verify this works
-- Details here: https://github.com/neovim/neovim/pull/25872
-- vim.g.clipboard = {
--   name = "OSC 52",
--   copy = {
--     ["+"] = require("vim.clipboard.osc52").copy,
--   },
--   paste = {
--     ["+"] = require("vim.clipboard.osc52").paste,
--   },
-- }

-- Things that may no longer be needed

-- filetype plugin indent on
-- set wildignore+=.svn,CVS,.git,*.pyc,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pdf,*.bak,*.beam,*/tmp/*,*.zip,log/**,node_modules/**,target/**,tmp/**,*.rbc    " Ignore these files when completing names and in Explorer
-- set wildmode=list:longest,list:full  " List all matches and complete till longest common string, or complete first match

-- Things to convert to lua

-- Backup settings
vim.opt.backupdir = { "~/.vim/tmp", "." }
vim.opt.directory = { "~/.vim/tmp", "." }

-- Key mappings
vim.keymap.set("n", ";", ":", { noremap = true })
vim.keymap.set("v", ";", ":", { noremap = true })
vim.keymap.set("v", "S", ":sort<CR>", { noremap = true })
vim.keymap.set("n", "S", ":w<CR>", { noremap = true })
vim.keymap.set("n", "Q", ":q<CR>", { noremap = true })
vim.keymap.set("x", ".", ":normal .<CR>", { noremap = true })


-- Folding settings
vim.opt.foldenable = true
vim.opt.foldmethod = "syntax"
vim.opt.foldopen = { "block", "hor", "percent", "quickfix", "tag" }
vim.opt.foldlevel = 99
vim.cmd("highlight Folded ctermfg=lightblue ctermbg=None")

-- Make folds persistent
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	pattern = "*.*",
	command = "mkview",
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*.*",
	callback = function()
		-- Try to execute the loadview command and catch any errors in case we haven't opened this file before
		pcall(vim.cmd, "silent! loadview")
	end,
})

-- Undo settings
if vim.fn.has("persistent_undo") == 1 then
	vim.opt.undofile = true
	vim.opt.undodir:append("~/.vim/undo//")
end
vim.keymap.set("n", "U", "<C-r>", { noremap = true })

-- Write settings
vim.api.nvim_create_autocmd({ "FocusLost" }, {
	pattern = "*",
	command = "silent! wall",
})
vim.opt.autowrite = true
vim.keymap.set("c", "w!!", "w !sudo tee % >/dev/null", { noremap = true })

-- Search settings
vim.keymap.set("n", "/", [[/\v]])
vim.keymap.set("v", "/", [[/\v]])
vim.keymap.set("n", "/", "/\\v", { noremap = true })
vim.keymap.set("v", "/", "/\\v", { noremap = true })
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true
vim.opt.showmatch = true
vim.keymap.set("n", "<leader>y", ":noh<CR>", { noremap = true })

vim.keymap.set("n", "-", ";", { noremap = true })
vim.keymap.set("n", "<leader>h", ":%s//c<Left><Left>", { noremap = true })

-- Movement settings
vim.opt.scrolloff = 5

vim.keymap.set("n", "<Tab>", "%", { noremap = true })
vim.keymap.set("v", "<Tab>", "%", { noremap = true })

-- Use physical lines rather than true lines, unless we prepend a number
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "^", "g^")
vim.keymap.set("n", "0", "g0")

-- Hex editor functionality
vim.keymap.set("n", "<F7>", ":call HexMe()<CR>", { noremap = true })
vim.g.in_hex = 0

vim.cmd([[
function! HexMe()
    set binary
    set noeol
    if g:in_hex > 0
        %!xxd -r
        let g:in_hex = 0
    else
        %!xxd
        let g:in_hex = 1
    endif
endfunction
]])

vim.opt.splitbelow = true
vim.opt.splitright = true

-- Tabs/buffers TODO
vim.keymap.set("n", "<leader>[", ":bprevious<CR>", { noremap = true })
vim.keymap.set("n", "<leader>]", ":bnext<CR>", { noremap = true })
vim.keymap.set("n", "<leader>,", ":b#<CR>", { noremap = true })


-- Go to tab by number
for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, i .. "gt", { noremap = true })
end
vim.keymap.set("n", "<leader>0", ":blast<CR>", { noremap = true })
--
-- Apply macros to multiple lines
vim.keymap.set("x", "@", ":<C-u>lua ExecuteMacroOverVisualRange()<CR>", { noremap = true })

-- ExecuteMacroOverVisualRange function
_G.ExecuteMacroOverVisualRange = function()
	local macro = vim.fn.getcharstr()
	vim.cmd(":'<,'>normal @" .. macro)
end
