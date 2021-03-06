--
--       ======================================================
--        \\\\\\\\  CONFIG BY GITHUB.COM/AIDANHOPPER  ////////
--       ======================================================
--

--  Required libraries
-- ======================================================================
local awful         = require("awful")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")

		      
--  Appearance options
-- ======================================================================

-- theme
local themes = {
   "auto",
   "nord",
}
local theme = themes[1]

-- dashboard theme
local dashboards = {
   "simple",
}
local dashboard = dashboards[1]

-- bar theme
local bars = {
   "windows",
   "nicebar",
}
local bar = bars[2]


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

--  Functions
-- ======================================================================
function get_font()
   local t    = io.popen("~/.dotfiles/scripts/get_font.sh")
   local f    = t.read(t, "*all")
   local font = string.sub(f, 1, string.len(f)-1)
   return font
end

function get_theme(theme)
   if (theme == "auto") then
      local t = io.popen("~/.dotfiles/scripts/get_theme.sh")
      theme   = t.read(t, "*all")
      theme   = string.sub(theme, 1, string.len(theme)-1)
   end
   return theme
end

--  User settings
-- ======================================================================
terminal = "kitty"
browser = "qutebrowser"
editor = os.getenv("EDITOR") or "emacs"
editor_cmd = terminal .. " -e " .. editor


--  Theme setup
-- ======================================================================
theme                 = get_theme(theme)
local theme_dir       = "~/.dotfiles/awesome/themes/" .. theme .. "/"
beautiful.init(theme_dir .. "theme.lua")
beautiful.bar         = bar
beautiful.theme       = theme
beautiful.font_name   = get_font()

--  Dashboard setup
-- ======================================================================
-- not currently working :/
--require("elemental.dashboard."..beautiful.dash_theme)


--  Bar setup
-- ======================================================================
require("elemental.bar." .. bar)


--  Getting keybinds
-- ======================================================================
local keys = require("utils.keybinds")


--  Autorun programs with script
-- ======================================================================
awful.util.spawn_with_shell("~/.dotfiles/scripts/startup.sh")


--  Layouts
-- ======================================================================
-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.floating,
   --awful.layout.suit.tile.bottom,
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

--  Right click menu
-- =======================================================================
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
-- ========================================================================
require("utils.rules")


--  Signals
-- ========================================================================
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
