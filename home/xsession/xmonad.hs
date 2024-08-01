import Data.Monoid
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.MouseResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.WindowNavigation
import XMonad.Util.EZConfig
import XMonad.Hooks.EwmhDesktops (ewmh)

cfg =
  docks $
  def
  { normalBorderColor = "#ebdbb2"
  , focusedBorderColor = "#458588"
  , borderWidth = 4
  , modMask = mod4Mask
  , manageHook =
      manageDocks <+>
      manageHook def
  , layoutHook =
      spacingRaw False (Border 10 0 10 0) True (Border 0 10 0 10) True .
      windowNavigation .
      avoidStruts $
      layoutHook def
  , handleEventHook = handleEventHook def
  }
  `additionalKeys`
  [ ((mod4Mask, xK_Return), spawn "alacritty")
  , ((mod4Mask, xK_p), spawn "exe=`dmenu_path | dmenu -fn Hack -nb '#282828' -nf '#ebdbb2' -sb '#458588' -sf '#ebdbb2' -i` && exec $exe")
  -- `scrap` is a screen capture script, defined elsewhere in this repo.
  , ((mod4Mask, xK_s), spawn "scrap")
  , ((mod4Mask .|. controlMask, xK_l), spawn "xscreensaver-command -lock")
  , ((mod4Mask, xK_h), sendMessage $ Go L)
  , ((mod4Mask, xK_j), sendMessage $ Go D)
  , ((mod4Mask, xK_k), sendMessage $ Go U)
  , ((mod4Mask, xK_l), sendMessage $ Go R)
  , ((mod4Mask .|. shiftMask, xK_h), sendMessage $ Swap L)
  , ((mod4Mask .|. shiftMask, xK_j), sendMessage $ Swap D)
  , ((mod4Mask .|. shiftMask, xK_k), sendMessage $ Swap U)
  , ((mod4Mask .|. shiftMask, xK_l), sendMessage $ Swap R)
  ]

main = xmonad $ ewmh cfg
