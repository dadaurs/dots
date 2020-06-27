/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int fuzzy = 1;                      /* -F  option; if 0, dmenu doesn't use fuzzy matching     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"iosevka:size=20"
};
static const char *prompt="\ ";      /* -p  option; prompt to the left of input field */
static const char *dynamic     = NULL;      /* -dy option; dynamic command to run on input change */
//static const char *colors[SchemeLast][2] = {
	//[>     fg         bg       <]
	//[SchemeNorm] = { "#c2caca", "#0F1C30" },
	//[SchemeSel] = { "#c2caca", "#AF5953" },
	//[SchemeOut] = { "#c2caca", "#97A2A2" },
//};
//static const char *colors[SchemeLast][2] = {
	//[>     fg         bg       <]
	//[SchemeNorm] = { "#c2caca", "#0F1C30" },
	//[SchemeSel] = { "#c2caca", "#EA905D" },
	//[SchemeOut] = { "#c2caca", "#97A2A2" },
//};
//static const char *colors[SchemeLast][2] = {
	//[SchemeNorm] = { "#bdbdbd", "#2E333F" },
	//[SchemeSel]  = { "#000000", "#2E333F" },
	//[SchemeOut]  = { "#ff0000", "#ff0000" },
//};
static const char *colors[SchemeLast][2] = {

	/*     fg         bg       */
	[SchemeNorm] = { "#bbbbbb", "#2B303B" },
	[SchemeSel] = { "#eeeeee", "#807BC0" },
	//[SchemeSel] = { "#eeeeee", "#BF616A" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 7;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
//static const unsigned int border_width = 3;
static const unsigned int border_width = 6;
