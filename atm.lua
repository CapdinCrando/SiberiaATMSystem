local accountApi = require("accountApi")
local api = require("buttonApi")
local event = require("event")
local term = require("term")
local component = require("component")
local gpu = component.gpu

local bankName = "Pandora National"
local playerName = nil

local chooseScreen, welcomeScreen

local function handleAccountCreation(signal, _, name)
	print(name)
end

event.listen("bioReader", handleAccountCreation)

local function checkBalance()
	api.clear()
	api.clearTable()
	api.label(1, 1, "Please swipe card again to check balance")
	api.screen()

	local a,b,c,d,e = event.pull("magData")
	local response =  tostring(accountApi.getAmount(c))
	api.clear()
	api.clearTable()
	if response == "Account does not exist!" then
		api.label(1, 1, response)
	else
		api.label(1, 1, " Account balance: $" .. response)
	end
	
	api.setTable("Return", chooseScreen, 16,29,7,9)
	api.screen()

	local _, _, x, y = event.pull("touch")
	api.checkxy(x, y)
end

local function withdrawl()
	api.clear()
	api.clearTable()
	api.label(1, 1, "Enter amount to withdrawl: $")
	api.screen()
	amount = io.read("*line")

	api.clear()
	api.label(1, 1, "Please swipe card to withdrawl amount")
	api.screen()
	local a,b,c,d,e = event.pull("magData")

	api.clear()
	-- Check amount in ATM
	local response = accountApi.transfer(c, nil, tonumber(amount))
	if response == "Transaction successful!" then
		
		api.label(1, 3, "Please take your money!")
		-- Give cash
	end
	api.label(1, 1, response)
	
	api.setTable("Return", chooseScreen, 16,29,7,9)
	api.screen()

	local _, _, x, y = event.pull("touch")
	api.checkxy(x, y)
end

local function deposit()
	api.clear()
	api.clearTable()
	-- Give box
	api.label(1, 1, "Please deposit cash in box")
	api.label(1, 3, "Swipe card to deposit")
	api.label(28, 7, "-->")
	api.screen()

	-- Take box and calculate amount
	local amount = 1

	api.clear()
	api.label(1, 1, "Please swipe card to withdrawl amount")
	api.screen()
	local a,b,c,d,e = event.pull("magData")

	api.clear()
	-- Check amount in ATM
	local response = accountApi.transfer(nil, c, tonumber(amount))
	if response == "Transaction successful!" then
		
		api.label(1, 3, "Please take your money!")
		-- Give cash
	end
	api.label(1, 1, response)
	
	api.setTable("Return", chooseScreen, 16,29,7,9)
	api.screen()

	local _, _, x, y = event.pull("touch")
	api.checkxy(x, y)
end

local function exit()
	api.clear()
	api.clearTable()
	api.label(1, 1, "Thank you for using " .. bankName .. " Bank!")
	-- Open door
	os.sleep(5)
	welcomeScreen()
end

chooseScreen = function()
	api.clear()
	api.clearTable()
	api.label(3, 1, "Welcome, " .. playerName .. "!")
	api.label(3, 2, "Please choose an action:")

	api.setTable("Check $", checkBalance, 2,14,3,5)
	api.setTable("Withdrawl", withdrawl, 16,29,3,5)
	api.setTable("Deposit", deposit, 2,14,7,9)
	api.setTable("Exit", exit, 16,29,7,9)
	api.screen()

	local _, _, x, y = event.pull("touch")
	api.checkxy(x, y)
end

welcomeScreen = function()
	playerName = nil
	api.clear()
	api.label(1, 3, "Welcome to " .. bankName .. " Bank!")
	api.label(1, 5, "Please insert card to continue")
	api.label(28, 7, "-->")
	
	-- State 2
	local a,b,c,d,e = event.pull("magData")
	playerName = c
	-- Needs to check account
	-- Close door if good
	chooseScreen()
end

--gpu.setResolution(30, 10)
term.setCursorBlink(false)
accountApi.loadFile()
welcomeScreen