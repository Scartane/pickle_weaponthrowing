if GetResourceState('es_extended') ~= 'started' then return end

ESX = exports.es_extended:getSharedObject()

function ShowNotification(text)
	ESX.ShowNotification(text)
end

function ShowHelpNotification(text)
	ESX.ShowHelpNotification(text)
end

function ServerCallback(name, cb, ...)
    ESX.TriggerServerCallback(name, cb,  ...)
end

function IsPlayerDead()
    return IsEntityDead(PlayerPedId())
end

RegisterNetEvent(GetCurrentResourceName()..":showNotification", function(text)
    ShowNotification(text)
end)

if GetResourceState('core_inventory') == 'started' then 
    RegisterNetEvent('core_inventory:custom:handleWeapon', function(currentWeapon, currentWeaponData, currentWeaponInventory)
        TriggerServerEvent("pickle_weaponthrowing:SetCurrentWeapon", currentWeaponData, currentWeaponInventory)
    end)
end
