local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = require("beautiful.xresources").apply_dpi
local gears     = require("gears")
local naughty   = require("naughty")


helper = {}

-- sends notifiction with input string to naughty
helper.notify = function(str)
   naughty.notify{
      preset  = naughty.config.presets.normal,
      title   = "Helper Notification",
      text    = str,
   }
end

-- adds maximized mask to screen
helper.screen_mask = function (s, bg)
   local mask = wibox{
      visible = true,
      ontop   = true,
      type    = "splash",
   }
   awful.placement.maximize(mask)
   mask.bg = bg
   return mask
end


return helper 
