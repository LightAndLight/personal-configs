{ dpi, fontSize }:
''
;==========================================================
;
;
;   ██████╗  ██████╗ ██╗  ██╗   ██╗██████╗  █████╗ ██████╗
;   ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝██╔══██╗██╔══██╗██╔══██╗
;   ██████╔╝██║   ██║██║   ╚████╔╝ ██████╔╝███████║██████╔╝
;   ██╔═══╝ ██║   ██║██║    ╚██╔╝  ██╔══██╗██╔══██║██╔══██╗
;   ██║     ╚██████╔╝███████╗██║   ██████╔╝██║  ██║██║  ██║
;   ╚═╝      ╚═════╝ ╚══════╝╚═╝   ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
;
;
;   To learn more about how to configure Polybar
;   go to https://github.com/polybar/polybar
;
;   The README contains a lot of information
;
;==========================================================

[colors]
background = #3c3836
background-alt = #504945
foreground = #ebdbb2
primary = #458588
secondary = #83a598
alert = #cc241d
disabled = #a89984

[global/wm]
margin-top = 0
margin-bottom = 10

[bar/base]
width = 100%
height = ${builtins.toString (fontSize * 2)}pt

dpi = ${builtins.toString dpi}

background = ''${colors.background}
foreground = ''${colors.foreground}

border-color = #00
radius = 10

line-size = 3pt

module-margin = 1

separator = |
separator-foreground = ''${colors.disabled}

font-0 = Hack:size=${builtins.toString fontSize};2

cursor-click = pointer
cursor-scroll = ns-resize

enable-ipc = true

[bar/top]
inherit = bar/base

border-top-size = 10
border-left-size = 10
border-right-size = 10

padding-left = 0
padding-right = 1

modules-left = xworkspaces xwindow
modules-right = date

[bar/bottom]
inherit = bar/base
bottom = true

border-bottom-size = 10
border-left-size = 10
border-right-size = 10

padding-left = 1
padding-right = 1

modules-left = cpu memory network-wireless network-wired
modules-right = battery

[module/battery]
type = internal/battery

; Use the following command to list batteries and adapters:
; $ ls -1 /sys/class/power_supply/
battery = BAT0
adapter = AC

poll-interval = 5

time-format = %H:%M

format-charging = <label-charging>
format-discharging = <label-discharging>

label-charging = %percentage%% (%time% to full)

label-discharging = %percentage%% (%time% @ %consumption%W)

[module/xworkspaces]
type = internal/xworkspaces

label-active = %name%
label-active-background = ''${colors.background-alt}
label-active-underline = ''${colors.primary}
label-active-padding = 1

label-occupied = %name%
label-occupied-padding = 1

label-urgent = %name%
label-urgent-background = ''${colors.alert}
label-urgent-padding = 1

label-empty =

[module/xwindow]
type = internal/xwindow
label = %title:0:60:...%

[module/memory]
type = internal/memory
interval = 2
format-prefix = "RAM "
format-prefix-foreground = ''${colors.primary}
label = %used%/%total%

[module/cpu]
type = internal/cpu
interval = 2
format = <label> <ramp-coreload>
format-prefix = "CPU "
format-prefix-foreground = ''${colors.primary}
label = %percentage-sum:4%%

ramp-coreload-spacing = 0.1
ramp-coreload-0 = ▁
ramp-coreload-1 = ▂
ramp-coreload-2 = ▃
ramp-coreload-3 = ▄
ramp-coreload-4 = ▅
ramp-coreload-5 = ▆
ramp-coreload-6 = ▇
ramp-coreload-7 = █

[module/network-base]
type = internal/network
interval = 5
accumulate-stats = true

format-connected = <label-connected>
format-connected-prefix = "↓↑"
format-connected-prefix-foreground = ''${colors.primary}

format-disconnected = <label-disconnected>
format-disconnected-prefix = "↓↑"

; XX.X XB/s
; ^^^^^^^^^ = 9 characters
label-connected = %netspeed:9% (%ifname%)
label-disconnected = " (%ifname%)"

[module/network-wireless]
inherit = module/network-base
interface-type = wireless

[module/network-wired]
inherit = module/network-base
interface-type = wired

[module/date]
type = internal/date
interval = 1

date = %a %d %b, %Y
time = %H:%M:%S%z

label = %date% %time%

[settings]
screenchange-reload = true
pseudo-transparency = true

; vim:ft=dosini
''
