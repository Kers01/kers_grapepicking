local QBCore = exports['qb-core']:GetCoreObject()

local function PickGrapes(location)
    local playerPed = PlayerPedId()

    RequestAnimDict("amb@prop_human_bum_bin@base")
    while not HasAnimDictLoaded("amb@prop_human_bum_bin@base") do
        Wait(100)
    end

    TaskPlayAnim(playerPed, "amb@prop_human_bum_bin@base", "base", 1.0, -1.0, Config.PickupDuration * 1000, 1, 0, false, false, false)

    exports['progressbar']:Progress({
        name = "grape_picking",
        duration = Config.PickupDuration * 1000,
        label = "Üzüm Toplanıyor...",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(cancelled)
        if not cancelled then
            ClearPedTasks(playerPed)
            TriggerServerEvent('kers_üzüm:giveGrapes')
        else
            ClearPedTasks(playerPed)
            QBCore.Functions.Notify("Toplama iptal edildi!", "error")
        end
    end)
end

CreateThread(function()
    while true do
        local sleep = 1000
        local playerCoords = GetEntityCoords(PlayerPedId())
        
        for _, location in ipairs(Config.GrapeLocations) do
            local dist = #(playerCoords - location)
            if dist < 2.0 then
                sleep = 5
                QBCore.Functions.DrawText3D(location.x, location.y, location.z, "[E] Üzüm Topla")
                if IsControlJustPressed(0, 38) then
                    PickGrapes(location)
                end
            end
        end
        Wait(sleep)
    end
end)
