------------------------------------------------------------
-- Minimal fast config: hints, directional focus, send-to-display
------------------------------------------------------------
hs.application.enableSpotlightForNameSearches(true)
-- 0) Quality-of-life
hs.window.animationDuration = 0
hs.hints.showTitleThresh = 9999 -- ALWAYS show titles (since count ≤ 9999)
hs.hints.titleMaxSize = -1      -- (optional) don't truncate long titles
hs.hints.style = "vimperator"   -- letter hints style; try "default" if you prefer

-- Reload hotkey: Cmd+Alt+Ctrl+r
hs.hotkey.bind({"cmd","alt","ctrl"}, "r", function()
  hs.reload()
  hs.alert.show("Hammerspoon reloaded", 0.8)
end)

-- Helper getters
local function fw() return hs.window.focusedWindow() end

------------------------------------------------------------
-- 1) FAST HINTS
--   Cmd+Esc = current screen only
--   Cmd+Shift+Esc = all screens (use sparingly)
------------------------------------------------------------

-- Use window.filter to prefilter visible/standard windows in current Space
local wf = hs.window.filter.new()
wf:setCurrentSpace(true) -- only current Mission Control space

local function windowsOnScreen(scr)
  local wins = wf:getWindows() -- already standard+visible
  return hs.fnutils.filter(wins, function(w) return w:screen() == scr end)
end

-- Cmd+Esc: current screen
hs.hotkey.bind({"alt"}, "escape", function()
  hs.hints.windowHints(windowsOnScreen(hs.screen.mainScreen()))
end)

-- Cmd+Shift+Esc: all screens
hs.hotkey.bind({"alt","shift"}, "escape", function()
  hs.hints.windowHints(wf:getWindows())
end)

------------------------------------------------------------
-- 2) Directional focus — original (no mouse simulation)
--   Same screen:   Cmd+Ctrl+H/J/K/L
--   Cross-display: Cmd+Ctrl+Alt+H/J/K/L  (only hops if no same-screen candidate)
--   MRU toggle:    Cmd+Ctrl+`
------------------------------------------------------------

-- cached window list (current Space only; standard+visible by default)
local wf_dir = hs.window.filter.new()
wf_dir:setCurrentSpace(true)

local function center(r) return { x = r.x + r.w/2, y = r.y + r.h/2 } end

-- scoring helpers
local function directionalScore(dx, dy, dir)
  -- angle gate: keep ~±56° cone
  local ok =
    (dir=="west"  and dx < -1 and math.abs(dy) < (math.abs(dx)*1.5)) or
    (dir=="east"  and dx >  1 and math.abs(dy) < (math.abs(dx)*1.5)) or
    (dir=="north" and dy < -1 and math.abs(dx) < (math.abs(dy)*1.5)) or
    (dir=="south" and dy >  1 and math.abs(dx) < (math.abs(dy)*1.5))
  if not ok then return nil end
  local dist = math.sqrt(dx*dx + dy*dy)
  local axis = (dir=="west" or dir=="east") and math.abs(dy) or math.abs(dx)
  return dist + axis * 0.25
end

-- pick best candidate in a given set
local function pickInSet(fromWin, dir, wins)
  local rf, c0 = fromWin:frame(), nil
  c0 = center(rf)
  local best, bestScore = nil, math.huge
  for _, w in ipairs(wins) do
    if w ~= fromWin then
      local cf, c1 = w:frame(), nil
      c1 = center(cf)
      local s = directionalScore(c1.x - c0.x, c1.y - c0.y, dir)
      if s and s < bestScore then best, bestScore = w, s end
    end
  end
  return best
end

-- unified picker: for crossDisplay, try same-screen first; only hop if needed
local function pickDirected(fromWin, dir, crossDisplay)
  if not fromWin then return nil end
  local all = wf_dir:getWindows()
  if #all == 0 then return nil end
  local scr = fromWin:screen()

  -- pass 1: same screen
  local same = hs.fnutils.filter(all, function(w) return w:screen() == scr end)
  local t = pickInSet(fromWin, dir, same)
  if t or not crossDisplay then return t end

  -- pass 2: other screens
  local others = hs.fnutils.filter(all, function(w) return w:screen() ~= scr end)
  return pickInSet(fromWin, dir, others)
end

-- focus via app activation + raise (classic behavior; raises app’s windows)
local function focusExactly(w)
  if not w then return end
  local app = w:application()
  if app then app:activate(false) end   -- set to 'true' if you want to raise ALL windows of the app
  w:raise(); w:focus()
  hs.timer.doAfter(0.02, function()
    if w:isVisible() then w:focus() end
  end)
end

local function focusDir(dir, crossDisplay)
  return function()
    local cur = hs.window.focusedWindow(); if not cur then return end
    local t = pickDirected(cur, dir, crossDisplay)
    if t then focusExactly(t) end
  end
end

-- same-screen directional focus (H/J/K/L)
hs.hotkey.bind({"cmd","ctrl"}, "h", focusDir("west",  false))
hs.hotkey.bind({"cmd","ctrl"}, "l", focusDir("east",  false))
hs.hotkey.bind({"cmd","ctrl"}, "k", focusDir("north", false))
hs.hotkey.bind({"cmd","ctrl"}, "j", focusDir("south", false))

-- cross-display directional focus (H/J/K/L with Alt)
hs.hotkey.bind({"cmd","ctrl","alt"}, "h", focusDir("west",  true))
hs.hotkey.bind({"cmd","ctrl","alt"}, "l", focusDir("east",  true))
hs.hotkey.bind({"cmd","ctrl","alt"}, "k", focusDir("north", true))
hs.hotkey.bind({"cmd","ctrl","alt"}, "j", focusDir("south", true))

-- MRU (previous window) toggle — uses same focus path
local lastWin, prevWin
hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(w)
  if w and w:isVisible() and w:isStandard() then
    if lastWin and w:id() ~= lastWin:id() then prevWin = lastWin end
    lastWin = w
  end
end)
hs.hotkey.bind({"cmd","ctrl"}, "`", function()
  if prevWin and prevWin:isVisible() then focusExactly(prevWin) end
end)

hs.loadSpoon("hs_select_window")

-- customize bindings to your preference
local SWbindings = {
   all_windows =  { {"alt"}, "b"},
   app_windows =  { {"alt", "shift"}, "b"}
}   
spoon.hs_select_window:bindHotkeys(SWbindings)
spoon.hs_select_window.showCurrentlySelectedWindow = true  -- or false
spoon.hs_select_window.useFuzzySearch = true

local hotswitchHs = require("hotswitch-hs/hotswitch-hs")
hotswitchHs.enableAutoUpdate() -- If you don't want to update automatically, remove this line.
hs.hotkey.bind({"command"}, ".", hotswitchHs.openOrClose) -- Set a keybind you like to open HotSwitch-HS panel.
hotswitchHs.enableAllSpaceWindows()
