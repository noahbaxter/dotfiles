-- Smart Shift+Tab: Previous transient if audio item selected, otherwise toggle docker
-- Bind to: Shift+Tab

local TOGGLE_DOCKER = 40279
local PREV_TRANSIENT = 40376
local MAXIMIZE_CMD = "_RS401abbfa943f5a90b5974cc282ce573007cdc7ac"
local HEIGHT_500_CMD = "_RS43c9e49e2579c78394cbb956b7515412be6569ff"

local function has_audio_item_selected()
    local item = reaper.GetSelectedMediaItem(0, 0)
    if not item then return false end
    local take = reaper.GetActiveTake(item)
    if not take then return false end
    return not reaper.TakeIsMIDI(take)
end

local function is_docker_visible()
    return reaper.GetToggleCommandState(TOGGLE_DOCKER) == 1
end

local function toggle_docker_size()
    if not is_docker_visible() then
        reaper.Main_OnCommand(TOGGLE_DOCKER, 0)
    end

    local key = "DockerMaxToggle"
    local state = reaper.GetExtState(key, "state")

    if state ~= "max" then
        local cmd = reaper.NamedCommandLookup(MAXIMIZE_CMD)
        if cmd ~= 0 then
            reaper.Main_OnCommand(cmd, 0)
            reaper.SetExtState(key, "state", "max", false)
        end
    else
        local cmd = reaper.NamedCommandLookup(HEIGHT_500_CMD)
        if cmd ~= 0 then
            reaper.Main_OnCommand(cmd, 0)
            reaper.SetExtState(key, "state", "", false)
        end
    end
end

local ctx = reaper.GetCursorContext()

-- ctx == 1 is arrange view, ctx == -1 is MIDI editor
if ctx ~= -1 and has_audio_item_selected() then
    reaper.Main_OnCommand(PREV_TRANSIENT, 0)
else
    toggle_docker_size()
end
