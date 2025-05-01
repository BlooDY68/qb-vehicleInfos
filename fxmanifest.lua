fx_version 'cerulean'
game 'gta5'

name 'qb-vehicleinfo'
description 'Vehicle Information - Converted from esx_vehicleInfos by BlooDY for QBCore'
author 'Converted for QBCore'
version '1.0.0'

dependencies {
    'qb-core',
    'Bloody-menu'
}

client_scripts {
    '@qb-core/import.lua',
    'config.lua',
    'client/main.lua'
}