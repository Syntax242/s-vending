local QBCore = exports['qb-core']:GetCoreObject()
local isUsingVending = false

CreateThread(function()
    while true do
        Wait(0)
        if isUsingVending then
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 21, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 44, true)
        end
    end
end)

CreateThread(function()
    for i, data in pairs(Config.Models) do
        exports['qb-target']:AddTargetModel(data.model, {
            options = {
                {
                    label = "Vending Machine",
                    icon = "fas fa-shopping-basket",
                    action = function(entity)
                        StartVendingAnimation(entity, i)
                    end
                }
            },
            distance = 2.0
        })
    end
end)

function StartVendingAnimation(entity, machineIndex)

    isUsingVending = true

    QBCore.Functions.Progressbar("vm_look", "You are looking at the machine...", 1500, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_atm@male@enter",
        anim = "enter",
        flags = 49,
    }, {}, {}, function()

        ClearPedTasks(PlayerPedId())
        isUsingVending = false

        OpenVendingMenu(machineIndex)
    end)
end

function OpenVendingMenu(machineIndex)
    QBCore.Functions.TriggerCallback("s-vending:server:getStock", function(stockData)

        local menuOptions = {}

        for i, itm in ipairs(stockData) do
            
            local title
            if itm.stock <= 0 then
                title = ("%s - OUT OF STOCK"):format(itm.label)
            else
                title = ("%s - $%s | Stock: %s"):format(itm.label, itm.price, itm.stock)
            end

            menuOptions[#menuOptions+1] = {
                title = title,
                disabled = itm.stock <= 0,
                event = "s-vending:client:selectAmount",
                args = { machineIndex = machineIndex, itemIndex = i, data = itm }
            }
        end

        lib.registerContext({
            id = 'vending_menu',
            title = 'Vending Machine',
            options = menuOptions
        })

        lib.showContext('vending_menu')

    end, machineIndex)
end

RegisterNetEvent("s-vending:client:selectAmount", function(info)

    local input = lib.inputDialog("How many do you want to buy?", {
        { type = "number", label = "Amount", default = 1, min = 1 }
    })

    if not input then return end
    local amount = tonumber(input[1])
    if not amount or amount <= 0 then return end

    isUsingVending = true

    QBCore.Functions.Progressbar("vm_buy", "Purchasing...", 2000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableCombat = true,
    }, {
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 49,
    }, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        isUsingVending = false

        TriggerServerEvent("s-vending:server:buyItem", info.machineIndex, info.itemIndex, amount)
    end)
end)
