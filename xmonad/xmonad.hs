import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.IndependentScreens as LIS
import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

main :: IO ()
main =
  xmonad $
    ewmhFullscreen $
      ewmh $
        withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey $
          desktopConfig
            { terminal = myTerminal,
              modMask = myModMask,
              workspaces = myWorkspaces,
              layoutHook = myLayout,
              borderWidth = myBorderWidth,
              normalBorderColor = myNormalBorderColor,
              focusedBorderColor = myFocusedBorderColor
              --startupHook = myStartupHook
            }

myStartupHook = do
  spawnOnce "xmobar -x 0"
  spawnOnce "xmobar -x 1"

myTerminal :: String
myTerminal = "alacritty"

myTextEditor :: String
myTextEditor = "nvim"

-- uses super key
myModMask = mod4Mask

myBorderWidth = 2

myNormalBorderColor = ""

myFocusedBorderColor = "#00A8A8"

myFocusFollowsMouse = True

myWorkspaces = ["web", "code"] ++ ["3", "4", "5", "6"]

myLayout = tiled ||| Mirror tiled ||| Full
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    delta = 3 / 100
    ratio = 1 / 2

myXmobarPP :: PP
myXmobarPP =
  def
    { ppSep = magenta " | ",
      ppTitleSanitize = xmobarStrip,
      ppCurrent = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2,
      ppVisible = green . wrap " " "",
      ppHidden = white . wrap " " "",
      ppHiddenNoWindows = lowWhite . wrap " " "",
      ppUrgent = red . wrap (yellow "!") (yellow "!"),
      ppOrder = \[ws, l, _, wins] -> [ws, l, wins],
      ppExtras = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused = wrap (white "[") (white "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue . ppWindow

    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30
    blue, lowWhite, magenta, red, white, yellow, green :: String -> String
    magenta = xmobarColor "#ff79c6" ""
    blue = xmobarColor "#bd93f9" ""
    white = xmobarColor "#f8f8f2" ""
    yellow = xmobarColor "#f1fa8c" ""
    red = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""
    green = xmobarColor "#98be65" ""

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
