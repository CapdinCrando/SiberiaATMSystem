-- Imports
local shell = require("shell")
local ttf = require("tableToFile")

-- Download file list
local header = "https://raw.githubusercontent.com/CapdinCrando/SiberiaATMSystem/master/"
shell.execute("wget -f" .. header .. "downloadList")

-- Download Files
files = ttf.load("downloadList")
for _,f in ipairs(files) do
	shell.execute("wget " .. header .. f)
end

-- Start server
shell.execute("atm")