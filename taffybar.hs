{-# language OverloadedStrings #-}
module Main where

import System.Taffybar
import System.Taffybar.Information.CPU
import System.Taffybar.Information.Memory
import System.Taffybar.SimpleConfig
import System.Taffybar.Widget.Battery
import System.Taffybar.Widget.FreedesktopNotifications
import System.Taffybar.Widget.Generic.PollingGraph
import System.Taffybar.Widget.Layout
import System.Taffybar.Widget.SNITray
import System.Taffybar.Widget.SimpleClock
import System.Taffybar.Widget.Util
import System.Taffybar.Widget.Windows
import System.Taffybar.Widget.Workspaces

memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

cpuCallback = do
  (userLoad, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]

main = do
  let
    memCfg =
      defaultGraphConfig
      { graphDataColors = [(1, 0, 0, 1)]
      , graphLabel = Just "mem"
      }

    cpuCfg =
      defaultGraphConfig
      { graphDataColors =
        [ (0, 1, 0, 1)
        , (1, 0, 1, 0.5)
        ]
      , graphLabel = Just "cpu"
      }

  let
    bat = textBatteryNew "$percentage$% ($time$)"
    clock = textClockNew Nothing "<span fgcolor='orange'>%a %b %_d %H:%M</span>" 1
    note = notifyAreaNew defaultNotificationConfig
    mem = pollingGraphNew memCfg 1 memCallback
    cpu = pollingGraphNew cpuCfg 0.5 cpuCallback
    tray = sniTrayNew
    workspaces = workspacesNew defaultWorkspacesConfig
    layout = layoutNew defaultLayoutConfig
    windows = windowsNew defaultWindowsConfig
    battery = textBatteryNew "$percentage$% $time$"
    config =
      defaultSimpleTaffyConfig
      { startWidgets = [ workspaces, layout, note ]
      , centerWidgets = [ windows ]
      , endWidgets = [ battery, tray, clock, mem, cpu ]
      , barPadding = 40
      }

  simpleTaffybar config
