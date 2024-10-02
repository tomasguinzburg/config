local wezterm = require 'wezterm';
local config = wezterm.config_builder()

config.font = wezterm.font("Hasklug Nerd Font Mono")
config.font_size = 18.0
config.default_prog = { '/usr/local/bin/fish', '-l' }
config.enable_tab_bar = false

-- colorsheme needs to be deep copied for a reason
local function copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
  return res
end
local custompuccin = wezterm.color.get_builtin_schemes()["Catppuccin Macchiato (Gogh)"]
config.color_schemes = {
	["custompuccin"] = custompuccin,
}
custompuccin = copy(custompuccin)

config.color_scheme = "custompuccin"
config.window_decorations = "RESIZE"
-- end copy hack


return config
