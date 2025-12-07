-- Expand track/folder (Ableton-style right arrow)
-- Folder: SHOW all children + expand folder track
-- Regular track: expand just this track

local EXPANDED_HEIGHT = 100

function main()
    local track = reaper.GetSelectedTrack(0, 0)
    if not track then return end

    local folder_depth = reaper.GetMediaTrackInfo_Value(track, "I_FOLDERDEPTH")

    reaper.PreventUIRefresh(1)

    if folder_depth == 1 then
        -- It's a folder - show all children and expand folder
        local track_idx = math.floor(reaper.GetMediaTrackInfo_Value(track, "IP_TRACKNUMBER")) - 1
        local num_tracks = reaper.CountTracks(0)
        local depth = 1

        for i = track_idx + 1, num_tracks - 1 do
            local child = reaper.GetTrack(0, i)
            local child_folder = reaper.GetMediaTrackInfo_Value(child, "I_FOLDERDEPTH")

            -- Show the child track
            reaper.SetMediaTrackInfo_Value(child, "B_SHOWINTCP", 1)
            reaper.SetMediaTrackInfo_Value(child, "B_SHOWINMIXER", 1)
            -- Set to normal height
            reaper.SetMediaTrackInfo_Value(child, "I_HEIGHTOVERRIDE", EXPANDED_HEIGHT)

            depth = depth + child_folder
            if depth <= 0 then break end
        end

        -- Expand the folder track itself
        reaper.SetMediaTrackInfo_Value(track, "I_HEIGHTOVERRIDE", EXPANDED_HEIGHT)
    else
        -- Regular track - just expand this one
        reaper.SetMediaTrackInfo_Value(track, "I_HEIGHTOVERRIDE", EXPANDED_HEIGHT)
    end

    reaper.PreventUIRefresh(-1)
    reaper.TrackList_AdjustWindows(false)
    reaper.UpdateArrange()
end

reaper.Undo_BeginBlock()
main()
reaper.Undo_EndBlock("Expand track/folder", -1)
