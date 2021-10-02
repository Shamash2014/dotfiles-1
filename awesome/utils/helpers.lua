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

helper.circle_widget = function (bg, border, border_size, inside_margin, outside_margin, widget)

   local new_widget = wibox.widget{
      {
	 { 
	    {
	       {
		  {
		     widget = widget
		  },
		  margins = inside_margin,
		  widget = wibox.container.margin,
	       },
	       bg = bg,
	       shape  = gears.shape.rounded_bar,
	       widget = wibox.container.background,
	    },
	    margins = border_size,
	    widget  = wibox.container.margin,
	 },
	 bg     = border,
	 shape  = gears.shape.rounded_bar,
	 widget = wibox.container.background,
      },
      margins = outside_margin,
      widget = wibox.container.margin,
   }
   return new_widget
end

return helper 
