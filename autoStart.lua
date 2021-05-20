-- Imports
local shell = require("shell")
local serialization = require("serialization")

-- Download file list
local header = "https://raw.githubusercontent.com/CapdinCrando/SiberiaATMSystem/master/"
shell.execute("wget -f" .. header .. "downloadList")

-- Download Files
local tableFile = assert(io.open("downloadList"))
local files = serialization.unserialize(tableFile:read("*all"))
for _,f in ipairs(files) do
	shell.execute("wget " .. header .. f)
end

-- Start server
shell.execute("atm")