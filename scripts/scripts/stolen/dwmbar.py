#!/usr/bin/python2.7
import time
import mpd
import commands

#Current date and time
#Wkday, Month Day HH:MM
date = time.strftime("%a, %b %d %H:%M")

#mpd
mpdPort = 6600;
mpdHost = "localhost"
try:
	mpdConn=mpd.MPDClient()
	mpdConn.connect("localhost", 6600)
	#print("After connect try")
	mpdRunning = True
except:
	mpdInfo = "MPD not running"
	mpdRunning = False

if mpdRunning:
	current = mpdConn.currentsong()
	if current.has_key('artist'):
		a = current['artist']

	if current.has_key('title'):
		t = current['title']

	mpdInfo = "%s - %s" %(a, t)
output = "%s | %s" %(mpdInfo, date)
commands.getoutput('xsetroot -name "{0}"'.format(output))
#print(output)
