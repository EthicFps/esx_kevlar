print('Made by Ethic')

local usekevlar = false
local playerPed = PlayerPedId() -- Optimisation
ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) -- Déclaration esx
    end
end)

RegisterCommand("dekev", function() --Commande admin pour retirer le kev
    if usekevlar and ESX.GetPlayerData()['group'] ~= 'user' then  -- Fonctionne uniquement si le group =/ user
        AddArmourToPed(playerPed,0) -- Mettre le kev a 0
        SetPedArmour(playerPed, 0)
        ESX.ShowNotification("Vous avez perdu votre kevlar.") -- Notif ingame
    else
        ESX.ShowNotification("Vous n'avez pas de kevlar.")-- Notif ingame
    end
end)

RegisterCommand("kev", function() -- Pour enlever le kevlar entant que admin
    if not usekevlar and ESX.GetPlayerData()['group'] ~= 'user' then -- Si le groupe est different de user ça marche--
        AddArmourToPed(playerPed,100)
        SetPedArmour(playerPed, 100)    
        usekevlar = true
        ESX.ShowNotification("Vous avez reçu un kevlar.") -- Notif ingame
    else 
        ESX.ShowNotification("Vous avez deja un kevlar.") -- Notif ingame
    end
end)



RegisterNetEvent('ethicfps:kevlar')
AddEventHandler('ethicfps:kevlar', function()
    if IsPedInAnyVehicle(PlayerPedId(), true) then
        ESX.ShowNotification('Impossible de mettre un gilet en voiture !', false, true, 30) -- Notif pour les kevlar en vehicule
    else
        local playerPed = PlayerPedId()
        ExecuteCommand("e adjusttie") -- Emote 
        Citizen.Wait(2500) -- Temps d'attente pour l'emote
        ExecuteCommand("e adjust") -- Emote 
        Citizen.Wait(4000) -- Temps d'attente pour l'emote
        ESX.ShowNotification("Vous avez enfilé votre kevlar !")   -- Notif ingame
        usekevlar = true
        TriggerEvent('skinchanger:getSkin', function(skin) -- Kevlar sur le skin
	        if skin.sex == 0 then
	     	TriggerEvent('skinchanger:loadSkin', {  -- Kevlar skin homme
	         sex          = 0,
             bproof_1     = 10,
	         bproof_2     = 1,
        })
	        else
		    TriggerEvent('skinchanger:loadSkin', { -- Kevlar skin femme
	         sex          = 1,
             bproof_1     = 10,
	         bproof_2     = 1,
        })
	        end
        end)
        AddArmourToPed(playerPed,100) -- Mettre le kev a 100
        SetPedArmour(playerPed, 100)  -- Mettre le kev a 100 
        --exports.esx_xp:ESXP_Add(100)  -- Ajouter de l'xp (esx_xp est nécessaire)
        end
end)


-- Enlever le gilet sur le skin quand il n'y a plus de kevlar

local playerPed = PlayerPedId()

Citizen.CreateThread(function() -- Enlevez le kevlar sur le skin
    while true do
        Citizen.Wait(10000) -- Check toutes les 10sec (optimisation)
        local kevlaramount = GetPedArmour(playerPed) -- Optimisation
        if usekevlar and kevlaramount <= 1 then -- Retirer le kev si il est a moin de 1
            usekevlar = false
            ESX.ShowNotification("Vous n'avez plus de kevlar !") -- Notification pour avertir le joueur
             TriggerEvent('skinchanger:getSkin', function(skin) -- Retirer le kevlar sur le skin 
              if skin.sex == 0 then -- Retirer le kevlar sur le skin Homme
                     TriggerEvent('skinchanger:loadSkin', {
                     sex          = 0,
                     bproof_1     = 0,
                     bproof_2     = 0,
            })
                else -- Revlar sur le skin Homme
                    TriggerEvent('skinchanger:loadSkin', {
                     sex          = 1,
                     bproof_1     = 0,
                     bproof_2     = 0,
            })
                end     
            end)
       end
    end
end) 
    


