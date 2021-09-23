ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-------------Light Diving suit
ESX.RegisterUsableItem('plongee1', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('plongee1', 1)
        TriggerClientEvent('esx_tenues:settenueplongee1', _source)
end)

-------------diving suit
ESX.RegisterUsableItem('plongee2', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('plongee2', 1)
        TriggerClientEvent('esx_tenues:settenueplongee2', _source)
end)

-------------giveback1
RegisterServerEvent('abcxyz_diving:server:GiveBackGear1')
AddEventHandler('abcxyz_diving:server:GiveBackGear1', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    
    xPlayer.addInventoryItem('plongee1', 1)
end)
-------------giveback2
RegisterServerEvent('abcxyz_diving:server:GiveBackGear2')
AddEventHandler('abcxyz_diving:server:GiveBackGear2', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    
    xPlayer.addInventoryItem('plongee2', 1)
end)
------------command1
RegisterCommand(Config.CommandTakeOffSuit1, function(source, args, user)
    TriggerClientEvent("esx_tenues:coido1", source, false)
end, false)
------------command2
RegisterCommand(Config.CommandTakeOffSuit2, function(source, args, user)
    TriggerClientEvent("esx_tenues:coido2", source, false)
end, false)
