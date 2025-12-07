-- Show FX chain tab for selected track (bring to front, never close)
-- Bind to: Track control panel double-click

local track = reaper.GetSelectedTrack(0, 0)
if not track then return end

-- Show FX chain window (1 = show, brings to focus if already open)
reaper.TrackFX_Show(track, 0, 1)
