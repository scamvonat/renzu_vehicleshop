Config = {}
Config.Locale = "en"
Config.Mysql = 'oxmysql'  -- "ghmattisql", "mysql-async", "oxmysql"
Config.framework = 'ESX'  -- ESX or QBCORE
Config.UseRayZone = false -- unrelease script https://github.com/renzuzu/renzu_rayzone
Config.UsePopUI = true    -- Create a Thread for checking playercoords and Use POPUI to Trigger Event, set this to false if using rayzone. Popui is originaly built in to RayZone -- DOWNLOAD https://github.com/renzuzu/renzu_popui
Config.Quickpick = false  -- if false system will create a garage shell and spawn every vehicle you preview
Config.EnableTestDrive = true
Config.PlateSpace = true  -- enable / disable plate spaces (compatibility with esx 1.1?)
Config.SaveJob = true     -- this config is to save the value to owned_vehicles.job column
Config.Licensed = false   -- Enable Driver Licensed Checker
Config.DisplayCars = true -- enable display of cars
Config.Marker = true      -- use draw marker and Iscontrollpress native , popui will not work if this is true

-- VEHICLE THUMBNAILS IMAGE
-- this is standalone
Config.CustomImg = false           -- if true your Config.CustomImgColumn IMAGE url will be used for each vehicles else, the imgs/uploads/MODEL.jpg
Config.CustomImgColumn = 'imglink' -- db column name
-- this is standalone
-- Config.use_renzu_vehthumb -- Config.CustomImg must be false
Config.use_renzu_vehthumb = false -- use vehicle thumb generation script
Config.RgbColor = false           -- your framework or garage must support custom colors ex. https://github.com/renzuzu/renzu_garage

-- CARKEYS -- -- you need to replace the event
Config.Carkeys = function(plate, source)
    TriggerClientEvent('vehiclekeys:client:SetOwner', source, plate) -- THIS EVENT IS QBCORE CAR KEYS!, replace the event name to your carkeys event
end
-- CARKEYS --

--EXTRA
Config.UseArenaSpawn = true -- will use custom location for spawning vehicle in quickpick == false

-- MAIN
VehicleShop = {
    ['pdm'] = {       -- same with name
        name = "pdm", --LEGION
        title = "Autókereskedés",
        icon = 'https://i.imgur.com/05SLYUP.png',
        type = 'car',
        job = 'all',
        default_garage = 'FÖ PUBLIK',
        Dist = 4, -- distance (DEPRECATED)
        Blip = { color = 38, sprite = 595, scale = 0.9 },
        shop_x = -35.469879150391,
        shop_y = -1100.3621826172,
        shop_z = 26.422359466553, -- coordinates for this garage
        spawn_x = -27.40502,
        spawn_y = -1082.172,
        spawn_z = 26.63704,
        heading = 30.23065185547, -- Vehicle spawn location,
        displaycars = {
            {
                model = 'adder',
                value = 100000,
                coord = vector4(-47.427722930908, -1101.3747558594, 25.714616775513,
                    341.64694213867)
            },
            {
                model = 'adder',
                value = 1000000,
                coord = vector4(-44.736125946045, -1094.1976318359, 25.748092651367,
                    158.2547454834)
            },
            {
                model = 'adder',
                value = 1000000,
                coord = vector4(-40.32751083374, -1095.6105957031, 26.009906768799,
                    158.58676147461)
            },
            --{model = 'zentorno', value = 1000000, coord = vector4(-43.318450927734,-1102.1627197266,25.758722305298,340.29724121094)},
        }
    },

    -- ['Police Vehicle Shop'] = { -- same with name
    --     name = "Police Vehicle Shop", --MRPD police shop
    --     title = "Police Vehicle Shop",
    --     icon = 'https://i.imgur.com/t1OPuVL.png',
    --     job = 'police',
    --     type = 'carshop',
    --     default_garage = 'Police Garage',
    --     Dist = 3, -- distance (DEPRECATED)
    --     Blip = {color = 38, sprite = 662, scale = 0.9},
    --     shop_x = 456.89453125,
    --     shop_y = -1020.8922729492,
    --     shop_z = 28.290912628174, -- coordinates for this garage
    --     spawn_x = 449.27224731445,
    --     spawn_y = -1025.3255615234,
    --     spawn_z = 27.905115127563,
    --     heading = 2.6015937328339, -- Vehicle spawn location
    --     plateprefix = 'LSPD', -- carefull using this, maximum should be 4, recommended is 3, use this only for limited vehicles, if you use this parameter in other shop, you might have a limited plates available, ex. LSPD1234 (max char of plate is 8) it means you only have 9999 vehicles possible with this LSPD
    --     shop = { -- if not vehicle is setup in Database SQL, we will use this
    --         {shop='Police Vehicle Shop',category='Police Sedan',stock=50,price=100000,model='police',name="Police Car", grade = 1},
    --         {shop='Police Vehicle Shop',category='Police Sedan',stock=50,price=100000,model='police2',name="Police 2", grade = 1},
    --         {shop='Police Vehicle Shop',category='Police Sedan',stock=50,price=100000,model='police4',name="Police 4", grade = 3},
    --         {shop='Police Vehicle Shop',category='Police SUVs',stock=50,price=100000,model='police3',name="Police SUV",grade = 5},
    --     },
    -- },

    -- BOAT shop
    -- ['Yacht Club Boat Shop'] = { -- same with name
    --     name = "Yacht Club Boat Shop", --LEGION
    --     type = 'boat', -- type of shop
    --     title = "Yacht Club Boat Shop",
    --     icon = 'https://i.imgur.com/62bRdH6.png',
    --     job = 'all',
    --     default_garage = 'Boat Garage A',
    --     Dist = 7, -- distance (DEPRECATED)
    --     Blip = {color = 38, sprite = 410, scale = 0.9},
    --     shop_x = -812.87133789062,
    --     shop_y = -1407.4493408203,
    --     shop_z = 5.0005192756653, -- coordinates for this garage
    --     spawn_x = -818.69775390625,
    --     spawn_y = -1420.5775146484,
    --     spawn_z = 0.12045155465603,
    --     heading = 178.27006530762, -- Vehicle spawn location
    --     shop = { -- if not vehicle is setup in Database SQL, we will use this
    --         {shop='Yacht Club Boat Shop',category='Normal Boat',stock=50,price=50000,model='dinghy',name="Dinghy"},
    --         {shop='Yacht Club Boat Shop',category='Normal Boat',stock=50,price=100000,model='dinghy2',name="Dinghy2"},
    --         {shop='Yacht Club Boat Shop',category='Normal Boat',stock=50,price=100000,model='dinghy3',name="Dinghy 3"},
    --         {shop='Yacht Club Boat Shop',category='Normal Boat',stock=50,price=100000,model='dinghy4',name="Dinghy4"},
    --         {shop='Yacht Club Boat Shop',category='Rich Boat',stock=50,price=100000,model='marquis',name="Marquiz"},
    --         {shop='Yacht Club Boat Shop',category='Rich Boat',stock=50,price=100000,model='toro2',name="Toro 2"},
    --         {shop='Yacht Club Boat Shop',category='Submarine',stock=50,price=100000,model='submersible',name="Submersible"},
    --         {shop='Yacht Club Boat Shop',category='Submarine',stock=50,price=100000,model='submersible2',name="Submersible2"},
    --     },
    -- },
    -- -- PLANE SHOP
    -- ['DEVIN WESTON PLANE SHOP'] = { -- same with name
    --     name = "DEVIN WESTON PLANE SHOP", --LEGION
    --     title = "DEVIN PLANE SHOP",
    --     icon = 'https://i.imgur.com/12rKk6E.png',
    --     type = 'air', -- type of shop
    --     job = 'all',
    --     default_garage = 'Plane Hangar A',
    --     Dist = 7, -- distance (DEPRECATED)
    --     Blip = {color = 38, sprite = 423, scale = 0.9},
    --     shop_x = -916.04522705078,
    --     shop_y = -3025.2377929688,
    --     shop_z = 13.945063591003, -- coordinates for this garage
    --     spawn_x = -985.01806640625,
    --     spawn_y = -3005.4670410156,
    --     spawn_z = 14.783501625061,
    --     heading = 54.631553649902, -- Vehicle spawn location
    --     shop = { -- if not vehicle is setup in Database SQL, we will use this
    --         {shop='DEVIN WESTON PLANE SHOP',category='Military',stock=50,price=50000,model='hydra',name="Hydra"},
    --         {shop='DEVIN WESTON PLANE SHOP',category='Military',stock=50,price=100000,model='titan',name="Titan"},
    --         {shop='DEVIN WESTON PLANE SHOP',category='Private Plane',stock=50,price=100000,model='luxor2',name="Luxor 2"},
    --         {shop='DEVIN WESTON PLANE SHOP',category='Private Plane',stock=50,price=100000,model='luxor',name="Luxor"},
    --         {shop='DEVIN WESTON PLANE SHOP',category='Private Plane',stock=50,price=100000,model='nimbus',name="Nimbus"},
    --         {shop='DEVIN WESTON PLANE SHOP',category='Propeller Type',stock=50,price=100000,model='dodo',name="Dodo"},
    --         {shop='DEVIN WESTON PLANE SHOP',category='Propeller Type',stock=50,price=100000,model='duster',name="Duster"},
    --         {shop='DEVIN WESTON PLANE SHOP',category='Propeller Type',stock=50,price=100000,model='nokota',name="Nokota"},
    --     },
    -- },
}

Config.EnableVehicleSelling = true -- allow your user to sell the vehicle and deletes it from database
Config.RefundPercent = 50          -- 70% (percentage from original value)
Refund = {
    ['pdm'] = {                    -- same with name
        name = "pdm",              --LEGION
        job = 'all',
        Dist = 7,                  -- distance
        Blip = { color = 38, sprite = 219, scale = 0.6 },
        shop_x = -44.43322,
        shop_y = -1082.214,
        shop_z = 26.68363, -- coordinates for selling / refunding the vehicle
    },
}
--[[
Config.Vehicles = {
    ["1126868326"] = "bfinjection"
}
 ]]

Config.Colors = {
    ['0'] = '#0d1116',
    ['1'] = '#1c1d21',
    ['2'] = '#32383d',
    ['3'] = '#454b4f',
    ['4'] = '#999da0',
    ['5'] = '#c2c4c6',
    ['6'] = '#979a97',
    ['7'] = '#637380',
    ['8'] = '#63625c',
    ['9'] = '#3c3f47',
    ['10'] = '#444e54',
    ['11'] = '#1d2129',
    ['12'] = '#13181f',
    ['13'] = '#26282a',
    ['14'] = '#515554',
    ['15'] = '#151921',
    ['16'] = '#1e2429',
    ['17'] = '#333a3c',
    ['18'] = '#8c9095',
    ['19'] = '#39434d',
    ['20'] = '#506272',
    ['21'] = '#1e232f',
    ['22'] = '#363a3f',
    ['23'] = '#a0a199',
    ['24'] = '#d3d3d3',
    ['25'] = '#b7bfca',
    ['26'] = '#778794',
    ['27'] = '#c00e1a',
    ['28'] = '#da1918',
    ['29'] = '#b6111b',
    ['30'] = '#a51e23',
    ['31'] = '#7b1a22',
    ['32'] = '#8e1b1f',
    ['33'] = '#6f1818',
    ['34'] = '#49111d',
    ['35'] = '#b60f25',
    ['36'] = '#d44a17',
    ['37'] = '#c2944f',
    ['38'] = '#f78616',
    ['39'] = '#cf1f21',
    ['40'] = '#732021',
    ['41'] = '#f27d20',
    ['42'] = '#ffc91f',
    ['43'] = '#9c1016',
    ['44'] = '#de0f18',
    ['45'] = '#8f1e17',
    ['46'] = '#a94744',
    ['47'] = '#b16c51',
    ['48'] = '#371c25',
    ['49'] = '#132428',
    ['50'] = '#122e2b',
    ['51'] = '#12383c',
    ['52'] = '#31423f',
    ['53'] = '#155c2d',
    ['54'] = '#1b6770',
    ['55'] = '#66b81f',
    ['56'] = '#22383e',
    ['57'] = '#1d5a3f',
    ['58'] = '#2d423f',
    ['59'] = '#45594b',
    ['60'] = '#65867f',
    ['61'] = '#222e46',
    ['62'] = '#233155',
    ['63'] = '#304c7e',
    ['64'] = '#47578f',
    ['65'] = '#637ba7',
    ['66'] = '#394762',
    ['67'] = '#d6e7f1',
    ['68'] = '#76afbe',
    ['69'] = '#345e72',
    ['70'] = '#0b9cf1',
    ['71'] = '#2f2d52',
    ['72'] = '#282c4d',
    ['73'] = '#2354a1',
    ['74'] = '#6ea3c6',
    ['75'] = '#112552',
    ['76'] = '#1b203e',
    ['77'] = '#275190',
    ['78'] = '#608592',
    ['79'] = '#2446a8',
    ['80'] = '#4271e1',
    ['81'] = '#3b39e0',
    ['82'] = '#1f2852',
    ['83'] = '#253aa7',
    ['84'] = '#1c3551',
    ['85'] = '#4c5f81',
    ['86'] = '#58688e',
    ['87'] = '#74b5d8',
    ['88'] = '#ffcf20',
    ['89'] = '#fbe212',
    ['90'] = '#916532',
    ['91'] = '#e0e13d',
    ['92'] = '#98d223',
    ['93'] = '#9b8c78',
    ['94'] = '#503218',
    ['95'] = '#473f2b',
    ['96'] = '#221b19',
    ['97'] = '#653f23',
    ['98'] = '#775c3e',
    ['99'] = '#ac9975',
    ['100'] = '#6c6b4b',
    ['101'] = '#402e2b',
    ['102'] = '#a4965f',
    ['103'] = '#46231a',
    ['104'] = '#752b19',
    ['105'] = '#bfae7b',
    ['106'] = '#dfd5b2',
    ['107'] = '#f7edd5',
    ['108'] = '#3a2a1b',
    ['109'] = '#785f33',
    ['110'] = '#b5a079',
    ['111'] = '#fffff6',
    ['112'] = '#eaeaea',
    ['113'] = '#b0ab94',
    ['114'] = '#453831',
    ['115'] = '#2a282b',
    ['116'] = '#726c57',
    ['117'] = '#6a747c',
    ['118'] = '#354158',
    ['119'] = '#9ba0a8',
    ['120'] = '#5870a1',
    ['121'] = '#eae6de',
    ['122'] = '#dfddd0',
    ['123'] = '#f2ad2e',
    ['124'] = '#f9a458',
    ['125'] = '#83c566',
    ['126'] = '#f1cc40',
    ['127'] = '#4cc3da',
    ['128'] = '#4e6443',
    ['129'] = '#bcac8f',
    ['130'] = '#f8b658',
    ['131'] = '#fcf9f1',
    ['132'] = '#fffffb',
    ['133'] = '#81844c',
    ['134'] = '#ffffff',
    ['135'] = '#f21f99',
    ['136'] = '#fdd6cd',
    ['137'] = '#df5891',
    ['138'] = '#f6ae20',
    ['139'] = '#b0ee6e',
    ['140'] = '#08e9fa',
    ['141'] = '#0a0c17',
    ['142'] = '#0c0d18',
    ['143'] = '#0e0d14',
    ['144'] = '#9f9e8a',
    ['145'] = '#621276',
    ['146'] = '#0b1421',
    ['147'] = '#11141a',
    ['148'] = '#6b1f7b',
    ['149'] = '#1e1d22',
    ['150'] = '#bc1917',
    ['151'] = '#2d362a',
    ['152'] = '#696748',
    ['153'] = '#7a6c55',
    ['154'] = '#c3b492',
    ['155'] = '#5a6352',
    ['156'] = '#81827f',
    ['157'] = '#afd6e4',
    ['158'] = '#7a6440',
    ['159'] = '#7f6a48',
}
