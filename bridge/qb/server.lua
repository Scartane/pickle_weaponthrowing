local useCoreInventory = false
if GetResourceState('qb-core') ~= 'started' then return end
if GetResourceState('core_inventory') == 'started' then useCoreInventory = true end

QBCore = exports['qb-core']:GetCoreObject()

function RegisterCallback(name, cb)
    QBCore.Functions.CreateCallback(name, cb)
end

function RegisterUsableItem(...)
    QBCore.Functions.CreateUseableItem(...)
end

function ShowNotification(target, text)
	TriggerClientEvent(GetCurrentResourceName()..":showNotification", target, text)
end

function GetWeapon(source, name)
    if Inventory.GetWeapon then return Inventory.GetWeapon(source, name) end
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local item = xPlayer.Functions.GetItemByName(name)
    if item ~= nil then 
        return item.amount
    else
        return 0
    end
end

function AddWeapon(source, data) 
    if Inventory.AddWeapon then return Inventory.AddWeapon(source, data) end
    local xPlayer = QBCore.Functions.GetPlayer(source)

    if useCoreInventory or Config.UsingCoreInventory then
        return xPlayer.Functions.AddItem(data.weapon, 1, nil, data.metadata)
    else
        return xPlayer.Functions.AddItem(data.weapon, 1)
    end
end

function RemoveWeapon(source, data) 
    if Inventory.RemoveWeapon then return Inventory.RemoveWeapon(source, data) end
    local xPlayer = QBCore.Functions.GetPlayer(source)

    if useCoreInventory or Config.UsingCoreInventory then
        local result = xPlayer.Functions.RemoveItem(data.weapon, 1, nil, nil, data.currentInventory)
        if result then
            TriggerClientEvent('core_inventory:client:handleWeaponChange', source, data.defaultData, data.currentInventory)
        end
        return result
    else
        return xPlayer.Functions.RemoveItem(data.weapon, 1)
    end
end

function CreateWeaponData(source, data, weaponData)
    if Inventory.CreateWeaponData then return Inventory.CreateWeaponData(source, data, weaponData) end
    return data
end