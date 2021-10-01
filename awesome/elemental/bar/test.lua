local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local keys = require("utils.keybinds")
local dpi = require("beautiful.xresources").apply_dpi


beautiful.taglist_text_color_focused  = "#B48EAD"
beautiful.taglist_text_color_urgent   = "#B48EAD"
beautiful.taglist_text_color_occupied = "#B48EAD"
beautiful.taglist_text_color_empty    = "#B48EAD"

local update_taglist = function (item, tag, index)
    if tag.selected then
        item.bg = beautiful.taglist_text_color_focused
    elseif tag.urgent then
        item.bg = beautiful.taglist_text_color_urgent
    elseif #tag:clients() > 0 then
        item.bg = beautiful.taglist_text_color_occupied
    else
        item.bg = beautiful.taglist_text_color_empty
    end
end

awful.screen.connect_for_each_screen(function(s)

      -- -- Each screen has its own tag table.
      -- awful.tag({ " ⭘ ", " ⭘ " }, s, awful.layout.layouts[1])

      -- -- Create an imagebox widget which will contain an icon indicating which layout we're using.
      -- -- We need one layoutbox per screen.
      -- s.mylayoutbox = awful.widget.layoutbox(s)
      -- s.mylayoutbox:buttons(gears.table.join(
      -- 			       awful.button({ }, 1, function () awful.layout.inc( 1) end),
      -- 			       awful.button({ }, 3, function () awful.layout.inc(-1) end),
      -- 			       awful.button({ }, 4, function () awful.layout.inc( 1) end),
      -- 			       awful.button({ }, 5, function () awful.layout.inc(-1) end)))
      -- -- Create a taglist widget
      -- s.mytaglist = awful.widget.taglist {
      -- 	 screen  = s,
      -- 	 filter  = awful.widget.taglist.filter.all,
      -- 	 buttons = keys.taglist_buttons,
      -- 	 layout = wibox.layout.flex.horizontal,
      -- }
      
      -- -- Create the wibox
      -- s.taglist_box = awful.wibar({
      -- 	    position = "bottom",
      -- 	    screen = s,
      -- 	    height = dpi(38),
      -- 	    width = dpi(2500),
      -- 	    opacity = .7,
      -- 	    bg = "#4C566A"
      -- })

      -- Add widgets to the wibox
      -- s.taglist_box:setup {
      -- 	 layout = wibox.layout.align.horizontal,
      -- 	 { -- Left widgets
      --       layout = wibox.layout.fixed.horizontal,
      -- 	 },
      -- 	 { -- Right widgets
      --       layout = wibox.layout.fixed.horizontal,
      -- 	    s.mytaglist,
      -- 	    s.mylayoutbox
      -- 	 },
      -- }

      s.systray = wibox.widget.systray()
      s.traybox = wibox({
	    screen = s,
	    width = dpi(150),
	    height = dpi(38),
	    opacity = .7,
      })

      s.traybox:setup{
	 {
	    {
	       s.systray,
	       expand = "none",
	       layoyt = wibox.layout.align.horizontal,
	    },
	    margins = dpi(10),
	    widget = wibox.container.margin,
	 },
	 widget = wibox.container.background
      }
end)

