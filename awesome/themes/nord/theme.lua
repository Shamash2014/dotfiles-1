local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local theme_name = "nord"
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local theme = {}

theme.font = "VictorMono Nerd Font Mono 12"

-- Gaps
theme.useless_gap = dpi(20)

-- Borders
theme.border_width = 7
theme.border_normal = "#4C566A"
theme.border_focus = "#81A1C1"

-- Titlebars
theme.titlebars_enabled = false

-- Notifications
-- Position: bottom_left, bottom_right, bottom_middle,
--         top_left, top_right, top_middle
theme.notification_position = "top_middle"
theme.notification_icon_size = dpi(60)
theme.notification_margin = dpi(16)

return theme
