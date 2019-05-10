hs.window.animationDuration = 0
hs.grid.setGrid('12x12').setMargins({0, 0})

function windowSizer(fn)
  return function()
    local win = hs.window.focusedWindow()
    local screenFrame = fn(win:screen():frame())

    win:setFrame(hs.geometry.new(screenFrame))
  end
end

function switchScreen(direction)
  return function()
    local win = hs.window.focusedWindow()
    local cell = hs.grid.get(win)
    local screen = win:screen()

    if direction == "East" then screen = screen:toEast()
    elseif direction == "West" then screen = screen:toWest()
    elseif direction == "North" then screen = screen:toNorth()
    elseif direction == "South" then screen = screen:toSouth()
    end

    hs.grid.set(win, cell, win:screen():next())
  end
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "m", windowSizer(function(screen)
  return screen
end))

-- -------------------------------
-- Window management shortcut keys
-- -------------------------------

-- Vertical halves
hs.hotkey.bind({"alt", "ctrl"}, "Left", function()
  hs.grid.set(hs.window.focusedWindow(), '0,0 6x12')
end)

hs.hotkey.bind({"alt", "ctrl"}, "Right", function()
  hs.grid.set(hs.window.focusedWindow(), '6,0 6x12')
end)

-- hs.hotkey.bind({"alt", "ctrl"}, "Left", windowSizer(function(screen)
--   return { screen.x, screen.y, screen.w / 2 + 2, screen.h }
-- end))
--
-- hs.hotkey.bind({"alt", "ctrl"}, "Right", windowSizer(function(screen)
--   return { screen.w / 2 - 1, screen.y, screen.w / 2 + 2, screen.h }
-- end))

-- Horizontal halves
hs.hotkey.bind({"alt", "ctrl"}, "Up", function()
  hs.grid.set(hs.window.focusedWindow(), '0,0 12x6')
end)

hs.hotkey.bind({"alt", "ctrl"}, "Down", function()
  hs.grid.set(hs.window.focusedWindow(), '0,6 12x6')
end)

-- hs.hotkey.bind({"alt", "ctrl"}, "Up", windowSizer(function(screen)
--   return { screen.x, screen.y, screen.w, screen.h / 2 + 8 }
-- end))
--
-- hs.hotkey.bind({"alt", "ctrl"}, "Down", windowSizer(function(screen)
--   return { screen.x, screen.y + screen.h / 2 - 4, screen.w, screen.h / 2 + 8 }
-- end))

-- Vertical thirds
hs.hotkey.bind({"alt", "ctrl"}, "i", function()
  hs.grid.set(hs.window.focusedWindow(), '0,0 4x12')
end)

hs.hotkey.bind({"alt", "ctrl"}, "o", function()
  hs.grid.set(hs.window.focusedWindow(), '4,0 4x12')
end)

hs.hotkey.bind({"alt", "ctrl"}, "p", function()
  hs.grid.set(hs.window.focusedWindow(), '8,0 4x12')
end)

-- hs.hotkey.bind({"alt", "ctrl"}, "i", windowSizer(function(screen)
  -- return { screen.x, screen.y, screen.w / 3 + 1.5, screen.h }
-- end))

-- hs.hotkey.bind({"alt", "ctrl"}, "o", windowSizer(function(screen)
  -- return { screen.w / 3, screen.y, screen.w / 3 + 1.5, screen.h }
-- end))

-- hs.hotkey.bind({"alt", "ctrl"}, "p", windowSizer(function(screen)
  -- return { screen.w * 2 / 3, screen.y, screen.w / 3 + 1.5, screen.h }
-- end))

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", switchScreen("East"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", switchScreen("West"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", switchScreen("North"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", switchScreen("South"))


function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
