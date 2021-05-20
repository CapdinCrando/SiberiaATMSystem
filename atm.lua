local accountApi = require("accountApi")
local api = require("buttonApi")
local event = require("event")
local term = require("term")
local component = require("component")
local gpu = component.gpu

local function handleAccountCreation(signal, name)
	print("")
end

event.listen("bioReader", handleAccountCreation)

local function writeTerm(x, y, message)
	term.setCursor(x,y)
	term.write(message)
end

-- Print welcome
api.clear()
term.setCursorBlink(false)
gpu.setResolution(30, 10)
writeTerm(1, 3, "Welcome to Siberia!")
writeTerm(1, 5, "Please insert card to continue")
writeTerm(28, 6, "-->")

-- Handle create account event

-- Access card event

-- Present options

-- Options (Withdrawl, Deposit, Check Balance)

-- Return
os.sleep(0)