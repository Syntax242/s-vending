-- discord.lua
local json = json or require("json") 

function SendVendingLog(title, fields)
    if not Config.LogsEnabled then return end
    if not Config.LogWebhook or Config.LogWebhook == "" then return end

    local embed = {
        {
            ["title"] = title,
            ["color"] = 3447003,
            ["fields"] = fields,
            ["footer"] = {
                ["text"] = "s-vending Logs • " .. os.date("%Y-%m-%d %H:%M:%S")
            }
        }
    }

    PerformHttpRequest(Config.LogWebhook, function() end, "POST", json.encode({
        username = "Vending Logs",
        embeds = embed
    }), {
        ["Content-Type"] = "application/json"
    })
end
