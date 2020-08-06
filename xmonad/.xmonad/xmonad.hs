--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.NamedScratchpad
import XMonad.Layout.Tabbed
import XMonad.Layout.Fullscreen
import Graphics.X11.ExtraTypes.XF86
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing               
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Decoration
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Util.NamedActions
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.Renamed
import XMonad.Layout.Accordion
import XMonad.Util.Run(spawnPipe, safeSpawn)
import System.IO
import XMonad.Hooks.FadeInactive

import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.Man
import XMonad.Prompt.Pass
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Prompt.Ssh
import XMonad.Prompt.XMonad
import Control.Arrow (first)
import XMonad.Util.EZConfig
import XMonad.Actions.Submap
import XMonad.Util.Font
import XMonad.Actions.CopyWindow
import qualified XMonad.StackSet as W
  

import Colors
import Lemonbar

--import XMonad.Hooks.DynamicLog hiding (xmobar, xmobarPP, xmobarColor, sjanssenPP, byorgeyPP)
--import XMonad.Util.Loggers
  
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "st"

--foreground = 
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False
gap = 10
myFont = "Ubuntu Mono Nerd Font"

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod1Mask
control       = controlMask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
--myNormalBorderColor  = "#000000"
--myFocusedBorderColor = "#FF0000"
myNormalBorderColor  = color0
myFocusedBorderColor = color3
super = mod4Mask

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--

myKeys :: [(String, X ())]
myKeys =
  [
   ("M-<Space>", spawn "/home/david/scripts/dmenu_run_history")
  ,("M-d", spawn "clipmenu")
  ,("M-q", kill)
  ,("M-S-q", io (exitWith ExitSuccess))
  ,("M-S-<Tab>", sendMessage NextLayout)
  ,("M-S-f", spawn "st -e ranger")
  ,("M-S-r", spawn "xmonad --recompile && xmonad --restart")
  ,("M-S-m", spawn "st -e neomutt")
  ,("M-n", spawn "$HOME/scripts/mpd/mpdmenu")
  ,("M-j", windows W.focusDown)
  ,("M-k", windows W.focusUp)
  ,("M-m", windows W.focusMaster)
  ,("M-S-j", windows W.swapDown)
  ,("M-S-k", windows W.swapUp)
  ,("M-S-<equal>", sendMessage $ ToggleGaps)
  ,("M-h", sendMessage Shrink)
  ,("M-l", sendMessage Expand)
  ,("M-f", sendMessage $ XMonad.Layout.MultiToggle.Toggle FULL)
  ,("M-t",  withFocused $ windows . W.sink)
  ,( "<XF86AudioLowerVolume>"   , spawn "$HOME/scripts/keybinds/volume.sh down")
  ,( "<XF86AudioRaiseVolume>", spawn "$HOME/scripts/keybinds/volume.sh up")
  ,( "<XF86AudioMute>", spawn "$HOME/scripts/keybinds/volume.sh toggle")
  ,("M-`", namedScratchpadAction myScratchPads "terminal")
  ,( "M-S-n", namedScratchpadAction myScratchPads "music")
  ,("M-r h", namedScratchpadAction myScratchPads "htop")
  ,("M-r M-f", namedScratchpadAction myScratchPads "ranger")
  ,("M-,", sendMessage (IncMasterN 1))
  ,("M-b", sendMessage ToggleStruts)
  ,("M-r e", spawn "st -e emacsclient -nw")
  ,("M-r M-e", spawn "emacsclient -nc")
  ,("M-r f", spawn "st -e ranger")
  ,("M-r s", spawn "st -e stig")
  ,("M-r m", spawn "st -e neomutt")
  ,("M-r p", spawn "pavucontrol")
  ,("M-r q", spawn "qutebrowser")
  ,("M-r n", spawn "st -e newsboat")
  ,("M-r b", spawn "st -e bluetoothctl")
  ,("M-r M-p", spawn "st -e python")
  ,("C-S-c", spawn "$HOME/scripts/curcourses")
  ,("M-C-l", sendMessage $ pullGroup R)
  ,("M-C-h", sendMessage $ pullGroup L)
  ,("M-C-k", sendMessage $ pullGroup U)
  ,("M-C-j", sendMessage $ pullGroup D)
  ,("M-a p", toggleCopyToAll)
  ]
     where
			toggleCopyToAll = wsContainingCopies >>= \ws -> case ws of
							[] -> windows copyToAll
							_ -> killAllOtherCopies
someKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [
      ((modm ,  xK_Return), spawn $ XMonad.terminal conf)
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((super , xK_t ), spawn "$HOME/scripts/change_theme" )
    ]
   ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

dtXPConfig :: XPConfig
dtXPConfig = def
      { font                = "xft:Mononoki Nerd Font:size=9"
      , bgColor             = "#292d3e"
      , fgColor             = "#d0d0d0"
      , bgHLight            = "#c792ea"
      , fgHLight            = "#000000"
      , borderColor         = "#535974"
      , promptBorderWidth   = 0
 --     , promptKeymap        = dtXPKeymap
      , position            = Top
--    , position            = CenteredAt { xpCenterY = 0.3, xpWidth = 0.3 }
      , height              = 20
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      , autoComplete        = Just 100000  -- set Just 100000 for .1 sec
      , showCompletionOnTab = False
      --, searchPredicate     = isPrefixOf
      , alwaysHighlight     = True
      , maxComplRows        = Nothing      -- set to Just 5 for 5 rows
      }



myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
suffixed n          = renamed [(XMonad.Layout.Renamed.AppendWords n)]
trimSuffixed w n    = renamed [(XMonad.Layout.Renamed.CutWordsRight w),
                                   (XMonad.Layout.Renamed.AppendWords n)]

myLayout = smartBorders $ fullScreenToggle $ avoidStruts $ (  tiledGapless ||| tiledGaps |||   tabbed shrinkText myTabConfig ||| noBorders Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
     fullScreenToggle = mkToggle (single FULL)

     tiledGapless = windowNavigation
       $ addTabs shrinkText myTabConfig
       $ mynongaps
       $ mynonspace
       $ subLayout [] (Simplest ||| Accordion)
       $ tiled
 
 
   
     tiledGaps = windowNavigation
       $ addTabs shrinkText myTabConfig
       $ myGaps
       $ addSpace
       $ subLayout [] (Simplest ||| Accordion)
       $ tiled

myTabConfig = def {
      fontName              = "xft:Iosevka Nerd Font:size=9"
      -- font              = "xft:Monospace:pixelsize=14,-*-*-*-r-*-*-16-*-*-*-*-*-*-*",
      , activeColor           = foreground
     , activeTextColor       = background
     , inactiveColor         = background
     , activeBorderColor     = foreground
     }


     --tabs= tabbed shrinktext myTabConfig

--  tabs = named "Tabs" $ avoidStruts $ addTopBar $ addTabs shrinkText myTabConfig $ Simplest
myGaps              = gaps [(U, 20),(D, gap),(L, gap),(R, gap)]
mynongaps           = gaps [(U, 0),(D, 0),(L, 0),(R, 0)]
mynonspace           = spacing 0
addSpace     =  spacing gap
------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , resource  =? "feh"            --> doCenterFloat
    , isFullscreen                  --> doFullFloat
    ]<+> namedScratchpadManageHook myScratchPads

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = fullscreenEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myStartupHook = do
   setLayout (Layout (layoutHook myConf))
   spawn "if pgrep -x xcape; then;pkill xcape;fi"
   spawn "exec xmodmap ~/.config/xmodmap/capstoctrl &"
   spawn "xrdb -merge ~/.config/X11/Xresources"
   spawn "xcape"
   spawn "exec ~/.fehbg"
   spawn "wal -R &"
   spawn "dunst &"
   --spawn "picom &"
--myStartupHook = do
   --sendMessage $ JumpToLayout $ Tall



myLogHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConf = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = someKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         =  myLayout,
--        layoutHook         = myLayout,

        manageHook         = myManageHook  <+> manageDocks,
        handleEventHook    = myEventHook,
        logHook            = myLogHook ,
        startupHook        = myStartupHook
    } `additionalKeysP` myKeys
main = do
   xmonad =<< statusBar myXmonadlemonbar myLemonHook toggleStrutsKey myConf

myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "music" spawnMusic findMusic manageMusic  
                , NS "htop" spawnHtop findHtop manageHtop  
                , NS "ranger" spawnRanger findRanger manageRanger  
                ]
  where
    spawnTerm  = myTerminal ++  " -n scratchpad"
    findTerm   = resource =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
                 where
                 h = 0.7
                 w = 0.7
                 t = 0.85 -h
                 l = 0.85 -w
    spawnMusic  = myTerminal ++  "  -n music $HOME/scripts/music"
    findMusic   = resource =? "music"
    manageMusic = customFloating $ W.RationalRect l t w h
                 where
                 h = 0.7
                 w = 0.7
                 t = 0.85 -h
                 l = 0.85 -w
    spawnHtop  = myTerminal ++  " -n htop 'htop'"
    findHtop   = resource =? "htop"
    manageHtop = customFloating $ W.RationalRect l t w h
                 where
                 h = 0.7
                 w = 0.7
                 t = 0.85 -h
                 l = 0.85 -w
    spawnRanger  = myTerminal ++  " -n ranger 'ranger'"
    findRanger   = resource =? "ranger"
    manageRanger = customFloating $ W.RationalRect l t w h
                 where
                 h = 0.7
                 w = 0.7
                 t = 0.85 -h
                 l = 0.85 -w
-- | Finally, a copy of the default bindings in simple textual tabular format.
