-- -------------------------------
-- Window management shortcut keys
-- -------------------------------

hs.window.animationDuration = 0
hs.grid.setGrid('12x12').setMargins({0, 0})

-- Fill current screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "m", function()
  local win = hs.window.focusedWindow()
  win:setFrame(win:screen():frame())
end)

-- Vertical halves
hs.hotkey.bind({'alt', 'ctrl'}, 'Left',  function() hs.grid.set(hs.window.focusedWindow(), '0,0 6x12') end)
hs.hotkey.bind({'alt', 'ctrl'}, 'Right', function() hs.grid.set(hs.window.focusedWindow(), '6,0 6x12') end)

-- Horizontal halves
hs.hotkey.bind({'alt', 'ctrl'}, 'Up',   function() hs.grid.set(hs.window.focusedWindow(), '0,0 12x6') end)
hs.hotkey.bind({'alt', 'ctrl'}, 'Down', function() hs.grid.set(hs.window.focusedWindow(), '0,6 12x6') end)

-- Vertical thirds
hs.hotkey.bind({'alt', 'ctrl'}, ',', function() hs.grid.set(hs.window.focusedWindow(), '0,0 4x12') end)
hs.hotkey.bind({'alt', 'ctrl'}, '.', function() hs.grid.set(hs.window.focusedWindow(), '4,0 4x12') end)
hs.hotkey.bind({'alt', 'ctrl'}, '/', function() hs.grid.set(hs.window.focusedWindow(), '8,0 4x12') end)

hs.hotkey.bind({'alt', 'ctrl'}, ';', function() hs.grid.set(hs.window.focusedWindow(), '0,0 8x12') end)
hs.hotkey.bind({'alt', 'ctrl'}, "'", function() hs.grid.set(hs.window.focusedWindow(), '4,0 8x12') end)

-- Quadrants
hs.hotkey.bind({'alt', 'ctrl'}, '-', function() hs.grid.set(hs.window.focusedWindow(), '0,0 6x6') end)
hs.hotkey.bind({'alt', 'ctrl'}, '=', function() hs.grid.set(hs.window.focusedWindow(), '6,0 6x6') end)
hs.hotkey.bind({'alt', 'ctrl'}, '[', function() hs.grid.set(hs.window.focusedWindow(), '0,6 6x6') end)
hs.hotkey.bind({'alt', 'ctrl'}, ']', function() hs.grid.set(hs.window.focusedWindow(), '6,6 6x6') end)

-- Move the current window to a different monitor
function switchScreen(direction)
  return function()
    local win = hs.window.focusedWindow()
    local cell = hs.grid.get(win)
    local screen = win:screen()

    hs.grid.set(win, cell, screen[direction](screen))
  end
end
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'Right', switchScreen('toEast'))
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'Left', switchScreen('toWest'))
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'Up', switchScreen('toNorth'))
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'Down', switchScreen('toSouth'))


-- -----------
-- Bookkeeping
-- -----------

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
