import Data.Monoid
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.WindowNavigation
import XMonad.Util.EZConfig

cfg = def
  { manageHook = manageDocks <+> manageHook def
  , layoutHook  = windowNavigation . avoidStruts $ layoutHook def
  , handleEventHook = handleEventHook def <> docksEventHook
  }
  `additionalKeys`
  [ ((mod1Mask, xK_l), sendMessage $ Go R)
  , ((mod1Mask, xK_h), sendMessage $ Go L)
  , ((mod1Mask, xK_j), sendMessage $ Go D)
  , ((mod1Mask, xK_k), sendMessage $ Go U)
  , ((mod1Mask, xK_Return), spawn "xterm")
  ]

main = xmonad =<< xmobar cfg
