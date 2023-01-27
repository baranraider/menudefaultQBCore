QBCore = nil
Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
		Citizen.Wait(200)
	end
	local MenuType = 'default'

	local openMenu = function(namespace, name, data)
		local tablo = {
			{
				header = data.title,
				icon = "fas fa-chevron-circle-right",
				isMenuHeader = true
			}
		}
		for k,v in ipairs(data.elements) do
			table.insert(tablo,{
				header = v.label,
				icon = "far fa-circle",
				isServer = false,
				params = {
					functions = function()
						local menu = QBCore.UI.Menu.GetOpened(MenuType, namespace, name)
						
						if menu.submit ~= nil then 
							menu.submit({current=v}, menu)
						end
					end
				}
			})
		end
		exports['qb-menu']:openMenu(tablo)
	end

	local closeMenu = function(namespace, name)
		exports["qb-menu"]:closeMenu()
	end

	QBCore.UI.Menu.RegisterType(MenuType, openMenu, closeMenu)
end)
