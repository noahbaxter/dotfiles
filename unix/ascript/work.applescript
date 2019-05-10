-- script to launch front and backend autopoc software
-- in separate terminal tabs (or iTerm if installed)

try
  tell application "iTerm"
    activate
    select first window

    -- Create new tab
    tell current window
      create window with default profile
    end tell

    -- Split pane
    tell current session of current window
      split vertically with default profile
    end tell

    -- Exec commands
    tell first session of current tab of current window
      set name to "Backend"
      write text "autopoc"
    end tell
    tell second session of current tab of current window
      set name to "Frontend"
      write text "autopoc-ui"
    end tell
  end tell
end try
