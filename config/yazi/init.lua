-- ~/.config/yazi/init.lua

-- Adds the `size_mtime` linemode: item count for folders, size for files, then mtime.
require("linemode-plus"):setup { date_mode = "default" }

-- Disk space meter in the status bar
require("sduf"):setup()

-- SSHFS: mount hosts from ~/.ssh/config under $XDG_RUNTIME_DIR/sshfs (nothing in the home folder).
-- Same directory and options as the g-a/e/w/u jump keys, so both share mounts.
require("sshfs"):setup({
  mount_dir = (os.getenv("XDG_RUNTIME_DIR") or "/tmp") .. "/sshfs",
  default_mount_point = "home",
  sshfs_options = {
    "reconnect",
    "ConnectTimeout=5",
    "compression=yes",
    "ServerAliveInterval=15",
    "ServerAliveCountMax=3",
    "follow_symlinks", -- show what server-side symlinks point to instead of broken local links
  },
})

-- Git status markers (fetchers are set in yazi.toml)
require("git"):setup()

-- Relative line numbers and vim-style counts (3j, 12k, 10gg)
require("relative-motions"):setup({ show_numbers = "relative", show_motion = true })

-- Redraw the relative-number column on top of the list, without the hover highlight
-- and with a blank cell on the hovered row.
do
  local redraw = Current.redraw
  function Current:redraw()
    local r = redraw(self)
    local files = self._folder.window
    local hovered
    for i, f in ipairs(files) do
      if f.is_hovered then hovered = i break end
    end
    if not hovered or type(r) ~= "table" then return r end

    local digits = #tostring(#self._folder.files)
    local lines = {}
    for i = 1, #files do
      lines[i] = ui.Line(i == hovered and string.rep(" ", digits + 1)
        or string.format(" %" .. digits .. "d", math.abs(hovered - i)))
    end
    local a = self._area
    local area = ui.Rect { x = a.x, y = a.y, w = digits + 1, h = math.min(#files, a.h) }
    r[#r + 1] = ui.Clear(area)
    r[#r + 1] = ui.Text(lines):area(area)
    return r
  end
end

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

-- Header: user@host, swapped for the server alias while inside an sshfs mount ($XDG_RUNTIME_DIR/sshfs/<alias>)
local mnt = (os.getenv("XDG_RUNTIME_DIR") or "/tmp") .. "/sshfs/"
Header:children_add(function()
  local ok, alias = pcall(function()
    local cwd = tostring(cx.active.current.cwd)
    return cwd:sub(1, #mnt) == mnt and cwd:sub(#mnt + 1):match("^[^/]+") or nil
  end)
  if ok and alias then
    return ui.Span(alias .. ": "):fg("red"):bold()
  end
  local user = ya.user_name() or os.getenv("USER") or ""
  local host = ya.host_name() or os.getenv("HOSTNAME") or ""
  return ui.Span(user .. "@" .. host .. ": "):fg("blue")
end, 500, Header.LEFT)
