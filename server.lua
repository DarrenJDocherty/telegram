RegisterServerEvent("Telegram:GetMessages")
AddEventHandler("Telegram:GetMessages", function()
	local src = source
	MySQL.Async.fetchAll("SELECT * FROM telegrams ORDER BY id DESC", {}, function(data)
        TriggerClientEvent("Telegram:ReturnMessages", src, data)
	end)
end)

RegisterServerEvent("Telegram:SendMessage")
AddEventHandler("Telegram:SendMessage", function(sender, message)
	MySQL.Async.execute("INSERT INTO telegrams (sender, message) VALUES (@sender, @message)",  { ['@sender'] = sender, ['@message'] = message })
end)
