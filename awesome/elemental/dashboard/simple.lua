local awful      = require("awful")
local gears      = require("gears")
local wibox      = require("wibox")
local beautiful  = require("beautiful")
local naughty    = require("naughty")
local keys       = require("utils.keybinds")
local dpi        = require("beautiful.xresources").apply_dpi
local helper     = require("utils.helpers")

beautiful.dashboard_bg = "#2E3440"

-- appearance
local box_radius = dpi(12)
local box_gap = dpi(6)

-- geometry
local screen_size = {
   awful.screen.focused().geometry.width,  -- width   (x)
   awful.screen.focused().geometry.height  -- height  (y)
}

-- creating dashboard wibox
dashboard = wibox{
   visible = false,
   ontop   = true,
   type    = "dock",
   screen  = screen.primary,
   width   = screen_size[1],
   height  = screen_size[2]
}

notif

awful.connect_for_each_screen(function (s)

      -- dashboard:setup{
	 
      -- }
      
end)
