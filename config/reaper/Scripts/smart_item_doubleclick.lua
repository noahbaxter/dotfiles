-- Smart double-click: MIDI vs Audio
-- MIDI: toggle docker maximize/minimize
-- Audio: toggle zoom/track height, minimize docker on zoom in only
-- Bind to: Media item double-click

local item = reaper.GetSelectedMediaItem(0, 0)
if not item then return end

local take = reaper.GetActiveTake(item)
if not take then return end

local is_midi = reaper.TakeIsMIDI(take)

local HEIGHT_500_CMD = "_RS43c9e49e2579c78394cbb956b7515412be6569ff"
local MAXIMIZE_CMD = "_RS401abbfa943f5a90b5974cc282ce573007cdc7ac"
local EXPANDED_HEIGHT = 600

local function set_envelope_visible(track, visible)
    local env = reaper.GetTrackEnvelopeByName(track, "Volume")
    if not env then return end

    local retval, chunk = reaper.GetEnvelopeStateChunk(env, "", false)
    if not retval then return end

    if visible then
        -- VIS 1 1 1 = visible, in lane, armed
        chunk = chunk:gsub("VIS %d+ %d+", "VIS 1 1")
    else
        -- VIS 0 0 = hidden
        chunk = chunk:gsub("VIS %d+ %d+", "VIS 0 0")
    end

    reaper.SetEnvelopeStateChunk(env, chunk, false)
end

if is_midi then
    -- MIDI: Open editor + fullscreen docker (covers arranger)
    reaper.Main_OnCommand(40153, 0)  -- Open MIDI editor

    local cmd = reaper.NamedCommandLookup(MAXIMIZE_CMD)
    if cmd ~= 0 then
        reaper.Main_OnCommand(cmd, 0)
    end
    reaper.SetExtState("DockerMaxToggle", "state", "max", false)
else
    -- Audio: Toggle zoom view
    local key = "AudioItemEditToggle"
    local state = reaper.GetExtState(key, "state")
    local track = reaper.GetMediaItem_Track(item)
    if not track then return end

    reaper.PreventUIRefresh(1)

    if state ~= "zoomed" then
        -- Save current state
        local track_h = reaper.GetMediaTrackInfo_Value(track, "I_TCPH")
        local h_start, h_end = reaper.GetSet_ArrangeView2(0, false, 0, 0)

        reaper.SetExtState(key, "track_height", tostring(track_h), false)
        reaper.SetExtState(key, "h_start", tostring(h_start), false)
        reaper.SetExtState(key, "h_end", tostring(h_end), false)
        reaper.SetExtState(key, "state", "zoomed", false)

        reaper.Main_OnCommand(40031, 0)  -- Zoom to selected items
        reaper.SetMediaTrackInfo_Value(track, "I_HEIGHTOVERRIDE", EXPANDED_HEIGHT)
        reaper.Main_OnCommand(41866, 0)  -- Show transients

        -- Show volume envelope for this track
        set_envelope_visible(track, true)

        -- Set docker to 500px
        local cmd = reaper.NamedCommandLookup(HEIGHT_500_CMD)
        if cmd ~= 0 then
            reaper.Main_OnCommand(cmd, 0)
        end
        reaper.SetExtState("DockerMaxToggle", "state", "", false)
    else
        -- Restore previous state
        local saved_h = tonumber(reaper.GetExtState(key, "track_height")) or 60
        local h_start = tonumber(reaper.GetExtState(key, "h_start")) or 0
        local h_end = tonumber(reaper.GetExtState(key, "h_end")) or 100

        reaper.SetMediaTrackInfo_Value(track, "I_HEIGHTOVERRIDE", saved_h)
        reaper.GetSet_ArrangeView2(0, true, 0, 0, h_start, h_end)

        -- Hide volume envelope for this track
        set_envelope_visible(track, false)

        reaper.SetExtState(key, "state", "", false)
    end

    reaper.PreventUIRefresh(-1)
    reaper.TrackList_AdjustWindows(false)
    reaper.UpdateArrange()
end
