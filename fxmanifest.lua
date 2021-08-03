-- Resource Metadata
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Rhys19'
description 'Tornado Script for fivem by rhys19'
version '1.0.4'

client_scripts {
	'soundfx/client/main.lua',
    'helpers/GameSound.lua',
    'helpers/Helpers.lua',
    'helpers/LoopedParticle.lua',
    'helpers/MathEx.lua',
    'tornado/TEntity.lua',
    'tornado/TFactory.lua',
    'tornado/TParticle.lua',
    'tornado/TScript.lua',
    'tornado/TVortex.lua',
    'client.lua'
}

server_scripts {
    'server.lua',
    'version.lua',
    'soundfx/server/main.lua'
}
