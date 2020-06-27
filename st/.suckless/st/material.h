
static const char *colorname[] = {
	/* 8 normal colors */
	[0] = "#282a2e", /* black   */
  [1] = "#a54242", /* red     */
  [2] = "#8c9440", /* green   */
  [3] = "#de935f", /* yellow  */
  [4] = "#5f819d", /* blue    */
  [5] = "#85678f", /* magenta */
  [6] = "#5e8d87", /* cyan    */
  [7] = "#F9F9F9", /* white   */

  /* 8 bright colors */
  [8]  = "#373b41", /* black   */
  [9]  = "#cc6666", /* red     */
  [10] = "#b5bd68", /* green   */
  [11] = "#f0c674", /* yellow  */
  [12] = "#81a2be", /* blue    */
  [13] = "#b294bb", /* magenta */
  [14] = "#8abeb7", /* cyan    */
  [15] = "#c5c8c6", /* white   *

	[255] = 0,

/* more colors can be added after 255 to use with DefaultXX */
[256]=  "#1d1f21",
//[256]=  "#282B37",
[257]=	"#c4c7d1",
	
};
unsigned int defaultfg = 7;
unsigned int defaultbg = 0;
static unsigned int defaultcs = 15;
static unsigned int defaultrcs = 257;
