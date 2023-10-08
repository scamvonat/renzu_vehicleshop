function Framework()
	ESX = exports.es_extended:getSharedObject()

	while PlayerData.job == nil do
		PlayerData = ESX.GetPlayerData()
		Citizen.Wait(111)
	end

	--[[ 	if Config.framework == 'ESX' then
	elseif Config.framework == 'QBCORE' then
		CreateThread(function()
			QBCore = exports['qb-core']:GetCoreObject()
		end)
		Wait(1000)
		if not QBCore then -- support old version in ugly way
			CreateThread(function()
				QBCore = exports['qb-core']:GetSharedObject()
			end)
		end
		--QBCore = exports['qb-core']:GetSharedObject()
		while QBCore == nil do Wait(0) end
		QBCore.Functions.GetPlayerData(function(p)
			PlayerData = p
			if PlayerData.job ~= nil then
				PlayerData.job.grade = PlayerData.job.grade.level
			end
		end)
	end ]]
end

function Playerloaded()
	RegisterNetEvent('esx:playerLoaded')
	AddEventHandler('esx:playerLoaded', function(xPlayer)
		playerloaded = true
	end)

	--[[ 	if Config.framework == 'ESX' then
	elseif Config.framework == 'QBCORE' then
		RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
		AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
			playerloaded = true
			QBCore.Functions.GetPlayerData(function(p)
				PlayerData = p
				if PlayerData.job ~= nil then
					PlayerData.job.grade = PlayerData.job.grade.level
				end
			end)
		end)
	end ]]
end

function SetJob()
	RegisterNetEvent('esx:setJob')
	AddEventHandler('esx:setJob', function(job)
		PlayerData.job = job
		playerjob = PlayerData.job.name
		inmark = false
		cancel = true
		markers = {}
	end)
end

CreateThread(function()
	Wait(500)
	if Config.framework == 'ESX' then
		while ESX == nil do Wait(1) end
		TriggerServerCallback_ = ESX.TriggerServerCallback
	elseif Config.framework == 'QBCORE' then
		while QBCore == nil do Wait(1) end
		TriggerServerCallback_ = QBCore.Functions.TriggerCallback
	end
end)

MathRound = function(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10 ^ numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

ShowNotification = function(msg)
	if Config.framework == 'ESX' then
		ESX.ShowNotification(msg)
	elseif Config.framework == 'QBCORE' then
		TriggerEvent('QBCore:Notify', msg)
	end
end
