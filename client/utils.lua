local Charset = {}
for i = 65, 90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

local NumberCharset = {}
for i = 48, 57 do table.insert(NumberCharset, string.char(i)) end

function GenPlate(prefix)
  local plate = LetterRand() .. ' ' .. NumRand()
  if prefix then plate = prefix .. ' ' .. NumRand() end

  local plateIsValid = lib.callback.await("renzu_vehicleshop:validateplate", false, plate)

  if plateIsValid then
    return plate
  end

  Wait(100)
  return GenPlate(prefix)
end

function LetterRand()
  local emptyString = {}
  local randomLetter;
  while (#emptyString < 6) do
    randomLetter = GetRandomLetter(1)
    table.insert(emptyString, randomLetter)
    Wait(0)
  end
  local a = string.format("%s%s%s", table.unpack(emptyString)):upper() -- "2 words"
  return a
end

function NumRand()
  local emptyString = {}
  local randomLetter;
  while (#emptyString < 6) do
    randomLetter = GetRandomNumber(1)
    table.insert(emptyString, randomLetter)
    Wait(0)
  end
  local a = string.format("%i%i%i", table.unpack(emptyString)) -- "2 words"
  return a
end

function GetRandomLetter(length)
  math.randomseed(GetGameTimer())
  if length > 0 then
    return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
  else
    return ''
  end
end

function GetRandomNumber(length)
  math.randomseed(GetGameTimer())
  if length > 0 then
    return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
  else
    return ''
  end
end

function GetDisplayName(model)
  for k, v in pairs(Config.Vehicles) do
    if v.hash == joaat(model) then
      return v.model
    end
  end

  return GetDisplayNameFromVehicleModel(model):lower()
end
