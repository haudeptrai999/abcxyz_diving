ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

-------------

local currentGear1 = {
    mask = 0,
    tank = 0,
    enabled = false
}

local currentGear2 = {
    mask = 0,
    tank = 0,
    enabled = false
}

function DeleteGear1()
	if currentGear1.mask ~= 0 then
        DetachEntity(currentGear1.mask, 0, 1)
        DeleteEntity(currentGear1.mask)
		currentGear1.mask = 0
    end
    
	if currentGear1.tank ~= 0 then
        DetachEntity(currentGear1.tank, 0, 1)
        DeleteEntity(currentGear1.tank)
		currentGear1.tank = 0
	end
end

function DeleteGear2()
	if currentGear2.mask ~= 0 then
        DetachEntity(currentGear2.mask, 0, 1)
        DeleteEntity(currentGear2.mask)
		currentGear2.mask = 0
    end
    
	if currentGear2.tank ~= 0 then
        DetachEntity(currentGear2.tank, 0, 1)
        DeleteEntity(currentGear2.tank)
		currentGear2.tank = 0
	end
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end

------------- Light Diving suit
RegisterNetEvent('esx_tenues:settenueplongee1')
AddEventHandler('esx_tenues:settenueplongee1', function()
	if currentGear1.enabled == false then
		GearAnim()
		DeleteGear1()
		local maskModel = GetHashKey("p_d_scuba_mask_s")
		local tankModel = GetHashKey("p_michael_scuba_tank_s")

		RequestModel(tankModel)
		while not HasModelLoaded(tankModel) do
			Citizen.Wait(1)
		end
		TankObject = CreateObject(tankModel, 1.0, 1.0, 1.0, 1, 1, 0)
		local bone1 = GetPedBoneIndex(GetPlayerPed(-1), 24818)
		AttachEntityToEntity(TankObject, GetPlayerPed(-1), bone1, -0.30, -0.25, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
		currentGear1.tank = TankObject

		RequestModel(maskModel)
		while not HasModelLoaded(maskModel) do
			Citizen.Wait(1)
		end
		
		MaskObject = CreateObject(maskModel, 1.0, 1.0, 1.0, 1, 1, 0)
		local bone2 = GetPedBoneIndex(GetPlayerPed(-1), 12844)
		AttachEntityToEntity(MaskObject, GetPlayerPed(-1), bone2, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
		currentGear1.mask = MaskObject

		SetEnableScuba(GetPlayerPed(-1), true)
		SetPedMaxTimeUnderwater(GetPlayerPed(-1), 400.00)
		currentGear1.enabled = true
		ClearPedTasks(GetPlayerPed(-1))
		TriggerEvent('chatMessage', Config.Translate[1], "error", Config.Translate[2])
    end
end)

RegisterNetEvent('esx_tenues:coido1')
AddEventHandler('esx_tenues:coido1', function()
	if currentGear1.enabled then
		GearAnim()
		DeleteGear1()

		SetEnableScuba(GetPlayerPed(-1), false)
		SetPedMaxTimeUnderwater(GetPlayerPed(-1), 20.00)
		currentGear1.enabled = false
		TriggerServerEvent('abcxyz_diving:server:GiveBackGear1')
		ClearPedTasks(GetPlayerPed(-1))
		notification1()
	else
		notification2()
	end
end)	

------------- Best Diving suit
RegisterNetEvent('esx_tenues:settenueplongee2')
AddEventHandler('esx_tenues:settenueplongee2', function()
	if currentGear2.enabled == false then
		GearAnim()
		DeleteGear2()
		local maskModel = GetHashKey("p_d_scuba_mask_s")
		local tankModel = GetHashKey("p_s_scuba_tank_s")

		RequestModel(tankModel)
		while not HasModelLoaded(tankModel) do
			Citizen.Wait(1)
		end
		TankObject = CreateObject(tankModel, 1.0, 1.0, 1.0, 1, 1, 0)
		local bone1 = GetPedBoneIndex(GetPlayerPed(-1), 24818)
		AttachEntityToEntity(TankObject, GetPlayerPed(-1), bone1, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
		currentGear2.tank = TankObject

		RequestModel(maskModel)
		while not HasModelLoaded(maskModel) do
			Citizen.Wait(1)
		end
		
		MaskObject = CreateObject(maskModel, 1.0, 1.0, 1.0, 1, 1, 0)
		local bone2 = GetPedBoneIndex(GetPlayerPed(-1), 12844)
		AttachEntityToEntity(MaskObject, GetPlayerPed(-1), bone2, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
		currentGear2.mask = MaskObject

		SetEnableScuba(GetPlayerPed(-1), true)
		SetPedMaxTimeUnderwater(GetPlayerPed(-1), 1500.00)
		currentGear2.enabled = true
		ClearPedTasks(GetPlayerPed(-1))
		TriggerEvent('chatMessage', Config.Translate[1], "error", Config.Translate[3])
    end
end)

RegisterNetEvent('esx_tenues:coido2')
AddEventHandler('esx_tenues:coido2', function()
	if currentGear2.enabled then
		GearAnim()
		DeleteGear2()

		SetEnableScuba(GetPlayerPed(-1), false)
		SetPedMaxTimeUnderwater(GetPlayerPed(-1), 20.00)
		currentGear2.enabled = false
		TriggerServerEvent('abcxyz_diving:server:GiveBackGear2')
		ClearPedTasks(GetPlayerPed(-1))
		notification1()
	else
		notification2()
	end
end)		

--------
function GearAnim()
    loadAnimDict("clothingshirt")    	
	TaskPlayAnim(GetPlayerPed(-1), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end
--------
function notification1()
	ESX.ShowNotification(Config.Translate[4])
end
--------
function notification2()
	ESX.ShowNotification(Config.Translate[5])
end	

