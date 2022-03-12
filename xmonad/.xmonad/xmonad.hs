-- Imports:
-- =================================================
-- {{{
import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.NamedScratchpad
import XMonad.Layout.Tabbed
import XMonad.Layout.TabBarDecoration
import XMonad.Layout.Fullscreen
import Graphics.X11.ExtraTypes.XF86
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Layout.Decoration
import XMonad.Layout.Simplest
import XMonad.Util.NamedActions
import XMonad.Util.SpawnOnce
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.SubLayouts
import XMonad.Layout.Renamed
import XMonad.Layout.Accordion
import XMonad.Util.Run(spawnPipe, safeSpawn)
import System.IO
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier
import XMonad.Actions.MouseResize


import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns

import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.Magnifier
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))

import XMonad.Layout.ShowWName
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))
import qualified XMonad.Actions.TreeSelect as TS
import XMonad.Hooks.WorkspaceHistory
import qualified XMonad.StackSet as W




import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.Man
import XMonad.Prompt.Pass
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Prompt.Ssh
import XMonad.Prompt.XMonad
import XMonad.Prompt.FuzzyMatch
import Control.Arrow (first)
import Data.Char (isSpace, toUpper)


import XMonad.Util.EZConfig
import XMonad.Actions.Submap
import XMonad.Actions.CopyWindow
import qualified XMonad.StackSet as W
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Tree


-- }}}
-- =================================================
-- Vars:
-- =================================================
-- {{{
myTerminal      = "st"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myModMask       = mod1Mask
myClickJustFocuses :: Bool
myClickJustFocuses = False
gap = 10
myFont      = "xft:Zekton:size=9:bold:antialias=true"
myBorderWidth :: Dimension
myBorderWidth = 2          

myNormalBorderColor :: String
myNormalBorderColor   = "#282c34" 

myFocusedBorderColor :: String
myFocusedBorderColor  = "#82AAFF"  

myWorkspaces    = [" 1 "," 2 "," 3 "," 4 "," 5 "," 6 "," 7 "," 8 "," 9 "]

-- }}}
-- =================================================
-- Keys:
-- =================================================
-- {{{
myKeys :: [(String, X ())]
myKeys =
  [
   --("M-<Space>", spawn "/home/david/scripts/dmenu_run_history")
  ("M-<Space>", shellPrompt davXPConfig) 
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
  ,("M-h", sendMessage Shrink)
  ,("M-l", sendMessage Expand)
  ,("M-t",  withFocused $ windows . W.sink)
  ,( "<XF86AudioLowerVolume>"   , spawn "$HOME/scripts/keybinds/volume.sh down")
  ,( "<XF86AudioRaiseVolume>", spawn "$HOME/scripts/keybinds/volume.sh up")
  ,( "<XF86AudioMute>", spawn "$HOME/scripts/keybinds/volume.sh toggle")
  ,("M-`", namedScratchpadAction myScratchPads "terminal")
  ,( "M-S-n", namedScratchpadAction myScratchPads "music")
  ,("M-r h", namedScratchpadAction myScratchPads "htop")
  ,("M-r M-f", namedScratchpadAction myScratchPads "ranger")
  ,("M-,", sendMessage (IncMasterN 1))
  , ("M-f", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) 
  --, ("C-t t", treeselectAction tsDefaultConfig)

  ,("M-r e", spawn "st -e emacsclient -nw")
  ,("M-r c", spawn "chromium")
  ,("M-r M-e", spawn "emacsclient -nc")
  ,("M-r f", spawn "st -e ranger")
  ,("M-r s", spawn "st -e stig")
  ,("M-r m", spawn "st -e neomutt")
  ,("M-r p", spawn "pavucontrol")
  ,("M-r q", spawn "qutebrowser")
  ,("M-r n", spawn "st -e newsboat")
  ,("M-r b", spawn "st -e bluetoothctl")
  ,("M-r M-p", spawn "st -e python")



  ,("M-e e", spawn "~/scripts/lectures/edit-lecture")
  ,("M-e m", spawn "~/scripts/lectures/course-menu")
  ,("M-e n", spawn "~/scripts/lectures/new-lecture")
  ,("M-e c", spawn "~/scripts/lectures/chcourse")
  ,("M-e S-n", spawn "~/scripts/lectures/new-course")
  ,("C-S-c", spawn "$HOME/scripts/curcourses")
  ,("M-C-l", sendMessage $ pullGroup R)
  ,("M-C-h", sendMessage $ pullGroup L)
  ,("M-C-k", sendMessage $ pullGroup U)
  ,("M-C-j", sendMessage $ pullGroup D)
  ,("M-C-u", withFocused (sendMessage . UnMerge))
  ,("M-a p", toggleCopyToAll)
  ,("M-r S-f", spawn "/home/david/scripts/firefox_menu")
  , ("M--", decWindowSpacing 1 <+> decScreenSpacing 1)           -- Decrease window spacing
  , ("M-=", incWindowSpacing 1 <+> incScreenSpacing 1)           -- Increase window spacing
  ]
     where
			toggleCopyToAll = wsContainingCopies >>= \ws -> case ws of
							[] -> windows copyToAll
							_ -> killAllOtherCopies
someKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [
      ((modm ,  xK_Return), spawn $ XMonad.terminal conf)
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm              , xK_b     ), sendMessage ToggleStruts)
    ]
   ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
------------------------------------------------------------------------
------------------------------------------------------------------------
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    ]
-- }}}
-- =================================================
-- Layouts:
-- =================================================
-- {{{
myTabTheme = def {
	fontName = myFont
	 , activeColor         = "#82AAFF"
	 , inactiveColor       = "#313846"
	 , activeBorderColor   = "#82AAFF"
	 , inactiveBorderColor = "#282c34"
	 , activeTextColor     = "#282c34"
	 , inactiveTextColor   = "#d0d0d0"
     }


mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True


tall     = renamed [Replace "tall"]
	   $ windowNavigation
	   $ addTabs shrinkText myTabTheme
	   $ subLayout [] Simplest
           $ limitWindows 12
	   $ mySpacing 5
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ windowNavigation
	   $ addTabs shrinkText myTabTheme
	   $ subLayout [] Simplest
           $ limitWindows 20 Full
floats   = renamed [Replace "floats"]
           $ windowNavigation
	   $ addTabs shrinkText myTabTheme
	   $ subLayout [] Simplest
           $ limitWindows 20 simplestFloat
grid     = renamed [Replace "grid"]
           $ windowNavigation
	   $ addTabs shrinkText myTabTheme
	   $ subLayout [] Simplest
           $ limitWindows 12
           $ mySpacing 8
           $ mkToggle (single MIRROR)
           $ Grid (16/10)
spirals  = renamed [Replace "spirals"]
           $ windowNavigation
	   $ addTabs shrinkText myTabTheme
	   $ subLayout [] Simplest
           $ mySpacing' 8
           $ spiral (6/7)
threeCol = renamed [Replace "threeCol"]
           $ windowNavigation
	   $ addTabs shrinkText myTabTheme
	   $ subLayout [] Simplest
           $ limitWindows 7
           $ mySpacing' 4
           $ ThreeCol 1 (3/100) (1/2)
threeRow = renamed [Replace "threeRow"]
           $ windowNavigation
	   $ addTabs shrinkText myTabTheme
	   $ subLayout [] Simplest
           $ limitWindows 7
           $ mySpacing' 4
           $ Mirror
           $ ThreeCol 1 (3/100) (1/2)
tabs     = renamed [Replace "tabs"]
           $ tabbed shrinkText myTabTheme


myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats  $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
     where
        nmaster = 1

        ratio   = 1/2

        delta   = 3/100
        myDefaultLayout =  tall
                                 ||| tabs
                                 ||| noBorders monocle
                                 ||| floats
                                 ||| noBorders tabs
                                 ||| grid
                                 ||| spirals
                                 ||| threeCol
                                 ||| threeRow
-- }}}
-- =================================================
-- Hooks:
-- =================================================
-- {{{
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
 , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
     , isFullscreen -->  doFullFloat
    ]<+> namedScratchpadManageHook myScratchPads

myEventHook = mempty



myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 1.0


-- myStartupHook :: X ()
myStartupHook = do
    spawnOnce "xset r rate 300 100 &"
    spawnOnce "xrdb -merge ~/.config/X11/Xresources &"
    spawnOnce "emacs --daemon &"
    spawnOnce "clipmenud &"
    spawnOnce "blueman-applet &"
    spawnOnce "nm-applet &"
    spawnOnce "xmodmap ~/.config/xmodmap/capstoctrl  2>&1"
    spawnOnce "xcape &"
    spawnOnce "~/.fehbg &"

-- }}}
-- =================================================
-- Main:
-- =================================================
-- {{{
main :: IO ()
main = do

   xmproc <- spawnPipe "xmobar /home/david/.xmobarrc"
   xmonad $ ewmh def{
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        -- numlockMask deprecated in 0.9.1
        -- numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = someKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayoutHook,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook <+> docksEventHook,
        logHook            = myLogHook <+> dynamicLogWithPP xmobarPP
                        { ppOutput = \x -> hPutStrLn xmproc x  
                        , ppCurrent = xmobarColor "#98be65" "" . wrap "[" "]" -- Current workspace in xmobar
                        , ppVisible = xmobarColor "#98be65" ""                -- Visible but not current workspace
                        , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" ""   -- Hidden workspaces in xmobar
                        , ppHiddenNoWindows = xmobarColor "#c792ea" ""        -- Hidden workspaces (no windows)
                        , ppTitle = xmobarColor "#b3afc2" "" . shorten 60     -- Title of active window in xmobar
                        , ppSep =  "<fc=#666666> <fn=2>|</fn> </fc>"          -- Separators in xmobar
                       , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        },
        startupHook        = myStartupHook
    } `additionalKeysP` myKeys

-- }}}
-- =================================================
-- Scratchpads:
-- =================================================
-- {{{
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
-- }}}
-- =================================================
-- Prompt:
-- =================================================
-- {{{
davXPConfig :: XPConfig
davXPConfig = def
      { font                = myFont
      , bgColor             = "#282c34"
      , fgColor             = "#bbc2cf"
      , bgHLight            = "#c792ea"
      , fgHLight            = "#000000"
      , borderColor         = "#535974"
      , promptBorderWidth   = 0
      --, position            = Top
      , position            = CenteredAt { xpCenterY = 0.3, xpWidth = 0.3 }
      , height              = 30
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      --, autoComplete        = Just 100000  -- set Just 100000 for .1 sec
      , showCompletionOnTab = False
      -- , searchPredicate     = isPrefixOf
      , searchPredicate     = fuzzyMatch
      , defaultPrompter     = id $ map toUpper  -- change prompt to UPPER
      -- , defaultPrompter     = unwords . map reverse . words  -- reverse the prompt
      -- , defaultPrompter     = drop 5 .id (++ "XXXX: ")  -- drop first 5 chars of prompt and add XXXX:
      , alwaysHighlight     = True
      , maxComplRows        = Nothing      -- set to 'Just 5' for 5 rows
      }

-- The same config above minus the autocomplete feature which is annoying
-- on certain Xprompts, like the search engine prompts.
davXPConfig' :: XPConfig
davXPConfig' = davXPConfig
      { autoComplete        = Nothing
      }

-- }}}
-- =================================================
-- TreeSelect:
-- =================================================
-- {{{
treeselectAction :: TS.TSConfig (X ()) -> X ()
treeselectAction a = TS.treeselectAction a
   [ Node (TS.TSNode "+ Accessories" "Accessory applications" (return ()))
       [ Node (TS.TSNode "Archive Manager" "Tool for archived packages" (spawn "file-roller")) []
       , Node (TS.TSNode "Calculator" "Gui version of qalc" (spawn "qalculate-gtk")) []
       , Node (TS.TSNode "Calibre" "Manages books on my ereader" (spawn "calibre")) []
       , Node (TS.TSNode "Castero" "Terminal podcast client" (spawn (myTerminal ++ " -e castero"))) []
       , Node (TS.TSNode "Picom Toggle on/off" "Compositor for window managers" (spawn "killall picom; picom")) []
       , Node (TS.TSNode "Virt-Manager" "Virtual machine manager" (spawn "virt-manager")) []
       , Node (TS.TSNode "Virtualbox" "Oracle's virtualization program" (spawn "virtualbox")) []
       ]
   ]

tsDefaultConfig :: TS.TSConfig a
tsDefaultConfig = TS.TSConfig { TS.ts_hidechildren = True
                              , TS.ts_background   = 0xdd282c34
                              , TS.ts_font         = myFont
                              , TS.ts_node         = (0xffd0d0d0, 0xff1c1f24)
                              , TS.ts_nodealt      = (0xffd0d0d0, 0xff282c34)
                              , TS.ts_highlight    = (0xffffffff, 0xff755999)
                              , TS.ts_extra        = 0xffd0d0d0
                              , TS.ts_node_width   = 200
                              , TS.ts_node_height  = 20
                              , TS.ts_originX      = 100
                              , TS.ts_originY      = 100
                              , TS.ts_indent       = 80
                              , TS.ts_navigate     = myTreeNavigation
                              }

myTreeNavigation = M.fromList
    [ ((0, xK_Escape),   TS.cancel)
    , ((0, xK_Return),   TS.select)
    , ((0, xK_space),    TS.select)
    , ((0, xK_Up),       TS.movePrev)
    , ((0, xK_Down),     TS.moveNext)
    , ((0, xK_Left),     TS.moveParent)
    , ((0, xK_Right),    TS.moveChild)
    , ((0, xK_k),        TS.movePrev)
    , ((0, xK_j),        TS.moveNext)
    , ((0, xK_h),        TS.moveParent)
    , ((0, xK_l),        TS.moveChild)
    , ((0, xK_o),        TS.moveHistBack)
    , ((0, xK_i),        TS.moveHistForward)
    , ((0, xK_a),        TS.moveTo ["+ Accessories"])
    , ((0, xK_e),        TS.moveTo ["+ Games"])
    , ((0, xK_g),        TS.moveTo ["+ Graphics"])
    , ((0, xK_i),        TS.moveTo ["+ Internet"])
    , ((0, xK_m),        TS.moveTo ["+ Multimedia"])
    , ((0, xK_o),        TS.moveTo ["+ Office"])
    , ((0, xK_p),        TS.moveTo ["+ Programming"])
    , ((0, xK_s),        TS.moveTo ["+ System"])
    , ((0, xK_b),        TS.moveTo ["+ Bookmarks"])
    , ((0, xK_c),        TS.moveTo ["+ Config Files"])
    , ((0, xK_r),        TS.moveTo ["+ Screenshots"])
    , ((mod4Mask, xK_l), TS.moveTo ["+ Bookmarks", "+ Linux"])
    , ((mod4Mask, xK_e), TS.moveTo ["+ Bookmarks", "+ Emacs"])
    , ((mod4Mask, xK_s), TS.moveTo ["+ Bookmarks", "+ Search and Reference"])
    , ((mod4Mask, xK_p), TS.moveTo ["+ Bookmarks", "+ Programming"])
    , ((mod4Mask, xK_v), TS.moveTo ["+ Bookmarks", "+ Vim"])
    ]
-- }}}
-- =================================================
