local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('kers_üzüm:giveGrapes', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local grapeCount = math.random(Config.MinGrapes, Config.MaxGrapes)
        Player.Functions.AddItem('uzum', grapeCount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['uzum'], 'add')
        TriggerClientEvent('QBCore:Notify', src, grapeCount .. " adet üzüm topladın!", "success")
    end
end)
