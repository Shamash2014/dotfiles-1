local awful      = require("awful")
local gears      = require("gears")
local wibox      = require("wibox")
local beautiful  = require("beautiful")
local naughty    = require("naughty")
local keys       = require("utils.keybinds")
local dpi        = require("beautiful.xresources").apply_dpi
local helper    = require("utils.helpers")

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
   ontop = true,
   type = "dock",
   screen = screen.primary,
}
dashboard.bg = "#111111"
dashboard.fg = "#FEFEFE"

-- add dashboard or mask to each screen
awful.screen.connect_for_each_screen(function(s)
      if s == screen.primary then
	 s.dashboard = dashboard
      else
	 s.dashboard = helper.screen_mask(s, dashboard.bg)
      end
end)

local function set_visibility(v)
   for s in screen do
      s.dashboard.visible = v
   end
end



dashboard:buttons(gears.table.join(
		     -- middle click hide dashboard
		     awful.button({ }, 2, function ()
			   set_visibility(false)
		     end)
))

function dashboard_show()
   dashboard_grabber = awful.keygrabber.run(function(_, key, event)
	 if event == "release" then return end
	 if key == "Escape" or key == "q" or key == "F1" then
	    set_visibility(false)
	 end
   end)
   set_visibility(true)
end

function toggle_dashboard()
   if not s.dashboard.visible then
      set_visibility(true)
      return
   end
   set_visibility(false)
end
