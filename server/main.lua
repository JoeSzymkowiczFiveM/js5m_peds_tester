local pedInsert = {
    {
        name = 'random_tester_2',
        model = "s_f_m_fembarber",
        coords = vector3(-550.08, -44.33, 42.53),
        heading = 12.33,
        gender = "female", --Use male or female
        --animDict = "", --The animation dictionary. Optional. Comment out or delete if not using.
        --animName = "", --The animation name. Optional. Comment out or delete if not using.
        options = {
            {
                event = "new_peds_tester:client:changeAnim",
                icon = "fas fa-cut",
                label = "Test Anim",
                anim = {dict = "missminuteman_1ig_2", anim = "handsup_base"}
            },
            {
                event = "new_peds_tester:client:changeAnim",
                icon = "fas fa-cut",
                label = "Reset Anim",
                anim = {dict = nil, anim = nil, scenario = nil}
            },
            {
                event = "new_peds_tester:client:testerServer",
                icon = "fas fa-cut",
                label = "Test Flee",
                type = 'flee'
            },
            {
                event = "new_peds_tester:client:testerServer",
                icon = "fas fa-cut",
                label = "Test Ghost",
                type = 'ghost'
            },
            {
                event = "new_peds_tester:client:testerServer",
                icon = "fas fa-cut",
                label = "Test Wander",
                type = 'wander'
            },
            {
                event = "new_peds_tester:client:testerData",
                icon = "fas fa-cut",
                label = "Test Data",
            },
        },
        optionsDistance = 3.5
    },
}
local netPed = {
    name = 'net_ped_test',
    model = "s_f_m_fembarber",
    coords = vector3(293.45, -2194.62, 10.36),
    heading = 319.11,
    gender = "female", --Use male or female
    --animDict = "", --The animation dictionary. Optional. Comment out or delete if not using.
    --animName = "", --The animation name. Optional. Comment out or delete if not using.
    task = 'wander',
    options = {
        {
            name = "net_ped_test_1",
            event = "new_peds_tester:client:testerNet",
            icon = "fas fa-cut",
            label = "Test Net",
        },
    },
    optionsDistance = 3.5
}

local netPed2 = {
    name = 'net_ped_asdf',
    model = "s_f_m_fembarber",
    coords = vector3(250.9, -1722.62, 29.28),
    heading = 52.51,
    gender = "female", --Use male or female
    --animDict = "", --The animation dictionary. Optional. Comment out or delete if not using.
    --animName = "", --The animation name. Optional. Comment out or delete if not using.
    task = 'wander',
    options = {
        {
            name = "net_ped_test2_1",
            event = "new_peds_tester:client:testerNet",
            icon = "fas fa-cut",
            label = "Test Net",
        },
    },
    optionsDistance = 3.5
}

local netPed3 = {
    name = 'net_ped_asdf2',
    model = "a_m_m_salton_02",
    coords = vector3(-258.45, 6246.89, 31.49),
    heading = 320.49,
    gender = "male", --Use male or female
    --animDict = "", --The animation dictionary. Optional. Comment out or delete if not using.
    --animName = "", --The animation name. Optional. Comment out or delete if not using.
    task = 'wander',
    options = {
        {
            name = "net_ped_test3_1",
            serverEvent = "new_peds_tester:server:testerNetRemove",
            icon = "fas fa-cut",
            label = "Test Net",
        },
    },
    optionsDistance = 3.5
}

ped.addNetworkedPed(netPed)
ped.addNetworkedPed(netPed2)
ped.addNetworkedPed(netPed3)
ped.loadPeds(pedInsert)


RegisterNetEvent("new_peds_tester:server:changeAnim", function(data)
    local anim = data.anim
    local name = data.name

    ped.modifyAnim(name, anim)
end)

RegisterNetEvent(cache.resource..":server:testerServerRemove", function(data)
    local type = data.type
    local name = data.name

    ped.removePed(name, type)
    Wait(4000)
    ped.respawnPed(pedInsert[1])
end)

RegisterNetEvent(cache.resource..":server:testerNetRemove", function(data)
    print(json.encode(data, {indent=true}))
    local name = data.data
    print('name', name)
    ped.removeNetworkedPed(name)
end)