-- Smart Tab: Next transient if audio item selected, otherwise do nothing
-- Bind to: Tab

local NEXT_TRANSIENT = 40375

local function has_audio_item_selected()
    local item = reaper.GetSelectedMediaItem(0, 0)
    if not item then return false end
    local take = reaper.GetActiveTake(item)
    if not take then return false end
    return not reaper.TakeIsMIDI(take)
end

if has_audio_item_selected() then
    reaper.Main_OnCommand(NEXT_TRANSIENT, 0)
end
