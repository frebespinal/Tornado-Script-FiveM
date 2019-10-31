local IsTornadoActive = false

x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.1, 8.0, 1.0))
heading = GetEntityHeading(PlayerPedId()+90, 1, 0)
Citizen.CreateThread(function()
    local Script = MainScript:new()
    Script:MainScript()
    IsTornadoActive = false
    local Tornado = nil


    RegisterNetEvent("tornado:spawn")
    AddEventHandler("tornado:spawn", function(pos, dest)
        IsTornadoActive = true
        pos = vec3(x,y,z)
        dest = vec3(x,y,z)
        Tornado = Script._factory:CreateVortex(pos)
        Tornado._position = pos
        Tornado._destination = dest
    end)

    RegisterNetEvent("tornado:setPosition")
    AddEventHandler("tornado:setPosition", function(pos)
        pos = vec3(pos.x, pos.y, pos.z)
        Tornado = Script._factory:CreateVortex(pos)
        Tornado._position = pos
    end)

    RegisterNetEvent("tornado:setDestination")
    AddEventHandler("tornado:setDestination", function(dest)
        dest = vec3(dest.x, dest.y, dest.z)
        Tornado = Script._factory:CreateVortex(dest)
        Tornado._destination = dest
    end)

    RegisterNetEvent("tornado:delete")
    AddEventHandler("tornado:delete", function()
        IsTornadoActive = false
    end)

    while true do
        if IsTornadoActive and Tornado then
            Script:OnUpdate(GetGameTimer())
        else
            if Tornado then
                Tornado._position = vec3(10000.0, 10000.0, 0.0)
                Script:OnUpdate(GetGameTimer())
                Tornado = nil
            end
        end
        Wait(15)
    end

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- Wait 0 seconds to prevent crashing ;)
    	if IsTornadoActive then -- checks if the tornado is active
            TriggerEvent('LIFE_CL:Sound:PlayOnAll', 'demo', 1.0) -- if tornado is active then play tornado siren.
            Citizen.Wait(2500)
        end
    end
end)
