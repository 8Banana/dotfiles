import XMonad
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Hooks.ManageDocks

import XMonad.Util.EZConfig(additionalKeys)

myLayout = gaps [(U, 10), (R, 10), (L, 10), (D, 10)] $ smartSpacing 10 $ (tiled ||| Mirror tiled ||| Full)
               where 
	           tiled = Tall nmaster delta ratio
		   nmaster = 1
		   ratio = 1/2
		   delta = 3/100

main = xmonad $ defaultConfig
    { borderWidth = 2,
      focusedBorderColor = "#226fa5", 
      normalBorderColor = "#191919",

      layoutHook = avoidStruts $ myLayout
    } `additionalKeys`
        [ ((0,               0x1008ff11), spawn "alsa-tooltip -d")
        , ((0,               0x1008ff13), spawn "alsa-tooltip -u")
        , ((0,               0x1008ff02), spawn "xbl-tooltip -u")
        , ((0,               0x1008ff03), spawn "xbl-tooltip -d")
        , ((0,               0xff61), spawn "scrot")
        ]

