local QBCore = exports['qb-core']:GetCoreObject()

MachineStocks = {}

local function LoadMachineStocks()
    MachineStocks = {}

    for i, machine in ipairs(Config.Models) do
        local group = Config.Items[machine.items]
        MachineStocks[i] = {}

        for k, item in ipairs(group) do
            MachineStocks[i][k] = {
                item = item.item,
                label = item.label,
                price = item.price,
                stock = item.stock or 10
            }
        end
    end

    if Config.Debug then
        print("^2[s-vending] Stocks refreshed!^0")
    end
end

LoadMachineStocks()

CreateThread(function()
    while true do
        Wait(Config.StockRefreshTime * 1000)
        LoadMachineStocks()
    end
end)

QBCore.Functions.CreateCallback("s-vending:server:getStock", function(source, cb, index)
    cb(MachineStocks[index])
end)

RegisterNetEvent("s-vending:server:buyItem", function(machineIndex, itemIndex, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local machine = MachineStocks[machineIndex]
    if not machine or not machine[itemIndex] then return end

    local itm = machine[itemIndex]

    if itm.stock < amount then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'No Stock',
            description = 'There is not enough stock of this item.',
            type = 'error'
        })
        return
    end

    local totalPrice = itm.price * amount

    if Player.PlayerData.money['cash'] < totalPrice then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Not Enough Money',
            description = 'You do not have enough money.',
            type = 'error'
        })
        return
    end

    Player.Functions.RemoveMoney('cash', totalPrice)
    itm.stock = itm.stock - amount

    exports.ox_inventory:AddItem(src, itm.item, amount)

    TriggerClientEvent('ox_lib:notify', src, {
        title = 'Purchased',
        description = ("%sx %s purchased!"):format(amount, itm.label),
        type = 'success'
    })

    local identityValue = ""
    local citizen = Player.PlayerData.citizenid
    local license = Player.PlayerData.license

    if Config.LogIdentity == "citizenid" then
        identityValue = citizen
    elseif Config.LogIdentity == "license" then
        identityValue = license
    elseif Config.LogIdentity == "both" then
        identityValue = "CitizenID: " .. citizen .. "\nLicense: " .. license
    end

    local charName = ("%s %s"):format(
        Player.PlayerData.charinfo.firstname,
        Player.PlayerData.charinfo.lastname
    )

    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)

    local locationString = ("X: %.2f | Y: %.2f | Z: %.2f"):format(coords.x, coords.y, coords.z)

    SendVendingLog("Vending Machine Purchase", {
        { name = "Player Identity", value = identityValue, inline = false },
        { name = "Character Name", value = charName, inline = false },
        { name = "Location", value = locationString, inline = false },
        { name = "Purchased Item", value = itm.label, inline = true },
        { name = "Amount", value = tostring(amount), inline = true },
        { name = "Paid Money", value = tostring(totalPrice), inline = true }
    })
end)

if Config.AdminRestockEnabled then
    RegisterCommand(Config.AdminRestockCommand, function(source)
        local src = source
        
        if src ~= 0 then
            local Player = QBCore.Functions.GetPlayer(src)
            if not Player or (Player.PlayerData.group ~= "admin" and Player.PlayerData.group ~= "god") then
                TriggerClientEvent('ox_lib:notify', src, {
                    title = 'No Permission',
                    description = 'You cannot use this command.',
                    type = 'error'
                })
                return
            end
        end

        LoadMachineStocks()

        print("^3[s-vending] Stocks refreshed via admin command.^0")

        if src ~= 0 then
            TriggerClientEvent('ox_lib:notify', src, {
                title = 'Stocks Refreshed',
                description = 'All vending machine stocks have been reset.',
                type = 'success'
            })
        end
    end)
end

