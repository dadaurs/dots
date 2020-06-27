/* See LICENSE file for copyright and license details. */

/* appearance */
static unsigned int borderpx  = 2;        /* border pixel of windows */
static unsigned int snap      = 32;       /* snap pixel */
static const int gappx     = 5;   /*              [> gaps between windows <]*/
static const unsigned int gappih    = 10;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 10;       /* vert inner gap between windows */
static const unsigned int gappoh    = 15;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 10;       /* vert outer gap between windows and screen edge */
static const int swallowfloating    = 1;        /* 1 means swallow floating windows by default */
static const int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static int showbar            = 0;        /* 0 means no bar */
static int topbar             = 1;        /* 0 means bottom bar */
static const int barheight          = 20;        /* 0 means bottom bar */
static const char *sepchar           = ":";
static const char *fonts[]          = { "monospace:size=10" };
static const char dmenufont[]       = "monospace:size=10";
//static const char col_gray1[]       = "#222222";
//static const char col_gray2[]       = "#444444";
//static const char col_gray3[]       = "#bbbbbb";
//static const char col_gray4[]       = "#eeeeee";
//static const char col_cyan[]        = "#D7B8FE";
////static const char col_cyan[]        = "#D08770";
static char normbgcolor[]           = "#222222";
static char normbordercolor[]       = "#444444";
static char normfgcolor[]           = "#bbbbbb";
static char selfgcolor[]            = "#eeeeee";
static char selbordercolor[]        = "#005577";
static char selbgcolor[]            = "#005577";
static char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
       [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};

/* tagging */
static const char *tags[] = { "1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 " };
//static const char *tags[] = { "%{A:dwmc view 0}1%{A} ", "%{A:dwmc view 1}2%{A} ", "%{A:dwmc view 2}3%{A} ", "%{A:dwmc view 3}4%{A} ", "%{A:dwmc view 4}5%{A} ", "%{A:dwmc view 5}6%{A} ", "%{A:dwmc view 6}7%{A} ", "%{A:dwmc view 7}8%{A} ", "%{A:dwmc view 8}9%{A} " };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance        title    tags_mask     isfloating          x    y     w    h monitor */
	{ "feh",          NULL,        NULL,           0,             0, 0, 0,  300, 200, 1300, 700, 2, 0},
	{ "mpv",          NULL,        NULL,           0,             0, 0, 0,  300, 200, 1300, 700, 2, 0},
	{ "Sxiv",         NULL,        NULL,           0,             0, 0, -1, 300, 200, 1300, 700, 2, 0},
	{ "qutebrowser",  NULL,        NULL,      1 << 1,             0, 0, -1, 300, 200, 1300, 700, 2, 0},
	{ "emacs@gentoo", NULL,        NULL,      1 << 1,             0, 0, -1, 300, 200, 1300, 700, 2, 0},
	{ "surf",         NULL,        NULL,      1 << 1,             0, 0, -1, 300, 200, 1300, 700, 2, 0},
	{ "st",           NULL,        NULL,      1 << 1,             0, 1, -1, 300, 200, 1300, 700, 2, 0},



	{ NULL,           NULL,"scratchpad",        0,                1, 0, 1, 300, 200, 1300, 700, 2, -1,       's' },
	{ NULL,           NULL,     "music",        0,                1,0, 1, 300, 200, 1300, 700, 2, -1,       'm' },
};

/* layout(s) */
static float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static int nmaster     = 1;    /* number of clients in master area */
static int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
    { "", tile },
    { "", monocle },
    { "缾", NULL }, // floating
   { NULL,       NULL },
};


/* key definitions */
#define MODKEY Mod1Mask
#define SUPKEY Mod4Mask
#define MODALT Mod1Mask|Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define CTRL ControlMask

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {"/home/dada/scripts/dmenu_run_history",NULL};
static const char *termcmd[]  = { "st", NULL };
static const char *scratchpadcmd[] = {"s", "st", "-t", "scratchpad", NULL}; 
//static const char *scratchpadcmd[] = { "st", "-t", "scratchpad", "-g", "120x34", NULL };
static const char *musicscratchcmd[] = {"m", "st", "-t", "music" , "-e","/home/dada/scripts/music", NULL };
static const char *musiccmd[] = { "/home/dada/scripts/mpd/mpdmenu", NULL};
static const char *mutecmd[] = { "/home/dada/scripts/keybinds/volume.sh", "toggle", NULL };
static const char *volupcmd[] = { "/home/dada/scripts/keybinds/volume.sh", "up", NULL };
static const char *voldowncmd[] = {  "/home/dada/scripts/keybinds/volume.sh", "down", NULL };
static const char *urlcmd[] = {"/home/dada/scripts/urlhandler.sh", NULL};
static const char *emacscmd[] = {"emacsclient","-nc", NULL};
static const char *charcmd[] = {"/home/dada/.local/bin/charsel", NULL};
static const char *coursecmd[] = {"/home/dada/scripts/curcourses", NULL};
static const char *quicktexcmd[] = {"/home/dada/scripts/quicktex", NULL};
static const char *clipmenucmd[] = {"clipmenu", NULL};
static const char *barcmd[] = {"/home/dada/scripts/lemonbar/dwm/minbar.sh","toggle", NULL};
static const char *chth[] = {"/home/dada/scripts/chth" ,NULL};
//static const char *tabbedcmd[] = {"tabbed_id=$(tabbed -cdk) && xdotoolwindowreparent $(xdotoolgetwindowfocus-f) $tabbed_id", NULL};
//static const char *createtabbedcmd[] = {"/home/dada/scripts/dwm_tab", NULL};
//static const char *attacheastcmd[] = {"/home/dada/scripts/dwm_tab","east", NULL};
//static const char *attachsouthcmd[] = {"/home/dada/scripts/dwm_tab","south", NULL};
//static const char *attachnordcmd[] = {"/home/dada/scripts/dwm_tab","north", NULL};
//static const char *attachwestcmd[] = {"/home/dada/scripts/dwm_tab","west", NULL};

#include <X11/XF86keysym.h>
#include "movestack.c"

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_space,      spawn,        {.v = dmenucmd } },
	{ SUPKEY,                       XK_d,      spawn,            {.v = clipmenucmd } },
	{ MODKEY,                       XK_Return, spawn,            {.v = termcmd } },
	{ CTRL|ShiftMask,               XK_c, spawn,                 {.v = coursecmd } },
	{ CTRL|ShiftMask,               XK_q, spawn,                 {.v = quicktexcmd } },
	{ SUPKEY,                       XK_t,      spawn,            {.v = chth } },
	//{ MODKEY,                       XK_b,      togglebar,        {0} },
	{ MODKEY,                       XK_b,      spawn,            {.v = barcmd } },
	{ MODKEY,                       XK_j,      focusstack,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_c,      spawn,            {.v = charcmd  } },
	{ MODKEY,                       XK_k,      focusstack,       {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,       {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,       {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,         {.f = -0.01} },
	{ MODKEY,                       XK_l,      setmfact,         {.f = +0.01} },
	{ MODKEY,                       XK_Return, zoom,             {0} },
	{ MODKEY,                       XK_Tab,    view,             {0} },
	{ MODKEY,                       XK_q,      killclient,       {0} },
	{ MODKEY,                       XK_t,      setlayout,        {.v = &layouts[0]} },
	{ MODKEY,                       XK_m,      setlayout,        {.v = &layouts[2]} },
	//{ MODKEY,                       XK_space,  setlayout,        {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating,   {0} },
	{ MODKEY,                       XK_0,      view,             {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,              {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,         {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,           {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,           {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_j,      movestack,        {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      movestack,        {.i = -1 } },
	{ MODALT,                       XK_j,      reparent,         {.i =+1} },
	{ MODALT,                       XK_k,      reparent,         {.i =-1} },
	//{ MODALT,                       XK_k,      reparent,         {.i = -1 } },
	//{ MODALT,                       XK_j,      reparent,         {.i = +1 } },
	{ MODKEY,                       XK_grave,  togglescratch,    {.v = scratchpadcmd } },
	{ MODKEY|ShiftMask,             XK_n,      togglescratch,    {.v = musicscratchcmd } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ 0, XF86XK_AudioMute, spawn, {.v = mutecmd } },
	{ 0, XF86XK_AudioLowerVolume, spawn, {.v = voldowncmd } },
	{ 0, XF86XK_AudioRaiseVolume, spawn, {.v = volupcmd } },
	{ MODKEY,                       XK_n,      spawn,            {.v = musiccmd } },
	{ MODKEY,                       XK_o,      spawn,            {.v = urlcmd } },
	{ MODKEY,                       XK_e,      spawn,            {.v = emacscmd } },
	{ MODKEY,                       XK_minus,  incrgaps,        {.i = -1 } },
	{ MODKEY,                       XK_equal,  incrgaps,        {.i = +1 } },
	//{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = 0  } },
	{ MODKEY,                       XK_equal,      togglegaps,     {0} },
	{ MODALT,                       XK_d,      spawntabwin,            {.i = +1} },
	//{ MODALT,                       XK_h,      spawn,            {.v = attachwestcmd } },
	//{ MODALT,                       XK_k,      spawn,            {.v = attachnordcmd } },
	//{ MODALT,                       XK_j,      spawn,            {.v = attachsouthcmd } },
	//{ MODALT,                       XK_l,      spawn,            {.v = attacheastcmd } },
	{ MODKEY,                       XK_f,      togglefullscreen,        {1} },
	{ MODKEY|ShiftMask,             XK_Tab,      cyclelayout,        {0} },

};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

void
setlayoutex(const Arg *arg)
{
	setlayout(&((Arg) { .v = &layouts[arg->i] }));
}

void
viewex(const Arg *arg)
{
	view(&((Arg) { .ui = 1 << arg->ui }));
}

void
viewall(const Arg *arg)
{
	view(&((Arg){.ui = ~0}));
}

void
toggleviewex(const Arg *arg)
{
	toggleview(&((Arg) { .ui = 1 << arg->ui }));
}

void
tagex(const Arg *arg)
{
	tag(&((Arg) { .ui = 1 << arg->ui }));
}

void
toggletagex(const Arg *arg)
{
	toggletag(&((Arg) { .ui = 1 << arg->ui }));
}

void
tagall(const Arg *arg)
{
	tag(&((Arg){.ui = ~0}));
}

/* signal definitions */
/* signum must be greater than 0 */
/* trigger signals using `xsetroot -name "fsignal:<signame> [<type> <value>]"` */
static Signal signals[] = {
	/* signum           function */
	{ "focusstack",     focusstack },
	{ "setmfact",       setmfact },
	{ "togglebar",      togglebar },
	{ "incnmaster",     incnmaster },
	{ "togglefloating", togglefloating },
	{ "focusmon",       focusmon },
	{ "tagmon",         tagmon },
	{ "zoom",           zoom },
	{ "view",           view },
	{ "viewall",        viewall },
	{ "viewex",         viewex },
	{ "toggleview",     view },
	{ "toggleviewex",   toggleviewex },
	{ "tag",            tag },
	{ "tagall",         tagall },
	{ "tagex",          tagex },
	{ "toggletag",      tag },
	{ "toggletagex",    toggletagex },
	{ "killclient",     killclient },
	{ "quit",           quit },
	{ "setlayout",      setlayout },
	{ "setlayoutex",    setlayoutex },
};
/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
		{ "normbgcolor",        STRING,  &normbgcolor },
		{ "color0",    STRING,  &normbordercolor },
		{ "normfgcolor",        STRING,  &normfgcolor },
		{ "selbgcolor",         STRING,  &selbgcolor },
		{ "color4",     STRING,  &selbordercolor },
		{ "selfgcolor",         STRING,  &selfgcolor },
		{ "borderpx",          	INTEGER, &borderpx },
		{ "snap",          		INTEGER, &snap },
		{ "showbar",          	INTEGER, &showbar },
		{ "topbar",          	INTEGER, &topbar },
		{ "nmaster",          	INTEGER, &nmaster },
		{ "resizehints",       	INTEGER, &resizehints },
		{ "mfact",      	 	FLOAT,   &mfact },
};
