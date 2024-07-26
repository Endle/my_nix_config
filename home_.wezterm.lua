
-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end


local act = wezterm.action

local function macCMDtoMeta()
	local keys = "cabdefghijklmopqrstuwxyz/" -- no v, no n
	local keymappings = {}
	for i = 1, #keys do
		local c = keys:sub(i, i)
		table.insert(keymappings, {
			key = c,
			mods = "CMD",
			action = act.SendKey({
				key = c,
				mods = "CTRL",
			}),
		})
		table.insert(keymappings, {
			key = c,
			mods = "CMD|SHIFT",
			action = act.SendKey({
				key = c,
				mods = "CTRL|SHIFT",
			}),
		})
	end
	for i = 1, 8 do
		table.insert(keymappings, {
		    key = tostring(i),
		    mods = 'ALT',
		    action = act.ActivateTab(i - 1),
		  })
  	end
	return keymappings
end

local function generateKeyMappings()
	local keymappings = {
		{ key = "n", mods = "CMD", action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
		{ key = "c", mods = "SHIFT|CMD", action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection' },
		{ key = "v", mods = "SHIFT|CMD", action = wezterm.action.PasteFrom 'Clipboard' },
		table.unpack(macCMDtoMeta()),
	}
	return keymappings
end

config.keys = generateKeyMappings()


config.font = wezterm.font 'JetBrains Mono'

-- This is where you actually apply your config choices

config.default_prog = { '/bin/bash', '-l' }
config.font_size = 14.0

-- For example, changing the color scheme:
config.color_scheme = 'Alabaster'

config.initial_cols = 120
config.initial_rows = 30

-- and finally, return the configuration to wezterm
return config
