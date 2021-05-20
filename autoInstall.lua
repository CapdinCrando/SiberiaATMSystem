-- Imports
local shell = require("shell")
local computer = require("computer")

-- Create directory
shell.execute("mkdir /atm")

-- Download autoStart script
shell.execute("wget https://raw.githubusercontent.com/CapdinCrando/SiberiaATMSystem/master/autoStart.lua /atm/autoStart.lua")

-- Write to .shrc (for startup)
local startFile = assert(io.open("~/.shrc", "a"))
startFile:write("\n/atm/updateAndStart.lua\n")
startFile:close()

-- Remove auto install script
shell.execute("rm /atm/autoStart.lua")

-- Restart computer
computer.shutdown(true)