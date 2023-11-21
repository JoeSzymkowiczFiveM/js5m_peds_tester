local function netMarker()
    CreateThread(function()
        while true  do
            for k, v in pairs(peds) do
                if v.source == 'server' then
                    -- print(GetEntityCoords(v.ped))
                    local coords = GetEntityCoords(v.ped)
                    DrawMarker(2, coords.x, coords.y, coords.z+20, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.5, 2.5, 2.5, 255, 255, 255, 255, false, false, false, true, false, false, false)

                end
            end
            Wait(2)
        end
    end)
end

AddEventHandler('onClientResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    netMarker()
    FreezeEntityPosition(cache.ped, false)
end)

local function test()
    print('JoeSzymkowiczFiveM')
end

local pedInsert = {{
    name = 'random_tester_1',
    model = "s_f_m_fembarber",
    coords = vector3(-573.01, -38.56, 42.83),
    heading = 158.01,
    gender = "female",
    options = {
        {
            event = "new_peds_tester:client:tester",
            icon = "fas fa-cut",
            label = "Test",
        },
        {
            onSelect = test,
            icon = "fas fa-cut",
            label = "Test 2",
        },
    },
    optionsDistance = 3.5
}}
ped.loadPeds(pedInsert)

RegisterNetEvent("new_peds_tester:client:tester", function(data)
    print(json.encode(data, {indent=true}))
end)

RegisterNetEvent("new_peds_tester:client:testerServer", function(data)
    local data = {
        type = data.type,
        name = data.data,
    }
    TriggerServerEvent(cache.resource..':server:testerServerRemove', data)
end)

RegisterNetEvent("new_peds_tester:client:testerData", function(data)
    for k, v in pairs(peds[data.data]) do
        print(k, tostring(v))
    end
end)

RegisterNetEvent("new_peds_tester:client:changeAnim", function(data)
    local data = {
        anim = data.anim,
        name = data.data,
    }
    TriggerServerEvent(cache.resource..':server:changeAnim', data)
end)

RegisterNetEvent("new_peds_tester:client:testerNet", function(data)
    print(data.name)
    local heading = GetEntityHeading(data.entity)
    local coords = GetOffsetFromEntityInWorldCoords(data.entity, 0.0, 0.95, 0.0)
    FreezeEntityPosition(cache.ped, true)
    FreezeEntityPosition(data.entity, true)

    SetEntityHeading(cache.ped, heading - 180.1)
    SetEntityCoordsNoOffset(cache.ped, coords.x, coords.y, coords.z, 0)
    Wait(300)
    ClearPedTasksImmediately(data.entity)
    local dict = "mp_ped_interaction"
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
    Wait(4500)
    TaskPlayAnim(cache.ped, dict, "hugs_guy_a", 2.0, 2.0, -1, 0, 0, false, false, false)
    TaskPlayAnim(data.entity, dict, "hugs_guy_a", 2.0, 2.0, -1, 0, 0, false, false, false)
    Wait(4500)
    FreezeEntityPosition(data.entity, false)
    FreezeEntityPosition(cache.ped, false)
    peds[data.name].tasked = false
end)
