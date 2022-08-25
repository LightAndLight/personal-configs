import Data.Monoid
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.WindowNavigation
import XMonad.Layout.MouseResizableTile
import XMonad.Util.EZConfig
import XMonad.Hooks.EwmhDesktops (ewmh)

cfg =
  docks $
  def
  { modMask = mod4Mask
  , manageHook =
      manageDocks <+>
      manageHook def
  , layoutHook = windowNavigation . avoidStruts $ layoutHook def
  , handleEventHook = handleEventHook def
  }
  `additionalKeys`
  [ ((mod4Mask, xK_l), sendMessage $ Go R)
  , ((mod4Mask, xK_h), sendMessage $ Go L)
  , ((mod4Mask, xK_j), sendMessage $ Go D)
  , ((mod4Mask, xK_k), sendMessage $ Go U)
  , ((mod4Mask, xK_Return), spawn "urxvt")
  , ((mod4Mask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock")
  ]

main = xmonad $ ewmh cfg
