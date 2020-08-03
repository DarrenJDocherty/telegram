RegisterServerEvent("Telegram:GetMessages")
AddEventHandler("Telegram:GetMessages", function()
	local _source = source

	TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		local recipient = user.getIdentifier()
		local recipientid = user.getSessionVar("charid")
		
		MySQL.Async.fetchAll("SELECT * FROM telegrams WHERE recipient=@recipient AND recipientid=@recipientid ORDER BY id DESC", { ['@recipient'] = recipient, ['@recipientid'] = recipientid }, function(result)
			TriggerClientEvent("Telegram:ReturnMessages", _source, result)
		end)
	end)
end)

RegisterServerEvent("Telegram:SendMessage")
AddEventHandler("Telegram:SendMessage", function(firstname, lastname, message)
	local _source = source

	TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		local sender = user.getName()

		-- get the steam and character id of the recipient
		MySQL.Async.fetchAll("SELECT identifier, characterid FROM characters WHERE firstname=@firstname AND lastname=@lastname", { ['@firstname'] = firstname, ['@lastname'] = lastname}, function(result)
			if result[1] then 
				local recipient = result[1].identifier 
				local recipientid = result[1].characterid

				local paramaters = { ['@sender'] = sender, ['@recipient'] = recipient, ['@recipientid'] = recipientid, ['@message'] = message }

				MySQL.Async.execute("INSERT INTO telegrams (sender, recipient, recipientid, message) VALUES (@sender, @recipient, @recipientid, @message)",  paramaters)
			else 
				TriggerClientEvent("redemrp_notification:start", _source, "Unable to process Telegram. Invalid first or lastname.", 3)
			end
		end)
    end)
end)