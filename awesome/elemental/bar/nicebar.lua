--
--       ======================================================
--        \\\\\\\\  CONFIG BY GITHUB.COM/AIDANHOPPER  ////////
--       ======================================================
--

local awful     = require("awful")
local gears     = require("gears")
local wibox     = require("wibox")
local b         = require("beautiful")
local keys      = require("utils.keybinds")
local dpi       = require("beautiful.xresources").apply_dpi
local helper    = require("utils.helpers")
local naughty   = require("naughty")


awful.screen.connect_for_each_screen(function(s)
      -- Each screen has its own tag table.
      awful.tag({ " ⭘ ", " ⭘ ", " ⭘ " }, s, awful.layout.layouts[1])
      awful.tag.font = "VictorMono Nerd Font Mono 24"
      
      s.clock = wibox.widget.textclock()

      -- Create a promptbox for each screen
      -- Create an imagebox widget which will contain an icon indicating which layout we're using.
      -- We need one layoutbox per screen.
      s.mylayoutbox = awful.widget.layoutbox(s)
      s.mylayoutbox:buttons(gears.table.join(
			       awful.button({ }, 1, function () awful.layout.inc( 1) end),
			       awful.button({ }, 3, function () awful.layout.inc(-1) end),
			       awful.button({ }, 4, function () awful.layout.inc( 1) end),
			       awful.button({ }, 5, function () awful.layout.inc(-1) end)))
      -- Create a taglist widget
      s.mytaglist = awful.widget.taglist {
	 screen  = s,
	 filter  = awful.widget.taglist.filter.all,
	 buttons = keys.taglist_buttons,
      }

      -- Create a tasklist widget
      s.mytasklist = awful.widget.tasklist {
	 screen    = s,
	 filter    = awful.widget.tasklist.filter.currenttags,
	 buttons   = keys.tasklist_buttons,
	 style    = {
	    shape  = gears.shape.rounded_bar,
	 },
	 layout   = {
	    spacing = 20,
	    layout  = wibox.layout.fixed.horizontal
	 },
	 widget_template = {
	    {
	       {
		  {
		     {
			id     = 'clienticon',
			widget = awful.widget.clienticon,
		     },
		     margins = 5,
		     widget  = wibox.container.margin,
		  },
		  bg     = b.border_normal,
		  shape  = gears.shape.circle,
		  widget = wibox.container.background,
	       },
	       margins = 8,
	       widget  = wibox.container.margin,
	    },
	    nil,
	    create_callback = function(self, c, index, objects) --luacheck: no unused args
	       self:get_children_by_id('clienticon')[1].client = c
	    end,
	    layout = wibox.layout.align.vertical,	    
	 },
      }
      

      -- spacer widget
      local spcr = wibox.widget.textbox("   ")

      -- systray
      local icons   = wibox.widget.systray()      
      local systray = helper.circle_widget(
	    "", -- bg
	    "", -- border
	    0,         -- border size
	    0,         -- inside margin
	    8,         -- outside margin
	    icons     -- widget
      )
      b.systray_icon_spacing = 20
      b.bg_systray = b.bg

      
      -- Create the wibox
      s.bar = wibox {
	 screen  = s,
	 visible = true,
	 type    = "dock",
	 width   = awful.screen.focused().geometry.width - dpi(80),
	 height  = dpi(50),
	 y       = dpi(20),
	 x       = dpi(40),
	 bg      = gears.color.transparent,
	 opacity = .7
      }
      
      s.bar:setup {
	 {
	    {
	       {
		  -- left
		  {
		     spcr,
		     s.mytaglist,
		     layout = wibox.layout.fixed.horizontal,
		     
		  },
		  -- center
		  layout = wibox.layout.fixed.horizontal,
		  s.mytasklist,
		  
		  -- right
		  {
		     layout = wibox.layout.fixed.horizontal,
		     --icons,
		     systray,
		     spcr,
		     s.mylayoutbox,
		     spcr,
		     s.clock,
		     spcr,
		  },
		  expand = "none",
		  layout = wibox.layout.align.horizontal
	       },
	       bg      = b.bg,
	       --shape  = gears.shape.rounded_rect,
	       widget  = wibox.container.background,
	    },
	    margins = 7,
	    widget  = wibox.container.margin,
	 },
	 bg     = b.border_normal,
	 --shape  = gears.shape.rounded_rect,
	 widget = wibox.container.background,
      }
      s.bar:struts {
	 --top = dpi(70),
	 top = dpi(s.bar.height - b.useless_gap + 10),
      }
      
      

end)

