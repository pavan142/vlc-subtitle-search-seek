function descriptor()
    return { title = "Hello World" ;
             version = "0.1" ;
             author = "Pavan Tirumani" ;
             capabilities = {} }
end

function isItTimeLine(line)
  local timePattern = "%d%d%:%d%d%:%d%d%,%d%d%d%s%-%-%>%s%d%d%:%d%d%:%d%d%,%d%d%d"
  local startTimePattern = "%d%d%:%d%d%:%d%d"
  start, finish = string.find(line, timePattern)
  if start ~= nil then
      return string.match(line, startTimePattern)
  end
  return nil
end

function ReverseTable(t) -- table
local rt={}
local n=#t
for i, v in ipairs(t) do
  rt[n-i+1]=v
end
return rt
end

function SplitString(s, d) -- string, delimiter pattern
local t={}
local i=1
local ss, j, k
local b=false
while true do
  j,k = string.find(s,d,i)
  if j then
    ss=string.sub(s,i,j-1)
    i=k+1
  else
    ss=string.sub(s,i)
    b=true
  end
  table.insert(t, ss)
  if b then break end
end
return t
end

function String2time(timeString)
local tt = ReverseTable(SplitString(timeString,":")) -- delimiters :/*-+
return (tonumber(tt[1]) or 0) + (tonumber(tt[2]) or 0)*60 + (tonumber(tt[3]) or 0)*3600 + (tonumber(tt[4]) or 0)*24*3600
end

local subtitleArray = {}
local reverseSubtitleArray = {}

function FormatSubtitle (filePath)
  local lineCount = 0
  local currentText = ""
  local currentTime = ""
  local inSub = false
      
  local file = io.open(filePath, 'r')
   
  while true do
      line = file:read("*l")
      if (line == nil) then
          print("reaced the end of file")
          print("total number of lines is: ")
          print(lineCount)
          break
      end
      
      lineCount = lineCount + 1
      if inSub then
          if (line == "\r") then
              inSub = false
              subtitleArray[currentTime] = currentText
              if reverseSubtitleArray[currentText] then
                  table.insert(reverseSubtitleArray[currentText], currentTime)
              else
                  reverseSubtitleArray[currentText] = {}                
                  table.insert(reverseSubtitleArray[currentText], currentTime)
              end
              currentText = ""
              currentTime = ""
          else
              currentText = currentText..line
          end
      else 
          local t = isItTimeLine(line)
          if t then
              inSub = true;
              currentText = ""
              currentTime = String2time(t)
          end
      end

  end
end

function getMatchingSubs(searchString, sourceTable) 
  local matches = {}
     for subtitle, timeList in pairs(sourceTable) do
         start, finish = string.find(subtitle, searchString)
         if start ~=null then
             table.insert(matches, subtitle)
         end
     end
  return matches
 end
 
 function tablelength(T)
     local count = 0
     for _ in pairs(T) do count = count + 1 end
     return count
 end
 
function submit_search()
  print("searching for "..search_input:get_text())
  local search_string = search_input:get_text() 
  local matches = getMatchingSubs(search_string, reverseSubtitleArray)
  local possibleTimes = {}
  for i = 1, #matches, 1 do
    local subtitle = matches[i]
    local s = string.gsub(subtitle, "\r", " ")
    print(s)
    local timeList = reverseSubtitleArray[subtitle]
    for i = 1, #timeList, 1 do
        time = timeList[i]
        table.insert(possibleTimes, time)
        print(time)
    end
  end
  seek_position(possibleTimes[1])
end

function seek_position(time) 
  print("the seek position is: "..time)
  local input = vlc.object.input()
  vlc.var.set(input,'time',time);
end

function set_subtitle ()
  local subtitlePath = subtitle_input:get_text()
  print("setting subtitle: "..subtitlePath)
  FormatSubtitle('/home/pavan/Videos/movies/Lootera.srt')
  vlc.input.add_subtitle(subtitlePath)
end

function activate()
    local d = vlc.dialog("Hello Bengaluru !")
    FormatSubtitle('/home/pavan/Videos/movies/Lootera.srt')    
    subtitle_input = d:add_text_input("subtitle")    
	  d:add_button(" Set Subtitle ", set_subtitle)
    d:add_label(" Fabulous Saturday")
	  search_input = d:add_text_input("query")    
	  d:add_button(" Go!! ", submit_search)
    
    local isplaying = vlc.input.is_playing()
    vlc.msg.info("hello there ! lets go debugging over the weekend")
    vlc.msg.info(type(isplaying))
    if isplaying then
      vlc.msg.info("input is playing")
    else
      vlc.msg.info("input is not playing")
    end
    d:show()
end

function deactivate()
end

function close()
    vlc.deactivate()
end