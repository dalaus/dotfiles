local bind = require("bind")
local autostart = require("autostart")
local style = require("style")
local permission = require("permission")
local input_output = require("input_output")
local windowrule = require("windowrule")
local layout = require("layout")
local exp = require("experiments")

-- Fix instant crash for some apps
hl.env("WEBKIT_DISABLE_COMPOSITING_MODE", 1)
