/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const char *tagfifo          = "/tmp/dwm_tags"; /*fifo of bar information */ 
static const int barheight          = 15;     /*height of bar*/ 
static const char *sepchar           = "|";
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "monospace:size=10" };
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */

	//{ "feh",          NULL,        NULL,           0,             0, 0, 0,  300, 200, 1300, 700, 2 , 0},
	//{ "mpv",          NULL,        NULL,           0,             0, 0, 0,  300, 200, 1300, 700, 2 , 0},
	//{ "Sxiv",         NULL,        NULL,           0,             0, 0, -1, 300, 200, 1300, 700, 2 , 0},
	//{ "qutebrowser",  NULL,        NULL,      1 << 1,             0, 0, -1, 300, 200, 1300, 700, 2 , 0},
	//{ "emacs@gentoo", NULL,        NULL,      1 << 1,             0, 0, -1, 300, 200, 1300, 700, 2 , 0},
	//{ "surf",         NULL,        NULL,      1 << 1,             0, 0, -1, 300, 200, 1300, 700, 2 , 0},
	//{ "st",           NULL,        NULL,      1 << 1,             0, 1, -1, 300, 200, 1300, 700, 2 , 0},
	//[> class      instance    title       tags mask     isfloating   monitor    float x,y,w,h         floatborderpx<]
	////{ "Gimp",     NULL,       NULL,       0,            1,           -1,        50,50,500,500,        5 },
	////{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1,        50,50,500,500,        5 },
	//{ NULL,           NULL,"scratchpad",        0,                1, 0, 1, 300, 200, 1300, 700, 2, 's' },
	//{ NULL,           NULL,     "music",        0,                1,0, 1, 300, 200, 1300, 700, 2, 'm' },

	{ "feh",          NULL,        NULL,           0,             0, 0,  300, 200, 1300, 700, 2 , 0},
	{ "mpv",          NULL,        NULL,           0,             0, 0,  300, 200, 1300, 700, 2 , 0},
	{ "Sxiv",         NULL,        NULL,           0,             0, 0,  300, 200, 1300, 700, 2 , 0},
	{ "qutebrowser",  NULL,        NULL,      1 << 1,             0, 0,  300, 200, 1300, 700, 2 , 0},
	{ "emacs@gentoo", NULL,        NULL,      1 << 1,             0, 0,  300, 200, 1300, 700, 2 , 0},
	{ "surf",         NULL,        NULL,      1 << 1,             0, 0,  300, 200, 1300, 700, 2 , 0},
	{ "st",           NULL,        NULL,      1 << 1,             0, 1,  300, 200, 1300, 700, 2 , 0},
	/* class      instance    title       tags mask     isfloating   monitor    float x,y,w,h         floatborderpx*/
	//{ "Gimp",     NULL,       NULL,       0,            1,           -1,        50,50,500,500,        5 },
	//{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1,        50,50,500,500,        5 },
	{ NULL,           NULL,"scratchpad",        0,                1, 0,  300, 200, 1300, 700, 2, 's' },
	{ NULL,           NULL,     "music",        0,                1,0,  300, 200, 1300, 700, 2, 'm' },
};


/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define CTRL ControlMask
#define SUPKEY Mod4Mask
#define MODALT Mod1Mask|Mod4Mask

#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {"dmenu_run_history",NULL};
static const char *termcmd[]  = { "st", NULL };

static const char *scratchpadcmd[] = {"s", "st", "-t", "scratchpad", NULL}; 
static const char *musicscratchcmd[] = {"m", "st", "-t", "music" , "-e","ncmpcpp", NULL };
static const char *musiccmd[] = { "$HOME/scripts/mpd/mpdmenu", NULL};
static const char *mutecmd[] = { "$HOME/scripts/keybinds/volume.sh", "toggle", NULL };
static const char *volupcmd[] = { "$HOME/scripts/keybinds/volume.sh", "up", NULL };
static const char *voldowncmd[] = {  "$HOME/scripts/keybinds/volume.sh", "down", NULL };
static const char *urlcmd[] = {"$HOME/scripts/urlhandler.sh", NULL};
static const char *emacscmd[] = {"emacsclient","-nc", NULL};
//static const char *charcmd[] = {"$HOME/.local/bin/charsel", NULL};
static const char *coursecmd[] = {"$HOME/scripts/curcourses", NULL};
static const char *quicktexcmd[] = {"$HOME/scripts/quicktex", NULL};
static const char *clipmenucmd[] = {"clipmenu", NULL};
//static const char *barcmd[] = {"$HOME/scripts/lemonbar/dwm/minbar.sh","toggle", NULL};
//static const char *chth[] = {"$HOME/scripts/chth" ,NULL};
#include <X11/XF86keysym.h>
#include "movestack.c"
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_space,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,         {.f = -0.01} },
	{ MODKEY,                       XK_l,      setmfact,         {.f = +0.01} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	//{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_f,      togglefullscreen, {0} },
	//{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
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
	{ MODKEY,                       XK_grave,  togglescratch,    {.v = scratchpadcmd } },
	{ MODKEY|ShiftMask,             XK_n,      togglescratch,    {.v = musicscratchcmd } },
	{ 0, XF86XK_AudioMute, spawn, {.v = mutecmd } },
	{ 0, XF86XK_AudioLowerVolume, spawn, {.v = voldowncmd } },
	{ 0, XF86XK_AudioRaiseVolume, spawn, {.v = volupcmd } },
	{ MODKEY,                       XK_n,      spawn,            {.v = musiccmd } },
	{ MODKEY,                       XK_o,      spawn,            {.v = urlcmd } },
	{ MODKEY,                       XK_e,      spawn,            {.v = emacscmd } },
	{ CTRL|ShiftMask,               XK_c, spawn,                 {.v = coursecmd } },
	{ CTRL|ShiftMask,               XK_q, spawn,                 {.v = quicktexcmd } },
	{ SUPKEY,                       XK_d,      spawn,            {.v = clipmenucmd } },
	{ MODALT,                       XK_j,      reparent,         {.i =+1} },
	{ MODALT,                       XK_k,      reparent,         {.i =-1} },
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
