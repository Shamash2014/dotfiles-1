local awful = require("awful")
local beautiful = require("beautiful")
local keys = require("utils.keybinds")
local dpi = require("beautiful.xresources").apply_dpi

--  Rules
-- =============================================================
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = keys.clientkeys,
                     buttons = keys.clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
      }
    },

    -- Floating clients.
    { rule_any = {
        class = {
          "Arandr",
	  "riotclientux.exe",
	  "discord",
	  "Steam",
	},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
	   "Event Tester",  -- xev.
	   "Minecraft Launcher",
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled =  beautiful.titlebars_enabled}
    },

    -- 

    -- Disable borders on clients
    {
       rule_any = { class = { "Conky",  } },
       properties = { border_width = 0 }
    },


    -- Client specific settings
    -- MPV 
    {
       rule_any = { class = { "mpv" } },
       properties = { floating = true, ontop = true }
    },
    
}
