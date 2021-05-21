-- Imports
local shell = require("shell")
local serialization = require("serialization")

local programName = "atm"

-- Change PWD
shell.setWorkingDirectory("/" .. programName .. "/")

-- Download file list
local header = "https://raw.githubusercontent.com/CapdinCrando/"
shell.execute("wget -f " .. header .. "SiberiaATMSystem/master/downloadList.txt")

-- Download Files
local tableFile = assert(io.open("downloadList.txt"))
local files = serialization.unserialize(tableFile:read("*all"))
for k,v in ipairs(files) do
	for _,f in ipairs(v) do
		shell.execute("wget -f " .. header .. k .. f)
	end
end

-- Start server
shell.execute(programName)