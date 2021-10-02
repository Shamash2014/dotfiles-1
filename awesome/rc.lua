--  Needed libraries
-- =====================================================================
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
local autorun = true
--  Appearance options
-- =====================================================================
-- theme
local themes = {
   "nord",
}
local theme = themes[1]

-- dashboard theme
local dash_themes = {
   "simple",
}
local dash_theme = dash_themes[1]

-- wibar theme
local bar_themes = {
   "windows",
   "top_bar",
   "test",
}
local bar_theme = bar_themes[3]


--  Error handling
-- =======================================================================
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}



--  User settings
-- ======================================================================
terminal = "alacritty"
browser = "qutebrowser"
editor = os.getenv("EDITOR") or "emacs"
editor_cmd = terminal .. " -e " .. editor

-- Getting keybinds
local keys = require("utils.keybinds")
-- Theme setup
local theme_dir = "~/.config/awesome/themes/" ..theme .. "/"
beautiful.init(theme_dir .. "theme.lua")
-- Dashboard setup
--require("elemental.dashboard."..dash_theme)
-- Bar setup
require("elemental.bar."..bar_theme)
-- Autorun programs with bash script
if autorun then
   awful.util.spawn_with_shell("~/.scripts/startup.sh")
end

--  Layouts
-- ======================================================================
-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

--  Menu
-- ============================================================
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function () return false, hotkeys_popup.show_help end },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}


--  Client rules
-- =============================================================
require("utils.rules")



--  Signals
-- =============================================================
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)


-- Disables when no border
if beautiful.border_width > 0 then
   client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
   client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
end
