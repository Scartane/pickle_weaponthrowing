if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

function ServerCallback(name, cb, ...)
    QBCore.Functions.TriggerCallback(name, cb,  ...)
end

function ShowNotification(text)
	QBCore.Functions.Notify(text)
end

function ShowHelpNotification(text)
    AddTextEntry('qbHelpNotification', text)
    BeginTextCommandDisplayHelp('qbHelpNotification')
    EndTextCommandDisplayHelp(0, false, false, -1)
end

function IsPlayerDead()
    return IsEntityDead(PlayerPedId())
end

RegisterNetEvent(GetCurrentResourceName()..":showNotification", function(text)
    ShowNotification(text)
end)

if GetResourceState('core_inventory') == 'started' then 
    RegisterNetEvent('core_inventory:client:handleWeapon', function(currentWeapon, currentWeaponData, currentWeaponInventory)
        TriggerServerEvent("pickle_weaponthrowing:SetCurrentWeapon", currentWeaponData, currentWeaponInventory)
    end)
end