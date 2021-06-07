local accountApi = require("accountApi")
local api = require("buttonApi")
local event = require("event")
local term = require("term")
local component = require("component")
local gpu = component.gpu

local bankName = "Pandora National"

local chooseScreen, welcomeScreen

local function handleAccountCreation()
	api.clear()
	api.clearTable()
	api.label(1, 1, "Please press the bioscanner to create account")
	api.label(1, 3, "--->")
	api.screen()

	local _,_,id = event.pull("bioReader")
	local response = accountApi.createAccount(id)
	print('\n' .. response)

	os.sleep(5)

	chooseScreen()
end

local function checkBalance()
	api.clear()
	api.clearTable()
	api.label(1, 1, "Please right click scanner to check balance")
	api.screen()

	local _,_,id = event.pull("bioReader")
	local response = tostring(accountApi.getAmount(id))
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
	api.label(1, 1, "Please right click scanner to withdrawl amount")
	api.screen()
	local _,_,id = event.pull("bioReader")

	api.clear()
	-- Check amount in ATM
	local response = accountApi.transfer(id, nil, tonumber(amount))
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
	api.label(1, 3, "Right click scanner to deposit")
	api.label(28, 7, "-->")
	api.screen()

	-- Take box and calculate amount
	local amount = 1

	api.clear()
	api.label(1, 1, "Please right click scanner to withdrawl amount")
	api.screen()
	local _,_,id = event.pull("bioReader")

	api.clear()
	-- Check amount in ATM
	local response = accountApi.transfer(nil, id, tonumber(amount))
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
	api.label(3, 1, "Welcome!")
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
	api.clear()
	api.label(1, 3, "Welcome to " .. bankName .. " Bank!")
	api.label(1, 5, "Please right click scanner to continue")
	api.label(28, 7, "-->")
	
	-- State 2
	local _,_,id = event.pull("bioReader")
	if(accountApi.doesAccountExist(id))
		-- Close door if good
		chooseScreen()
	else
		api.clear()
		api.clearTable()
		api.label(1, 1, "You do not have an account. Would you like to create one?")
		api.setTable("Yes", handleAccountCreation, 2,14,3,5)
		api.setTable("No", welcomeScreen, 16,29,3,5)
		api.screen()

		local _, _, x, y = event.pull("touch")
		api.checkxy(x, y)
	end
end

--gpu.setResolution(30, 10)
term.setCursorBlink(false)
accountApi.loadFile()
welcomeScreen()