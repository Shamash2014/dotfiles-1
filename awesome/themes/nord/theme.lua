--
--       ======================================================
--        \\\\\\\\  CONFIG BY GITHUB.COM/AIDANHOPPER  ////////
--       ======================================================
--

function get_font()
   local t    = io.popen("~/.dotfiles/scripts/get_font.sh")
   local f    = t.read(t, "*all")
   local font = string.sub(f, 1, string.len(f)-1)
   return font
end


local awful                   = require("awful")
local wibox                   = require("wibox")
local gears                   = require("gears")
local theme_name              = "nord"
local b                       = require("beautiful")
local theme_assets            = require("beautiful.theme_assets")
local xresources              = require("beautiful.xresources")
local dpi                     = xresources.apply_dpi

local theme                    = {}
local pallete                  = {}
-- Color pallete      numbers go from dim to bright
pallete.gray0                  = "#2E3440"
pallete.gray1                  = "#3B4252"
pallete.gray2                  = "#434C5E"
pallete.gray3                  = "#4C566A"
pallete.white0                 = "#D8DEE9"
pallete.white1                 = "#E5E9F0"
pallete.white2                 = "#ECEFF4"
pallete.darkblue               = "#5E81AC"
pallete.babyblue               = "#81A1C1"
pallete.lightblue              = "#88C0D0"
pallete.bluegreentint          = "#8FBCBB"
pallete.red                    = "#BF616A"
pallete.orange                 = "#D08770"
pallete.yellow                 = "#EBCB8B"
pallete.green                  = "#A3BE8C"
pallete.magenta                = "#B48EAD"
-- Font
theme.font_name                = get_font()
theme.font                     = theme.font_name .. " 12"
-- Gaps
theme.useless_gap              = dpi(20)
-- Borders
theme.border_width             = 7
-- Colors
theme.border_normal            = pallete.gray3
theme.border_focus             = pallete.babyblue
theme.bg                       = pallete.gray0
theme.fg                       = pallete.white2
theme.accent                   = pallete.yellow
-- Titlebars
theme.titlebars_enabled        = false
-- Notifications
-- Position: bottom_left, bottom_right, bottom_middle,
--         top_left, top_right, top_middle
theme.notification_position    = "top_middle"
theme.notification_icon_size   = dpi(60)
theme.notification_margin      = dpi(16)

return theme
