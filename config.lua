Config = {}



-------- Script Settings --------

-- Stock refresh time (seconds)
Config.StockRefreshTime = 600 -- 10 minutes

-- Debug mode (true = prints restock info to server console)
Config.Debug = false



-------- Admin Settings --------

-- Enable/Disable admin restock command
Config.AdminRestockEnabled = true

-- Admin restock command name
Config.AdminRestockCommand = "vendingrestock"

-- must be qbcore admin system (qbcore.admin or qbcore.god)

-------- Log System --------

-- Enable/Disable purchase logging
Config.LogsEnabled = true

-- Discord Webhook URL
Config.LogWebhook = "set_your_discord_webhook"

-- Identity shown in logs:
-- "citizenid" = QBCore citizen ID
-- "license"   = Rockstar license
-- "both"      = Show both CitizenID + License
Config.LogIdentity = "both"



-------- Vending Machine Settings --------

Config.Items = {
    drinks = {
        { item = "water",    label = "Water",     price = 5,   stock = 10 },
        { item = "sprunk",   label = "Sprunk",    price = 5,   stock = 10 },
        { item = "cola",     label = "Cola",      price = 5,   stock = 10 },
    },
    food = {
        { item = "chips",    label = "Chips",     price = 10,  stock = 10 },
        { item = "ramen",    label = "Ramen",     price = 7,   stock = 10 },
        { item = "sandwich", label = "Sandwich",  price = 12,  stock = 10 },
    },
    water = {
        { item = "water",    label = "Water",     price = 5,   stock = 20 },
    },
    coffee = {
        { item = "coffee",   label = "Coffee",    price = 10,  stock = 10 },
    }
}


-------- Vending Machine Models --------

Config.Models = {
    { model = `prop_vend_soda_01`,  items = "drinks" },
    { model = `prop_vend_soda_02`,  items = "drinks" },
    { model = `prop_vend_coffe_01`, items = "coffee" },
    { model = `prop_vend_snak_01`,  items = "food" },
    { model = `prop_watercooler`,   items = "water" },
    { model = `prop_vend_water_01`, items = "water" },
}
