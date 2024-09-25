ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('armor', function (source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('armor', 1)

    TriggerClientEvent('ethicfps:kevlar', source)

    print(userkevlar)


end)