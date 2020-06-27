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

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False
gap = 10
myFont = "Ubuntu Mono Nerd Font:size=15"

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
myNormalBorderColor  = color0
myFocusedBorderColor = color4
super = mod4Mask

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,  xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_space     ), spawn "/home/dada/scripts/dmenu_run_history")
    , ((modm,               xK_d     ), spawn "clipmenu")

    -- launch gmrun

    -- close focused window
    , ((modm , xK_q     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm .|. shiftMask,               xK_Tab ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

   -- ,  ((modm .|. shiftMask,               xK_n     ), spawn "urxvt -e ncmpcpp")
    ,  ((modm .|. shiftMask,               xK_f     ), spawn "urxvt -e ranger")
    ,  ((modm .|. shiftMask,               xK_m     ), spawn "st -e neomutt")
    -- Resize viewed windows to the correct size
    --, ((modm,               xK_n     ), refresh)
    , ((modm,               xK_n     ), spawn "/home/dada/scripts/mpd/mpdmenu")

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
    , ((super,               xK_t   ), spawn "/home/dada/scripts/chth")

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    --, ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((modm .|. shiftMask, xK_equal), sendMessage $ ToggleGaps)  -- toggle all gaps

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)
    , ((modm,               xK_f     ), sendMessage $ XMonad.Layout.MultiToggle.Toggle FULL)
    --, ((modm, xK_f), treeselectWorkspace myTreeConf myWorkspaces W.greedyView)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((0, xF86XK_AudioLowerVolume   ), spawn "/home/dada/scripts/keybinds/volume.sh down")
    , ((0, xF86XK_AudioRaiseVolume   ), spawn "/home/dada/scripts/keybinds/volume.sh up")
    , ((0, xF86XK_AudioMute          ), spawn "/home/dada/scripts/keybinds/volume.sh toggle")

    -- Increment the number of windows in the master area
    , ((modm                , xK_grave ), namedScratchpadAction myScratchPads "terminal")
    , ((modm .|. shiftMask  ,xK_n      ), namedScratchpadAction myScratchPads "music")
    , ((modm .|. shiftMask  ,xK_t      ), namedScratchpadAction myScratchPads "htop")
    , ((modm                ,xK_comma ), sendMessage (IncMasterN 1))
    ,((modm, xK_b     ), sendMessage ToggleStruts)

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    , ((control .|. shiftMask              , xK_c), spawn "/home/dada/scripts/curcourses" )

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm .|. shiftMask, xK_r     ), spawn "xmonad --recompile; xmonad --restart")
    , ((modm .|. controlMask, xK_h), sendMessage $ pullGroup L)
    , ((modm .|. controlMask, xK_l), sendMessage $ pullGroup R)
    , ((modm .|. controlMask, xK_k), sendMessage $ pullGroup U)
    , ((modm .|. controlMask, xK_j), sendMessage $ pullGroup D)
    , ((modm .|. controlMask, xK_u), withFocused (sendMessage . UnMerge))
    ,((modm,                  xK_b), sendMessage ToggleStruts)
    , ((modm .|. controlMask, xK_x), shellPrompt dtXPConfig)

    -- Restart xmonad
    --, ((modm .|.             , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    --[((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        -- | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        --, (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
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

myLayout = avoidStruts $ (  tiledGapless |||  tiledGaps ||| tabbed shrinkText myTabConfig ||| noBorders Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
     --fullScreenToggle    = mkToggle (single Full)
       -- $ addTabs shrinkText myTabConfig
     fullScreenToggle = mkToggle (single FULL)

     tiledGapless = smartBorders
       $ fullScreenToggle
       $ windowNavigation
       $ addTabs shrinkText myTabConfig
       $ mynongaps
       $ mynonspace
       $ subLayout [] (Simplest ||| Accordion)
       $ tiled


  
     tiledGaps = fullScreenToggle
       $ windowNavigation
       $ addTabs shrinkText myTabConfig
       $ myGaps
       $ addSpace
       $ subLayout [] (Simplest ||| Accordion)
       $ tiled

myTabConfig = def { fontName              = myFont
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
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         =  myLayout,
--        layoutHook         = myLayout,

        manageHook         = myManageHook  <+> manageDocks,
        handleEventHook    = myEventHook,
        logHook            = myLogHook ,
        startupHook        = myStartupHook
    }
main = do
   xmonad =<< statusBar myXmonadlemonbar myLemonHook toggleStrutsKey myConf

myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "music" spawnMusic findMusic manageMusic  
                , NS "htop" spawnHtop findHtop manageHtop  
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
    spawnMusic  = myTerminal ++  "  -n music /home/dada/scripts/music"
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
-- | Finally, a copy of the default bindings in simple textual tabular format.
