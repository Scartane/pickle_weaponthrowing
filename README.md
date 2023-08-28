# pickle_weaponthrowing [C8RE INVENTORY COMPATIBLE]
A multi-framework weapon throwing script.

In **core_inventory resource folder**, locate `/client/main.lua` and add this event at the end of the file :
```lua
RegisterNetEvent('core_inventory:custom:handleWeaponChange', function(weapondata, weaponInventory)
    useWeapon(weapondata, weaponInventory)
    Holders[weaponInventory] = nil
end)
```

Then, in the same file, locate the `function useWeapon(weapon, inventory)` and at the end of the function, before the last `end` that close it, add :
```lua 
    TriggerEvent('core_inventory:custom:handleWeapon', currentWeapon, currentWeaponData, currentWeaponInventory)
```