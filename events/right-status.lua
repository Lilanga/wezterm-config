local wezterm = require('wezterm')
local umath = require('utils.math')
local colors_utils = require('utils.colors')
local weather_service = require('utils.weather')


local nf = wezterm.nerdfonts
local M = {}

local SEPARATOR_CHAR = nf.md_dots_vertical .. ' '
local weather_icons = {
   temperature = '',
   humidity = '',
}

local discharging_icons = {
   nf.md_battery_10,
   nf.md_battery_20,
   nf.md_battery_30,
   nf.md_battery_40,
   nf.md_battery_50,
   nf.md_battery_60,
   nf.md_battery_70,
   nf.md_battery_80,
   nf.md_battery_90,
   nf.md_battery,
}
local charging_icons = {
   nf.md_battery_charging_10,
   nf.md_battery_charging_20,
   nf.md_battery_charging_30,
   nf.md_battery_charging_40,
   nf.md_battery_charging_50,
   nf.md_battery_charging_60,
   nf.md_battery_charging_70,
   nf.md_battery_charging_80,
   nf.md_battery_charging_90,
   nf.md_battery_charging,
}

local colors = colors_utils.RIGHT_STATUS
local __cells__ = {} -- wezterm FormatItems (ref: https://wezfurlong.org/wezterm/config/lua/wezterm/format.html)

---@param text string
---@param icon string
---@param fg string
---@param bg string
---@param separate boolean
local _push = function(text, icon, fg, bg, separate)
   table.insert(__cells__, { Foreground = { Color = fg } })
   table.insert(__cells__, { Background = { Color = bg } })
   table.insert(__cells__, { Attribute = { Intensity = 'Bold' } })
   table.insert(__cells__, { Text = icon .. ' ' .. text .. ' ' })

   if separate then
      table.insert(__cells__, { Foreground = { Color = colors.separator_fg } })
      table.insert(__cells__, { Background = { Color = colors.separator_bg } })
      table.insert(__cells__, { Text = SEPARATOR_CHAR })
   end
end

local _set_weather = function()
   local weather = weather_service.update_weather()

   if weather ~= nil then
      _push(weather.temperature .. nf.md_temperature_celsius, weather_icons.temperature, colors.weather_fg, colors.weather_bg, true)
      _push(weather.humidity .. '%', weather_icons.humidity, colors.weather_fg, colors.weather_bg, true)
   end
end

local _set_date = function()
   local date = wezterm.strftime(' %a %H:%M:%S')
   _push(date, nf.oct_calendar, colors.date_fg, colors.date_bg, true)
end

local _set_tardy = function(pane)
   local meta = pane:get_metadata() or {}
   if meta.is_tardy then
      local secs = meta.since_last_response_ms / 1000.0
      local tardy = string.format('tardy: %5.1fs⏳', secs)
      _push(tardy, nf.cod_pulse, colors.domain_fg, colors.domain_bg, true)
   else
      local domain = pane:get_domain_name()
      if domain then
         _push(domain, nf.cod_server_process, colors.domain_fg, colors.domain_bg, true)
      end
   end
end

local _set_battery = function()
   -- ref: https://wezfurlong.org/wezterm/config/lua/wezterm/battery_info.html

   local charge = ''
   local icon = ''

   for _, b in ipairs(wezterm.battery_info()) do
      local idx = umath.clamp(umath.round(b.state_of_charge * 10), 1, 10)
      charge = string.format('%.0f%%', b.state_of_charge * 100)

      if b.state == 'Charging' then
         icon = charging_icons[idx]
      else
         icon = discharging_icons[idx]
      end
   end

   _push(charge, icon, colors.battery_fg, colors.battery_bg, false)
end

M.setup = function()
   wezterm.on('update-right-status', function(window, pane)
      __cells__ = {}

      _set_weather()
      _set_tardy(pane)
      _set_date()
      _set_battery()

      window:set_right_status(wezterm.format(__cells__))
   end)

   wezterm.on('update-status', function(window, pane)
      __cells__ = {}

      _set_weather()
      _set_tardy(pane)
      _set_date()
      _set_battery()

      window:set_right_status(wezterm.format(__cells__))
   end)
end

return M
