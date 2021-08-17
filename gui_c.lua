_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Tornado Menu", "~b~Main Menu") -- menu name appears at top of menu
_menuPool:Add(mainMenu)
_menuPool:MouseControlsEnabled(false)
_menuPool:ControlDisablingEnabled(false)

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
    		TriggerServerEvent("tornado:delete")
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
end

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
end)

RegisterCommand('tm', function(source, args, rawCommand)
		if IsPlayerAceAllowed(source, "rhys19.tornado") then
		mainMenu:Visible(not mainMenu:Visible())
		else
			return
				TriggerEvent('chat:addMessage', { color = { 255, 0, 0}, multiline = true, args = {"^2[Tornado Script]", "^1You don't have permissions to use that command!"} })
	end
end)
