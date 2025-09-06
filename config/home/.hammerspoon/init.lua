------------------------------------------------------------
-- Minimal fast config: hints, directional focus, send-to-display
------------------------------------------------------------
hs.application.enableSpotlightForNameSearches(true)
-- 0) Quality-of-life
hs.window.animationDuration = 0
hs.hints.showTitleThresh = 9999 -- ALWAYS show titles (since count ≤ 9999)
hs.hints.titleMaxSize = 48      -- truncate long titles to 48 characters
hs.hints.style = "vimperator"   -- letter hints style; try "default" if you prefer

-- Reload hotkey: Cmd+Alt+Ctrl+r
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "r", function()
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
hs.hotkey.bind({ "alt" }, "escape", function()
  hs.hints.windowHints(windowsOnScreen(hs.screen.mainScreen()))
end)

-- Cmd+Shift+Esc: all screens
hs.hotkey.bind({ "alt", "shift" }, "escape", function()
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

local function center(r) return { x = r.x + r.w / 2, y = r.y + r.h / 2 } end

-- scoring helpers
local function directionalScore(dx, dy, dir)
  -- angle gate: keep ~±56° cone
  local ok =
      (dir == "west" and dx < -1 and math.abs(dy) < (math.abs(dx) * 1.5)) or
      (dir == "east" and dx > 1 and math.abs(dy) < (math.abs(dx) * 1.5)) or
      (dir == "north" and dy < -1 and math.abs(dx) < (math.abs(dy) * 1.5)) or
      (dir == "south" and dy > 1 and math.abs(dx) < (math.abs(dy) * 1.5))
  if not ok then return nil end
  local dist = math.sqrt(dx * dx + dy * dy)
  local axis = (dir == "west" or dir == "east") and math.abs(dy) or math.abs(dx)
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
  if app then app:activate(false) end -- set to 'true' if you want to raise ALL windows of the app
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
hs.hotkey.bind({ "cmd", "ctrl" }, "h", focusDir("west", false))
hs.hotkey.bind({ "cmd", "ctrl" }, "l", focusDir("east", false))
hs.hotkey.bind({ "cmd", "ctrl" }, "k", focusDir("north", false))
hs.hotkey.bind({ "cmd", "ctrl" }, "j", focusDir("south", false))

-- cross-display directional focus (H/J/K/L with Alt)
hs.hotkey.bind({ "cmd", "ctrl", "alt" }, "h", focusDir("west", true))
hs.hotkey.bind({ "cmd", "ctrl", "alt" }, "l", focusDir("east", true))
hs.hotkey.bind({ "cmd", "ctrl", "alt" }, "k", focusDir("north", true))
hs.hotkey.bind({ "cmd", "ctrl", "alt" }, "j", focusDir("south", true))

-- MRU (previous window) toggle — uses same focus path
local lastWin, prevWin
hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(w)
  if w and w:isVisible() and w:isStandard() then
    if lastWin and w:id() ~= lastWin:id() then prevWin = lastWin end
    lastWin = w
  end
end)
hs.hotkey.bind({ "cmd", "ctrl" }, "`", function()
  if prevWin and prevWin:isVisible() then focusExactly(prevWin) end
end)

hs.loadSpoon("hs_select_window")

-- customize bindings to your preference
local SWbindings = {
  all_windows = { { "alt" }, "b" },
  app_windows = { { "alt", "shift" }, "b" }
}
spoon.hs_select_window:bindHotkeys(SWbindings)
spoon.hs_select_window.showCurrentlySelectedWindow = true -- or false
spoon.hs_select_window.useFuzzySearch = true

local hotswitchHs = require("hotswitch-hs/hotswitch-hs")
hotswitchHs.enableAutoUpdate()                              -- If you don't want to update automatically, remove this line.
hs.hotkey.bind({ "command" }, ".", hotswitchHs.openOrClose) -- Set a keybind you like to open HotSwitch-HS panel.
hotswitchHs.enableAllSpaceWindows()


local spaces = require("hs.spaces")

local function spacesFor(scr)
  -- returns array of integer space IDs (or empty)
  return spaces.spacesForScreen(scr) or {}
end

local function setify(t)
  local s = {}
  for _, v in ipairs(t) do s[v] = true end
  return s
end

-- Cmd+Ctrl+N → create + switch to new Space on screen under mouse
hs.hotkey.bind({ "cmd", "ctrl" }, "n", function()
  local scr = hs.mouse.getCurrentScreen()
  local before = spacesFor(scr)
  local beforeSet = setify(before)

  -- request new space (return value is not reliable across versions)
  spaces.addSpaceToScreen(scr)

  -- poll for the new space to show up, then switch to it
  local attempts, poll = 0, nil
  poll = hs.timer.doEvery(0.12, function()
    attempts = attempts + 1
    local after = spacesFor(scr)
    if #after > #before then
      local created
      for _, id in ipairs(after) do
        if not beforeSet[id] then
          created = id
          break
        end
      end
      if type(created) == "number" then
        spaces.gotoSpace(created) -- now it's definitely an integer ID
        hs.alert.show("🆕 New Space on " .. (scr:name() or "display"), 1)
      else
        hs.alert.show("⚠️ Couldn’t identify new Space ID", 1.5)
      end
      poll:stop()
    elseif attempts >= 20 then -- ~2.4s timeout
      poll:stop()
      hs.alert.show("⚠️ Timeout creating Space", 1.5)
    end
  end)
end)

-- Cmd+Ctrl+Shift+N → close (remove) the current Space on the display under the mouse
hs.hotkey.bind({ "cmd", "ctrl", "shift" }, "n", function()
  local scr = hs.mouse.getCurrentScreen()
  local list = spacesFor(scr)
  if #list <= 1 then
    hs.alert.show("⚠️ Can't close the only Space on this display", 1.2)
    return
  end

  -- Active space on this screen
  local active = nil
  if type(spaces.activeSpaceOnScreen) == "function" then
    active = spaces.activeSpaceOnScreen(scr)
  elseif type(spaces.activeSpace) == "function" then
    active = spaces.activeSpace()
  end
  if not active then
    hs.alert.show("⚠️ Couldn't detect active Space", 1.2)
    return
  end

  -- Ensure the active space is part of this screen's list
  local idx
  for i, id in ipairs(list) do
    if id == active then
      idx = i; break
    end
  end
  if not idx then
    hs.alert.show("⚠️ Active Space not on this display", 1.2)
    return
  end

  -- Only user spaces can be removed
  local stype = (type(spaces.spaceType) == "function") and spaces.spaceType(active) or "user"
  if stype ~= "user" then
    hs.alert.show("⚠️ Can't remove non-user Space (" .. tostring(stype) .. ")", 1.5)
    return
  end

  -- Pick neighbor on same display
  local neighbor = (idx > 1) and list[idx - 1] or list[idx + 1]
  spaces.gotoSpace(neighbor)

  -- Wait until the active space on this screen == neighbor, then remove old one
  local tries = 0
  local poll
  poll = hs.timer.doEvery(0.12, function()
    tries = tries + 1
    local now = (type(spaces.activeSpaceOnScreen) == "function") and spaces.activeSpaceOnScreen(scr)
        or (type(spaces.activeSpace) == "function") and spaces.activeSpace()
        or nil
    if now == neighbor or tries >= 40 then
      poll:stop()

      -- Re-check the type just in case the space changed state
      local st = (type(spaces.spaceType) == "function") and spaces.spaceType(active) or "user"
      if st ~= "user" then
        hs.alert.show("⚠️ Space became non-user (" .. tostring(st) .. ")", 1.5)
        return
      end

      if type(spaces.removeSpace) ~= "function" then
        hs.alert.show("⚠️ hs.spaces.removeSpace not available in this Hammerspoon", 1.5)
        return
      end

      -- Try a few times in case the MC daemon is busy
      local removed = false
      for _ = 1, 4 do
        local ok, err = pcall(spaces.removeSpace, active)
        if ok then
          removed = true
          break
        else
          hs.timer.usleep(80 * 1000)
        end
      end

      if removed then
        hs.alert.show("🗑️ Closed Space", 0.9)
      else
        hs.alert.show("⚠️ Couldn't close Space (busy or denied)", 1.6)
      end
    end
  end)
end)

-- Sidecar toggle via UI scripting (Intel & Apple Silicon)
-- Cmd+Ctrl+S → just open the Screen Mirroring popover (manual pick)
-- Will move the mouse to the open popover (with multiple fallbacks).
local DEBUG = false

local function log(...) if DEBUG then hs.printf("[sidecar] " .. string.format(...)) end end

local function runAS(applescript)
  local ok, result, err = hs.osascript.applescript(applescript)
  if not ok and err then
    local emsg
    if type(err) == "table" then
      emsg = table.concat(err, "\n")
    else
      emsg = tostring(err)
    end
    hs.alert.show("Sidecar script error:\n" .. emsg, 2)
    log("AppleScript error: %s", emsg)
  end
  return ok, result
end

-- Move mouse to the visual center of a rect {x,y,w,h}
local function moveMouseToRect(rect)
  if type(rect) == "table" and #rect == 4 then
    local x, y, w, h = rect[1], rect[2], rect[3], rect[4]
    if (w or 0) > 0 and (h or 0) > 0 then
      -- If this is a large popover, aim slightly below the top header so
      -- the pointer lands near the device list or controls. For small
      -- items (like a menubar item), center vertically.
      local offset
      if h > 96 then
        offset = math.min(80, h * 0.25)
      else
        offset = h / 2
      end
      local target = { x = x + (w / 2), y = y + offset }
      hs.mouse.absolutePosition(target)
      log("Moved mouse to rect: %.1f, %.1f (w=%.1f h=%.1f) offset=%.1f", target.x, target.y, w, h, offset)
      return true
    end
  end
  return false
end

-- Final failsafe: move near the top-right corner (where the CC popover usually appears)
local function moveNearTopRight()
  local scr = hs.screen.mainScreen():fullFrame()
  -- 80px inset from top-right; adjust if you use a very tall menu bar
  local pt = { x = scr.x + scr.w - 80, y = scr.y + 80 }
  hs.mouse.absolutePosition(pt)
  log("Fallback moveNearTopRight: %.1f, %.1f", pt.x, pt.y)
end

-- Menubar item rect as a fallback (when popover rect can’t be read)
local function getMirroringMenubarRectAS()
  return [[
tell application "System Events"
  if not (exists application process "ControlCenter") then return {0,0,0,0}
  tell application process "ControlCenter"
    try
      set mirrItems to (menu bar items of menu bar 1 whose description contains "Screen Mirroring")
      if (count of mirrItems) > 0 then
        set r to value of attribute "AXFrame" of item 1 of mirrItems
        -- AXFrame is {{x,y},{w,h}}; convert to {x,y,w,h}
        set x to item 1 of item 1 of r
        set y to item 2 of item 1 of r
        set w to item 1 of item 2 of r
        set h to item 2 of item 2 of r
        return {x, y, w, h}
      end if
    end try
  end tell
end tell
return {0,0,0,0}
]]
end

local function sidecarOpenPopoverAS()
  return [[
tell application "System Events"
  if not (exists application process "ControlCenter") then error "ControlCenter process not found."
  tell application process "ControlCenter"
    set opened to false
    try
      set mirrItems to (menu bar items of menu bar 1 whose description contains "Screen Mirroring")
      if (count of mirrItems) > 0 then
          click item 1 of mirrItems
          set opened to true
        end if
    end try
    if opened is false then
      set ccItems to (menu bar items of menu bar 1 whose description is "Control Center")
      if (count of ccItems) = 0 then error "Control Center menu bar item not found"
  click item 1 of ccItems
      tell window 1
        set mm to (buttons whose description contains "Screen Mirroring")
        if (count of mm) = 0 then set mm to (buttons whose title contains "Screen Mirroring")
        if (count of mm) = 0 then
          set gList to (groups whose description contains "Screen Mirroring")
          if (count of gList) > 0 then
            click (first button of (item 1 of gList))
          else
            error "Screen Mirroring control not found"
          end if
        else
          click (item 1 of mm)
        end if
      end tell
    end if

    -- Return rect for whatever window we got
    set theWin to missing value
    try
      set theWin to first window whose subrole is "AXDialog"
    end try
    if theWin is missing value then
      try
        set theWin to first window whose role is "AXWindow"
      end try
    end if
    if theWin is missing value then
      try
        set theWin to first window whose subrole is "AXSystemDialog"
      end try
    end if
    if theWin is missing value then
      try
        if (count of windows) > 0 then set theWin to item 1 of windows
      end try
    end if

    if theWin is missing value then
      return {0,0,0,0}
    else
      set p to position of theWin
      set s to size of theWin
      return {item 1 of p, item 2 of p, item 1 of s, item 2 of s}
    end if
  end tell
end tell
]]
end

-- Fallback: get menubar item rect
local function getMenubarRect()
  local ok, rect = runAS(getMirroringMenubarRectAS())
  if ok then return rect end
  return { 0, 0, 0, 0 }
end

-- Try to move to popover; if not available, try menubar item; else top-right fallback
local function moveCursorSmart(rectFromAS)
  if moveMouseToRect(rectFromAS) then return end
  log("Popover rect invalid, trying menubar rect…")
  local menurect = getMenubarRect()
  if moveMouseToRect(menurect) then return end
  log("Menubar rect invalid, falling back to top-right…")
  moveNearTopRight()
end

hs.hotkey.bind({ "cmd", "ctrl" }, "S", function()
  local ok, rect, err = runAS(sidecarOpenPopoverAS())
  if type(rect) ~= "table" then rect = { 0, 0, 0, 0 } end
  log("sidecarOpenPopoverAS -> ok=%s rect={%s,%s,%s,%s}", tostring(ok), tostring(rect[1]), tostring(rect[2]),
    tostring(rect[3]), tostring(rect[4]))
  -- Move cursor using smart logic (popover -> menubar -> top-right fallback)
  moveCursorSmart(rect)
  if not ok then
    hs.alert.show("Screen Mirroring script error (see Console)", 0.6)
  else
    hs.alert.show("Opened Screen Mirroring", 0.6)
  end
end)

------------------------------------------------------------
-- Sticky audio + HUD fix (UID-based, ordered, guarded, HUD refresh)
------------------------------------------------------------
local SETTINGS_KEY = "stickyAudioDeviceUID"

local function curOut() return hs.audiodevice.defaultOutputDevice() end
local function curFx() return hs.audiodevice.defaultEffectDevice() end
local function devByUID(uid) return uid and hs.audiodevice.findDeviceByUID(uid) or nil end

-- Treat AirPlay routes as "auto" (don’t adopt as sticky on auto-switch)
local function isAirPlay(dev)
  if not dev then return false end
  local tt = dev:transportType() or ""
  local nm = dev:name() or ""
  return tt == "AirPlay" or nm:match("[Aa]ir[Pp]lay")
end

-- Start sticky as saved UID, else current default device UID
local stickyUID = hs.settings.get(SETTINGS_KEY) or (curOut() and curOut():uid())
local function stickyDev() return devByUID(stickyUID) end

-- Remember current volume/mute on the sticky device (for HUD refresh)
local lastStickyVol, lastStickyMute = nil, nil
local function snapshotStickyLevels()
  local d = stickyDev(); if not d then return end
  -- These cover common devices; some interfaces expose only :volume()
  lastStickyVol  = d.outputVolume and d:outputVolume() or (d.volume and d:volume()) or nil
  lastStickyMute = d.outputMuted and d:outputMuted() or nil
end

-- Apply sticky to System/Sound-effects first, then Output (HUD tracks system output)
local function enforceOnce()
  local d = stickyDev(); if not d then return end
  local fx = curFx()
  if (not fx) or (fx:uid() ~= stickyUID) then d:setDefaultEffectDevice() end   -- system/effects
  local out = curOut()
  if (not out) or (out:uid() ~= stickyUID) then d:setDefaultOutputDevice() end -- main output
end

-- After restore, nudge the HUD by re-applying volume/mute to the sticky device
-- After having restored the sticky device, "poke" the HUD by re-applying saved levels:
local function refreshHUD()
  local d = stickyDev()
  if not d then return end
  if lastStickyVol and d.setOutputVolume then
    d:setOutputVolume(lastStickyVol)
  end
  if type(lastStickyMute) == "boolean" and d.setOutputMuted then
    d:setOutputMuted(lastStickyMute)
  end
end


-- Guard loop to beat late system events (up to ~600 ms)
local function enforceGuarded()
  local attempts, t = 0, nil
  t = hs.timer.doEvery(0.05, function()
    attempts = attempts + 1
    enforceOnce()
    local outOK = (curOut() and curOut():uid() == stickyUID)
    local fxOK  = (curFx() and curFx():uid() == stickyUID)
    if (outOK and fxOK) or attempts >= 12 then
      t:stop()
      -- Small extra delay to ensure system UI catches up, then refresh HUD
      hs.timer.doAfter(0.10, refreshHUD)
    end
  end)
end

-- Hotkey: adopt current device as sticky (Cmd+Alt+Ctrl+A)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "A", function()
  local d = curOut(); if not d then return end
  stickyUID = d:uid()
  hs.settings.set(SETTINGS_KEY, stickyUID)
  snapshotStickyLevels()
  hs.alert.show("🔒 Sticky: " .. (d:name() or stickyUID), 0.8)
  enforceGuarded()
end)

-- Watch for output/system-output/default-device churn
hs.audiodevice.watcher.setCallback(function(event)
  if event == "dOut" or event == "sOut" or (event and event:match("^dev")) then
    local d = curOut()
    if d and not isAirPlay(d) then
      -- Manual change → adopt as new sticky
      stickyUID = d:uid()
      hs.settings.set(SETTINGS_KEY, stickyUID)
      snapshotStickyLevels()
    end
    -- Fix immediately, again shortly, and keep fixing during negotiation
    enforceOnce()
    hs.timer.doAfter(0.20, enforceOnce)
    enforceGuarded()
  end
end)
hs.audiodevice.watcher.start()

-- Align on reload
snapshotStickyLevels()
hs.timer.doAfter(0.10, enforceGuarded)
