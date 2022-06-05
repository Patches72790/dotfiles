import GHC.IO.Handle (Handle)
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout (Tall)
import XMonad.Layout.IndependentScreens as LIS
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Renamed (Rename (Replace), renamed)
import XMonad.Layout.ResizableTile (ResizableTall (ResizableTall))
import XMonad.Layout.Spacing (Border (Border), Spacing (Spacing), spacingRaw)
import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

main :: IO ()
main =
  do
    xmobar0 <- spawnPipe "xmobar -x 0 $HOME/dotfiles/xmobar/desktop.xmobarrc.main"
    xmobar1 <- spawnPipe "xmobar -x 1 $HOME/dotfiles/xmobar/desktop.xmobarrc.second"
    xmonad $
      ewmhFullscreen $
        ewmh $
          withEasySB (statusBarProp "xmobar" (pure (myXmobarPP xmobar0 xmobar1))) defToggleStrutsKey $
            desktopConfig
              { terminal = myTerminal,
                modMask = myModMask,
                workspaces = myWorkspaces,
                layoutHook = myLayout,
                borderWidth = myBorderWidth,
                normalBorderColor = myNormalBorderColor,
                focusedBorderColor = myFocusedBorderColor,
                startupHook = myStartupHook
              }

myStartupHook = do
  spawnOnce "nitrogen --restore &"
  spawnOnce "picom &"

myFont :: String
myFont = "xft:FireMono Nerd Font Mono:regular:size=10"

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

mySpacing :: Integer -> l a -> ModifiedLayout Spacing l a
mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True

tiled =
  renamed [Replace "tiled"] $
    mySpacing 5 $
      Tall 1 (3 / 100) (1 / 2)

myLayout = tiled ||| Mirror tiled ||| Full

myXmobarPP :: Handle -> Handle -> PP
myXmobarPP xmproc0 xmproc1 =
  def
    { ppOutput = \x -> hPutStrLn xmproc0 x >> hPutStrLn xmproc1 x,
      ppSep = magenta " | ",
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
