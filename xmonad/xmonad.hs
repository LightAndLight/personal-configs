import Data.Monoid
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

cfg = def
  { manageHook = manageDocks <+> manageHook def
  , layoutHook  = avoidStruts $ layoutHook def
  , handleEventHook = handleEventHook def <> docksEventHook
  }

main = xmonad =<< xmobar cfg
