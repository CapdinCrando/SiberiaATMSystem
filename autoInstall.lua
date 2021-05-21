-- Imports
local shell = require("shell")
local computer = require("computer")
local process = require("process")

local programName = "atm"

-- Create directory
shell.execute("mkdir /".. programName)

-- Download autoStart script
shell.execute("wget https://raw.githubusercontent.com/CapdinCrando/SiberiaATMSystem/master/autoStart.lua /" .. programName .. "/autoStart.lua")

-- Write to .shrc (for startup)
local startFile = assert(io.open("/home/.shrc", "a"))
startFile:write("\n/" .. programName .. "/autoStart.lua\n")
startFile:close()

-- Remove auto install script
shell.execute("rm " .. shell.resolve(process.info().path))

-- Restart computer
computer.shutdown(true)