local wezterm = require('wezterm')

local nf = wezterm.nerdfonts
local M = {}

local GLYPH_KEY_TABLE = nf.oct_tasklist --[[ '' ]]
local GLYPH_KEY = nf.oct_tools --[[ '' ]]

local colors = {
   glyph_semi_circle = { bg = 'rgba(0, 0, 0, 0.4)', fg = '#6aa84f' },
   text = { bg = '#6aa84f', fg = '#fff2cc' },
}

local __cells__ = {}

---@param text string
---@param fg string
---@param bg string
local _push = function(text, fg, bg)
   table.insert(__cells__, { Foreground = { Color = fg } })
   table.insert(__cells__, { Background = { Color = bg } })
   table.insert(__cells__, { Attribute = { Intensity = 'Bold' } })
   table.insert(__cells__, { Text = text })
end

-- Get display name from name (e.g. "resize_pane" ruturns " Resize Pane")
-- Lookup uisng given input string and return matching display name
---@param name string
---@return string
local _get_display_name = function(name)
   if name == 'resize_pane' then
      return 'Resize Pane '
   elseif name == 'resize_font' then
      return 'Resize Font '
   end
   return name
end


M.setup = function()
   wezterm.on('update-right-status', function(window, _pane)
      __cells__ = {}

      local name = window:active_key_table()
      if name then
         _push(' ', colors.text.fg, colors.text.bg)
         _push(GLYPH_KEY_TABLE, colors.text.fg, colors.text.bg)
         _push(' ' .. _get_display_name(name), colors.text.fg, colors.text.bg)
      end

      if window:leader_is_active() then
         _push(' ', colors.text.fg, colors.text.bg)
         _push(GLYPH_KEY, colors.text.fg, colors.text.bg)
         _push(' ', colors.text.fg, colors.text.bg)
      end

      window:set_left_status(wezterm.format(__cells__))
   end)
end

return M
