--[[
function AddMenuTornado(menu)
    local submenu = _menuPool:AddSubMenu(menu, "Tornados")
    for i = 1, 1 do
    	local Item = NativeUI.CreateItem("Summon Tornado", "~o~Summons a ~r~Tornado in front of you!")
		Item.Activated = function(ParentMenu, SelectedItem)
    		--Do stuff
    		TriggerServerEvent("tornado:summon")
    	end
		local Item2 = NativeUI.CreateItem("Delete Tornado", "~y~Deletes the tornado! ~r~(All tornados)")
		Item2.Activated = function(ParentMenu, SelectedItem)
    		--Do stuff
    		TriggerServerEvent("tornado:delete2")
    	end
		local Item3 = NativeUI.CreateItem("Exit", "")
		Item3.Activated = function(ParentMenu, SelectedItem)
    		--Do stuff
    		ToggleMenu()
    	end
        submenu:AddItem(Item)
		submenu:AddItem(Item2)
		submenu:AddItem(Item3)
		_menuPool:MouseControlsEnabled(false)
		_menuPool:ControlDisablingEnabled(false)
    end
end--]]
--[[
AddMenuTornado(mainMenu)
_menuPool:RefreshIndex()

function ToggleMenu()
	_menuPool:CloseAllMenus()
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
    end
end)--]]

RegisterCommand('tm', function(source, args, rawCommand)
	--if isAdmin then
		--mainMenu:Visible(not mainMenu:Visible())
	--	else
TriggerEvent('chat:addMessage', { color = { 255, 0, 0}, multiline = true, args = {"^1System", "Menu Version Disabled"} })
	--	end
end)
