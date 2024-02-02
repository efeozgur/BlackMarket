local ped = nil
local pedCreated = false



CreateThread(function () 
    while true do
        Wait(1000)
        
        print(GetClockHours()..":"..GetClockMinutes()); 
    end
end)


CreateThread(function()
    while true do
        local saat = GetClockHours()
        
        if saat > 21 and saat < 24 then
            if not pedCreated then
                blackman()
                pedCreated = true -- ped oluşturulduğunu işaretle
            end
        else
            if pedCreated then
                -- Eğer ped zaten oluşturulmuşsa ve saat artık gece saatleri dışındaysa,
                DeletePed(ped)
                pedCreated = false -- ped oluşturma durumunu sıfırla
            end
        end
        
        Wait(1000)-- Döngüyü her 1 saniyede bir kontrol et
    end
end)




function blackman()
    
    local modelHash = GetHashKey(Config.PedHash);
    RequestModel(modelHash)
    while (not HasModelLoaded(modelHash)) do
        Wait(100)
    end
    ped = CreatePed(4, modelHash, Config.PedLokasyon, false, true);
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetModelAsNoLongerNeeded(ped)--> model yüklenince requestteki veriyi siler bu önemli resmon için
end

exports['qb-target']:AddTargetModel(Config.PedHash, {
    options = {
        {
            event = "openshop",
            icon = "fas fa-sack-dollar",
            label = "Goril Hüsnü",
        },
    
    },
    distance = 2.5,
})

RegisterNetEvent("openshop", function()
    local saat = GetClockHours();
    local gecemi = true
    local ShopItems = {}
    ShopItems.label = 'BlackMarket'
    ShopItems.items = Config.BlackItem;
    ShopItems.slots = #Config.BlackItem;
    
    
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "BlackItem_" .. math.random(1, 100), ShopItems)


end)
