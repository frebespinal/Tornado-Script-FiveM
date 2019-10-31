local IsTornadoActive = false
local TornadoPosition = nil
local TornadoDestination = nil
local TornadoGirth = 8.0

AddEventHandler("tornado:summon", function()
    local start = x,y,z
    local destination = x,y,z
    if start==destination then
        destination = x,y,z
    end
    TornadoPosition = x,y,z, heading
    TornadoDestination = x,y,z, heading
    IsTornadoActive = true
    TriggerClientEvent("tornado:spawn", -1, x,y,z, heading)
    print("[Tornado] A tornado has spawned ahead")
end)

AddEventHandler("tornado:move_here", function(x,y,z)
    if x~=nil and y~=nil and z~=nil then
        TornadoDestination = x,y,z, heading
        if not IsTornadoActive then
            TornadoPosition = x,y,z, heading
        end
        IsTornadoActive = true
        TriggerClientEvent("tornado:spawn", -1, TornadoPosition, TornadoDestination)
    end
end)

AddEventHandler("tornado:summon_right_here", function(x,y,z)
	  x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
    if x~=nil and y~=nil and z~=nil then
        TornadoPosition = x,y,z, heading
        if not IsTornadoActive then
            TornadoDestination = x,y,z, heading
        end
        IsTornadoActive = true
        TriggerClientEvent("tornado:spawn", -1, x,y,z, heading)		
    end
end)

RegisterServerEvent("tornado:delete2")
AddEventHandler("tornado:delete2", function()
    IsTornadoActive = false
    TriggerClientEvent("tornado:delete", -1)
end)

AddEventHandler("tornado:delete", function()
    IsTornadoActive = false
    TriggerClientEvent("tornado:delete", -1)
end)

RegisterCommand("tornado", function(source, args, raw)
	if (args[1] == "summon") then
    TriggerEvent("tornado:summon")
	elseif (args[1] == "delete") then
	TriggerEvent("tornado:delete")
	elseif #args < 1 then
	return TriggerClientEvent('chat:addMessage', source, { color = { 255, 0, 0}, multiline = true, args = {"^1System", "Invalid Arguments!"} })
	end
end)

--Update Check

local LatestVersion = ''; CurrentVersion = '2.1.2'
local GithubResourceName = 'Tornado-Script-FiveM'
local githubUsername = 'rhys19'
local versionurl = "https://raw.githubusercontent.com/"..githubUsername.."/"..GithubResourceName.."/master/VERSION"
local changesurl = "https://raw.githubusercontent.com/"..githubUsername.."/"..GithubResourceName.."/master/CHANGES"

PerformHttpRequest(versionurl, function(Error, NewestVersion, Header)
	PerformHttpRequest(changesurl, function(Error, Changes, Header)
		LatestVersion = NewestVersion
		print('\n')
		print('====================================================================')
		print(' Tornado ('..GetCurrentResourceName()..')')
		print('====================================================================')
		print(' Current Version: ' .. CurrentVersion.. ' ')
		print(' Newest Version: ' .. NewestVersion.. ' ')
		print('====================================================================')
		if CurrentVersion ~= NewestVersion then
			print(' Outdated ')
			print(' Check the Github for new updates! ')
			print('====================================================================')
			print('CHANGES:\n' .. Changes)
		if CurrentVersion > NewestVersion then
		print("Your version is: "..CurrentVersion.." but it's higher then the updated version! Newest Version: "..NewestVersion)
		end
		else
			print('============')
			print(' Up to date!')
			print('============')
		end
		print('\n')
	end)
end)
