local wezterm = require('wezterm')
local M = {}
M.last_triggered_time = nil

M.update_weather = function()

    local current_time = os.time()
    if M.last_triggered_time ~= nil and (current_time - M.last_triggered_time) < 60 then
        return wezterm.GLOBAL.room_weather
    end

    M.last_triggered_time = current_time
    local success, stdout, _stderr = wezterm.run_child_process({
        'curl',
        '--silent',
        'https://[DeviceID].balena-devices.com/data',
    })
    if not success or not stdout then
        return
    end

    wezterm.GLOBAL.room_weather =  wezterm.json_parse(stdout)
    return wezterm.GLOBAL.room_weather
end

return M