-- script to launch front and backend autopoc software
-- in separate terminal tabs (or iTerm if installed)

try
  tell application "iTerm"
    activate
    select first window

    -- Create new window
    tell current window
      create window with default profile
    end tell
    
    -- Exec commands
    tell current session of current window
      write text "cd autopoc"
      write text "autopoc-api -ll"
    end tell
    
    -- Create new tab
    tell current window
      create tab with default profile
    end tell
    
    -- Exec commands
    tell current session of current window
      write text "cd autopocui"
      write text "ng serve"
    end tell
    
  end tell
end try
