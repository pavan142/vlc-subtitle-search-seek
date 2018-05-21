local file = io.open('/home/pavan/Videos/movies/Lootera.srt', 'r')

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

FormatSubtitle('/home/pavan/Videos/movies/Lootera.srt')
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

local matches = getMatchingSubs("know", reverseSubtitleArray)
print("length of matches  "..#matches)

for i = 1, #matches, 1 do
    local subtitle = matches[i]
    local s = string.gsub(subtitle, "\r", " ")
    print(s)
    local timeList = reverseSubtitleArray[subtitle]
    for i = 1, #timeList, 1 do
        time = timeList[i]
        print(time)
    end
end