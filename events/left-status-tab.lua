local wezterm = require 'wezterm';
local mocha = require('utils.colors').MOCHA

local M = {}

local function basename(s)
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
local SOLID_LEFT_MOST = utf8.char(0x2588)
local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)

local ADMIN_ICON = utf8.char(0xf49c)

local CMD_ICON = '󰆍'
local NU_ICON = ''
local PS_ICON = ''
local GIT_BASH_ICON = ''
local ELV_ICON = utf8.char(0xfc6f)
local PWSH_ICON = ''
local YORI_ICON = utf8.char(0xf1d4)
local NYA_ICON = utf8.char(0xf61a)

local VIM_ICON = utf8.char(0xe62b)
local PAGER_ICON = utf8.char(0xf718)
local FUZZY_ICON = utf8.char(0xf0b0)
local BASH_ICON = ''
local SUNGLASS_ICON = utf8.char(0xf9df)

local PYTHON_ICON = utf8.char(0xf820)
local NODE_ICON = utf8.char(0xe74e)
local DENO_ICON = utf8.char(0xe628)
local LAMBDA_ICON = utf8.char(0xfb26)
local UBUNTU_ICON = '󰕈'

local SUP_IDX = {"¹","²","³","⁴","⁵","⁶","⁷","⁸","⁹","¹⁰",
                    "¹¹","¹²","¹³","¹⁴","¹⁵","¹⁶","¹⁷","¹⁸","¹⁹","²⁰"}
local SUB_IDX = {"₁","₂","₃","₄","₅","₆","₇","₈","₉","₁₀",
                    "₁₁","₁₂","₁₃","₁₄","₁₅","₁₆","₁₇","₁₈","₁₉","₂₀"}

-- Box drawing characters for pane split visualization
local BOX_H = "─"  -- horizontal line
local BOX_V = "│"  -- vertical line
local BOX_TL = "┌" -- top-left corner
local BOX_TR = "┐" -- top-right corner
local BOX_BL = "└" -- bottom-left corner
local BOX_BR = "┘" -- bottom-right corner
local BOX_FILL = "█" -- filled block for active pane
local BOX_EMPTY = "▒" -- medium shade block for better contrast

-- Function to create visual pane representation
local function create_pane_visual(active_pane_index, total_panes)
    local visual
    if total_panes == 1 then
        visual = BOX_TL .. BOX_FILL .. BOX_TR
    elseif total_panes == 2 then
        -- Vertical split representation
        if active_pane_index == 1 then
            visual = BOX_TL .. BOX_FILL .. BOX_V .. BOX_EMPTY .. BOX_TR
        else
            visual = BOX_TL .. BOX_EMPTY .. BOX_V .. BOX_FILL .. BOX_TR
        end
    elseif total_panes == 3 then
        -- Three pane representation (one large, two small)
        local panes = {BOX_EMPTY, BOX_EMPTY, BOX_EMPTY}
        panes[active_pane_index] = BOX_FILL
        visual = BOX_TL .. panes[1] .. BOX_V .. panes[2] .. BOX_V .. panes[3] .. BOX_TR
    else
        -- For 4+ panes, show as grid-like representation
        local active_char = BOX_FILL
        local inactive_char = BOX_EMPTY
        local result = BOX_TL
        for i = 1, math.min(total_panes, 4) do
            result = result .. (i == active_pane_index and active_char or inactive_char)
            if i < math.min(total_panes, 4) then
                result = result .. BOX_V
            end
        end
        if total_panes > 4 then
            result = result .. "+" .. SUP_IDX[total_panes - 4]
        end
        visual = result .. BOX_TR
    end
    
    -- Add spacing around the visual for better separation
    return " " .. visual .. " "
end

M.setup = function()
    wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)

    local edge_background = mocha.surface0_trnsp
    local background = "#4E4E4E"
    local foreground = "#1C1B19"
    local dim_foreground = "#3A3A3A"

    if tab.is_active then
        background = "#FBB829"
        foreground = "#1C1B19"
    elseif hover then
        background = "#FF8700"
        foreground = "#1C1B19"
    end

    local edge_foreground = background
    local process_name = tab.active_pane.foreground_process_name
    local pane_title = tab.active_pane.title
    local exec_name = basename(process_name):gsub("%.exe$", "")
    local title_with_icon

    if exec_name == "nu" then
        title_with_icon = NU_ICON .. " NuSh"
    elseif exec_name == "pwsh" then
        title_with_icon = PS_ICON .. " PwSh"
    elseif exec_name == "powershell" then
        title_with_icon = PWSH_ICON .. " PowerShell"
    elseif exec_name == "cmd" then
        title_with_icon = CMD_ICON .. " CMD"
    elseif exec_name == "bash" then
        title_with_icon = GIT_BASH_ICON .. " GitBash"
    elseif exec_name == "elvish" then
        title_with_icon = ELV_ICON .. " Elvish"
    elseif exec_name == "wsl" or exec_name == "wslhost" then
        title_with_icon = UBUNTU_ICON .. " WSL"
    elseif exec_name == "nyagos" then
        title_with_icon = NYA_ICON .. " " .. pane_title:gsub(".*: (.+) %- .+", "%1")
    elseif exec_name == "yori" then
        title_with_icon = YORI_ICON .. " Yori"
    elseif exec_name == "nvim" then
        title_with_icon = VIM_ICON .. pane_title:gsub("^(%S+)%s+(%d+/%d+) %- nvim", " %2 %1")
    elseif exec_name == "bat" or exec_name == "less" or exec_name == "moar" then
        title_with_icon = PAGER_ICON .. " " .. exec_name:upper()
    elseif exec_name == "fzf" or exec_name == "hs" or exec_name == "peco" then
        title_with_icon = FUZZY_ICON .. " " .. exec_name:upper()
    elseif exec_name == "btm" or exec_name == "ntop" then
        title_with_icon = SUNGLASS_ICON .. " " .. exec_name:upper()
    elseif exec_name == "python" or exec_name == "hiss" then
        title_with_icon = PYTHON_ICON .. " " .. exec_name
    elseif exec_name == "node" then
        title_with_icon = NODE_ICON .. " " .. exec_name:upper()
    elseif exec_name == "deno" then
        title_with_icon = DENO_ICON .. " " .. exec_name:upper()
    elseif exec_name == "bb" or exec_name == "cmd-clj" or exec_name == "janet" or exec_name == "hy" then
        title_with_icon = LAMBDA_ICON .. " " .. exec_name:gsub("bb", "Babashka"):gsub("cmd%-clj", "Clojure")
    else
        title_with_icon = BASH_ICON .. " " .. exec_name
    end
    if pane_title:match("^Administrator: ") then
        title_with_icon = title_with_icon .. " " .. ADMIN_ICON
    end
    local left_arrow = SOLID_LEFT_ARROW
    if tab.tab_index == 0 then
        left_arrow = SOLID_LEFT_MOST
    end
    local id = SUB_IDX[tab.tab_index+1]
    local pane_count = #tab.panes
    local pid = ""
    if pane_count > 1 then
        local active_pane_index = tab.active_pane.pane_index + 1
        pid = create_pane_visual(active_pane_index, pane_count)
    end
    local title = " " .. wezterm.truncate_right(title_with_icon or "Unknown", max_width-8) .. " "


    return {
        {Attribute={Intensity="Bold"}},
        {Background={Color=edge_background}},
        {Foreground={Color=edge_foreground}},
        {Text=left_arrow},
        {Background={Color=background}},
        {Foreground={Color=foreground}},
        {Text=id},
        {Text=title},
        {Foreground={Color=pane_count > 1 and (tab.is_active and "#B91C1C" or hover and "#1C1B19" or "#7FB4CA") or dim_foreground}},
        {Text=pane_count > 1 and pid or SUP_IDX[pane_count]},
        {Background={Color=edge_background}},
        {Foreground={Color=edge_foreground}},
        {Text=SOLID_RIGHT_ARROW},
        {Attribute={Intensity="Normal"}},
    }
    end)

return {
    colors = {
        tab_bar = {
        background = mocha.surface0_trnsp,
        new_tab = {bg_color = mocha.surface0_trnsp, fg_color = "#FCE8C3", intensity = "Bold"},
        new_tab_hover = {bg_color = mocha.surface0_trnsp, fg_color = "#FBB829", intensity = "Bold"},
        active_tab = {bg_color = mocha.surface0_trnsp, fg_color = "#FCE8C3"},
        },
    },
}
end

return M