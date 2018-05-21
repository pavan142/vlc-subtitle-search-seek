--                 Resume Media Version 3.40
--        VLC Lua Extension by Rocky Dotterer 5/5/2014
--     Last update 9/24/2015 (see change log further down)


-------- user adjustable variables (please use caution!) --------------
-- If you are reading this in the Resume Media....lua file, then
-- changing "simple" or "filename" here will affect the program.

simple = false   -- Set true for simple resume feature. This was
                 -- most useful before VLC 2.2 had a resume feature.
                 -- Resume Media will start with single table and no 
                 -- dialog window. Resume positions will be added or
                 -- updated in the table, applied when media replayed,
                 -- and deleted when media finished.

filename = ""    -- change if you want data files in your own directory.
                 -- example for full path filename (must end in .txt) 
-- Windows: filename = "D:\\Video\\VLC Resume Media\\Resume Media.txt"
-- Linux: filename = "<homedir>/Video/VLC Resume Media/Resume Media.txt"
                 -- the directory must exist and not be write protected

limtables = 50   -- Maximum allowed number of tables (be careful)
autosegs = true  -- set false to prevent search for segments in metadata.
allowosx = false -- set true to experiment with display parameters in osx
                 -- the lua runtime for osx has issues and needs fixing.
                 -- the osx display function further down is osx_display()
-----------------------------------------------------------------------

--[[       please don't change anything below this line

~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
Resume Media displays the saved positions of all media as well as a
bookmark where last played in each table. Media segments can be 
defined without editing your file allowing you to watch or listen 
to your favorite parts. Media can be automatically added or removed 
from a table when the media stops or finishes. Old-style tv video 
ratios can be adjusted without going to the VLC menu each time. 
There are fun settings to sample media for a number of seconds or 
play at different speeds. And more...
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

A table can be used as a playlist for, say, a tv series or a music
album. The resume feature then allows you to play and stop and
quickly resume whichever entries interest you at the time until you
have finally completed the list. Sort the list to see which entries
you have started.

Great for audio books that you have transferred to your storage in
chapters. Never lose your place. Adjust 'rewind' time to your liking
to help re-sync your memory with the story. Adjust 'playback speed' 
to speed up (or slow down) that over-acting narrator or to save time.

Use the segments feature to tag the highlights of a family video.
Then go to the segments list to play whichever highlights that 
friends and relatives are leaning over your shoulder to see.

You can import and save top level playlists or directories into
a table. Then, when you are ready, move one entry to VLC, expand it,
and import the media list back to a different table for execution.

Bookmark features:
The playing media is bookmarked with an '*' symbol.
When finished, the bookmark advances to the next unfinished media.
If all media finished, the bookmark increments to the next media.
There's a convenient button to play the bookmark where you left off.
Play unfinished or whole table with options to randomize and loop.

Installation:
* Designed in Windows. Mostly works in Linux. Does not work in OSX.
See "Mac Attack" and "Licking Linux" near the end of the description.
* If this version is not available in the VLC Addons Manager, you can
install it manually from this Addons site. Open zip file, copy the lua
file to C:\Users\%UserName%\AppData\Roaming\vlc\lua\extensions
or %homedir%/.local/share/vlc/lua/extensions/ for Linux (unhide .local)
Create ..\lua\extensions directory if necessary. Delete old versions.
When installed, restart VLC and check 'Resume Media' in View menu.
(Extensions must be checked each time VLC is opened. It's OK...)
* A Command prompt window will flash in Windows the first time only
to create the data directory ..\vlc\VLC Resume Media\.

Detailed Features and Notes (this acts as the help reference):
Note: The [Play/Options] menu changes while VLC playlist is playing.
* If the VLC playlist is stopped (not playing), then you can click
[Play/Options] > [Add VLC] to add the VLC playlist to current table.
* If the VLC playlist is playing (or paused), then you can click
[Play/Options] > [Position] to add the playing media to the table.
* There's a setting to allow automatic new entries when media stops.
* Click [Play/Options] > [Settings] to access the settings table.
* There is a media-just-started tolerance of 60 seconds, so you have
60 seconds to sample media without saving the stop position.
* When resuming, position will rewind 5 seconds from saved position.
* Settings 'media-just-started' and 'rewind' are adjustable.
* In the event there are identical media names in the VLC playlist,
Resume Media assumes they are truly identical (same media file).
* There's a setting to allow automatic new entries when media stops.
* Operations are performed on current table. Switching tables while
media playing causes the stop position to be updated in the new table.
* Marking a table with '*' will remove media from table when finished.
* The number of tables is adjustable from 1 to 50 tables.
* Higher tables are not deleted when the number of tables is lowered.
* To delete a table datafile, remove all contents and remove mark '*'.
* Combining tables saves the highest position of duplicate entries.
* When sorting by time, 'Finished' media will always be at the bottom.
* You can set media saved positions to 'hh:mm:ss' or to 'Finished'.
* 'Finished' media will not update position unless reset to 'hh:mm:ss'.
* 'Finished' media will remain in any table when replayed to the end.
* You can backup your tables if needed by copying the data directory.
(In the data directory, the table # in each file is the file # plus 1)

Non-media table entries (i.e. directories or playlists) are very
useful for making convenient tables of playlists. Note that the saved
position and bookmark are meaningless for these files and do not
respond as expected.

The occasional user who might open two instances of Resume Media in
two instances of VLC must switch to different tables so that the
instances do not overwrite each other's tables.

Tables are backed up before a session starts. If you make undesirable
changes and need to restore a table, then go to [Settings] and enter:
"restore t1" | "restore t1 t2" | "restore all" , where
t1 = table to restore, t2 = alternate destination, all = all tables.

--- Keys ------------------------------------------------------------
There are three "Key=Value" parameters which can be set for each
media in any table. The two picture keys are described in the Picture
section following this and apply to video only. The third key is:

RMP=% where % is the percent playback speed for video or audio.
A reasonable range for % is 25 to 300 and the default is RMP=100
The motivation for adding the speed key is to allow up or dowm tuning
of an instumental audio to sync it with a live instrument performance.
(See Pitch setting in the Fun Settings section further down.)
* If the Playback Speed setting in the Settings table is set to other
than 100 (also see Fun Settings) then that speed setting overrides the 
individual RMP speed keys for each media.

--- Setting the keys ---
While a media is playing (or paused), go to: 
[Play/Options] > [Keys] to set the keys for media in the current table.
* Spaces are not allowed in "Key=Value".
* To delete a key, enter "Key=" (no value) or remove "Key=" altogether.
* To delete all keys, clear the input line.
* There is one level of [Undo], then [Cancel] will reset the keys to 
the values before [Keys] was pressed.
* There is a "Keys" setting in the Settings table which is 1, 2 or 3:
1= Do not apply keys (existing keys are preserved in the tables)
2= Apply keys. Also, when in the [Keys] input screen, corresponding 
keys which have been placed in the playing media's metadata (explained
further down) will be read from the metadata and placed in the input
box to allow easy "manual" entry of the key values into the table.
3= Apply keys. Also, corresponding keys which have been placed in
the playing media's metadata will be read from the metadata and 
"automatically" entered into the table for that media.
Note: It may take several plays to successfully read the metadata.

--- Putting keys in media file metadata ---
You can place keys (ex. RMP=102) in a media file's metadata comments 
section to save the keys with the media file when not in a table. 
* Changing metadata is easier in Windows. Go to Properties> Details>
Comments. If you select a group of similar files, you can change them
all at once. Remove write-protection first.
* When in the [Keys] or [Segments] screen, you can enter "getallkeys"
in the input line to retrieve all keys (including segment keys) into
the input line for easy transfer to a file's metadata comments section.
* Segments are also keys, but their structure is normally hidden.
Be careful when including segment keys in the metadata, since they can
be long. The limit using Windows properties is ~255 characters.
(Be careful changing metadata using VLC. I have seen media corrupted.)
----------------------------------------------------------------------

--- Picture Adjustment -----------------------------------------------
Users with videos or tv recordings that need picture adjustment might 
be tired of manually adjusting the picture in VLC each time they play.
There are Resume Media keys to adjust aspect-ratio and crop values
automatically while a video is playing.
* Picture keys are RMA=nn:mm and RMC=nn:mm where nn:mm are ratios.
(Ex. RMA=16:11 might make a boxy tv video aspect-ratio more appealing.)
* See the Keys section above to enter keys into the table.
* For technical reasons, application of picture keys is limited to 
single selection plays initiated from any one of the Resume Media play
options. Multiple selections will play normally. Since videos are
usually long, playing one at a time should not be an issue.
----------------------------------------------------------------------

--- Segmenting -------------------------------------------------------
Segmenting of media allows you to set start and stop times and name
the segments for any media (usually video, but audio also). Resume
Media will play the segments while ignoring the other parts.

* Go to the Resume Media Settings and allow segmenting of media.
* Play any media in the current Resume Media table. (Pausing is ok,
since a paused media is still considered to be 'playing'.)
* Now click [Play/Options] > [Segments] to prepare to edit segments.
* Click [Get] without selection to add media position to the input box.
With a selection, [Get] will load existing segment into the input box.
* Segment elements are [start stop name]. Get a start and stop time,
add an optional name, click [Save]. Save order is based on start time.
- The start/stop times will be switched if they are out of order.
- Type 'end' instead of a time to indicate play to end of media.
- The segment name cannot contain parentheses, "(" or ")".
* You can [Delete] unwanted segments.

--- Notes ---
* Segment play is limited to single plays initiated from Resume Media.
Multiple selections will play normally without segments.
* Setting mousewheel to position control in VLC Hotkey Preferences
can make locating start and stop times more convenient.
* There is a Resume Media setting to set the VLC Fullscreen setting.
Use this to keep segment play in a window or fullscreen. An alternate
Fullscreen setting in the VLC Video Menu lasts for one VLC session.
* For consistant window viewing, you might want to consider unchecking
'Resize Interface to Video size' in VLC Interface Preferences.
* By default, the media name will show on a video at the beginning of
each segment. There is a VLC Video Preference setting to turn that off.

*** A little narrative to help explain segmenting ***

When a segmented media is played by itself from Resume Media, an
attempt is made to make the segments behave like a single file. The
segments will play in order and then the media will be marked finished.
The media can be stopped and resumed in any segment. You can click
later in the time line and Resume Media will play the segment closest
to the time clicked. Clicking past the last segment will finish media.
If [^Loopv] selected in [Play More] then the segments will loop.

Note: Resume Media cannot detect if you click earlier on the time line,
so the media will just play from there until it hits the end time of
the segment it was playing. Resume Media can detect When you click 
past the segment end time and thereby decide what should be done next.
Clicking Play in VLC instead of Resume Media will not play segments.

While the segmented media is playing, you can go to the segment list.
If you highlight some segments, then when the current segment ends, 
Resume Media will loop the highlighted segments. This allows you to
dynamically choose which segments will play. Also, clicking later in
the time line (past the segment end) will play the next highlighted
segment instead of the one closest to the time clicked, thus allowing 
you to jump through the highlighted segments. When there are no
highlights or you exit from the segment list, segments play normally.
Be careful not to click [Delete] when segments are highlighted.
----------------------------------------------------------------------

--- Fun Settings -----------------------------------------------------
* "Run time" lets you sample all media for a set number of seconds.
* "Start time" lets you start further into the media. A saved position
will override this value.
* "Playback speed" lets you, say, listen to an audio book faster or
have fun with a video, etc.
* Pitch setting allows the audio pitch to vary or be unaffected when
playback speed is varied. Allows tuning of instrumental audio media.
* Loop setting allows automatic looping when playing from Resume Media.

Ex. Set "Run time" to 5 or 10 and "Playback speed" to 150 to help find
that one song or piano piece out of a 100 you are looking for.
(Use saved positions combined with "Run time" for deep sampling.)

These settings apply to all media while Resume Media open. Have fun!
----------------------------------------------------------------------

--- Mac Attack -------------------------------------------------------
OSX seems to render a dialog window much more loosely and dynamically.
The dialog window starts out large and gets longer with each operation.

The 'growing list' behavior in OSX has been submitted as a defect to
the VLC developers, and accepted. There hasn't been any movement on
fixing issue this since 4/27. The VLC team needs programmers to help.

When (if) the "growing list" issue is fixed, I will continue to work
to make Resume Media for OSX possible.
----------------------------------------------------------------------
  
--- Licking Linux ----------------------------------------------------  
Everything seems to work properly in Linus except segmenting.

Segments do not transition properly in Linux. Leave segmenting off.
I will work to fix this issue. Please let me know if there are
other repeatable issues that you would like me to address. Thanks.
----------------------------------------------------------------------  
  
--- Changelog --------------------------------------------------------
2015-09-24 V3.40
Detect XP in addition to later Windows
Setting to show/hide playlist control buttons in Resume Media.
Setting to always loop selections played from Resume Media.
Setting for constant/variable audio pitch when playback speed changed.
Added key to allow individual media playback speeds.
2015-07-14 V3.38
Fix button-click function re-entry issue for Linux
2015-07-10 V3.37
Now operating system aware. Mostly works in Linux but not in OSX.
Table data moved to "VLC Resume Media" directory in the vlc directory.
Tables backed up before a session and restorable during a session.
2015-07-01 V3.36
Correct media finished flag in segment play
2015-06-30 V3.35
Correct looping issue in segment play
2015-06-30 V3.34
Correct 'run-time' setting behavior.
Segment play order now correct if segments should happen to overlap.
2015-06-18 V3.33
Segments can be dynamically selected for play in the segments list
2015-06-12 V3.32
Improve some behaviors.
2015-05-31 V3.31
Correct label in table view.
2015-05-31 V3.30
Reverse default table behavior to not automatically add/delete media.
Settings can be changed as needed to automate add/delete behavior.
2015-05-28 V3.30 beta1 55803
Introduction of media segmenting.
2015-05-27 V3.23 55668
Correct picture key handling when table order changes.
2015-03-13 V3.22 50813
Use the input box to set picture keys, saved positions and settings.
Change to picture-adjust keys only allowed when video playing.
Setting to suppress automatic new table entry when media stops.
2015-03-24 V3.21 47979
"Playback speed" can now be set without restarting VLC
2015-03-17 V3.20 46639
New settings for "start time", "run time" and "playback speed"
2015-03-15 V3.11
Correct picture adjustment settings altered in V3.10
2015-03-13 V3.10
New setting to close or hide Resume Media when 'X' clicked.
Eliminate one second delay between button clicks.
2014-12-29
Settings table now has its own button in the [Play] menu.
Allow copy as well as move when combining tables.
Improve a few behaviors.
2014-12-23
Display and adjust picture keys for the whole table.
2014-12-21
A manual update will now also update 'Finished' media
Setting to show bookmarked table entries in list of tables.
Advance bookmark when bookmarked media set to 'Finished'.
Setting to allow manual or automatic picture adjustment.
2014-12-10 V3.00
Version 3 with simpler handshaking with VLC.
Bookmark feature added to keep track where last played.
Play Bookmark/Unfinished/Table/Selection with Random/Loop options.
2014-12-06
Revert to version 2.40 due to unresolved issue in version 3.
V2 main menu and other buttons improved.
2014-12-05 V3.00
Bookmark and autoplay features added.
Table can be randomized manually or in autoplay.
Main menu and other buttons improved.
2014-11-26
If media is playing, clicking [Import/Play] will now do a manual
update of the playing position without stopping the media.
Improved text-reading economy using patterns.
2014-11-19
Cosmetic changes only. Modified a few labels. More intuitive.
'Keep Media' mark is now '*' instead of 'K'.
2014-11-18 V2.40
User settings (variables) are now adjusted in the dialog window.
2014-11-11
Removed the "instances/exclude/busy" complexity and issues, thus
simplifying Resume Media and the dialog for the majority of users.
2014-11-09 V2.30
Moved user variables to top of download file for easy adjustment.
New variables to adjust size of table dialog window.
2014-10-28
Set variable "simple = true" to force a single hidden table with no
table dialog window. Control media and resume from the VLC playlist.
2014-10-09
Rewind 5 seconds when resuming (adjustable variable 'rewind').
Selection no longer needed before entering Set/Delete mode.
2014-07-03
Set default media-just-started to 60 rather than 30 seconds.
Set media completed flag to 'Finished' rather than 00:00:01.
You can now reset media to 00:00:00 or set to 'Finished.'
2014-06-18
Amend the previous update to include the case where the media is paused.
2014-06-16
If the table dialog 'Play' button is clicked while media is playing, the media
stop position will now update before selected entries are enqueued in VLC.
One click can stop/enqueue or enqueue/play but not stop/enqueue/play.
2014-06-12
Allow media to remain in an excluded table when completed.
Set X for normal exclude or K to keep media with time reset to 00:00:01.
2014-06-11
Disallow automatic resume if Resume Media is opened while media is
playing, because the next stop event is undetectable in this case.
Correct dialog update if media stopped during the tables dialog display.
Correct open table option broken in last update.
2014-06-09
Refine the media detection to eliminate spurious updates.
A few other minor improvements.
2014-06-01
Resume Media will now open even if all tables are busy or excluded.
This should be rare, but it allows recovery if tables are orphaned.
2014-05-31
Message saying that busy tables cannot be combined.
2014-05-30
Correct multiple-selection delete and move operations.
2014-05-25 V2.20
Support for multiple tables. Entries can be sorted by time or name.
2014-05-17 V2.10
Add ability to rearrange table and to import the VLC playlist.
----------------------------------------------------------------------

Uses input_changed() and meta_changed() functions called by VLC
to capture media name and stop position 
The reliability of this program depends on VLC calling one of
these functions with position data when media started/stopped
--]]


-------------- many (not all) global variables ------------------------

names = {}       -- table of media metadata/file names played and stopped
times = {}       -- stopped position times of media in seconds
paths = {}       -- full file path in %-coded uri/url format
parms = {}       -- addition parameters like aspect-ratio and crop
len = 0          -- table length
endtol = 10      -- end-of-media interval. Don't resume too close to end
infoline   = "<< This file generated by 'VLC Resume Media V3.lua' >>"
begintol = 60    -- media-just-starting between 2 and 120 sec
rewind = 5       -- seconds to back-up when resuming (0 to 120 sec)
tablenum = 1     -- current table
maxtables = 10   -- number of tables between 1 and limtables
starttable = 1   -- starting table between 1 and maxtables
savestyle = 1    -- 1=separate files 2=single file for all tables
showmark = 1     -- =2 to show bookmarked media in tables list
allowkeys = 1    -- =2,3 to allow adjustment keys (see description)
closehide = 1    -- when clicking "X", 1=close 2=hide Resume Media
starttime = 0    -- start-time from config file vlcrc
runtime = 0      -- run-time from config file vlcrc
playspeed = 100  -- playback speed (%) from config file vlcrc
timestretch = 2  -- pitch 1=changes 2=unchanged with playback speed
blocknew = 2     -- 1=allow 2=block new table entry when media stops
segments = 1     -- 2=allow segmenting of media
segsb = {}       -- segment starting times (secs)
segse = {}       -- segment ending times (secs)
segsn = {}       -- segment names (optional)
nsegs = 0        -- number of segments
maxsegs = 100    -- 100 segments?  really?
iseg = 0         -- segment that is playing
segcnt = 0       -- the number of segments played
doingsegs =false -- actively playing segments
fullscreen = 1   -- 1=start video in VLC window, 2=start fullscreen
alwaysloop = 1   -- 2=always loop the VLC playlist
stopbutton = 2   -- 1=hide 2=show stop button
                 -- width and height numbers are VLC units
listwidth = 7    -- dialog table width,  min  4 to max 40 
listheight = 35  -- dialog table height, min 10 to max 70   

                --   options (line 2 of file)
optns = {}       -- comma separated options in line 2 of data file
prevostime = 0   -- last time file closed
filelocked = 2   -- =2 means media will stay in table when finished
bookmark = ""    -- bookmark '*' at last/next media
filelock = {}    -- filelocked flag for all tables
bkmarknum = {}   -- bookmarks for all tables

                --   dialog modes and mode flags
normal = true      ;  setnormal = 1
modify = false     ;  setmodify = 2  
sorttn = false     ;  setsorttn = 3
movetb = false     ;  setmovetb = 4 
playmenu = false   ;  setplaymenu = 5 
dotables = false   ;  setdotables = 6
keepmode = false   ;  setkeepmode = 7
combineyn = false  ;  setcombineyn = 8
variables = false  ;  setvariables = 9
randomize = false  ;  setrandomize = 10
moremenu = false   ;  setmoremenu = 11
manualupd = false  ;  setmanualupd = 12
pickeys = false    ;  setpickeys = 13
segkeys = false    ;  setsegkeys = 14

                --   dialog button labels
modifylbl = "Modify"
arrangelbl = "Arrange"
sortlbl = "^ Sort v"
movelbl = "^ Move v"
randlbl = "^ Random v"
playlbl = "Play"
playoptlbl = "Play/Options"
removelbl = "Remove"
startlbl = "hhmmss"
finishlbl = "Finished"
yeslbl = "Yes"  ;  nolbl = "No"
positionlbl = "Position"
keyslbl = "Keys"
segmentsbtn = "Segments"
getsellbl = "Get Selection"
setsellbl = "Set Selection"
keylistlbl = "Key List"
cancellbl = "Cancel"
undolbl = "Undo"
toplbl = "Top"  ;  botlbl = "Bottom"
mixedlbl = "Mixed"
donelbl = "Done"
tableslbl = "Tables"
openlbl = "Open"
locklbl = "Delete Mode"
alocklbl = "* Delete Mode"
combinelbl = "Combine"
move2lbl = "Move" ; copylbl = "Copy"
backlbl = "Back"
namelbl = "Name"
timelbl = "Time"
increaselbl = "   >>   "  ; decreaselbl = "   <<   "
incbyonelbl = "    >    "
addvlclbl = "Add VLC"
playmorelbl = "Play More"
playmarklbl = "* Play One"
settingslbl = "Settings"
nonelbl = "^ None v"
unfinishedlbl = "^ Unfinished v"
tablelbl = "^ Table v"
selectionlbl = "^ Selection v"
inorderlbl = "^ In Order v"
randomlbl = "^ Random v"
nolooplbl = "^ No loop v"
looplbl = "^ Loop v"
getbtn = "Get"
savebtn = "Save"
deletebtn = "Delete"

                --   dialog message labels
--normallbl = "<font size='+2' face='Arial Narrow'>Click ["..playoptlbl.."] with a selection to immediately play selection.</font>"
normallbl = "Click ["..playoptlbl.."] with a selection to immediately play selection."
normal2lbl = "Click ["..playoptlbl.."] to add the VLC playlist to the table."
playinglbl = "Click ["..playoptlbl.."] for currently playing media options."
setdellbl = "Set selection to hhmmss | 'Finished' or remove selection."
sorttnlbl = "Sort ascending or descending (toggle)"
movetblbl = "Move selection to top or bottom"
randomizelbl = "Randomize table with 'Finished' media [Mixed] in or at [Bottom]"
getplayllbl = "Import playlist . Play More menu . Play bookmark '*'"
dotableslbl = "[Delete Mode] governs table behavior when media finishes."
notableslbl = "Cannot change tables while playing segments."
combineynlbl = "Combine selected tables into table "  -- add table #
tabletitle = "Tbl #    # Entries    First Entry"
btabletitle = "Tbl #    # Entries    Bookmarked Entry"
keepmodelbl = "Remove media from selected tables when finished? (Mark Tbl# *)"
variableslbl = "Select a variable to adjust. Input is optional."
manualupdlbl = "[Position] manually updates position of playing media in table."
manualup2lbl = "Update position and/or picture"
segmentslbl = "Edit segments for: "
modparmslbl = "Space after '=' resets that key. Blank input resets both keys."
moremenulbl = "Toggle options then click [Play]."
xcancel = "Cancel play"
xunfinished = "Play unfinished media"
xtable = "Play the whole table"
xselection = "Play the selection"
xinorder = "in order"
xrandom = "randomly"
xloop = "and loop"

---------------- It all starts here ------------------------

function activate()

    local osx = allowosx and sys()=="osx"  -- allowosx lets max users experiment
    if not (sys()=="win" or sys()=="lin" or osx) then
      dlg = vlc.dialog("Resume Media")
      lbl = dlg:add_label("This version runs in Windows/Linux. "..
                          "Click 'X' to close.") 
      return
    end  
  
    locatefiles()         -- prepare the data location
    backuptables()        -- in case user makes big mistake
    if simple then
      maxtables = 1       -- ok, only one table
      starttable = 1
      blocknew = 1        -- enter newly stopped media into the table
    else
      get_vars()            -- get and check user variables
      restoreconfig()
    end
    tablenum = starttable
    filename = getfilename(tablenum)      -- load table
    read_names(false)
    if sys()=="osx" then osx_display() else make_display() end
    if simple then      
      filelocked = 1      -- allow finished media to delete from table
      dlg:hide()          -- hide the dialog in simple mode
    end
end

function make_display()
                          --  non-osx display dialog

    dlg = vlc.dialog("Resume Media Table "..tablenum)

--        (..., i, j, k, l) = (..., left, down, width, height)

    ld = 3   -- list down position
    lw = listwidth
    lh = listheight

    hiddenspacer = dlg:add_image("Esha AR.jpg",lw+1,lh,1,1) -- this allows list sizing
    list = dlg:add_list(1,ld,lw,lh)
    label_msg = dlg:add_label("",1,lh+3,4,1)     -- ("",1,lh+3,lw,1) 
    input    = dlg:add_text_input("",1,lh+10,4,1)
    button = {}
    button[1] = dlg:add_button("", click_button1,1,lh+11,1,1)
    button[2] = dlg:add_button("", click_button2,2,lh+11,1,1)
    button[3] = dlg:add_button("", click_button3,3,lh+11,1,1)
    button[4] = dlg:add_button("", click_button4,4,lh+11,1,1)
    if stopbutton == 2 then
      button[5] = dlg:add_button("Pause", click_button5,1,lh+12,1,1)
      button[6] = dlg:add_button("|<<", click_button6,2,lh+12,1,1)
      button[7] = dlg:add_button("Stop", click_button7,3,lh+12,1,1)
      button[8] = dlg:add_button(">>|", click_button8,4,lh+12,1,1)
    end
    setdlgmode(setnormal)
        -- there seems to be an issue where a click function is called twice
        -- with a single click. uses lastclicktime to slow the calling process
    lastclicktime = os.clock()
    del = .2     -- do not allow click function re-entry before this time
    if sys() == "lin" then del = 0 end  -- not used, see set_button()
end

function osx_display()
                          --  osx display dialog

    dlg = vlc.dialog("Resume Media Table "..tablenum)

-- osx users who want to experiment to get Resume Media working on Macs:
-- set "allowosx = true" at the top of this file to force Resume Media to run.
-- this is for tinkerers only. don't get mad at anyone. back up your lua file.
-- experiment with changing i,j,k,l,ld,lw,lh to get a working display.
-- i,j,k,l are the 4 integers at the end of each widget creation below.
-- these integers are weak placement suggestions to the VLC compiler.
--

--     dlg.add_xxxx(..., i, j, k, l) = (..., left, down, width, height)
--        xxxx = label, button, input, list
--        the list widget has some real problems in osx - good luck

--    for osx, I tried placing the buttons and label above the list widget
--    to help keep the list issues from affecting the buttons.
--    compare with windows display creation function above this one.

--    the functions which alter the list are list_update, tables_update and
--    keys_update further down. The list keeps growing in osx, so I changed
--    code to delete the list and re-create it in osx to limit growth.
--    ld, lw, lh are used in those functions also to re-create the list

    ld = 5   -- list down position
    lw = 4   -- list width
    lh = 3   -- list height
    
--    the hiddenspacer below is a trick which works in windows to allow sizing
--    of the Resume Media display. In osx the dummy image is not hidden and
--    affects the display differently, so it has been commented out here.

--    hiddenspacer = dlg:add_image("",lw+1,lh,1,1) -- this allows list sizing
    input    = dlg:add_text_input("",1,1,4,1)
    label_msg = dlg:add_label("",1,2,4,1)     -- ("",1,lh+3,lw,1) 
    button = {}
    button[1] = dlg:add_button("", click_button1,1,3,1,1)
    button[2] = dlg:add_button("", click_button2,2,3,1,1)
    button[3] = dlg:add_button("", click_button3,3,3,1,1)
    button[4] = dlg:add_button("", click_button4,4,3,1,1)
    if stopbutton == 2 then
      button[5] = dlg:add_button("Pause", click_button5,1,4,1,1)
      button[6] = dlg:add_button("|<<",   click_button6,2,4,1,1)
      button[7] = dlg:add_button("Stop",  click_button7,3,4,1,1)
      button[8] = dlg:add_button(">>|",   click_button8,4,4,1,1)
    end
    list = dlg:add_list(1,ld,lw,lh)
    setdlgmode(setnormal)
        -- there seems to be an issue where a click function is called twice
        -- with a single click. uses lastclicktime to slow the calling process
    lastclicktime = os.clock()
    del = .2     -- do not allow click function re-entry before this time
end

------------------------- Update Functions ------------------------

-- input_changed possibly called by VLC at begin or end of playlist.

function input_changed() 
    inpt = vlc.object.input()
    if inpt == nil then return end   -- just in case
    state = "start"     --
    check_names()    
end

-- meta_changed called a bunch of times with state = 2 and several
-- times with state = 1 (near start) and only once with state = 4 (stop)

function meta_changed()  
    inpt = vlc.object.input()
    if inpt == nil then return end   -- just in case
    stst = vlc.var.get(inpt, "state") -- 1=start 4=stop
    autoupdate()    -- try to set keys from meta data
    segsupdate()    -- try to set segment keys from meta
--    set_vout()    -- try this in VLC 3 (see playstuff)
    adjustspeed()   -- check playback speed settings and keys
    if stst == 1 then
      if normal then label_msg:set_text(playinglbl) end
      state = "start"      
      check_names()
    elseif stst == 2 then  -- may occur many times
      if normal and label_msg:get_text() ~= playinglbl then
        label_msg:set_text(playinglbl)  -- only do once
      end
    elseif stst == 4 then
      if manualupd then setdlgmode(setnormal) end
      if normal then label_msg:set_text(normallbl) end
      state = "stop"
      if next_segment() then return end
      restoreconfig()
      check_names()
    end
end

manual = false
function manual_check(doit)       -- save position or check playing
    inpt = vlc.object.input()  
    stat = vlc.playlist.status()
    if inpt ~= nil and (stat == "playing" or stat == "paused") then
      if doit then      -- do it or just check if playing
        state = "stop"  
        manual = true
        check_names()   -- possible update before clearing playlist
        manual = false
      end 
      return true
    end
    return nil
end

function check_names()  -- check for playlist input changes
    if tablenum == 0 then return end  -- we're in variables table
    nam = vlc.input.item():name()
    uri = vlc.input.item():uri()
    dur = vlc.input.item():duration()  -- end of media
    tim = vlc.var.get(inpt, "time") -- seconds from beginning
    fin = dur - endtol  -- end-of-media tolerance position
    if fin < begintol then -- short media
      if state == "start" then
        pos = "begin"
      else
        pos = "end"   
      end
    elseif tim < begintol then
      pos = "begin"
    elseif tim < fin then
      pos = "mid"
    else
      pos = "end"
    end
    update_table()    -- now update the current table
end

function update_table()
    idx = find_in_table(nam)  -- nil if not in table
    updatedlg = false   

  --     logic table
  --  if media  is in table and just started playing then
  --     move to saved position (that's the whole idea!!!)
  --  if media  is in table and had been playing awhile then
  --     update the saved position
  --  if media  is in table and at the end then
  --     remove from table (or reset to 00:00:01 meaning 'Finished')
  --  if media not in table and just started playing then
  --     do nothing (no need to save a new starting media)
  --  if media not in table and had been playing awhile then
  --     add the media and position to the tables

    if idx then                   -- in table?
      if state == "start" then    -- only change if starting
        if times[idx] >= 2 then   -- time=1 is media finished flag
          backoff = times[idx] - rewind
          if backoff < 0 then backoff = 0 end
          vlc.var.set(inpt, "time", backoff) -- resume!!!!!!!!
        end
        if bookmark ~= nam then
          bookmark = nam        -- update bookmark '*' in table
          updatedlg = true 
        end
      elseif (pos=="mid" and times[idx]==0) or   -- first stop update
             (pos~="end" and times[idx]>=2) or   -- other stop updates
             (manual and tim>=2) then            -- manual update
        times[idx] = tim            -- update stopped position
        updatedlg = true            -- change so update dialog 
      elseif pos == "end" then      -- keep or delete
        if times[idx] ~= 1 then     -- keep or delete
          if filelocked == 2 then   -- keep media entry (K)
            times[idx] = 1          -- 1 sec = media completed flag
          else
            table.remove(names,idx)
            table.remove(times,idx)
            table.remove(paths,idx)
            table.remove(parms,idx)
            len = len - 1
          end
        end
        findbookmark(true)          -- next media for playing   
        updatedlg = true            -- change so update dialog 
      end
    elseif (state=="stop" and pos=="mid" and blocknew==1) or 
           (manual and tim>=2) then  
      table.insert(names,1,nam)    -- add stopped name
      table.insert(times,1,tim)    -- add stopped position
      table.insert(paths,1,uri)    -- add uri/path
      table.insert(parms,1, "")    -- add empty parms
      len = len + 1       
      updatedlg = true             -- change so update dialog 
      bookmark = names[1]          -- update playing 
    end

    if updatedlg then              -- update the dialog
      filename = getfilename(tablenum)
      write_names()
      list_update() 
    end
end

function find_in_table(nam)
    idx = nil
    if len > 0 then
      for i = 1, len do
        if names[i] == nam then
          idx = i
          break
        end
      end
    end
    return idx  -- nil if not in table
end

function find_playing_media_in_table()
    local inpt, nam
    inpt = vlc.object.input()
    if inpt == nil then return nil end
    nam = vlc.input.item():name()
    if nam == nil then return nil end
    return find_in_table(nam)
end
  
--------------------- bookmark functions ------------------
local function z______marks______() end   -- spacer in outline

function findbookmark(inc)  -- make sure valid or move to next
    local ip = ibookmark(bookmark)
    local looped = false
    local done = allfinished()
    if len==0 then             -- empty table
      bookmark = ""
      return 
    elseif bookmark=="" or ip==0 then  
      ip = 1             -- nothing playing so point to first
    elseif state == "start"  or not inc then
      return             -- ok to bookmark starting media
    else                 -- checking the next
      ip = ip + 1
      if ip > len then
        ip = 1
        looped = true  -- we looped to top of table
      end
    end
        -- ok, now we have at least one media and a valid ip
        -- now check finished media
    if not done then         -- find next unfinished
      if times[ip]==1 then  -- finished?
        local i
        for i = 1, len do     -- oops need to find unfinished
          ip = ip + 1
          if ip > len then ip = 1 end
          if times[ip] ~= 1 then break end -- gotta be one
        end
      end
    end
    bookmark = names[ip]          -- ok we got next playing
end

function allfinished()         -- true if all media finished
    local i 
    for i = 1, len do
      if times[i] ~= 1 then return false end
    end
    return true
end

function ibookmark(s)
    local i = find_in_table(s)
    if i then return i else return 0 end
end

function nbookmark(i)
    local n = names[i]
    if n then return n else return "" end
end

------------------------ dialog functions -------------------
local function z______dialog______() end   -- spacer in outline

-- the lua runtime has a button click re-entry issue. In Windows,
-- a click delay works (see make_display() and click() functions.
-- In Linux, os.clock() is not as accurate so, the "delete and
-- re-create button" method is used to solve the re-entry issue.
function set_button(btn, text)
    local i ; local btext = {}
    if sys() == "lin" then      -- delay method doesn't work in Linux  
      for i = 1, 4 do           -- so delete and re-create buttons
        btext[i] = button[i]:get_text()
--        dlg:del_widget(button[i])      -- may not be necessary
      end
      btext[btn] = text   -- new text
      button[1] = dlg:add_button(btext[1], click_button1,1,lh+11,1,1)
      button[2] = dlg:add_button(btext[2], click_button2,2,lh+11,1,1)
      button[3] = dlg:add_button(btext[3], click_button3,3,lh+11,1,1)
      button[4] = dlg:add_button(btext[4], click_button4,4,lh+11,1,1)
    else                         -- windows and osx
      button[btn]:set_text(text) 
    end
end

function setdlgmode(flag)        -- set dialog
    if not dlg then return end
    normal = false
    modify = false
    movetb = false
    playmenu = false
    dotables = false
    combineyn = false
    sorttn = false
    keepmode = false
    variables = false
    manualupd = false
    randomize = false
    moremenu = false
    pickeys = false
    segkeys = false
    if flag~=setpickeys then input:set_text("") end -- clear
    if setnormal == flag then
      normal = true
      dlg:set_title("Resume Media Table "..tablenum)
      list_update()
      if manual_check(false) then  -- playing?
        label_msg:set_text(playinglbl)
      elseif len == 0 then
        label_msg:set_text(normal2lbl)
      else
        label_msg:set_text(normallbl)
      end
      set_button(1, modifylbl)
      set_button(2, arrangelbl)
      set_button(3, playoptlbl)
      set_button(4, tableslbl)
    elseif setmodify == flag then
      modify = true
      label_msg:set_text(setdellbl)
      input:set_text("000000")
      set_button(1, startlbl)
      set_button(2, finishlbl)
      set_button(3, removelbl)
      set_button(4, donelbl)
    elseif setsorttn == flag then
      sorttn = true
      label_msg:set_text(sorttnlbl )
      set_button(1, timelbl)
      set_button(2, namelbl)
      set_button(3, donelbl)
      set_button(4, sortlbl)
    elseif setmovetb == flag then
      movetb = true
      label_msg:set_text(movetblbl)
      set_button(1, toplbl)
      set_button(2, botlbl)
      set_button(3, donelbl)
      set_button(4, movelbl)
    elseif setrandomize == flag then
      randomize = true
      label_msg:set_text(randomizelbl)
      set_button(1, mixedlbl)
      set_button(2, botlbl)
      set_button(3, donelbl)
      set_button(4, randlbl)
    elseif setplaymenu == flag then
      playmenu = true
      label_msg:set_text(getplayllbl )
      set_button(1, addvlclbl)
      set_button(2, playmorelbl)
      set_button(3, playmarklbl)
      set_button(4, settingslbl)
    elseif setmoremenu == flag then
      moremenu = true
      set_button(1, selectionlbl)
      set_button(2, inorderlbl)
      set_button(3, nolooplbl)
      set_button(4, playlbl)
      makemorelabel()
    elseif setdotables == flag then
      dotables = true
      dlg:set_title("Resume Media Tables (Tbl #"..tablenum.." open)")
      tables_update()
      label_msg:set_text(dotableslbl)
      set_button(1, openlbl)
      if deltables == 0 then
        set_button(2, locklbl)   -- no asterisk if no 'keep' tables
      else
        set_button(2, alocklbl)  -- asterisk in button label
      end
      set_button(3, combinelbl)
      set_button(4, backlbl)
    elseif setcombineyn == flag then
      combineyn = true
      label_msg:set_text(combineynlbl..tablenum.." ?")
      set_button(1, move2lbl)
      set_button(2, copylbl)
      set_button(3, cancellbl)
      set_button(4, "        ")
    elseif setkeepmode == flag then
      keepmode = true
      label_msg:set_text(keepmodelbl)
      set_button(1, yeslbl)
      set_button(2, nolbl)
      set_button(3, cancellbl)
      set_button(4, "        ")
    elseif setvariables == flag then
      variables = true
      dlg:set_title("Resume Media Settings")
      open_table(0)      -- open the settings table
      set_fullscreen()   -- set fullscreen same as VLC preferences
      list_update()
      label_msg:set_text(variableslbl)
      set_button(1, decreaselbl)
      set_button(2, increaselbl)
      set_button(3, incbyonelbl)
      set_button(4, donelbl)
    elseif setpickeys == flag then
      pickeys = true
      parmsave = copy_var(parms)
      keys_update()
      label_msg:set_text(modparmslbl)
      set_button(1, getsellbl)
      set_button(2, setsellbl)
      set_button(3, cancellbl)
      set_button(4, donelbl)
    elseif setsegkeys == flag then
      segkeys = true
      keyidx = find_playing_media_in_table()
      keynam = names[keyidx]
      if not doingsegs then get_segments(keyidx) end
      segkeys_update()
      local seg = "("..iseg..") "
      label_msg:set_text(segmentslbl..seg..names[idx])
      set_button(1, getbtn)
      set_button(2, savebtn)
      set_button(3, deletebtn)
      set_button(4, donelbl)
    elseif setmanualupd == flag then
      manualupd = true
      label_msg:set_text(manualupdlbl)
      set_button(1, positionlbl)
      if allowkeys > 1
        then set_button(2, keyslbl)
        else set_button(2, "        ") end
      if segments == 2 
        then set_button(3, segmentsbtn)
        else set_button(3, "        ") end
      set_button(4, donelbl)
    end
end

function makemorelabel()
    local btn1 = button[1]:get_text()
    local btn2 = button[2]:get_text()
    local btn3 = button[3]:get_text()
    local lbl = xunfinished
    if btn1 == tablelbl then lbl = xtable end
    if btn1 == selectionlbl then lbl = xselection end
    if btn2 == inorderlbl then
      lbl = lbl.." "..xinorder
    else
      lbl = lbl.." "..xrandom
    end
    if btn3 == looplbl then
      lbl = lbl.." "..xloop
    else
      lbl = lbl.." ".."once"
    end
    if btn1 == selectionlbl then
      lbl = lbl.." ".."(no selection cancels play)"
    end
    label_msg:set_text(lbl)
end

function makepicinput()       -- show media keys from table/meta
    local playi, nam, rma, rmc, rmp, crma, crmc, crmp
    playi = nil
    nam = vlc.input.item():name()
    if nam ~= nil then playi = find_in_table(nam) end
    if playi == nil then
      rma = getparm(parms[playi],"RMA")
      rmc = getparm(parms[playi],"RMC")
      rmp = getparm(parms[playi],"RMP")
    end
    if rma == nil then rma = "" end
    if rmc == nil then rmc = "" end
    if rmp == nil then rmp = "" end
    crma, crmc, crmp = getmeta()
    if crma ~= nil then rma = crma end
    if crmc ~= nil then rmc = crmc end
    if crmp ~= nil then rmp = crmp end
    input:set_text("RMA="..rma.."  RMC="..rmc.."  RMP="..rmp)
end

function click_button1()   -- Set/Delete, Yes, '00:00:00', Open
    if os.clock() - lastclicktime < del then return end -- no double click
    lastclicktime = os.clock()

    if normal then
      setdlgmode(setmodify)
    elseif modify then
      set_time(0)                 -- reset time to zero
    elseif sorttn then
      sort_by_time()
    elseif movetb then
      move_top()
    elseif randomize then
      randomize_table("mix")
    elseif playmenu then
      getplaylist()
      setdlgmode(setnormal)
    elseif dotables then
      if is_selection() then 
        if open_table(nil) then setdlgmode(setnormal) end
      else
        setdlgmode(setnormal)
      end
    elseif combineyn then
      combine_tables(true)
    elseif keepmode then
      lock_table(0)
    elseif variables then
      adjust_vars("dec")
    elseif manualupd then
      manual_check(true)  -- update position if media playing
    elseif moremenu then
      local button1 = button[1]:get_text()
      if button1 == unfinishedlbl then
        set_button(1, tablelbl)
      elseif button1 == tablelbl then
        set_button(1, selectionlbl)
      elseif button1 == selectionlbl then
        set_button(1, unfinishedlbl)
      end
      makemorelabel()
      if is_selection() then list_update() end -- reset selection
    elseif pickeys then
      get_parms()
    elseif segkeys then
      get_timeorseg()
    end
end

function click_button2()   -- Sort/Move, No, 'Finished', Keep Media
    if os.clock() - lastclicktime < del then return end -- no double click
    lastclicktime = os.clock()

    if normal then
      if is_selection() then
        setdlgmode(setmovetb)
      else
        setdlgmode(setsorttn)
      end
    elseif modify then
      set_time(1)                 -- set time to 1 (finished)
    elseif sorttn then
      sort_by_name()
    elseif movetb then
      move_bottom()
    elseif randomize then
      randomize_table("bot")
    elseif playmenu then
      setdlgmode(setmoremenu)
    elseif dotables then
      setdlgmode(setkeepmode)
    elseif combineyn then
      combine_tables(false)
    elseif keepmode then
      lock_table(2)
    elseif variables then
      adjust_vars("inc")
    elseif manualupd then
      if allowkeys>1 then 
        setdlgmode(setpickeys) 
        makepicinput() 
      end
    elseif moremenu then         -- toggle looping
      local button2 = button[2]:get_text()
      if button2 == inorderlbl then
        set_button(2, randomlbl)
      elseif button2 == randomlbl then
        set_button(2, inorderlbl)
      end
      makemorelabel()
    elseif pickeys then
      set_parms()
    elseif segkeys then
      save_seg()
    end
end    

function click_button3()   -- Import/Play, Delete, Done, Combine, Cancel
    if os.clock() - lastclicktime < del then return end -- no double click
    lastclicktime = os.clock()

    if normal then
      if manual_check(false) then  -- check if media playing or paused
        setdlgmode(setmanualupd) 
      elseif is_selection() then 
        playstuff()
      else
        setdlgmode(setplaymenu)
      end
    elseif playmenu then
      if manual_check(false) then  -- check if media playing or paused
        setdlgmode(setmanualupd) 
      else
        playstuff() 
        setdlgmode(setnormal)
      end
    elseif moremenu then         -- toggle looping
      local button3 = button[3]:get_text()
      if button3 == nolooplbl then
        set_button(3, looplbl)
      elseif button3 == looplbl then
        set_button(3, nolooplbl)
      end
      makemorelabel()
    elseif modify then
      remove()
    elseif combineyn then
      setdlgmode(setdotables)     -- reset
    elseif dotables then
      setdlgmode(setcombineyn)
    elseif keepmode then
      setdlgmode(setdotables)  -- cancel
    elseif variables then
      adjust_vars("one")  -- increment by one
    elseif manualupd then
      if segments>1 and find_playing_media_in_table()~=nil then 
        setdlgmode(setsegkeys)
      end
    elseif pickeys then
      if button[3]:get_text() == undolbl then
        parms = copy_var(parmsundo)
        set_button(3, cancellbl)
        keys_update()
      else   -- cancellbl
        parms = copy_var(parmsave)
        setdlgmode(setnormal)
      end
    elseif segkeys then
      delete_seg()
    else  -- all other modes
      setdlgmode(setnormal)
    end
end

function click_button4()  -- Tables, Done, Back
    if os.clock() - lastclicktime < del then return end -- no double click
    lastclicktime = os.clock()

    if normal then
      if doingsegs then 
        label_msg:set_text(notableslbl) -- no switch while segging
      else
        setdlgmode(setdotables)
      end
    elseif playmenu then
      setdlgmode(setvariables)   -- we're adjusting variables
    elseif modify or dotables or pickeys or segkeys then
      setdlgmode(setnormal)
    elseif sorttn then
      setdlgmode(setmovetb)
    elseif movetb then
      setdlgmode(setrandomize)
    elseif randomize then
      setdlgmode(setsorttn)
    elseif variables then
      filename = getfilename(tablenum)  -- should be = 0
      write_names()            -- save variables to table Vars
      tablenum = filenumsave    -- load previous table
      if tablenum > maxtables then tablenum = 1 end  -- oops
      filename = getfilename(tablenum)
      read_names(false)
      setdlgmode(setnormal)    -- back to normal
    elseif moremenu then
      if manual_check(false) then  -- check if media playing or paused
        setdlgmode(setmanualupd) 
      else
        playstuff()
        setdlgmode(setnormal)
      end
    elseif manualupd then
      setdlgmode(setnormal)
    elseif keepmode then      -- do nothing button, use for testing
      -- put test code here
      vlc.var.set(vlc.object.vout(),"aspect-ratio","16:11")  --"crop","16:9"
      msg("X")
    end
end

function click_button5()  -- Stop the VLC Playlist
    vlc.playlist.pause() --stop()
end

function click_button6()  -- Stop the VLC Playlist
    vlc.playlist.prev() --stop()
end

function click_button7()  -- Stop the VLC Playlist
    vlc.playlist.stop() --stop()
end

function click_button8()  -- Stop the VLC Playlist
    vlc.playlist.next() --stop()
end

function list_update()           -- redisplay
    local i, t, v, name, mark, segs, sn
    if not dlg then return end
      -- don't update in tables mode
    if dotables or keepmode or combineyn or 
       pickeys or segkeys then return end
    if sys() == "osx" then
      dlg:del_widget(list)      -- list grows in osx, so delete
      list = dlg:add_list(1,ld,lw,lh)         -- then re-create
    else
      list:clear()        -- ok to just clear in windows, linux
    end
    if len == 0 then return end
    if tablenum == 0 then
--      local yn = {"N","Y"}
      for i = 1, len do          -- make table of settings
        t = times[i]
        v = t
--        if i==8 then v = yn[t+1] end 
        if t < 100 then v = "  "..v end
        if t < 10 then v = "  "..v end
        list:add_value(v.."\t"..names[i], i)
      end
    else    -- normal table
      findbookmark(false)    -- point to playing/next media   
      mark = ibookmark(bookmark)
      for i = 1, len do          -- make table of media
        t = hhmmss(times[i])
        if t == "00:00:01" then t = "Finished" end
        if i==mark then t=t.." *  " else t=t.."    " end
        name = names[i]
        segs = count_segs(i)
        if segs > 0 and segments == 2 then
          if doingsegs and i==mark and 
             nsegs>0 and iseg>0 and iseg<=nsegs then 
            sn = trim(segsn[iseg])
            if sn=="" then 
              sn = "-"..hhmmss(segse[iseg])
            end
            name = "("..iseg..": "..sn..") "..name
          else 
            name = "("..segs..") "..name
          end
        end 
        list:add_value(t..name, i)
      end
    end
end

function tables_update()          -- show tables in dialog
    if not dlg then return end
    get_tables()
    if sys() == "osx" then
      dlg:del_widget(list)      -- list grows in osx, so delete
      list = dlg:add_list(1,ld,lw,lh)         -- then re-create
    else
      list:clear()        -- ok to just clear in windows, linux
    end
    if lent > 0 then 
      if showmark == 2 then
        list:add_value(btabletitle, 0)
      else  
        list:add_value(tabletitle, 0)
      end
      for i = 1, lent do
        t = i
        if i < 10 then t = "  "..i end
        if tbllock[i] == 0 then
          l = " *" 
        else       -- tbllock = 0
          l = "   "
        end
        n = tbllen[i]
        s = ""
        if n < 100 then s = "  "..s end
        if n < 10 then s = "  "..s end
        list:add_value(t..l.."\t"..s..n.."\t"..tblentry[i], i)
      end
    end
end

function keys_update()         -- redisplay table and show keys
    if not dlg then return end
    local text
    if sys() == "osx" then
      dlg:del_widget(list)      -- list grows in osx, so delete
      list = dlg:add_list(1,ld,lw,lh)         -- then re-create
    else
      list:clear()        -- ok to just clear in windows, linux
    end
    if len == 0 then return end
    for i = 1, len do          -- make table of media
      local rma = getparm(parms[i],"RMA")
      if not rma then rma = "-" end
      local rmc = getparm(parms[i],"RMC")
      if not rmc then rmc = "-" end
      local rmp = getparm(parms[i],"RMP")
      if rmp then 
        if rma~="-" and rmc~="-" then
          text = rma..", "..rmc..", "..rmp
        else
          text = rma..", "..rmc.."\t"..rmp
        end
      else
        text = rma.."\t"..rmc
      end
      list:add_value(text.."\t"..names[i], i)
    end
end

function is_selection()               -- did the user select anything?
    if not dlg then return end
    selection = list:get_selection()  -- global var used by caller
    selidx = {}
    selcount = 0
    for idx, selitem in pairs(selection) do
      selcount = selcount + 1
      selidx[selcount] = idx
    end
    table.sort(selidx)
    fstselidx = selidx[1]
    return  selcount > 0
end

function close()           -- the user clicked "X" on the dialog
    if closehide == 1 then
      vlc.deactivate()     -- exit Resume Media
    elseif closehide == 2 then
      if variables then click_button4() end  -- close variable table
      dlg:hide()           -- hide the dialog for simple resume feature
    end
end

--------------------- key functions ---------------------
local function z______keys______() end   -- spacer in outline

function adjustspeed()  -- adjust playback speed
    local irate = nil
    if playspeed ~= 100 then  -- speed other than normal?
      irate = playspeed/100   -- set to playback speed setting
    elseif allowkeys > 1 then   -- set to playback speed key if set
      idx = find_in_table(vlc.input.item():name())
      if idx then rmp = getparm(parms[idx],"RMP") else rmp = nil end
      if rmp then irate = rmp/100 else irate = 1 end
    end
    if irate then
      rate = vlc.var.get(inpt, "rate")
      if math.abs(rate - irate) > .01 then  -- don't change if close
        vlc.var.set(inpt, "rate", irate)
      end
    end
end

function savkeyinput(idx)     -- save input keys to media at idx
    local str = input:get_text()
    local rma = getparm(str,"RMA")
    if rma and string.match(rma,"[^%d.:]") then rma = nil end
    local rmc = getparm(str,"RMC")
    if rmc and string.match(rmc,"[^%d.:]") then rmc = nil end
    local rmp = getparm(str,"RMP")
    local playi
    if idx == 0 then
      local nam = vlc.input.item():name()
      if not nam then return end   -- oops
      playi = find_in_table(nam)
      if not playi then manual_check(true) end
      playi = find_in_table(nam)    -- try again now
      if not playi then return end  -- oops
    else
      playi = idx
    end
    if rma then 
      parms[playi] = setparm(parms[playi],"RMA",rma) 
    else 
      parms[playi] = setparm(parms[playi],"RMA") 
    end
    if rmc then 
      parms[playi] = setparm(parms[playi],"RMC",rmc)
    else 
      parms[playi] = setparm(parms[playi],"RMC")
    end
    if rmp then 
      parms[playi] = setparm(parms[playi],"RMP",rmp)
    else 
      parms[playi] = setparm(parms[playi],"RMP")
    end
end

function getmeta()     -- get keys from media meta comments
    local rma, rmc, rmp
    local comments = vlc.input.item():metas()["description"]
    if comments then
      rma = getparm(comments,"RMA")
      if rma and string.match(rma,"[^%d.:]") then rma = nil end
      rmc = getparm(comments,"RMC")
      if rmc and string.match(rmc,"[^%d.:]") then rmc = nil end
      rmp = getparm(comments,"RMP")
    end
    return rma, rmc, rmp
end

tryupdate = false
function autoupdate()  -- try to get keys from meta and enter in table
    if not tryupdate then return end
    local rma, rmc, rmp
    rma, rmc, rmp = getmeta()
    if not (rma or rmc or rmp) then return end
    tryupdate = false
    local nam = vlc.input.item():name()
    if not nam then return end   -- oops
    local playi = find_in_table(nam)
    if not playi then return end
    if rma then parms[playi] = setparm(parms[playi],"RMA",rma) end
    if rmc then parms[playi] = setparm(parms[playi],"RMC",rmc) end
    if rmp then parms[playi] = setparm(parms[playi],"RMP",rmp) end
end

function getparm(str,parm)    --  find key in string
  return string.match(str, parm.."=(%S*)")
end  

function setparm(str,parm,value)  -- update key in string or remove key
    local sstr = " "..str
    if value==nil or value=="" then    -- delete parm?
      p1, p2 = string.match(sstr, "() "..parm.."=%S*()")
      if p1 and p2 then
        return string.sub(sstr,2,p1-1)..string.sub(sstr,p2,-1)
      else
        return str     -- parm wasn't in string
      end
    else              -- change value or add parm and value
      p1, p2 = string.match(sstr, " "..parm.."()=%S*()")
      if p1 and p2 then   -- change value
        return string.sub(sstr,2,p1)..value..string.sub(sstr,p2,-1)
      else                -- add
        return str.." "..parm.."="..value
      end
    end
end

function set_parms()     -- update keys in table from input box
    local pinput
    if is_selection() then
      parmsundo = copy_var(parms)
      for idx, selitem in pairs(selection) do
        savkeyinput(idx)
      end
      keys_update()
      set_button(3, undolbl)
    end
    pinput = trim(input:get_text())
    if pinput=="" then input:set_text("RMA=  RMC=  RMP=") end
end

function get_parms()   -- put selected table keys in input box
    local str, idx
    if trim(input:get_text()) == "getallkeys"  then
      idx = find_playing_media_in_table()
      if idx then input:set_text(trim(parms[idx])) end
    elseif is_selection() then
      str = parms[fstselidx]
    else
      str = input:get_text()
    end
    local rma = getparm(str,"RMA")
    if not rma then rma = "" end
    local rmc = getparm(str,"RMC")
    if not rmc then rmc = "" end
    local rmp = getparm(str,"RMP")
    if not rmp then rmp = "" end
    input:set_text("RMA="..rma.."  RMC="..rmc.."  RMP="..rmp)
    keys_update()  -- reset selection
end

function restoreconfig()   -- stop messing with config file      
    vlc.config.set("aspect-ratio", "")
    vlc.config.set("crop", "")
    vlc.config.set("stop-time", 0)
    vlc.config.set("start-time", starttime)
    vlc.config.set("run-time", runtime)
end

function set_vout()
    if allowkeys < 2 then return end
    vout = vlc.object.vout()
    if not vout then return end
    vlc.var.set(vout, "aspect-ratio", "")
    vlc.var.set(vout, "crop", "")
    local idx = find_in_table(vlc.input.item():name())
    if idx == nil then return end 
    local rma = getparm(parms[idx],"RMA")
    if rma then vlc.var.set(vout, "aspect-ratio", rma) end
    local rmc = getparm(parms[playidx],"RMC")
    if rmc then vlc.var.set(vout, "crop", rmc) end
end

-------------------- Segment functions ------------------
local function z______segments______() end   -- spacer in outline

function count_segs(idx)  -- count_segs doesn't destroy seg tables
    local s, sb, i
    for i = 1 , maxsegs do 
      s = getparm(parms[idx],"S"..i)
      sb = getparm(parms[idx],"SB"..i)
      if not (s or sb) then return i-1 end  -- assume no more
    end
    return maxsegs
end

function get_segments(idx)
    local segs, sb, se, sn, s
    convert_segs(idx)   -- change to new format
    nsegs = 0
    segs = parms[idx]
    for i = 1 , maxsegs do
      s = getparm(segs,"S"..i)
      if not s then break end  -- assume no more
      sb,se,sn = parseseg(s)
      if not (sb and se) then break end  -- oops
      sb = secs(sb)
      se = secs(se)
      if sb >= se then break end  -- oopsie
      nsegs = i
      segsb[i] = sb
      segse[i] = se
      segsn[i] = sn
    end
    return nsegs
end

function convert_segs(idx)  -- convert old to new key format
    local segs, sb, se, sn, s, i
    local modseg = false        -- did we make changes
    segs = parms[idx]
    for i = 1 , maxsegs do
      s = getparm(segs,"S"..i)
      sb = getparm(segs,"SB"..i)
      if not (s or sb) then            -- assume no more
        if modseg then parms[idx] = segs end 
        return
      elseif s and (not sb) then       -- we're good so far
--      continue  (loop and check the next segment)
      elseif s and sb then             -- clear old style
        segs = setparm(segs,"SB"..i)   
        segs = setparm(segs,"SE"..i)
        segs = setparm(segs,"SN"..i)
        modseg = true
      elseif (not s) and sb then       -- old style
        se = getparm(segs,"SE"..i)
        if se then 
          sb = secs(sb)
          se = secs(se)
          sn = getparm(segs,"SN"..i)
          if not sn then sn = "" end
          s = prepseg(sb,se,sn)
          segs = setparm(segs,"S"..i,s)
          segs = setparm(segs,"SB"..i)   -- clear old style
          segs = setparm(segs,"SE"..i)
          segs = setparm(segs,"SN"..i)
          modseg = true
        end
      end
    end
    if modseg then parms[idx] = segs end 
end

function put_segments(idel)
    local i, idx, segs, sn, seg
    idx = find_in_table(keynam)  -- point to correct media
    if idx == nil then return end
    segs = parms[idx]
    if nsegs > 0 then
      for i = 1, nsegs do
        seg = prepseg(segsb[i],segse[i],segsn[i])
        segs = setparm(segs,"S"..i,seg)
      end
    end
    if idel > 0 then   -- clean up stuff
      for i = nsegs+1, nsegs+idel do
        segs = setparm(segs,"S"..i)
        segs = setparm(segs,"SB"..i)
        segs = setparm(segs,"SE"..i)
        segs = setparm(segs,"SN"..i)
      end
    end
    parms[idx] = segs
end

function next_segment()
    if segments==1 or not doingsegs then return false end
    iseg = find_segment()   -- skip to seg containing resume time
    if iseg==0 or 
       (segcnt>0 and not find_playing_media_in_table()) then  -- reset
      segcnt = 0
      playidx = 0
      doingsegs = false
      list_update()   -- update seg name in table list
      return false
    else
      segcnt = segcnt + 1
      vlc.config.set("start-time", segsb[iseg])
      vlc.config.set("stop-time", segse[iseg])
      vlc.config.set("run-time", 0)
      if segcnt > 1 then vlc.playlist.play() end
      list_update()   -- update seg name in table list
      if segkeys then      -- change playing segment in label
        local seg = "("..iseg..") "
        label_msg:set_text(segmentslbl..seg..names[idx])
      end
      return true
    end
end

function  find_segment()  -- find seg containing resume time
    local tim, t, dur
    if nsegs == 0  then return 0 end     -- must have deleted segs
    if segcnt == 0 then                  -- first time
      iselidx = 0                        -- reset selection play
      t = times[playidx]
      if t==1 or t>segse[nsegs]-2 then t = 0 end
    else
      t = vlc.var.get(inpt, "time")  -- inpt from check_names()
      if iseg>nsegs or iseg<1 then iseg = nsegs end  -- oops
      if t < segse[iseg] - 2 then return 0 end  -- manual stop
      if segkeys and is_selection() then -- play seg list selection
        if iselidx>0 and iselidx<=selcount then
          if selidx[iselidx] ~= iseg then iselidx = 0 end -- sel changed
        end
        iselidx = iselidx + 1
        if iselidx > selcount then iselidx = 1 end
        iseg = selidx[iselidx]
        times[playidx] = segsb[iseg] + rewind  -- point to selected seg
        return iseg
      elseif t < segse[iseg] + 2 then     -- normal seg end
        iseg = iseg + 1                   -- point to next seg
        if iseg > nsegs then iseg = 1 end
        if iseg == 1 and not (loop or alwaysloop==2) then -- done media
          times[playidx] = 1  -- prevent segged media from being deleted
          dur = vlc.input.item():duration()  -- end of media
          vlc.var.set(inpt, "time", dur)  -- force end of media
          return 0
        else                                -- play next seg
          times[playidx] = segsb[iseg] + rewind
          return iseg
        end  -- done
      end
    end
    for i = 1, nsegs do  -- here if first play or user clicked past seg end
      if  t <= segse[i]-1 then
        if t < segsb[i]+rewind then t = segsb[i]+rewind end
        times[playidx] = t
        return i 
      end
    end
    if loop or alwaysloop==2 then
      times[playidx] = segsb[1] + rewind
      return 1
    else                  -- past all segments so finished
      times[playidx] = 1  -- prevent segged media from being deleted
      dur = vlc.input.item():duration()  -- end of media
      vlc.var.set(inpt, "time", dur)  -- force end of media
      return 0 
    end
end  
  
function get_timeorseg()
    local sb, se, sn, idx
    if trim(input:get_text()) == "getallkeys"  then
      idx = find_playing_media_in_table()
      if idx then input:set_text(trim(parms[idx])) end
    elseif is_selection() then
      sb = segsb[fstselidx]
      se = segse[fstselidx]
      sn = segsn[fstselidx]
      input:set_text(hhmmss6(sb).."  "..hhmmss6(se).."  "..sn)
      segkeys_update()     -- clear the selection 
    else
      local nam = vlc.input.item():name()
      if nam == nil then return end
      if nam ~= keynam then return end
      local inpt = vlc.object.input()  
      local tim = hhmmss6(vlc.var.get(inpt, "time"))
      input:set_text(tim.."  "..input:get_text())
    end
end
  
function parseseg(str)
    local sb, se, sn
    str = string.gsub(str,"%)"," ")
    str = string.gsub(str,"%(",",")
    str = str.." "     -- to make match work
    sb,se,sn = string.match(str,"(%S+)%s+(%S+)%s+(.*)")
    if not sn then sn = "" end
    return sb, se, sn
end
  
function prepseg(sb,se,sn)
    local str = trim(hhmmssle6(sb).." "..hhmmssle6(se).." "..sn)
    str = string.gsub(str," ","%)")  -- don't use "," and " "
    str = string.gsub(str,",","%(")
    return str
end    
  
function save_seg()
    local sb, se, sn, tmp, i, insert, dur, nam
    if find_in_table(keynam)==nil then
      nsegs = 0
      segkeys_update()
      return 
    end
    sb,se,sn = parseseg(input:get_text())
    if not (sb or se) then 
      segkeys_update()       -- clear selection
      return 
    end
    dur = nil
    nam = vlc.input.item():name()
    if nam ~= nil then -- and nam == keynam then 
      dur = vlc.input.item():duration()  -- end of media
    end
    if tonumber(sb)==nil then sb=dur else sb = secs(sb) end
    if sb == 1 then sb = 0 end
    if tonumber(se)==nil then se=dur else se = secs(se) end
    if se == 1 then se = 0 end
    if sb == nil or se == nil or sb == se then
       segkeys_update()       -- clear selection
      return 
    end
   if sb > se then
      tmp = sb
      sb = se
      se = tmp
    end
    if sn==nil then sn = "" else sn = trim(sn) end
    insert = nsegs + 1
    for i = 1, nsegs do
      if sb < segsb[i] then
        insert = i
        break
      end
    end
    table.insert(segsb,insert,sb)
    table.insert(segse,insert,se)
    table.insert(segsn,insert,sn)
    nsegs = nsegs + 1
    if doingsegs and iseg>=insert then iseg=iseg+1 end
    put_segments(0)
    segkeys_update()
end
  
function delete_seg()
    local oldnsegs, idxs, nidxs, i, j
    if find_in_table(keynam)==nil then  -- oops
      nsegs = 0
      segkeys_update()
      return 
    end
    if not is_selection() then return end
    oldnsegs = nsegs
    for i = selcount, 1, -1 do
      j = selidx[i]
      table.remove(segsb, j)
      table.remove(segse, j)
      table.remove(segsn, j)
      nsegs = nsegs - 1
      if doingsegs and iseg>=j then iseg=iseg-1 end -- approximate
    end
    put_segments(oldnsegs-nsegs)
    segkeys_update()
end
  
function segkeys_update()         -- redisplay table and show keys
    local sb, se, sn, is, i, n
    if not dlg then return end
    list:clear()
    is = nsegs
    if nsegs == 0 then return end
    for i = 1, nsegs do          -- make list of segments
      sb = hhmmss(segsb[i])
      se = hhmmss(segse[i])
      sn = segsn[i]
      n = i
      if n < 10 then n = "  "..n end
      list:add_value(n.."   "..sb.."   "..se.."   "..sn, i)
    end
end

      --**********************************************************  
      --*  Segment key format is S#=hhmmss)hhmmss)name where:    *
      --*    # = 1, 2, 3, ...                                    *
      --*    leading 0's can be removed from hhmmss              *
      --*    Blanks in name must be replaced with ")"            *
      --*    Commas in name must be replaced with "("            *
      --**********************************************************

segupdate = false 
function segsupdate()  -- get seg keys from meta and enter in table
    if not autosegs then return end  -- autosegs near top of file 
    local comments, nam, playi, i, s, sb, se, sn
    if not segupdate then return end
    comments = vlc.input.item():metas()["description"]
    if not comments then return end
    segupdate = false
    nam = vlc.input.item():name()
    if not nam then return end   -- oops
    playi = find_in_table(nam)
    if not playi then return end    -- oops
    s = getparm(parms[playi],"S1")
    sb = getparm(parms[playi],"SB1")
    if s or sb then return end   -- already got segments
    for i = 1, maxsegs do
      s = getparm(comments, "S"..i)
      if not s then break end       -- assume no more
      sb,se,sn = parseseg(s)
      if not (sb or se) then return end  -- oops
      if not sn then sn = "" end
      sb = secs(sb)
      se = secs(se)
      if sb >= se then return end    -- oops
      s = prepseg(sb,se,sn)
      parms[playi] = setparm(parms[playi],"S"..i,s) 
    end 
end

--------------------- table operations ---------------------
local function z______table______() end   -- spacer in outline

function copy_var(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function remove()
    local i
    if is_selection() then
      for i = selcount, 1, -1 do
        table.remove(names,selidx[i])
        table.remove(times,selidx[i])
        table.remove(paths,selidx[i])
        table.remove(parms,selidx[i])
        len = len - 1
      end
    end
    list_update()
end

function set_time(hmsorend)
    local hms = trim(input:get_text())
    local sec = secs(hms)
    if sec == 1 then        -- 1 is the 'Finished' flag
      hms = "000000"
      input:set_text(hms)
      sec = 0
    end
    if is_selection() then
      for idx, selitem in pairs(selection) do
        if hmsorend==0 then
          times[idx] = sec       -- set to input if valid
        elseif hmsorend==1 then
          times[idx] = 1         -- 1 is "Finished" flag
          if bookmark==names[idx] then findbookmark(true) end
        end
      end
    end
    list_update()
end

function getplaylist()
    for i, item in pairs(vlc.playlist.get("playlist",false).children) do
      if not find_in_table(item.name) then
        len = len + 1        -- add playlist item to table
        names[len] = item.name
        times[len] = 0
        paths[len] = item.path
        parms[len] = ""
      end 
    end
    list_update()
end

playidx = nil    -- play not initiated from RM if nil
function playstuff()
    local i, j
    if len == 0 then return end
    local media = button[1]:get_text()
    local playunfinished = (media == unfinishedlbl)
    if playunfinished and allfinished() then return end
    local playtable = (media == tablelbl)
    local playselection = (media == selectionlbl)
    local playmain = (button[3]:get_text() == playoptlbl)
    if playmain then playselection = true end
    if playselection and not is_selection() then return end
    local playbookmark = (button[3]:get_text() == playmarklbl)
    local random = (button[2]:get_text() == randomlbl)
    loop = (button[3]:get_text() == looplbl)
    vlc.playlist.clear()   -- create new playlist
    playcount = 0
    for i = 1, len do
      playi = false
      if playbookmark then
        if bookmark == names[i] then playi = true end
      elseif playunfinished then
        if times[i] ~= 1 then playi = true end
      elseif playtable then
        playi = true
      elseif playselection then
        for j = 1, selcount do
          if selidx[j] == i then 
            playi = true
            break
          end
        end
      end
      if playi then
        video = { name = names[i], path = paths[i] }
        vlc.playlist.enqueue({video})
        playcount = playcount + 1
        playidx = i
      end
    end
    -- use config settings in VLC 2 to adjust picture here --
    -- try vout in VLC 3 (see set_vout in meta_changed)
    restoreconfig()
    if playcount==1 and allowkeys>1 then
      rma = getparm(parms[playidx],"RMA")
      if rma then vlc.config.set("aspect-ratio", rma) end
      rmc = getparm(parms[playidx],"RMC")
      if rmc then vlc.config.set("crop", rmc) end
      if allowkeys==3 then tryupdate = true end
      if allowkeys==3 then segupdate = true end
    end
    if playcount==1 and segments==2 and get_segments(playidx)>0 then
      segcnt = 0     -- number of segments played
      doingsegs = true
      next_segment()
    end
    vlc.playlist.repeat_("off")
    vlc.playlist.random("off")
    vlc.playlist.loop("off")
    if random then vlc.playlist.random() end
    if loop or alwaysloop==2 then vlc.playlist.loop() end
    vlc.playlist.play()
    list_update()         -- clear the selection
end

function move_top()  -- move selection to top of table
    local i, k, nam, tim, uri, par
    if not is_selection() then return end
    for i = 1, selcount do  
      k = selidx[i]
      nam = names[k]
      tim = times[k]
      uri = paths[k]
      par = parms[k]
      table.remove(names,k)
      table.remove(times,k)
      table.remove(paths,k)
      table.remove(parms,k)
      table.insert(names,i,nam)  -- i places item in order
      table.insert(times,i,tim)  
      table.insert(paths,i,uri)  
      table.insert(parms,i,par)  
    end
    list_update()
end

function move_bottom()  -- move selection to bottom of table
    local i, j, k, nam, tim, uri, par
    if not is_selection() then return end
    j = len + 1
    for i = selcount, 1, -1 do
      j = j - 1              -- j places moved item in order
      k = selidx[i]
      nam = names[k]
      tim = times[k]
      uri = paths[k]
      par = parms[k]
      table.remove(names,k)
      table.remove(times,k)
      table.remove(paths,k)
      table.remove(parms,k)
      table.insert(names,j,nam)  
      table.insert(times,j,tim)  
      table.insert(paths,j,uri)  
      table.insert(parms,j,par)  
    end
    list_update()
end

function randomize_table(fin)
    idxs = {}
    local i
    math.randomseed(os.time())
    math.random(1,10)   -- first one doesn't seem random
    for i = 1, len do
      local idx = string.sub("000"..i,-4,-1)
      local rdm = string.sub("0000"..math.random(1,99999),-5,-1)
      idxs[i] = rdm..idx
    end
    table.sort(idxs)  
    for i = 1, len do
      idxs[i] = tonumber(string.sub(idxs[i],-4,-1))
    end
    names = sort_idxs(names,idxs,len)    
    times = sort_idxs(times,idxs,len)
    paths = sort_idxs(paths,idxs,len)
    parms = sort_idxs(parms,idxs,len)
    list_update()
    if fin == "bot" then
      move_completed()
    end  
    list_update()
end

flipflop = false
function flip_table(tbl,n)  -- allows table flipping in sort below
    if not flipflop then return tbl end
    local tmp = {}
    for i = 1, n do
      tmp[i] = tbl[n-i+1]
    end
    return tmp
end

function sort_by_name()
    idxs = flip_table(stable_sort(names,len),len) -- flip?
    flipflop = not flipflop
    names = sort_idxs(names,idxs,len)    
    times = sort_idxs(times,idxs,len)
    paths = sort_idxs(paths,idxs,len)
    parms = sort_idxs(parms,idxs,len)
    list_update()
end

function sort_by_time()
    sort_by_name()            -- to make sure subsort is ascending by name
    flipflop = not flipflop         -- reverse flip in sort_by_name
    local hms = {}
    for i=1,len do hms[i] = hhmmss(times[i]) end -- sorts better by string
    idxs = flip_table(stable_sort(hms,len),len)
    flipflop = not flipflop
    names = sort_idxs(names,idxs,len)    
    times = sort_idxs(times,idxs,len)
    paths = sort_idxs(paths,idxs,len)
    parms = sort_idxs(parms,idxs,len)
    move_completed()          -- now move finished media to the bottom
    list_update()
end

function stable_sort(tbl,n)  -- this preserves the sub-order of equal elements
    local idxs = {}
    for i = 1, n do
      idxs[i] = tbl[i]..string.sub("000"..i,-4,-1)
    end
    table.sort(idxs)  -- now we get a stable sort, then strip the indicies
    for i = 1, n do
      idxs[i] = tonumber(string.sub(idxs[i],-4,-1))
    end
    return idxs
end

function sort_idxs(tbl,idxs,n)    -- sort table based on sorted idxs
    local tmp = {}
    for i = 1, n do
      j = tonumber(idxs[i])
      if not j then j = i end     -- just in case
      if j < 1 or j > n then j = i end -- just in case
      tmp[i] = tbl[j]
    end
    return tmp
end

function move_completed()   -- move 'Finished' media to bottom
    local ntemp = {} ; local ttemp = {}
    local ptemp = {} ; local ktemp = {}
    k = 0
    for i = 1, len do       -- unfinished at top 
      if times[i] ~= 1 then
        k = k + 1
        ntemp[k] = names[i]
        ttemp[k] = times[i]
        ptemp[k] = paths[i]
        ktemp[k] = parms[i]
      end
    end
    for i = 1, len do       -- finished at bottom 
      if times[i] == 1 then
        k = k + 1
        ntemp[k] = names[i]
        ttemp[k] = times[i]
        ptemp[k] = paths[i]
        ktemp[k] = parms[i]
      end
    end
    names = ntemp
    times = ttemp
    paths = ptemp
    parms = ktemp
end   

function get_tables()      -- read the tables
    deltables = 0         -- count the tables with '*' mark
    if tablenum > 0 then    -- not first time
      filename = getfilename(tablenum)
      write_names() 
    end 
    lent = maxtables
    tbllen = {}
    tblentry = {}
    tbllock = {}
    for i = 1, lent do
      filename = getfilename(i)
      read_names(false)
      if len == 0 then
        tblentry[i] = "empty"
      elseif showmark == 2 then
        tblentry[i] = bookmark
      else
        tblentry[i] = names[1]
      end
      tbllock[i] = filelocked
      if filelocked == 0 then deltables = deltables + 1 end
      tbllen[i] = len
    end
    if tablenum > 0 then
      filename = getfilename(tablenum)
      read_names()                -- restore current table
    end
end

function open_table(num)      -- make selection the current table
    if not dlg then return nil end
    if num then
      fstselidx = num    -- we know which table to open
    else
      if not is_selection() then return nil end    -- no selection
      if selcount > 1 then return nil end          -- no multi-selection 
      if fstselidx == 0 then return nil end        -- title line
      if fstselidx == tablenum then return 1 end    -- current table
    end
    get_tables()             --  refresh in case change
    tables_update()
    filename = getfilename(tablenum) 
    write_names()            -- save current table
    filenumsave = tablenum    -- table to restore if adjusting variables
    tablenum = fstselidx
    filename = getfilename(tablenum)
    read_names(false)        -- open new table
    return 1
end

function lock_table(mode)       -- set or unset 'keep' flag in tables
    if not is_selection() then return end
    if selcount == 1 and fstselidx == 0 then return end
    filename = getfilename(tablenum) 
    write_names()               -- save current table
    for idx, selitem in pairs(selection) do
      if idx == 0 then break end
      filename = getfilename(idx)
      read_names(false)
      filelocked = mode         -- 0=normal  2=K(keep media)
      write_names()
    end
    filename = getfilename(tablenum) -- restore current table
    read_names()
    setdlgmode(setdotables)
end

function combine_tables(delete)    -- move selected tables to current table
    if not dlg then return end
    if not is_selection() then return end
    if selcount == 1 and fstselidx == 0 then return end  -- title
    filename = getfilename(tablenum) 
    write_names()              -- save current table
    tnames = {}
    ttimes = {}
    tpaths = {}
    tparms = {}
    tlen = 0
    for idx, selitem in pairs(selection) do
      if idx == 0 or idx == tablenum then break end
      filename = getfilename(idx)
      read_names(false)        -- read each selected table
      if len > 0 then        -- add table to current table
        for i = 1, len do
          tlen = tlen + 1
          tnames[tlen] = names[i]
          ttimes[tlen] = times[i]
          tpaths[tlen] = paths[i]
          tparms[tlen] = parms[i]
        end
        if delete then
          len = 0              -- clear the selected table
          write_names()
        end  
      end
    end     
    filename = getfilename(tablenum)      -- now reload current table
    read_names()
    if tlen > 0 then
      for i = 1 , tlen do
        ln = find_in_table(tnames[i])    -- check for dups
        if ln then
          if ttimes[i] > times[ln] then  -- if dup, save latest
            times[ln] = ttimes[i]
          end
        else
          len = len + 1                  -- add the selected tables
          names[len] = tnames[i]
          times[len] = ttimes[i]
          paths[len] = tpaths[i]
          parms[len] = tparms[i]
        end
      end
      write_names()              -- save
    end
    setdlgmode(setdotables)      -- don't stay in combine mode
    return
end

------------------- settings table functions -------------------
local function z______settings______() end   -- spacer in outline

function get_vars()     -- get user adjustable variables
    tablenum = 0
    filename = getfilename(0)
    read_names(false)
    nvars = 18          -- number of variables in table
    put_vars(len+1)     -- copy unset variables to table
    len = nvars         -- now we have the correct table
    set_vars()          -- set variables to table values
    check_vars()        -- check variables
    put_vars(1)         -- back to table
    write_names()       -- save user settings
end

function set_vars()    -- set variables to user table
    begintol = times[1]
    rewind = times[2]
    maxtables = times[3]
    starttable = times[4]
    listwidth = times[5]
    listheight = times[6]
    showmark = times[7]
    allowkeys = times[8]
    closehide = times[9]
    starttime = times[10]
    runtime = times[11]
    playspeed = times[12]
    blocknew = times[13]
    segments = times[14]
    fullscreen = times[15]
    alwaysloop = times[16]
    timestretch = times[17]
    stopbutton = times[18]
end

function set_fullscreen() -- set fullscreen same as in preferences
  -- the ideal time to do this would be at extension startup
  -- but, apparently, config.get() is not available during activate()
  -- because everything seems to come back nil
  -- so, this is set when the settings table is opened in click_button4
    local fs = vlc.config.get("fullscreen")
    if fs ~= (fullscreen==2) then  -- set same as VLC preferences
      if fullscreen>1 then fullscreen=1 else fullscreen=2 end
      times[15] = fullscreen  
    end
  -- also, timestretch
    local ts = vlc.config.get("audio-time-stretch")
    if ts ~= (timestretch==2) then  -- set same as VLC preferences
      if timestretch>1 then timestretch=1 else timestretch=2 end
      times[17] = timestretch  
    end
end

names7 = {}
names7[1] = "Show first table entry in list of tables"
names7[2] = "Show bookmarked entry in list of tables"
names8 = {}
names8[1] = "Do not apply keys (picture/speed)"
names8[2] = "Apply keys (manual key entry)"
names8[3] = "Apply keys (automatic key entry)"
names9 = {}
names9[1] = "Clicking 'X' closes Resume Media"
names9[2] = "Clicking 'X' hides Resume Media dialog"
names13 = {}
names13[1] = "Allow new table entry when media stops"
names13[2] = "Block new table entry when media stops"
names14 = {}
names14[1] = "Do not apply segment keys"
names14[2] = "Play media in segments, if keys entered"
names17 = {}
names17[1] = "Audio pitch varies with playback speed"
names17[2] = "Audio pitch unaffected by playback speed"
function put_vars(start)    -- copy variables to table
    if start <=  1 then times[ 1] = begintol end
    if start <=  2 then times[ 2] = rewind end
    if start <=  3 then times[ 3] = maxtables end
    if start <=  4 then times[ 4] = starttable end
    if start <=  5 then times[ 5] = listwidth end
    if start <=  6 then times[ 6] = listheight end
    if start <=  7 then times[ 7] = showmark end
    if start <=  8 then times[ 8] = allowkeys end
    if start <=  9 then times[ 9] = closehide end
    if start <= 10 then times[10] = starttime end
    if start <= 11 then times[11] = runtime end
    if start <= 12 then times[12] = playspeed end
    if start <= 13 then times[13] = blocknew end
    if start <= 14 then times[14] = segments end
    if start <= 15 then times[15] = fullscreen end
    if start <= 16 then times[16] = alwaysloop end
    if start <= 17 then times[17] = timestretch end
    if start <= 18 then times[18] = stopbutton end
    names[ 1] = "Media-just-started  (2 to 120 seconds)"
    names[ 2] = "Rewind when resuming  (0 to 120 seconds)"
    names[ 3] = "Number of tables  (1 to "..limtables..")"
    names[ 4] = "Starting table  (1 to number of tables)"
    names[ 5] = "Dialog window width  (4 to 40 VLC units)"
    names[ 6] = "Dialog window height  (10 to 70 VLC units)"
    names[ 7] = names7[showmark]
    names[ 8] = names8[allowkeys]
    names[ 9] = names9[closehide]
    names[10] = "Start time for all media (0 to 600 seconds)"
    names[11] = "Run time for all media (0 to 600 seconds)"
    names[12] = "Playback speed (25 to 300 percent)"
    names[13] = names13[blocknew]
    names[14] = names14[segments]
    names[15] = "Start videos in (1) VLC window (2) fullscreen"
    names[16] = "(1) Normal (2) Always loop when playing"
    names[17] = names17[timestretch]
    names[18] = "(1) Hide (2) Show playlist control buttons."
    for i = 1, nvars do paths[i] = "--------" end   -- dummy paths
    for i = 1, nvars do parms[i] = "" end           -- dummy parms
end

function check_vars()          -- check user variables
    if begintol < 2 then begintol = 2 end
    if begintol > 120 then begintol = 120 end
    if rewind < 0 then rewind = 0 end  
    if rewind > 120 then rewind = 120 end  
    if maxtables < 1 then maxtables = 1 end          
    if maxtables > limtables then maxtables = limtables end       
    if starttable < 1 then starttable = 1 end
    if starttable > maxtables then starttable = maxtables end
    if listwidth < 4 then listwidth = 4 end
    if listwidth > 40 then listwidth = 40 end
    if listheight < 10 then listheight = 10 end
    if listheight > 70 then listheight = 70 end
    if showmark > 2 then showmark = 1 end
    if showmark < 1 then showmark = 2 end
    if allowkeys > 3 then allowkeys = 1 end
    if allowkeys < 1 then allowkeys = 3 end
    if allowkeys==1 then restoreconfig() end
    if closehide > 2 then closehide = 1 end
    if closehide < 1 then closehide = 2 end
    if starttime > 600 then starttime = 600 end
    if starttime < 0 then starttime = 0 end
    if currentvar==10 then vlc.config.set("start-time", starttime) end
    if runtime > 600 then runtime = 600 end
    if runtime < 0 then runtime = 0 end
    if currentvar==11 then vlc.config.set("run-time", runtime) end
    if playspeed > 300 then playspeed = 300 end
    if playspeed < 25 then playspeed = 25 end
    if blocknew > 2 then blocknew = 1 end
    if blocknew < 1 then blocknew = 2 end
    if segments > 2 then segments = 1 end
    if segments < 1 then segments = 2 end
    if fullscreen > 2 then fullscreen = 1 end
    if fullscreen < 1 then fullscreen = 2 end
-- times[15] set when opening Settings table. see set_fullscreen().
    if currentvar==15 then vlc.config.set("fullscreen", fullscreen==2) end
    if alwaysloop > 2 then alwaysloop = 1 end
    if alwaysloop < 1 then alwaysloop = 2 end
    if timestretch > 2 then timestretch = 1 end
    if timestretch < 1 then timestretch = 2 end
-- times[17] set when opening Settings table. see set_fullscreen().
    if currentvar==17 then vlc.config.set("audio-time-stretch", timestretch==2) end
    if stopbutton > 2 then stopbutton = 1 end
    if stopbutton < 1 then stopbutton = 2 end
end

var = {{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}}
var[ 1] = {2,10,20,30,40,50,60,90,120}                -- begintol
var[ 2] = {0,5,10,15,20,30,60,90,120}                 -- rewind
var[ 3] = {1,10,20,30,40,50,60,70,80,90,100,limtables} -- maxtables
var[ 4] = {1,10,20,30,40,50,60,70,80,90,100,limtables} -- starttable
var[ 5] = {4,10,15,20,25,30,35,40}                    -- listwidth
var[ 6] = {10,15,20,25,30,35,40,45,50,55,60,65,70}    -- listheight
var[ 7] = {0,1,2,3}                                   -- showmark
var[ 8] = {0,1,2,3,4}                                 -- adjustpic
var[ 9] = {0,1,2,3}                                   -- closehide
var[10] = {0,60,120,180,240,300,360,420,480,540,600}  -- starttime
var[11] = {0,60,120,180,240,300,360,420,480,540,600}  -- runtime
var[12] = {25,50,75,100,125,150,175,200,225,250,275,300}  -- playspeed
var[13] = {0,1,2,3}                                   -- blocknew
var[14] = {0,1,2,3}                                   -- segments
var[15] = {0,1,2,3}                                   -- fullscreen
var[16] = {0,1,2,3}                                   -- alwaysloop
var[17] = {0,1,2,3}                                   -- timestretch
var[18] = {0,1,2,3}                                   -- stopbutton
varn = {9,9,12,12,8,13,4,5,4,11,11,12,4,4,4,4,4,4}   -- array lengths
vari = {1,1,1,1,1,1,1,1,1,5,5,5,1,1,1,1,1,1}         -- increment value
varmsg = {}
varmsg[ 1] = "Media-just-started allows media preview without saving position."
varmsg[ 2] = "Rewind helps you remember where you left off."
varmsg[ 3] = "Higher tables are not deleted when the number of tables is lowered."
varmsg[ 4] = "Starting table is the table opened when Resume Media is started."
varmsg[ 5] = "Window resizing takes effect when Resume Media is restarted."
varmsg[ 6] = varmsg[5]
varmsg[ 7] = "Show first table entry or bookmarked entry in list of tables."
varmsg[ 8] = "See description in addons url/download about entering keys."
varmsg[ 9] = "Hide Resume Media if you want a simple resume feature."
varmsg[10] = "A saved resume time overrides start time. Default is 0."
varmsg[11] = "This allows sampling of media. Default is 0 (unlimited)."
varmsg[12] = "Play media faster or slower. Default is 100 percent."
varmsg[13] = "Blocking prevents unexpected new entries in all tables."
varmsg[14] = "Segmenting lets you skip the boring stuff (see description)."
varmsg[15] = "Sets 'Fullscreen' setting in VLC preferences. Must restart VLC."
varmsg[16] = "You can set [Loop] when playing from [Play More] menu."
varmsg[17] = "Sets 'Audio Time Stretch' setting in VLC preferences."
varmsg[18] = "Change takes effect when Resume Media is restarted."

currentvar = 0

function adjust_vars(dir)
    if not dlg then return end
    local s = trim(input:get_text())
    
    if string.sub(s,1,8) == "restore " then
      restoretables(trim(string.sub(s,9,-1)))
      list_update()
      return
    end  
      
    if is_selection() then
      if selcount > 1 then      -- no multi selection
        label_msg:set_text(variableslbl)
        currentvar = 0
        return 
      else
        currentvar = fstselidx  -- selected variable
      end 
    end     
    if currentvar == 0 then return end

    local i = currentvar
    if s ~= "" then                 -- if input entered
      local int = integer(s)        -- in=0 when invalid
      if int~=0 or s=="0" then      -- if valid
        times[i] = int
      end
      input:set_text("")            -- clear input in any case
    elseif times[i] > var[i][varn[i]] then  -- user set > max
      times[i] = var[i][varn[i]]            -- bring down to max
    elseif dir == "inc" then
      for j = 1, varn[i]-1 do
        if times[i] >= var[i][j] and times[i] < var[i][j+1] then
          times[i] = var[i][j+1]
          break
        end
      end
    elseif dir == "dec" then
        for j = 2, varn[i] do
        if times[i] > var[i][j-1] and times[i] <= var[i][j] then
          times[i] = var[i][j-1]
          break
        end
      end
    else
      times[i] = times[i] + vari[i]
    end
    set_vars()
    check_vars()    -- make any adjustments
    put_vars(1)      -- put back in table
    list_update()
    label_msg:set_text(varmsg[i])  -- help msg while adjusting

end

------------  temporary message functions to test code  -----------
local function z______msgs______() end   -- spacer in outline

msglast = "what are the odds that the first msg is this?"
firstmsg = true
function msg(s)       -- add message to dialog label for testing
    if not dlg then return end
    if firstmsg then          -- add label if first message
      label_dbg = dlg:add_label("",1,lh+6,lw,1) 
      firstmsg = false
    end
    local text = ""
    local typ = "nil"
    if s ~= nil then typ = type(s) end     -- get the parameter type
    if typ == "boolean" then
      if s then text="t" else text="f" end 
    elseif typ == "string" then
      text = trim(s)
    elseif typ == "number" then
      text = s
    else
      text = typ
    end
    msglast = s
    label_dbg:set_text(label_dbg:get_text().." "..text)  -- add
end

function msgi()                 -- reset the test label
    msg()                  -- make sure label is present
    label_dbg:set_text("") 
end

function msgl(tf)                 -- true or false msg in label
    if tf then msg("t") else msg("f") end 
end

function msgq(s)               -- msg in quotes in label
    msg("'"..tostring(s).."'")
end

function msgc(s)               -- msg only if changed
    if s ~= msglast then
      msg(s)
    end
end

------------- formatting functions (the old fashion way) --------
local function z______format______() end   -- spacer in outline

function secs(hhmmss)            -- "hh:mm:ss" to secs
    local hms, h, m, s, n, i
    hms = hhmmss    -- ok, let's do some generous error checking
    hms = string.gsub(hms,"[:;,.-/ ]","") -- remove time dividers
    n = string.len(hms)
    if n < 6 then hms = string.sub("000000"..hms, -6, -1) end
    if string.len(hms) ~= 6 then return 0 end -- oops
    h = integer(string.sub(hms,1,2))
    m = integer(string.sub(hms,3,4))
    s = integer(string.sub(hms,5,6))
    if h<0 or m<0 or s<0 then return 0 end          -- oops
    return s + m*60 + h*3600
end

function hhmmss(secs) -- secs to "hh:mm:ss"
    local seconds = integer(secs)
    if seconds < 0  then return "00:00:00" end      -- oops
    if seconds > 359999 then return "99:59:59" end  -- oops
    local h = seconds/3600
    local hh = math.floor(h)
    local m = (h - hh) * 60
    local mm = math.floor(m)
    local s = (m - mm) * 60 + .5
    local ss = math.floor(s)
    if hh > 99 then hh = 99 end    -- just in case
    if hh < 10 then hh = "0"..hh end
    if mm < 10 then mm = "0"..mm end
    if ss < 10 then ss = "0"..ss end
    fhhmmss = hh..":"..mm..":"..ss
return fhhmmss
end

function hhmmss6(secs) -- secs to "hhmmss"
    local hms = hhmmss(secs)
    local h = string.sub(hms,1,2)
    local m = string.sub(hms,4,5)
    local s = string.sub(hms,7,8)
    return h..m..s
end

function hhmmssle6(secs)  -- secs to "hhmmss" with no left zeros
    local hms = hhmmss6(secs)
    hms = string.gsub(hms,"^0*","") -- remove left zeros    
    if hms=="" then hms = "0" end -- at least one zero
    return hms
end

function integer(s)   -- hoping s is integer in string format
    local num = tonumber(s)
    if num == nil then num = 0 end
    num = math.floor(num + .5)  -- ok, round to nearest integer
    if string.match(tostring(num),"[^-0123456789]") then
      return 0      -- if not an integer then set to 0
    else
      return num
    end
end

function trim(s)
  if s == nil then return "" end
  local a = s:match('^%s*()')
  local b = s:match('()%s*$', a)
  return s:sub(a,b-1)
end

------------- file input / output functions -------------------
local function z______file______() end   -- spacer in outline

function getfilename(tn)   -- get file name from table number
    fn = ""
    if tn == 0 then fn = " Vars" end
    if tn > 1 then fn = " "..tn-1 end
    fn = string.sub(filebasename,1,-5)..fn..".txt"
    return fn
end

function read_names(optionsonly)
    file = io.open(filename,"r") 
    if (not file) then            -- exists?
      len = 0
      prevostime = 0
      filelocked = 2
      return nil 
    end 
    len = -2
    for line in file:lines() do  -- load tables from file
      if len < 0 then   -- first two line are not part of table
        if len == -1 then 
          get_options(line)  -- comma separated options
          if optionsonly then
            file:close()
            return 0
          end
        end
        len = len + 1
      else            -- look for filename , hh:mm:ss picturekeys , uri
        c1 = nil
        c2 = nil
        for comma in string.gmatch(line,"(),") do
          c1 = c2       -- shift down to get last two commas
          c2 = comma
        end
        if not c1 then break end  -- at least two commas. commas ok in name
        len = len + 1     --  now we have  filename , keys , path
        names[len] = trim(string.sub(line,1,c1-1))
        paths[len] = trim(string.sub(line,c2+1,-1))
        local params = trim(string.sub(line,c1+1,c2-1))
        local parlen = string.len(params)
        times[len] = secs(string.sub(params,1,8))
        params = string.sub(params,9,-1)
        parms[len] = ""
        for nextp in string.gmatch(params,"( %S+=%S*)") do
          parms[len] = parms[len]..nextp
        end 
      end
    end
    bookmark = nbookmark(idxbookmark)  -- get playing from option
    findbookmark(false)          -- set the bookmark
    file:close()
    return 1
end

function get_options(line)  -- extension options on line 2
    leno = 0
    c2 = 0
    for comma in string.gmatch(line,"(),") do
      leno = leno + 1
      c1 = c2                -- shift down
      c2 = comma
      optns[leno] = trim(string.sub(line,c1+1,c2-1)) -- extract option
    end 
    leno = leno + 1
    optns[leno] = trim(string.sub(line,c2+1,-1))     -- last option

    if leno > 0 then         --  startup dialog option 
      prevostime = integer(optns[1]) 
    else
      prevostime = 0
    end 
    if leno > 1 then         --  startup dialog option 
      filelocked = integer(optns[2]) 
      if filelocked == 1 then filelocked = 0 end  -- =1 not used anymore
    else
      filelocked = 2
    end 
    if leno > 2 then         --  startup dialog option 
      idxbookmark = integer(optns[3]) 
    else
      idxbookmark = 1
    end 
    savestyle = getparm(line,"savestyle")       -- single or multi-file
    if not savestyle then savestyle = 1 end     -- old multi-style
end

function write_names()
    if len == 0 and filelocked == 2 then  -- no sense saving empty file
      file = io.open(filename,"r") 
      if file then   
        file:close()
        os.remove(filename)
      end
    else
      file = io.open(filename,"w")
      if file then
        file:write(infoline.."\n")   -- file descriptor
        file:write(os.time().." , "..filelocked.." , "..
                   ibookmark(bookmark).."\n")
        for i = 1, len do
          file:write(names[i].." , "..
                     hhmmss(times[i]).." "..trim(parms[i]).." , "..
                     paths[i].."\n")
        end
        file:close()
      end
    end
end

function locatefiles() -- move files to ../lua/extensions/VLC Resume Media V3/
    local i, oldbasename, newbasename, newvars, oldfile, newfile, line
  
    if limtables < 1 then limtables = 1 end
    if limtables > 500 then limtables = 500 end   -- seriously?  
  
    -- if user defined data location then just check .txt ending
   
    if filename ~= "" then   -- did user change the file name?
      if string.sub(filename,-4,-1) ~= ".txt" then  -- must end in .txt
        filename = filename..".txt"
      end
      filebasename = filename  -- save for table routines
      return
    end
   
    -- set up old and new location names
    
    usrdatdir = vlc.config.userdatadir()
    if sys() == "win" then
      oldbasename = usrdatdir.."\\VLC Resume Media V2.txt"
      usrdatdir   = usrdatdir.."\\VLC Resume Media\\"
      newbasename = usrdatdir.."VLC Resume Media.txt"
      newvars     = usrdatdir.."VLC Resume Media Vars.txt"
    elseif sys() == "lin" or sys() == "osx" then
      oldbasename = usrdatdir.."\\VLC Resume Media V2.txt"
      usrdatdir   = usrdatdir.."/VLC Resume Media/"
      newbasename = usrdatdir.."VLC Resume Media.txt"
      newvars     = usrdatdir.."VLC Resume Media Vars.txt"
    end
    
    -- for now only move data in Windows, linux or OSX
    
    if not (sys()=="win" or sys()=="lin" or sys()=="osx") then
      filebasename = oldbasename   -- save for table routines
      return
    end
    
    -- test for data directory by testing for files in it
    -- don't want to test for all files every startup, so just two main
    
    newfile = io.open(newvars,"r")     -- test for new Vars file
    if newfile then               -- leave if RM directory already exists
      newfile:close()
      filebasename = newbasename  -- save for table routines
      return
    end
    newfile = io.open(newbasename,"r")  -- test for new table 1
    if newfile then               -- leave if RM directory already exists
      newfile:close()
      filebasename = newbasename  -- save for table routines
      return
    end
    
    -- need to create the data directory
    -- os.execute will flash a command prompt window (hate that)    
    
    if sys() == "win" then
      os.execute('mkdir "'..usrdatdir..'"')  -- make the RM directory
    elseif sys() == "lin" or sys() == "osx" then
      os.execute('mkdir -p "'..usrdatdir..'"')
    else                           -- oops
      filebasename = oldbasename   -- save for table routines
      return      
    end

    -- copy table files to new location
    
    for i = 0, limtables do 
      filebasename = oldbasename
      oldfile = io.open(getfilename(i),"r")
      if i==0 and not oldfile then break end  -- assume nothing else
      if oldfile then
        filebasename = newbasename
        newfile = io.open(getfilename(i),"r")
        if newfile then 
          newfile:close()
        else
          newfile = io.open(getfilename(i),"w")
          if newfile then
            for line in oldfile:lines() do  -- copy file
              newfile:write(line.."\n")  
            end
            newfile:close()
          end
        end
        oldfile:close()
      end
    end
    
    -- now delete the old files after making sure new files exist
    
    for i = 0, limtables do
      filebasename = newbasename
      newfile = io.open(getfilename(i),"r")
      if newfile then
        filebasename = oldbasename
        oldfile = io.open(getfilename(i),"r")
        if oldfile then 
          oldfile:close()
          os.remove(getfilename(i))
        end
        newfile:close()
      end
    end
    filebasename = newbasename   -- save for table routines
end

function sys()                    -- determine operating system
    local dir = vlc.config.userdatadir()
    if string.find(dir,"AppData") or 
       string.find(dir,"Documents and Settings") then
      return "win"
    elseif string.find(dir,"share") then
      return "lin"
    elseif string.find(dir,"Application") then
      return "osx"
    else
      return "err"
    end
end

function backuptables()
    local backup, file
    backup = io.open(usrdatdir.."RM tables backup.txt","w")
    if not backup then return end             -- oops
    for i = 1, limtables do   -- all tables, not just visible ones
      file = io.open(getfilename(i),"r")
      if file then
        backup:write("backuptable="..i.."\n")
        for line in file:lines() do  -- copy table
          backup:write(line.."\n")  
        end
        file:close()
      end
    end
    backup:close()
end

function restoretables(s)
    local t1, t2, i
    local msg = "format: restore tbl# (to_tbl#) | restore all"
    if trim(s) == "" then
      label_msg:set_text(msg)
      return
    end
    t1, t2 = string.match(s, "(%S*)%s*(.*)")
    if t2=="" then t2 = nil end
    if t1 == "all" then
      if t2 then
        label_msg:set_text(msg)
        return
      end
    else
      if not t2 then t2 = t1 end
      t1 = integer(t1)      
      t2 = integer(t2)
      if t1 < 1 or t2 < 1 then
        label_msg:set_text(msg)
        return
      elseif t1>limtables or t2>limtables then
        label_msg:set_text("Table number out of range")
        return
      end
    end
    if t1 == "all" then
      for i = 1, limtables do
        restoreonetable(i,i)
      end
      label_msg:set_text("All tables restored")
    elseif t1 == t2 then
      if restoreonetable(t1,t2) then 
        label_msg:set_text("Table "..t1.." restored")
      end
    else
      if restoreonetable(t1,t2) then
        label_msg:set_text("Table "..t1.." restored to table "..t2)
      end
    end
    input:set_text("")
end

function restoreonetable(t1,t2)
    local backup, file, tb, line
    backup = io.open(usrdatdir.."RM tables backup.txt","r")
    if not backup then   -- oops
      label_msg:set_text("Unable to read backup file")
      return false 
    end           
    local foundtable = false
    for line in backup:lines() do  
      tb = integer(getparm(line,"backuptable"))
      if tb > 0 then
        if foundtable then
          break                              -- end of table
        elseif tb == t1 then
          foundtable = true
          file = io.open(getfilename(t2),"w")
          if not file then break end           --  oops
        end
      elseif foundtable then 
        file:write(line.."\n")  
      end
    end
    backup:close()
    if foundtable then 
      file:close() 
      if t2 == tablenum then
        read_names(getfilename(t2),false) -- read new data
      end
    else
      label_msg:set_text("Table "..t1.." not found.")
    end
    return foundtable
end

------------------ VLC Extension functions ----------------------

function descriptor()
    return {title = "Resume Media V3.40",
            version = "3.40" ,
            author = "Rocky Dotterer",
	    url = "http://addons.videolan.org/content/show.php/"..
               "Resume+Media+V3?content=165231",
--	    shortdesc = "Handy, all-purpose playlists",
	    description = "Handy, all-purpose tables "..
               "of media/playlists with resume positions, "..
               "video adjust, media segmenting and more.",
            capabilities = {"input-listener"}
   }
end

function deactivate()
    if tablenum > 0 then
      inpt = vlc.object.input()
      if inpt ~= nil and vlc.playlist.status() == "playing" then
        state = "stop"
        check_names()  -- possible update before leaving
      end
      filename = getfilename(tablenum) 
      write_names()  -- output the updated file
    end
    restoreconfig()            
    vlc.config.set("start-time", 0)
    vlc.config.set("run-time", 0)
end
