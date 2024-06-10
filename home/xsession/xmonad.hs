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
  [ ((mod4Mask, xK_Return), spawn "alacritty")
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
