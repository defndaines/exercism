local BankAccount = {}

local function validate(account, amount)
	print("ACCOUNT AMOUNT: ", account.amount)
	print("AMOUNT: ", amount)
	if account.state == "closed" then
		error()
	end
	if  amount > account.amount then
		error()
	end
end

function BankAccount.new()
	local account = { amount = 0, state = "open" }

	account.balance = function()
		print("AMOUNT: ", account.amount)
		return account.amount
	end

	account:deposit = function(amount)
		validate(account, amount)
		self.amount = self.amount + amount
	end

	account:withdraw = function(amount)
		validate(account, amount)
		self.amount = self.amount - amount
	end

	account:close = function()
		account.state = "closed"
	end

	return account
end

return BankAccount
