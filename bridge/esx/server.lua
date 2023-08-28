local useCoreInventory = false
if GetResourceState('es_extended') ~= 'started' then return end
if GetResourceState('core_inventory') == 'started' then useCoreInventory = true end

ESX = exports.es_extended:getSharedObject()

function RegisterCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

function RegisterUsableItem(...)
    ESX.RegisterUsableItem(...)
end

function ShowNotification(target, text)
	TriggerClientEvent(GetCurrentResourceName()..":showNotification", target, text)
end

function GetWeapon(source, name)
    if Inventory.GetWeapon then return Inventory.GetWeapon(source, name) end
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(name)
    if item ~= nil then 
        return item.count
    else
        return 0
    end
end

function AddWeapon(source, data) 
    if Inventory.AddWeapon then return Inventory.AddWeapon(source, data) end
    local xPlayer = ESX.GetPlayerFromId(source)

    if useCoreInventory or Config.UsingCoreInventory then       
        return xPlayer.addInventoryItem(data.weapon, 1, data.metadata)
    else
        return xPlayer.addInventoryItem(data.weapon, 1)
    end
end

function RemoveWeapon(source, data)
    if Inventory.RemoveWeapon then return Inventory.RemoveWeapon(source, data) end
    local xPlayer = ESX.GetPlayerFromId(source)

    if useCoreInventory or Config.UsingCoreInventory then       
        local result = xPlayer.removeInventoryItem(data.name, 1, data.currentInventory)
        if result then
            TriggerClientEvent('core_inventory:custom:handleWeaponChange', source, data.defaultData, data.currentInventory)
        end
        return result
    else
        return xPlayer.removeInventoryItem(data.weapon, 1)
    end
end

function CreateWeaponData(source, data, weaponData)
    if Inventory.CreateWeaponData then return Inventory.CreateWeaponData(source, data, weaponData) end
    return data
end