ESX = exports.es_extended:getSharedObject()
vehicletable = 'owned_vehicles'
vehiclemod = 'vehicle'
owner = 'owner'
stored = 'stored'
garage_id = 'garage_id'
type_ = 'type'
local shops = {}

CreateThread(function()
    for k, v in pairs(VehicleShop) do
        local list, foundshop = GetVehiclesFromShop(k or 'pdm')
        if not shops[k] then shops[k] = {} end
        --TriggerClientEvent('table',-1,Owned_Vehicle)
        if v.shop then
            shops[k].list = v.shop
            shops[k].type = v.type
        else
            shops[k].list = list
            shops[k].type = v.type
        end
    end

    GlobalState.VehicleShops = shops
end)

function GetVehiclesFromShop(shop)
    local vehicles = {}
    local found = false
    local result = MySQL.query.await('SELECT * FROM vehicles WHERE available = 1 AND custom = 0', {})

    for k, v in pairs(result) do
        -- if v.shop == shop then

        -- DB MÓDOSÍTÁS UTÁN
        if v.qty == -1 or v.qty > 0 and v.available == 1 then
            vehicles[k] = v
            if v.premium == 1 then
                vehicles[k].brand = "Prémium"
            else
                vehicles[k].brand = "Városi"
            end
            if v.category ~= "boat" then
                vehicles[k].type = "car"
                vehicles[k].shop = "pdm"
            elseif v.category == "boat" then
                vehicles[k].type = "boat"
                vehicles[k].shop = "Yacht Club Boat Shop"
            end
            found = true
        end
        -- end
    end
    return vehicles, found
end

function Deleteveh(plate, src)
    local plate = tostring(plate)
    if plate and type(plate) == 'string' then
        MySQL.query("DELETE FROM " .. vehicletable .. " WHERE `plate` = @plate", {
            ['@plate'] = plate,
        })
    end
end

-- function QtyMinus(model)
--     local affectedRows = MySQL.update.await('UPDATE vehicles SET model = ? WHERE qty = qty - 1', { model })
--     if affectedRows then

--     end
-- end

RegisterServerEvent('renzu_vehicleshop:setdefaultbucket')
AddEventHandler('renzu_vehicleshop:setdefaultbucket', function()
    local source = source
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(source))
    SetPlayerRoutingBucket(source, 0)

    --print("Alap bucket")

    --[[     local playerPed = GetPlayerPed(xPlayer.source)
    local vehicle = GetVehiclePedIsIn(playerPed) ]]

    if vehicle and vehicle ~= 0 then
        SetEntityRoutingBucket(vehicle, 0)
        for i = 0, 16 do
            local ped = GetPedInVehicleSeat(vehicle, i)
            if ped ~= 0 then
                SetPlayerRoutingBucket(NetworkGetEntityOwner(ped), 0)
            end
        end
    end
end)

function GetVehiclemodByPlateAndOwner(owner, plate)
    return MySQL.single.await("SELECT vehicle FROM owned_vehicles WHERE plate = @plate AND owner = @owner LIMIT 1", {
        ['@plate'] = string.gsub(plate:upper(), '^%s*(.-)%s*$', '%1'),
        ['@owner'] = owner
    })
end

RegisterServerEvent('renzu_vehicleshop:setplayerbucket')
AddEventHandler('renzu_vehicleshop:setplayerbucket', function()
    local source = source
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(source))
    local bucket = math.random(5, 200)
    SetPlayerRoutingBucket(source, bucket)

    if vehicle and vehicle ~= 0 then
        SetEntityRoutingBucket(vehicle, bucket)
        for i = 0, 16 do
            local ped = GetPedInVehicleSeat(vehicle, i)
            if ped ~= 0 then
                SetPlayerRoutingBucket(NetworkGetEntityOwner(ped), bucket)
            end
        end
    end
end)

function getCarPriceModifier(r, source)
    local modifier = 1

    if r and #r > 0 then
        local model = json.decode(r[1][vehiclemod]).model
        local carQty = MySQL.query.await(
            'SELECT owner, vehicle FROM owned_vehicles WHERE JSON_EXTRACT(vehicle, "$.model") = ?',
            {
                model
            })

        --  WHERE vehicle LIKE %829927215%'
        if (#carQty > 200) then
            modifier = 10
        elseif (#carQty > 150 and #carQty < 200) then
            modifier = 7
        elseif (#carQty > 100 and #carQty < 150) then
            modifier = 5
        elseif (#carQty > 75 and #carQty < 100) then
            modifier = 4
        elseif (#carQty > 50 and #carQty < 75) then
            modifier = 3
        else
            modifier = 1
        end
    end

    return modifier
end

lib.callback.register('renzu_vehicleshop:getCarPrice', function(source, modelname)
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 200000
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(source))
    local plate = GetVehicleNumberPlateText(vehicle)
    local price2 = getPrice(modelname)

    if (price2 == nil or price2 == false) then
        xPlayer.showNotification('Jelenleg ez a jármű nem eladható!', true, false, 110)
        return false
    end
    local r = GetVehiclemodByPlateAndOwner(xPlayer.identifier, plate)

    local divider = getCarPriceModifier(r, source)

    if r then
        local model = json.decode(r[vehiclemod]).model
        if model == GetEntityModel(vehicle) then
            result = Config.Vehicles
            if result then
                for k, v in pairs(result) do
                    if model == GetHashKey(v.model) then
                        price = price2 * (Config.RefundPercent * 0.01)
                        price = price / divider
                        price = math.floor(price)
                        return price
                    end
                end
            end
        else
            xPlayer.showNotification('Biztosan el szeretnéd adni?', true, false, 110)
        end

        return price
    end

    xPlayer.showNotification('Nem a tiéd a jármű, ezért nem adhatod el', true, false, 110)
    return nil
end)

RegisterServerEvent('renzu_vehicleshop:sellvehicle')
AddEventHandler('renzu_vehicleshop:sellvehicle', function(modelname)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 200000
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(source))
    local plate = GetVehicleNumberPlateText(vehicle)
    local price2 = getPrice(modelname)

    if (price2 == nil or price2 == false) then
        xPlayer.showNotification('Jelenleg ez a jármű nem eladható!', true, false, 110)
    else
        local r = GetVehiclemodByPlateAndOwner(xPlayer.identifier, plate)
        local divider = getCarPriceModifier(r, source)


        if r then
            local model = json.decode(r[vehiclemod]).model
            if model == GetEntityModel(vehicle) then
                result = Config.Vehicles
                if result then
                    for k, v in pairs(result) do
                        if model == GetHashKey(v.model) then
                            price = price2 * (Config.RefundPercent * 0.01)
                            price = price / divider
                            price = math.floor(price)
                        end
                    end
                    Deleteveh(plate, xPlayer.source)
                    xPlayer.addMoney(price)
                    xPlayer.showNotification('Sikeresen eladtad a járműved, ennyiért:' .. price .. '', true, false,
                        110)
                    --[[                     exports.csuda_piac:addItem('rubber', math.random(1, 15))
                    exports.csuda_piac:addItem('femhulladek', math.random(10, 15))
                    exports.csuda_piac:addItem('elektromoshulladek', math.random(0, 15))
                    exports.csuda_piac:addItem('uveg', math.random(0, 15))
                    exports.csuda_piac:addItem('aluminium', math.random(0, 15)) ]]
                    TriggerClientEvent('sellvehiclecallback', xPlayer.source)

                    CarSellLog(plate, xPlayer.identifier, modelname, price)
                end
            else
                xPlayer.showNotification('Biztosan el szeretnéd adni?', true, false, 110)
            end
        else
            xPlayer.showNotification('Nem a tiéd a jármű, ezért nem adhatod el', true, false, 110)
        end
    end
end)

function CarSellLog(plate, identifier, model, price)
    local message = message or ''
    message = message .. "\n\nID: " .. identifier .. "\nJármű: " ..
        model .. "\nRendszám: " .. plate .. "\nÁr: " .. price

    exports.csp_helper:DiscordLog('JarmuEladas', message, 'Jármű Eladás')
end

-- CreateThread(function()
--     Wait(1000)
--     local vehicles = CustomsSQL(Config.Mysql, 'fetchAll', 'SELECT plate FROM ' .. vehicletable, {})
--     for k, v in pairs(vehicles) do
--         if v.plate ~= nil then
--             temp[v.plate] = v
--         end
--     end
-- end)

lib.callback.register('renzu_vehicleshop:validateplate', function(source, plate)
    local res = MySQL.single.await("SELECT plate FROM owned_vehicles WHERE plate = ? LIMIT 1", { plate })

    return res == nil
end)

lib.callback.register('renzu_vehicleshop:buyvehicle',
    function(source, model, props, payment, job, type, garage, notregister, personal)
        local xPlayer = ESX.GetPlayerFromId(source)

        return Buy({ [1] = Config.Vehicles[model] }, xPlayer, model, props, payment, job, type, garage, personal)
    end)

function getPrice(model)
    return MySQL.scalar.await('SELECT price FROM vehicles WHERE model = ? LIMIT 1', { model })
end

function Buy(result, xPlayer, model, props, payment, job, type, garage, personal)
    fetchdone = false
    bool = false

    model = model

    if (personal == "personal") then
        car_owner = xPlayer.identifier
    elseif (personal == "frakcio") then
        car_owner = xPlayer.job.name
    end
    if result then
        local price = nil
        local stock = nil
        if not notregister then
            model = result[1].model
            price = result[1].price
        else
            model = model
            price = notregister.value
        end

        price = getPrice(result[1].model)

        local money = false
        if payment == 'cash' then
            money = xPlayer.getMoney() >= tonumber(price)
        else
            money = xPlayer.getAccount('bank').money >= tonumber(price)
        end
        stock = 999
        if money then
            -- PRÉMIUM BEKÖTÉS
            if payment == 'cash' then
                xPlayer.removeMoney(tonumber(price))
            elseif payment == 'bank' then
                xPlayer.removeAccountMoney('bank', tonumber(price))
            else
                xPlayer.removeMoney(tonumber(price))
            end
            stock = stock - 1
            local data = json.encode(props)
            local query = 'INSERT INTO ' ..
                vehicletable ..
                ' (' ..
                owner ..
                ', plate, ' ..
                vehiclemod ..
                ', job, `' ..
                stored ..
                '`, ' ..
                garage_id ..
                ', `' ..
                type_ ..
                '`, `t1ger_keys`) VALUES (@' ..
                owner ..
                ', @plate, @props, @job, @' .. stored .. ', @' .. garage_id .. ', @' .. type_ .. ', @t1ger_keys)'
            local var = {
                ['@' .. owner .. '']     = car_owner,
                ['@plate']               = props.plate:upper(),
                ['@props']               = data,
                ['@job']                 = job,
                ['@' .. stored .. '']    = 1,
                ['@' .. garage_id .. ''] = garage,
                ['@' .. type_ .. '']     = type,
                ['@t1ger_keys']          = 1,
            }

            CustomsSQL(Config.Mysql, 'execute', query, var)
            fetchdone = true
            bool = true
            Config.Carkeys(props.plate, xPlayer.source)
            --TriggerClientEvent('mycarkeys:setowned',xPlayer.source,props.plate) -- sample
        else
            xPlayer.showNotification('Nincs elég pénzed', true, false, 110)
            fetchdone = true
            bool = false
        end
    else
        xPlayer.showNotification('A jármű nem létezik', true, false, 110)
        fetchdone = true
        bool = false
    end
    while not fetchdone do Wait(0) end
    return bool
end
