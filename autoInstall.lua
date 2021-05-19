local shell = require("shell")

-- Download Files
local header = "https://raw.githubusercontent.com/CapdinCrando/SiberiaATMSystem/master/"
files = {"accountApi.lua", "tableToFile.lua", "buttonApi.lua", "atm.lua"}
for _,f in ipairs(files) do
	shell.execute("wget " .. header .. f)
end

-- Start server
shell.execute("atm")