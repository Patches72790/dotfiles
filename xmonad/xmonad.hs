import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Loggers
import XMonad.Util.Run

main :: IO ()
main =
  xmonad $
    ewmhFullscreen $
      ewmh $
        withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey $
          desktopConfig
            { terminal = myTerminal,
              modMask = myModMask
            }

myTerminal :: String
myTerminal = "alacritty"

myTextEditor :: String
myTextEditor = "nvim"

-- uses super key
myModMask = mod4Mask

myBorderWidth = 2

myFocusFollowsMouse = True

myWorkspaces = [1 .. 9]

myLayout = tiled ||| Mirror tiled ||| Full
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    delta = 3 / 100
    ratio = 1 / 2

myXmobarPP :: PP
myXmobarPP =
  def
    { ppSep = magenta " . ",
      ppTitleSanitize = xmobarStrip,
      ppCurrent = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2,
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
    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta = xmobarColor "#ff79c6" ""
    blue = xmobarColor "#bd93f9" ""
    white = xmobarColor "#f8f8f2" ""
    yellow = xmobarColor "#f1fa8c" ""
    red = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

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
