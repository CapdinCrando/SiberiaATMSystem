local accountApi = require("accountApi")
local api = require("buttonApi")
local event = require("event")
local term = require("term")
local component = require("component")
local gpu = component.gpu

local function handleAccountCreation(signal, _, name)
	print(name)
end

event.listen("bioReader", handleAccountCreation)

local function writeTerm(x, y, message)
	term.setCursor(x,y)
	term.write(message)
end

-- Main Loop
while true do
	api.clear()
	term.setCursorBlink(false)
	gpu.setResolution(30, 10)
	writeTerm(1, 3, "Welcome to Siberia!")
	writeTerm(1, 5, "Please insert card to continue")
	writeTerm(28, 6, "-->")
	
	a,b,c,d,e,f = event.pull("magData")
	print(a)
	print(b)
	print(c)
	print(d)
	print(e)
	print(f)
end

-- Handle create account event

-- Access card event

-- Present options

-- Options (Withdrawl, Deposit, Check Balance)

-- Return