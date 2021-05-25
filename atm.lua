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

local function chooseScreen()
	api.clear()
	api.cleartable()
	api.label(1, 3, "Welcome, " .. c .. "!")
	api.label(3, 3, "Please choose an action:")

	api.setTable("Check balance", checkBalance, 10,20,3,5)
	api.setTable("Withdrawl", withdrawl, 10,20,3,5)
	api.setTable("Deposit", deposit, 10,20,3,5)
	api.setTable("Exit", exit, 10,20,3,5)
	api.screen()

	local _, _, x, y = event.pull("touch")
	api.checkxy(x, y)
end

local function checkBalance()
	api.clear()
	api.cleartable()
	api.label(1, 1, "Check balance")
	api.setTable("Check balance", checkBalance, 10,20,3,5)
end

local function withdrawl()
	api.clear()
	api.cleartable()
	api.label(1, 1, "Withdrawl")
end

local function deposit()
	api.clear()
	api.cleartable()
	api.label(1, 1, "Deposit")
end

local isUsing = true
local function exit()
	api.clear()
	api.cleartable()
	api.label(1, 10, "Check balance")
	-- Open door
	os.sleep(5)
	isUsing = false
end

--gpu.setResolution(30, 10)
term.setCursorBlink(false)

-- Main Loop
while true do
	-- State 1
	api.clear()
	api.label(1, 3, "Welcome to Siberia!")
	api.label(1, 5, "Please insert card to continue")
	api.label(28, 7, "-->")
	
	-- State 2
	a,b,c,d,e = event.pull("magData")
	-- Needs to check account
	-- Close door if good
	chooseScreen()
	isUsing = true
	while isUsing do
		

		-- State 3
		
	end
end

-- Handle create account event

-- Access card event

-- Present options

-- Options (Withdrawl, Deposit, Check Balance)

-- Return