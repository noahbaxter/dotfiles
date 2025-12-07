-- Collapse track/folder (Ableton-style left arrow)
-- Folder: HIDE all children + collapse folder track
-- Regular track: collapse just this track

local COLLAPSED_HEIGHT = 1

function main()
    local track = reaper.GetSelectedTrack(0, 0)
    if not track then return end

    local folder_depth = reaper.GetMediaTrackInfo_Value(track, "I_FOLDERDEPTH")

    reaper.PreventUIRefresh(1)

    if folder_depth == 1 then
        -- It's a folder - hide all children and collapse folder
        local track_idx = math.floor(reaper.GetMediaTrackInfo_Value(track, "IP_TRACKNUMBER")) - 1
        local num_tracks = reaper.CountTracks(0)
        local depth = 1

        for i = track_idx + 1, num_tracks - 1 do
            local child = reaper.GetTrack(0, i)
            local child_folder = reaper.GetMediaTrackInfo_Value(child, "I_FOLDERDEPTH")

            -- Hide the child track
            reaper.SetMediaTrackInfo_Value(child, "B_SHOWINTCP", 0)
            reaper.SetMediaTrackInfo_Value(child, "B_SHOWINMIXER", 0)

            depth = depth + child_folder
            if depth <= 0 then break end
        end

        -- Collapse the folder track itself
        reaper.SetMediaTrackInfo_Value(track, "I_HEIGHTOVERRIDE", COLLAPSED_HEIGHT)
    else
        -- Regular track - just collapse this one
        reaper.SetMediaTrackInfo_Value(track, "I_HEIGHTOVERRIDE", COLLAPSED_HEIGHT)
    end

    reaper.PreventUIRefresh(-1)
    reaper.TrackList_AdjustWindows(false)
    reaper.UpdateArrange()
end

reaper.Undo_BeginBlock()
main()
reaper.Undo_EndBlock("Collapse track/folder", -1)
