-- Imports
local shell = require("shell")
local serialization = require("serialization")

-- Download file list
local header = "https://raw.githubusercontent.com/CapdinCrando/SiberiaATMSystem/master/"
shell.execute("wget -f" .. header .. "downloadList.txt")

-- Download Files
local tableFile = assert(io.open("downloadList.txt"))
local files = serialization.unserialize(tableFile:read("*all"))
for _,f in ipairs(files) do
	shell.execute("wget -f" .. header .. f)
end

-- Start server
shell.execute("atm")