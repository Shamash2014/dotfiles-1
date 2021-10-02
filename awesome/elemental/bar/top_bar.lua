local awful     = require("awful")
local gears     = require("gears")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local keys      = require("utils.keybinds")
local dpi       = require("beautiful.xresources").apply_dpi
local helpers    = require("utils.helpers")


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
	 screen  = s,
	 filter  = awful.widget.tasklist.filter.currenttags,
	 buttons = keys.tasklist_buttons,
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
		  bg = "#4C566A",
		  shape = gears.shape.circle,
		  widget = wibox.container.background,
	       },
	       margins = 8,
	       widget = wibox.container.margin,
	    },
	    nil,
	    create_callback = function(self, c, index, objects) --luacheck: no unused args
	       self:get_children_by_id('clienticon')[1].client = c
	    end,
	    layout = wibox.layout.align.vertical,	    
	 },
      }
      

      -- spacer widget
      local spcr = wibox.widget.textbox("  ")
      
      local icons = wibox.widget.systray()      
      local systray = wibox.widget{
	 {
	    icons,
	    layout = wibox.layout.fixed.horizontal,
	 },
	 margins = 10,
	 widget = wibox.container.margin,
      }
      beautiful.systray_icon_spacing = 10
	 
      -- Create the wibox
      s.wibar = awful.wibar{
	    --position = "bottom",
	    screen = s,
	    height = dpi(42),
	    width = dpi(2500),
	    opacity = 1,
	    shape = gears.shape.rounded_rect,
	    opacity = .8,
	    bg = "#3B4252",
	    --fg = "#2E3440",
	    border_width = 15,
      }
      
      -- Add widgets to the wibar
      s.wibar:setup {	 
	 layout = wibox.layout.align.horizontal,
	 widget = {
	    bg = "#D8DEE9",
	    widget = wibox.container.background
	 },
	 expand = "none",
	 
	 { -- Left widgets
	    layout = wibox.layout.fixed.horizontal,
	    spcr,
	    s.mytasklist
	    
	 },
	 s.mytaglist,
	 -- Middle widget
	 { -- Right widgets
	    layout = wibox.layout.fixed.horizontal,
	    spcr,
	    systray,
	    spcr,
	    mytextclock,
	    power_button,
	    spcr,
	    s.mylayoutbox,
	    spcr,
	    s.clock,
	    spcr,
	 },
	 
      }


end)

