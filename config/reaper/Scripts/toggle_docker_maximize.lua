-- Toggle bottommost dock between max and 500px (uses Docking Tools)
-- Bind to Shift+Tab

local MAXIMIZE_CMD = "_RS401abbfa943f5a90b5974cc282ce573007cdc7ac"
local HEIGHT_500_CMD = "_RS43c9e49e2579c78394cbb956b7515412be6569ff"

local key = "DockerMaxToggle"
local state = reaper.GetExtState(key, "state")

if state ~= "max" then
    local cmd = reaper.NamedCommandLookup(MAXIMIZE_CMD)
    if cmd ~= 0 then
        reaper.Main_OnCommand(cmd, 0)
        reaper.SetExtState(key, "state", "max", false)
    else
        reaper.ShowConsoleMsg("Docking Tools 'Maximize bottommost dock' not found.\n")
    end
else
    local cmd = reaper.NamedCommandLookup(HEIGHT_500_CMD)
    if cmd ~= 0 then
        reaper.Main_OnCommand(cmd, 0)
        reaper.SetExtState(key, "state", "", false)
    else
        reaper.ShowConsoleMsg("Docking Tools 'Set bottommost dock height (500)' not found.\n")
    end
end
