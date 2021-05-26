-- Imports
local shell = require("shell")
local computer = require("computer")
local process = require("process")
local component = require("component")

local programName = "atm"

-- Create directory
shell.execute("mkdir /".. programName)

-- Download autoStart script
shell.execute("wget https://raw.githubusercontent.com/CapdinCrando/SiberiaATMSystem/master/autoStart.lua /" .. programName .. "/autoStart.lua")

-- Write to .shrc (for startup)
local startFile = assert(io.open("/home/.shrc", "a"))
startFile:write("\n/" .. programName .. "/autoStart.lua\n")
startFile:close()

-- Copy serverData file
shell.execute("cp /data/serverData /" .. programName .. "/serverData")

-- Generate vendor file
local vendorDir = "/data/vendor/"
shell.execute("mkdir " .. vendorDir)
local startFile = assert(io.open(vendorDir .. component.modem.address, "w"))
startFile:write("")
startFile:close()

-- Remove auto install script
shell.execute("rm " .. shell.resolve(process.info().path))

-- Restart computer
computer.shutdown(true)