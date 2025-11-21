fx_version 'cerulean'
game 'gta5'

author 'Syntax'
description 'Advanced Vending Machine System'
version '0.1'

shared_script 'config.lua'

client_scripts {
    '@ox_lib/init.lua',
    'client.lua'
}

server_scripts {
    'server.lua',
    'discord.lua'
}

dependencies {
    'qb-core',
    'qb-target',
    'ox_inventory',
    'ox_lib'
}
