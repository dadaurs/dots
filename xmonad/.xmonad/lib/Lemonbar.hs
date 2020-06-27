module Lemonbar where

import System.IO (hPutStrLn)
import XMonad.Hooks.DynamicLog hiding (xmobar, xmobarPP, xmobarColor, sjanssenPP, byorgeyPP)
import XMonad.Util.Loggers
import Colors


myLemonHook = defaultPP {
    ppCurrent          = wrap "%C" "%c"  . pad
  , ppVisible          = wrap "%V" "%v" . pad
  , ppHidden           = wrap "%H" "%h"  . pad 
  , ppHiddenNoWindows  = wrap "%N" "%n"  . pad 
  , ppWsSep            = "|"
  , ppSep              = " "
  ,ppLayout            = wrap " " " " .
       (\x -> case x of
       "Tabbed Spacing 10 Tall"  -> "Tiled"
       "Tabbed Simplest"        -> "Tiled Gapless"
       "Maximize Minimize mtabbed"      -> "Tabbed"
       "Maximize Minimize mtiled"       -> "Fullscreen"
       _                                -> "" ++ x ++ ""
       ) 
  --, ppTitle = wrap "" "%{r}"
  --     (\x -> case x of
  --         ""   -> "..."
  --         _    -> x
  --         )
  -- , ppLayout              = wrap " " " " .
   --, ppTitle = wrap "%{F#00ff00}" "%{r}" .
       --(\x -> case x of
       --"Tabbed Spacing 10 Tall"  -> "   %{B#00ff00}%{F#000000}  Tall  %{B#000000}%{F#2199ee}   "
       --"Tabbed Simplest"        -> "   %{B#00ff00}%{F#000000}  Tabbed  %{B#000000}%{F#2199ee}   "
       --"Maximize Minimize mtabbed"      -> "   %{B#00ff00}%{F#000000}  tabb  %{B#000000}%{F#2199ee}   "
       --"Maximize Minimize mtiled"       -> "   %{B#00ff00}%{F#000000}  tile  %{B#000000}%{F#2199ee}   "
       --_                                -> "%{B#007733}%{F#999999} " ++ x ++ " %{B#000000}%{F#2199ee}"
       --) 
   --, ppOrder       =  \(ws:l:t:x) -> [ws, l, "  " , t] ++ x
}

--myXmonadlemonbar = "lemonbar -p -f \"Source Code Pro For Powerline:size=12\"  -f \"Ubuntu Mono Nerd Font:size=12\"  > /tmp/lemlog"
myXmonadlemonbar = "/home/dada/scripts/lemonbar/xmonad/bar"

