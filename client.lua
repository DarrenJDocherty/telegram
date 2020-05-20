local telegrams = {}
local index = 1
local menu = false

-----------------
--- Change Me ---
-----------------

-- Add your own location(s) to view telegrams here.

local locations = {
    { x=-275.183, y=796.919, z=118.816 },
    { x=-276.260, y=805.332, z=119.380 },
}

-----------------
--- Functions ---
-----------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        for key, value in pairs(locations) do
            if IsPlayerNearCoords(value.x, value.y, value.z) then
                if not menu then
                    DrawText("Press X to view recent telegraphs.",0.5,0.88)
                    if IsControlJustReleased(0, 0x8CC9CD42) then
                        TriggerServerEvent("Telegram:GetMessages")
                    end
                end
            end
        end
    end
end)

function IsPlayerNearCoords(x, y, z)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(GetPlayerPed(), 0))
    local distance = GetDistanceBetweenCoords(playerx, playery, playerz, x, y, z, true)

    if distance < 1 then
        return true
    end
end

function DrawText(text,x,y)
    SetTextScale(0.35,0.35)
    SetTextColor(255,255,255,255)--r,g,b,a
    SetTextCentre(true)--true,false
    SetTextDropshadow(1,0,0,0,200)--distance,r,g,b,a
    SetTextFontForCurrentCommand(0)
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end

function OpenTelegram()
    menu = true
    SetNuiFocus(true, true)
    SendNUIMessage({ display = true, message = telegrams[index].message })
end

function CloseTelegram()
    index = 1
    menu = false
    SetNuiFocus(false, false)
    SendNUIMessage({ display = false })
end

RegisterNetEvent("Telegram:ReturnMessages")
AddEventHandler("Telegram:ReturnMessages", function(data)
    telegrams = data

    if next(telegrams) == nil then
        SetNuiFocus(true, true)
        SendNUIMessage({ display = true, message = "No telegrams to display." })
    else
        OpenTelegram()
    end
end)

-----------------
--- Callbacks ---
-----------------

RegisterNUICallback('back', function()
    if index > 1 then
        index = index - 1
        SendNUIMessage({ display = true, message = telegrams[index].message })
    end
end)

RegisterNUICallback('next', function()
    if index < #telegrams then
        index = index + 1
        SendNUIMessage({ display = true, message = telegrams[index].message })
    end
end)

RegisterNUICallback('close', function()
    CloseTelegram()
end)

RegisterNUICallback('new', function()
    CloseTelegram()

    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", "", "", "", "", 175)

    while (UpdateOnscreenKeyboard() == 0) do
        Wait(0);
    end
    while (UpdateOnscreenKeyboard() == 2) do
        Wait(0);
        break
    end
    if (GetOnscreenKeyboardResult()) then
        TriggerServerEvent("Telegram:SendMessage", GetPlayerName(GetPlayerPed(-1)), GetOnscreenKeyboardResult())
    end
end)
