-- NOPIXEL RADIAL MENU--
--CONVERTED BY SUREKING--
ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(5)
  end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


--Fonksiyonlar--

RegisterNetEvent('attach:prop_roadcone02a')
AddEventHandler('attach:prop_roadcone02a', function()
    TriggerEvent("inrp_propsystem:attachItem","prop_roadcone02a")
	exports["mythic_notify"]:SendAlert("inform", "Yere Bırakmak için 'Y' Basınız, Silmek İçin /r Yazınız.", 5500)
end)

RegisterNetEvent('attach:xm_prop_x17_bag_med_01a') --xm_prop_smug_crate_s_medical
AddEventHandler('attach:xm_prop_x17_bag_med_01a', function()
    TriggerEvent("inrp_propsystem:attachItem","xm_prop_x17_bag_med_01a")
    exports["mythic_notify"]:SendAlert("inform", "Yere Bırakmak için 'Y' Basınız, Silmek İçin /r Yazınız.", 5500)	
end)

RegisterNetEvent('attach:xm_prop_smug_crate_s_medical') --xm_prop_smug_crate_s_medical
AddEventHandler('attach:xm_prop_smug_crate_s_medical', function()
    TriggerEvent("inrp_propsystem:attachItem","xm_prop_smug_crate_s_medical")
	exports["mythic_notify"]:SendAlert("inform", "Yere Bırakmak için 'Y' Basınız, Silmek İçin /r Yazınız.", 5500)
end)

RegisterNetEvent('policedog') --xm_prop_smug_crate_s_medical
AddEventHandler('policedog', function()
    TriggerEvent('esx_policedog:openMenu')
end)

RegisterNetEvent("ygx:togglegas")
AddEventHandler("ygx:togglegas", function()
   -- DeleteWaypoint()

    local currentGasBlip = 0

	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords

	for k,v in pairs(GasStations) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
            closestCoords = v
        end
    end

    SetNewWaypoint(closestCoords)
    exports["mythic_notify"]:SendAlert("inform", "En yakın benzinci GPS'de işaretlendi.", 3500)

end)

RegisterNetEvent('propsil')
AddEventHandler('propsil', function()
    ExecuteCommand('r')
end)

RegisterNetEvent("ygx:togglebarber")
AddEventHandler("ygx:togglebarber", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords1

	for k,v in pairs(BarberShops) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords1 = v
		end
    end
    
    SetNewWaypoint(closestCoords1)
    exports["mythic_notify"]:SendAlert("inform", "En yakın berber GPS'de işaretlendi.", 3500)
end)

RegisterNetEvent('meeta_ambulance:cpr')
AddEventHandler('meeta_ambulance:cpr', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local random = math.random(1,100)
	TriggerEvent('esx_inventoryhud:closeHud')

	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer == -1 or closestDistance > 1.0 then
		TriggerEvent("pNotify:SendNotification", {
			text = '<strong class="red-text">ไม่มีผู้เล่นอยู่ใกล้คุณ</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	else
		ESX.TriggerServerCallback('meeta_ambulance:getItem', function(result)

			if result then
				local closestPlayerPed = GetPlayerPed(closestPlayer)
				local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
				ESX.Streaming.RequestAnimDict(lib, function()
					TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 33, 0, false, false, false)
				end)

				if random <= 50 then -- Success
					ClearPedTasks(playerPed)
					TriggerServerEvent('meeta_ambulance:revive', GetPlayerServerId(closestPlayer))

					TriggerEvent("pNotify:SendNotification", {
						text = '<strong class="green-text">คุณช่วยชีวิตเขาไว้ได้!!</strong>',
						type = "success",
						timeout = 3000,
						layout = "bottomCenter",
						queue = "global"
					})
				else -- Fail
					ESX.Streaming.RequestAnimDict(lib, function()
						TaskPlayAnim(PlayerPedId(), lib, "cpr_fail", 8.0, -8.0, -1, 0, 0, false, false, false)
						Wait(20000)
						ClearPedTasks(playerPed)
					end)
				end
				
				TriggerServerEvent('meeta_ambulance:DeleteItem', 'defibrillator')
				
			else
				TriggerEvent("pNotify:SendNotification", {
					text = '<strong class="red-text">คุณไม่มี Defibrillator</strong>',
					type = "error",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			end
		end, 'defibrillator')
	end

end)

RegisterNetEvent("ygx:toggletattos")
AddEventHandler("ygx:toggletattos", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(TattoShops) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports["mythic_notify"]:SendAlert("inform", "En yakın dövmeci GPS'de işaretlendi.", 3500)
end)

RegisterNetEvent("fk:karakol")
AddEventHandler("fk:karakol", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(Karakol) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports["mythic_notify"]:SendAlert("inform", "Karakol GPS'de işaretlendi.", 3500)
end)

RegisterNetEvent("fk:hastane")
AddEventHandler("fk:hastane", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(Hastane) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports["mythic_notify"]:SendAlert("inform", "Hastane GPS'de işaretlendi.", 3500)
end)

RegisterNetEvent("fk:galeri")
AddEventHandler("fk:galeri", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(Galeri) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports["mythic_notify"]:SendAlert("inform", "Galeri GPS'de işaretlendi.", 3500)
end)

RegisterNetEvent("fk:motel")
AddEventHandler("fk:motel", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(Motel) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports["mythic_notify"]:SendAlert("inform", "Motel GPS'de işaretlendi.", 3500)
end)

RegisterNetEvent("ygx:togglegarage")
AddEventHandler("ygx:togglegarage", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(Garage) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports["mythic_notify"]:SendAlert("inform", "En yakın garaj GPS'de işaretlendi.", 3500)
end)

TattoShops = {
	vector3(1322.6, -1651.9, 51.2),
	vector3(-1153.6, -1425.6, 4.9),
	vector3(322.1, 180.4, 103.5),
	vector3(-3170.0, 1075.0, 20.8),
	vector3(1864.6, 3747.7, 33.0),
	vector3(-293.7, 6200.0, 31.4)
}

Karakol = {
	vector3(431.91, -981.62, 30.71),
}

Galeri = {
	vector3(-45.24, -1098.05, 26.42),
}

Hastane = {
	vector3(292.1, -583.5, 43.19),
}

Motel = {
	vector3(326.51, -213.28, 54.07),
}

BarberShops = {
	vector3(-814.308, -183.823, 36.568),
	vector3(136.826, -1708.373, 28.291),
	vector3(-1282.604, -1116.757, 5.990),
	vector3(1931.513, 3729.671, 31.844),
	vector3(1212.840, -472.921, 65.208),
	vector3(-32.885, -152.319, 56.076),
	vector3(-278.077, 6228.463, 30.695),
}

GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253)
}

RegisterNetEvent('kiyafet1')
AddEventHandler('kiyafet1', function()
    TriggerEvent('hat')
end)

RegisterNetEvent('kiyafet2')
AddEventHandler('kiyafet2', function()
	TriggerEvent('mask')
end)

RegisterNetEvent('kiyafet3')
AddEventHandler('kiyafet3', function()
    TriggerEvent('handske')
end)

RegisterNetEvent('squad')
AddEventHandler('squad', function()
	TriggerEvent("meeta_police:squadMenu")
end)


RegisterNetEvent('kimlikgor')
AddEventHandler('kimlikgor', function()
local player, distance = ESX.Game.GetClosestPlayer()

if distance ~= -1 and distance <= 3.0 then
  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
else
  ESX.ShowNotification('Yakında Oyuncu Yok')
end

end)

RegisterNetEvent('kimlikgoster')
AddEventHandler('kimlikgoster', function()
local player, distance = ESX.Game.GetClosestPlayer()

if distance ~= -1 and distance <= 3.0 then
  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
  TriggerServerEvent('cuzdantut')
else
  ESX.ShowNotification('Yakında Oyuncu Yok')
end

end)

RegisterNetEvent("esx_policejob:kelepcecoz")
AddEventHandler("esx_policejob:kelepcecoz", function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 2.0 then
        ESX.ShowNotification("Yakında kimse yok.")
    else
		TriggerServerEvent('kelepcele:requestrelease', target_id, playerheading, playerCoords, playerlocation)
		exports['mythic_notify']:DoHudText('black', "Kelepçeyi Çözdün")	
    end
end)

RegisterNetEvent("esx_policejob:kelepce")
AddEventHandler("esx_policejob:kelepce", function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 2.0 then
        ESX.ShowNotification("Yakında kimse yok.")
    else
        TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
    end	
end)

RegisterNetEvent('kiyafet4')
AddEventHandler('kiyafet4', function()
    TriggerEvent('briller') 
end)

RegisterNetEvent('kepo_speaker')
AddEventHandler('kepo_speaker', function()
TriggerEvent("kepo_speaker:place")
end)

RegisterNetEvent('kiyafet5')
AddEventHandler('kiyafet5', function()
    TriggerEvent('hals')
end)

RegisterNetEvent('kiyafet6')
AddEventHandler('kiyafet6', function()
    TriggerEvent('ryg')
end)

RegisterNetEvent('kiyafet7')
AddEventHandler('kiyafet7', function()
    TriggerEvent('bukser')
end)

RegisterNetEvent('kiyafet8')
AddEventHandler('kiyafet8', function()
    TriggerEvent('harm')
end)

RegisterNetEvent('kiyafet9')
AddEventHandler('kiyafet9', function()
    TriggerEvent('varm')
end)

RegisterNetEvent('kiyafet10')
AddEventHandler('kiyafet10', function()
    TriggerEvent('ear')
end)

RegisterNetEvent('kiyafet11')
AddEventHandler('kiyafet11', function()
    TriggerEvent('sko')
end)

RegisterNetEvent('kiyafet12')
AddEventHandler('kiyafet12', function()
    TriggerEvent('skoF')
end)

RegisterNetEvent('kiyafet13')
AddEventHandler('kiyafet13', function()
    TriggerEvent('shirt')
end)

RegisterNetEvent('kiyafet14')
AddEventHandler('kiyafet14', function()
    TriggerEvent('shirtF')
end)

RegisterNetEvent('kiyafet15')
AddEventHandler('kiyafet15', function()
    TriggerEvent('bukserF')
end)

RegisterNetEvent('attach:prop_cs_cardbox_01') --prop_cs_cardbox_01
AddEventHandler('attach:prop_cs_cardbox_01', function()
	holdAnim()
    TriggerEvent("inrp_propsystem:attachItem","prop_cs_cardbox_01")
	exports["mythic_notify"]:SendAlert("inform", "Yere Bırakmak için 'Y' Basınız, Silmek İçin /r Yazınız.", 5500)
end)

RegisterNetEvent('tsandalye')
AddEventHandler('tsandalye', function()
	LoadModel('prop_wheelchair_01')

	local wheelchair = CreateObject(GetHashKey('prop_wheelchair_01'), GetEntityCoords(PlayerPedId()), true)
end, false)

RegisterNetEvent('attach:hei_prop_hei_drug_pack_01b') --hei_prop_hei_drug_pack_01b
AddEventHandler('attach:hei_prop_hei_drug_pack_01b', function()
	holdAnim()
    TriggerEvent("inrp_propsystem:attachItem","hei_prop_hei_drug_pack_01b")
	exports["mythic_notify"]:SendAlert("inform", "Yere Bırakmak için 'Y' Basınız, Silmek İçin /r Yazınız.", 5500)
end)

RegisterNetEvent('mdtopen')
AddEventHandler('mdtopen', function()
TriggerServerEvent('mdt:hotKeyOpen')
end)

RegisterNetEvent('attach:prop_table_03') 
AddEventHandler('attach:prop_table_03', function()
	holdAnim()
    TriggerEvent("inrp_propsystem:attachItem","prop_table_03")
	exports["mythic_notify"]:SendAlert("inform", "Yere Bırakmak için 'Y' Basınız, Silmek İçin /r Yazınız.", 5500)
end)

RegisterNetEvent('attach:ex_office_swag_guns03')
AddEventHandler('attach:ex_office_swag_guns03', function()
	holdAnim()
    TriggerEvent("inrp_propsystem:attachItem","ex_office_swag_guns03")
	exports["mythic_notify"]:SendAlert("inform", "Yere Bırakmak için 'Y' Basınız, Silmek İçin /r Yazınız.", 5500)
end)

RegisterNetEvent('attach:p_gcase_s')
AddEventHandler('attach:p_gcase_s', function()
	holdAnim()
    TriggerEvent("inrp_propsystem:attachItem","p_gcase_s")
	exports["mythic_notify"]:SendAlert("inform", "Yere Bırakmak için 'Y' Basınız, Silmek İçin /r Yazınız.", 5500)
end)

RegisterNetEvent('attach:xm_prop_x17_bag_01a') --xm_prop_x17_bag_01a
AddEventHandler('attach:xm_prop_x17_bag_01a', function()
    TriggerEvent("inrp_propsystem:attachItem","xm_prop_x17_bag_01a")
	exports["mythic_notify"]:SendAlert("inform", "Yere Bırakmak için 'Y' Basınız, Silmek İçin /r Yazınız.", 5500)
end)

RegisterNetEvent('st:handcuff');
AddEventHandler('st:handcuff', function()
    local target, distance = ESX.Game.GetClosestPlayer()
    playerheading = GetEntityHeading(PlayerPedId())
    playerlocation = GetEntityForwardVector(PlayerPedId())
    playerCoords = GetEntityCoords(PlayerPedId())
    local target_id = GetPlayerServerId(target)
    print(distance)
    if distance <= 2.0 then
        if distance == -1 then
            exports['mythic_notify']:SendAlert('error', 'Yakında kelepçeleyebileceğin biri yok', 4000)
        else
            TriggerServerEvent('esx_policejob:handcuff', target_id, playerheading, playerCoords, playerlocation)
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında kelepçeleyebileceğin biri yok', 4000)
    end
end)
RegisterNetEvent('st:checkGSR');
AddEventHandler('st:checkGSR', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        TriggerServerEvent('GSR:Status2', GetPlayerServerId(closestPlayer))
    end
end)
RegisterNetEvent('st:uncuff');
AddEventHandler('st:uncuff', function()
    local target, distance = ESX.Game.GetClosestPlayer()
    playerheading = GetEntityHeading(PlayerPedId())
    playerlocation = GetEntityForwardVector(PlayerPedId())
    playerCoords = GetEntityCoords(PlayerPedId())
    local target_id = GetPlayerServerId(target)
    print(distance)
    if distance <= 2.0 then
        if distance == -1 then
            exports['mythic_notify']:SendAlert('error', 'Yakında kelepçeleyebileceğin biri yok', 4000)
        else
            TriggerServerEvent('esx_policejob:requestrelease', target_id, playerheading, playerCoords, playerlocation)
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında kelepçeleyebileceğin biri yok', 4000)
    end
end)
RegisterNetEvent('st:escort');
AddEventHandler('st:escort', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
    end
end)

RegisterNetEvent('esx_policejob:odenmemisfatura');
AddEventHandler('esx_policejob:odenmemisfatura', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        OpenUnpaidBillsMenu(nearbyPlayer)
    end
end)

RegisterNetEvent("esx_policejob:putInVehicle")
AddEventHandler("esx_policejob:putInVehicle", function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 2.0 then
        ESX.ShowNotification("Yakında kimse yok.")
    else
           TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
    end
end)
RegisterNetEvent("hirsiz:putInVehicle")
AddEventHandler("hirsiz:putInVehicle", function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 2.0 then
        ESX.ShowNotification("Yakında kimse yok.")
    else
           TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
    end
end)
RegisterNetEvent('st:takeoutvehicle');
AddEventHandler('st:takeoutvehicle', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
    end
end)
RegisterNetEvent('st:putv');
AddEventHandler('st:putv', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
    end
end)

RegisterNetEvent("ustara")
AddEventHandler("ustara", function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 2.0 then
        ESX.ShowNotification("Yakında kimse yok.")
    else
        TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), _U('being_searched'))
        OpenBodySearchMenu(closestPlayer)
    end
end)

RegisterNetEvent('motelanahtar')
AddEventHandler('motelanahtar', function()
    ExecuteCommand('anahtar')
	exports['mythic_notify']:SendAlert('inform', 'Anahtarların Burada!', 4000)
end)

RegisterNetEvent('motelanahtar1')
AddEventHandler('motelanahtar1', function()
    ExecuteCommand('anahtarver')
end)

RegisterNetEvent('baju')
AddEventHandler('baju', function()
    ExecuteCommand('shirt')
end)

RegisterNetEvent('celana')
AddEventHandler('celana', function()
    ExecuteCommand('pants')
end)

RegisterNetEvent('motelanahtar2')
AddEventHandler('motelanahtar2', function()
    ExecuteCommand('kapikilit')
    exports['mythic_notify']:SendAlert('inform', 'Kapıyı Açtın/Kapattın.Dikkatli Ol Kapıyı Açık Bırakma!', 8000)	
end)

RegisterNetEvent('copkaristir')
AddEventHandler('copkaristir', function()
    ExecuteCommand('çöpkarıştır')
end)

RegisterNetEvent('motelanahtar3')
AddEventHandler('motelanahtar3', function()
    ExecuteCommand('depokilit')
    exports['mythic_notify']:SendAlert('inform', 'Depo Kilidini Açtın/Kapattın.Dikkatli Ol Deponu Açık Bırakma!', 10000)	
end)

RegisterNetEvent('motelanahtar4')
AddEventHandler('motelanahtar4', function()
    ExecuteCommand('depo')
	exports['mythic_notify']:SendAlert('inform', 'Depoyu Açtın/Eğer Depo Açılmadıysa Depo Kilitlidir.', 4000)
end)

RegisterNetEvent('motelanahtar5')
AddEventHandler('motelanahtar5', function()
    ExecuteCommand('dolap')
	exports['mythic_notify']:SendAlert('inform', 'Dolabını Açtın', 4000)
end)

RegisterNetEvent("esx_policejob:lisanscheck")
AddEventHandler("esx_policejob:lisanscheck", function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 2.0 then
        ESX.ShowNotification("Yakında kimse yok.")
    else
		ShowPlayerLicense(nearbyPlayer)
    end
end)

RegisterNetEvent("esx_policejob:OutVehicle")
AddEventHandler("esx_policejob:OutVehicle", function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 2.0 then
        ESX.ShowNotification("Yakında kimse yok.")
    else
        TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
    end
end)

RegisterNetEvent("hirsiz:OutVehicle")
AddEventHandler("hirsiz:OutVehicle", function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 2.0 then
        ESX.ShowNotification("Yakında kimse yok.")
    else
        TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
    end
end)

RegisterNetEvent('carcontrol:open')
AddEventHandler('carcontrol:open', function()
    print("abre")
    local ped = PlayerPedId()    
    local inVeh = IsPedInAnyVehicle(ped,false)    
    if inVeh then       
        local veh = GetVehiclePedIsIn(ped)      
        if lastVeh and lastData and veh == lastVeh then        
            ctrl.display(lastData)      
        else       
            lastData = nil       
            ctrl.display()     
        end     
        lastVeh = veh   
    end 
end)

RegisterNetEvent('st:outv');
AddEventHandler('st:outv', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
    end
end)
RegisterNetEvent('st:pdrevive');
AddEventHandler('st:pdrevive', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    local health = GetEntityHealth(closestPlayerPed)
    if health == 0 then
        local playerPed = PlayerPedId()
        Citizen.CreateThread(function()
        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
        Wait(5000)
        ClearPedTasks(playerPed)
            if GetEntityHealth(closestPlayerPed) == 0 then
                TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))--('esx_policejob:revive')
            else
                exports['mythic_notify']:SendAlert('error', 'Yakında ölü biri yok', 4000)
            end
        end)
    end
end)
RegisterNetEvent('st:menuimpound');
AddEventHandler('st:menuimpound', function()
    local playerPed = PlayerPedId()
    local vehicle = ESX.Game.GetVehicleInDirection()
    if vehicle ~= nil then
        exports['progressBars']:startUI(10000, "Araç Çekiliyor")
        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
        Citizen.Wait(10000)
        ClearPedTasks(playerPed)
        DeleteVehicle(vehicle)
        exports['mythic_notify']:SendAlert('success', 'Araba çekildi', 4000)
        Citizen.Wait(100)
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında araba yok', 4000)
    end
end)
RegisterNetEvent('st:open');
AddEventHandler('st:open', function()
    local playerPed = PlayerPedId()
    local coords  = GetEntityCoords(playerPed)
    local vehicle = ESX.Game.GetVehicleInDirection()
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
        exports['progressBars']:startUI(10000, "Araç Açılıyor")
        Citizen.Wait(10000)
        ClearPedTasksImmediately(playerPed)

        SetVehicleDoorsLocked(vehicle, 1)
        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
        PlayVehicleDoorOpenSound(vehicle, 0)
        SetVehicleLights(vehicle, 2)
        Citizen.Wait(150)
        SetVehicleLights(vehicle, 0)
        exports['mythic_notify']:SendAlert('inform', 'Aracın kilidini açtın', 4000)
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında araba yok', 4000)
    end
end)
RegisterNetEvent('st:mechrepair');
AddEventHandler('st:mechrepair', function()
    local playerPed = PlayerPedId()
    local coords  = GetEntityCoords(playerPed)
    local vehicle = ESX.Game.GetVehicleInDirection()
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
        exports['progressBars']:startUI(10000, "Araç Tamir Ediliyor")
        Citizen.Wait(10000)
        ClearPedTasksImmediately(playerPed)

        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndriveable(vehicle, false)
        SetVehicleEngineOn(vehicle, true, true)
        exports['mythic_notify']:SendAlert('inform', 'Aracı Tamir ettin', 4000)
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında araba yok', 4000)
    end
end)
RegisterNetEvent('st:mechclean');
AddEventHandler('st:mechclean', function()
    local playerPed = PlayerPedId()
    local coords  = GetEntityCoords(playerPed)
    local vehicle = ESX.Game.GetVehicleInDirection()
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
        exports['progressBars']:startUI(10000, "Araç Temizleniyor")
        Citizen.Wait(10000)
        ClearPedTasksImmediately(playerPed)

        WashDecalsFromVehicle(vehicle, 1.0)
        SetVehicleDirtLevel(vehicle)
        exports['mythic_notify']:SendAlert('inform', 'Aracı temizledin', 4000)
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında araba yok', 4000)
    end
end)
RegisterNetEvent('st:kamu');
AddEventHandler('st:kamu', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        SendToCommunityService(GetPlayerServerId(closestPlayer))
    end
end)
RegisterNetEvent('st:ceza');
AddEventHandler('st:ceza', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        OpenFineMenu(closestPlayer)
    end
end)
RegisterNetEvent('st:bag');
AddEventHandler('st:bag', function()
    local target, distance = ESX.Game.GetClosestPlayer()
    local target_id = GetPlayerServerId(target)
    if distance <= 2.0 then
        TriggerServerEvent('st:bag2', target_id)
    end
end)
RegisterNetEvent('st:bag3');
AddEventHandler('st:bag3', function(targetid)
    exports['mythic_notify']:SendAlert('inform', 'Çantası Açıldı', 4000)
    owner = targetid
    TriggerEvent('disc-inventoryhud:openInventory', {
        type = 'canta',
        owner = owner,
        slots = 80,
    })
end)
function OpenFineMenu(player)

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine',
	{
		title    = 'Ceza Kes',
		align    = 'top-left',
		elements = {
			{label = 'Trafik Cezaları', value = 0},
			{label = 'Küçük Cezalar',   value = 1},
			{label = 'Ortalama Cezalar', value = 2},
			{label = 'Önemli Cezalar',   value = 3}
		}
	}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)

end

function OpenFineCategoryMenu(player, category)

	ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)

		local elements = {}

		for i=1, #fines, 1 do
			table.insert(elements, {
				label     = fines[i].label .. ' <span style="color: green;"> $' .. fines[i].amount .. '</span>',
				value     = fines[i].id,
				amount    = fines[i].amount,
				fineLabel = fines[i].label
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category',
		{
			title    = 'Ceza Kes',
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)

			local label  = data.current.fineLabel
			local amount = data.current.amount

			menu.close()

            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_police', label, amount)

			ESX.SetTimeout(300, function()
				OpenFineCategoryMenu(player, category)
			end)

		end, function(data, menu)
			menu.close()
		end)

	end, category)

end

function SendToCommunityService(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Community Service Menu', {
		title = "Community Service Menu",
	}, function (data2, menu)
		local community_services_count = tonumber(data2.value)
		
		if community_services_count == nil then
			ESX.ShowNotification('Invalid services count.')
		else
			TriggerServerEvent("esx_communityservice:sendToCommunityService", player, community_services_count)
			menu.close()
		end
	end, function (data2, menu)
		menu.close()
	end)
end

function OpenIdentityCardMenu(player)

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

		local elements    = {}
		local nameLabel   = 'Adı: ' .. data.name
		local jobLabel    = nil
		local sexLabel    = nil
		local dobLabel    = nil
		local heightLabel = nil
		local idLabel     = nil
	
		if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
			jobLabel = 'Meslek: ' .. data.job.label .. ' - ' .. data.job.grade_label
		else
			jobLabel = 'Meslek: ' .. data.job.label
		end
	
			nameLabel = 'Adı: ' .. data.firstname .. ' ' .. data.lastname
	
			if data.sex ~= nil then
				if string.lower(data.sex) == 'm' then
					sexLabel = 'Erkek'
				else
					sexLabel = 'Kadın'
				end
			else
				sexLabel = 'Bilinmiyor'
			end
	
			if data.dob ~= nil then
				dobLabel = 'Doğum Tarihi: ' .. data.dob
			else
				dobLabel = 'Doğum Tarihi: Bilinmiyor'
			end
	
			if data.height ~= nil then
				heightLabel = 'Boy: ' .. data.height
			else
				heightLabel = 'Boy: Bilinmiyor'
			end
	
			if data.name ~= nil then
				idLabel = 'Kimlik: ' .. data.name
			else
				idLabel = 'Kimlik: Bilinmiyor'
			end
	
		local elements = {
			{label = nameLabel, value = nil},
			{label = jobLabel,  value = nil},
		}
	
			table.insert(elements, {label = sexLabel, value = nil})
			table.insert(elements, {label = dobLabel, value = nil})
			table.insert(elements, {label = heightLabel, value = nil})
			table.insert(elements, {label = idLabel, value = nil})
	
		if data.drunk ~= nil then
			table.insert(elements, {label = _U('bac', data.drunk), value = nil})
		end
	
		if data.licenses ~= nil then
	
			table.insert(elements, {label = 'Lisans Adı:', value = nil})
	
			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label, value = nil})
			end
	
		end
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
		{
			title    = 'Vatandaş Etkileşimi',
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	
	end, GetPlayerServerId(player))

end

--DOKTOR--
RegisterNetEvent('st:emsRevive');
AddEventHandler('st:emsRevive', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer == -1 or closestDistance > 1.0 then
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok', 4000)
    else
        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
            if quantity > 0 then
                local closestPlayerPed = GetPlayerPed(closestPlayer)

                if GetEntityHealth(playerPed) <= 0 then
                    local playerPed = PlayerPedId()


                    local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

                    for i=1, 15, 1 do
                        Citizen.Wait(900)
                
                        ESX.Streaming.RequestAnimDict(lib, function()
                            TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                        end)
                    end

                    TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
                    TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
                else
                    exports['mythic_notify']:SendAlert('error', 'Kişinin kritik durumu yok', 4000)
                end
            else
                exports['mythic_notify']:SendAlert('error', 'İlk yardım kitin yok', 4000)
            end

        end, 'medikit')
    end
end)
RegisterNetEvent('st:emssmallheal');
AddEventHandler('st:emssmallheal', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer == -1 or closestDistance > 1.0 then
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok', 4000)
    else
        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
            if quantity > 0 then
                local closestPlayerPed = GetPlayerPed(closestPlayer)
                local health = GetEntityHealth(closestPlayerPed)

                if health > 0 then
                    local playerPed = PlayerPedId()

                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                    Citizen.Wait(10000)
                    ClearPedTasks(playerPed)

                    TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
                    TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
                else
                    exports['mythic_notify']:SendAlert('error', 'Kişinin kötü durumu yok', 4000)
                end
            else
                exports['mythic_notify']:SendAlert('error', 'Bandajın yok', 4000)
            end
        end, 'bandage')
    end
end)
RegisterNetEvent('st:emsbigheal');
AddEventHandler('st:emsbigheal', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer == -1 or closestDistance > 1.0 then
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok', 4000)
    else
        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
            if quantity > 0 then
                local closestPlayerPed = GetPlayerPed(closestPlayer)
                local health = GetEntityHealth(closestPlayerPed)

                if health > 0 then
                    local playerPed = PlayerPedId()

                    IsBusy = true
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                    Citizen.Wait(10000)
                    ClearPedTasks(playerPed)

                    TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
                    TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
                    IsBusy = false
                else
                    exports['mythic_notify']:SendAlert('error', 'Kişinin kötü durumu yok', 4000)
                end
            else
                exports['mythic_notify']:SendAlert('error', 'Medikitin yok', 4000)
            end
        end, 'medikit')
    end
end)