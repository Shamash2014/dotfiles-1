local awful     = require("awful")
local gears     = require("gears")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local keys      = require("utils.keybinds")
local dpi       = require("beautiful.xresources").apply_dpi
local helpers    = require("utils.helpers")


awful.screen.connect_for_each_screen(function(s)
      -- clock
      mytextclock = wibox.widget.textclock()
      
      -- Each screen has its own tag table.
      awful.tag({ " ⭘ " }, s, awful.layout.layouts[1])
      awful.tag.font = "VictorMono Nerd Font Mono 25"
      
      -- Rofi drun widget
      local run_button = wibox.widget.textbox()
      run_button.font = "VictorMono Nerd Font Mono 25"
      run_button.text = " ﰜ "
      run_button:buttons(gears.table.join(
			    awful.button({ }, 1, function () awful.util.spawn_with_shell("~/.scripts/rofi_drun.sh") end)
      ))
      -- run_button:buttons(gears.table.join(
      -- 			    awful.button({ }, 1, dashboard_show())
      -- ))


      -- Rofi powermenu widget 
      local power_button = wibox.widget.textbox()
      power_button.font = "VictorMono Nerd Font Mono 25"
      power_button.text = " ⏻ "
      power_button:buttons(gears.table.join(
			      awful.button({ }, 1, function () awful.util.spawn_with_shell("~/.scripts/rofi_powermenu.sh") end)
      ))


      -- Create a promptbox for each screen
      s.mypromptbox = awful.widget.prompt()
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
	    spacing_widget = {
	       {
		  forced_width  = 5,
		  forced_height = dpi(35),
		  thickness     = 1,
		  color         = '#4C566A',
		  widget        = wibox.widget.separator
	       },
	       valign = 'center',
	       halign = 'center',
	       widget = wibox.container.place,
	    },
	    spacing = 20,
	    layout  = wibox.layout.fixed.horizontal
	 },
	 widget_template = {
	    {
	       wibox.widget.base.make_widget(),
	       forced_height = 3,
	       id            = 'background_role',
	       widget        = wibox.container.background,
	    },
	    {
	       {
		  id     = 'clienticon',
		  widget = awful.widget.clienticon,
	       },
	       margins = 2,
	       widget  = wibox.container.margin
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
      s.mywibar = awful.wibar{
	    position = "bottom",
	    screen = s,
	    height = dpi(38),
	    -- width = dpi(2500),
	    opacity = .65
      }

      -- Add widgets to the wibar
      s.mywibar:setup {
	 layout = wibox.layout.align.horizontal,
	 { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            run_button,
	    spcr,
            s.mypromptbox,
	    
	 },
	 s.mytasklist, -- Middle widget
	 { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
	    spcr,
            systray,
	    spcr,
            mytextclock,
	    --s.mytaglist,
	    power_button,
	    spcr,
	    s.mylayoutbox,
	    spcr,
	 },
      }
end)

