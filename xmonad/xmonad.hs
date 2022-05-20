import XMonad
import XMonad.Config.Desktop

myTerminal = "xterm" -- alacritty

myTextEditor = "nvim"

-- uses super key
myModMask = mod4Mask

myBorderWidth = 2

myFocusFollowsMouse = True

myWorkspaces = [1 .. 9]

main =
  xmonad
    desktopConfig
      { terminal = myTerminal,
        modMask = myModMask
      }

-- example config block for desktop
--{
--  terminal           = myTerminal,
--  focusFollowsMouse  = myFocusFollowsMouse,
--  borderWidth        = myBorderWidth,
--  modMask            = myModMask,
--  -- numlockMask deprecated in 0.9.1
--  -- numlockMask        = myNumlockMask,
--  workspaces         = myWorkspaces,
--  normalBorderColor  = myNormalBorderColor,
--  focusedBorderColor = myFocusedBorderColor,
--
--  -- key bindings
--  keys               = myKeys,
--  mouseBindings      = myMouseBindings,
--
--  -- hooks, layouts
--  layoutHook         = myLayout,
--  manageHook         = myManageHook,
--  handleEventHook    = myEventHook,
--  logHook            = myLogHook,
--  startupHook        = myStartupHook
--}
