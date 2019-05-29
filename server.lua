local IsTornadoActive = false
local TornadoPosition = nil
local TornadoDestination = nil
local TornadoGirth = 8.0
local ace_perm = "rhys19.tornado"
local debug = false

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
    print("[Tornado] A tornado has spawned at ", x,y,z, heading)
end)

AddEventHandler("tornado:move_here", function(x,y,z)
    if x~=nil and y~=nil and z~=nil then
        TornadoDestination = x,y,z, heading
        if not IsTornadoActive then
            TornadoPosition = x,y,z, heading
            print("[Tornado] A tornado has spawned at " .. TornadoPosition.x .. ", " .. TornadoPosition.y .. ", " .. TornadoPosition.z)
        end
        IsTornadoActive = true
        TriggerClientEvent("tornado:spawn", -1, TornadoPosition, TornadoDestination)
        print("[Tornado] A tornado is moving to " .. x .. ", " .. y .. ", " .. z)
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
        print("[Tornado] A tornado has spawned at " .. x .. ", " .. y .. ", " .. z)
		
    end
end)

function ProcessAces()
    if GetNumPlayerIndices() > 0 then -- don't do it when there aren't any players
        for i=0, GetNumPlayerIndices()-1 do -- loop through all players
            player = tonumber(GetPlayerFromIndex(i))
            Citizen.Wait(0)
            if IsPlayerAceAllowed(player, ace_perm) then
                TriggerClientEvent("sendAcePermissionToClient", player, true)
                if debug then print("[DEBUG][" .. GetCurrentResourceName() .. "] ^5Syncronising player aces, sending to client...^0") end
            end
        end
    end
end

Citizen.CreateThread(function()
    while true do
        ProcessAces()
        Citizen.Wait(0) -- lets check every minute
    end
end)

AddEventHandler("onResourceStart", function(name)
    if name == GetCurrentResourceName() then
        ProcessAces()
        if debug then print("[DEBUG][" .. GetCurrentResourceName() .. "] ^6Resource [ " .. GetCurrentResourceName() .. " ] was (re)started, syncing aces to all players.^0") end
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

RegisterNetEvent("sendAcePermissionToClient")
AddEventHandler("sendAcePermissionToClient", function(state)
    isAdmin = state
end)
