-- ~/.config/yazi/init.lua

-- Adds the `size_mtime` linemode: item count for folders, size for files, then mtime.
require("linemode-plus"):setup { date_mode = "default" }

-- Disk space meter in the status bar
require("sduf"):setup()

-- Git status markers (fetchers are set in yazi.toml)
require("git"):setup()

-- Relative line numbers and vim-style counts (3j, 12k, 10gg)
require("relative-motions"):setup({ show_numbers = "relative", show_motion = true })

-- Marks: m<key> sets, '<key> jumps, '' returns to the previous directory. Not persisted.
require("bookmarks"):setup({
  persist = "none",
  last_directory = { enable = true, persist = false },
  notify = { enable = true },
})

-- Downloads sorted by mtime (newest first). Entering it saves the current sort and switches;
-- leaving restores it, so manual sorts (,s ,m ...) elsewhere are untouched.
local saved_sort, in_downloads = nil, false
ps.sub("cd", function()
  local is_dl = cx.active.current.cwd:ends_with("Downloads")
  local pref = cx.active.pref
  if is_dl and not in_downloads then
    in_downloads = true
    saved_sort = { tostring(pref.sort_by):lower(), reverse = pref.sort_reverse, dir_first = pref.sort_dir_first }
    ya.emit("sort", { "mtime", reverse = true, dir_first = false })
  elseif not is_dl and in_downloads then
    in_downloads = false
    ya.emit("sort", saved_sort)
  end
end)
