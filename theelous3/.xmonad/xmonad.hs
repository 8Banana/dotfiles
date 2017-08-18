import XMonad
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Hooks.ManageDocks

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

      layoutHook = avoidStruts $ myLayout }
