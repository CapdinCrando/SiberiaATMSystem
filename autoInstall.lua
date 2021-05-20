-- Imports
local shell = require("shell")
local computer = require("computer")

-- Create directory
shell.execute("mkdir /atm")

-- Download autoStart script
shell.execute("wget https://raw.githubusercontent.com/CapdinCrando/SiberiaATMSystem/master/autoStart.lua /atm/autoStart.lua")

-- Write to .shrc (for startup)
local startFile = assert(io.open("/home/.shrc", "a"))
startFile:write("\n/atm/autoStart.lua\n")
startFile:close()

-- Remove auto install script
shell.execute("rm " .. shell.getPath())

-- Restart computer
--computer.shutdown(true)