QBCore = exports['qb-core']:GetCoreObject()

local function Notify(player, message, type)
    if Config.NotifySystem == "none" then return end
    if Config.NotifySystem == "qbcore" then
        TriggerClientEvent('QBCore:Notify', player, message, type )
    elseif Config.NotifySystem == "okok" then
        TriggerClientEvent('okokNotify:Alert', player, "Info", message, 5000, type)
    elseif Config.NotifySystem == "codem" then
        TriggerClientEvent('codem_notify', player, message, type)
    elseif Config.NotifySystem == "qs" then
        TriggerClientEvent('qs-notify:send', player, message, type)
    end
end

local function GiveRandomItem()
    for _, playerId in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(playerId)
        if Player then
            local randomItem = Config.Items[math.random(#Config.Items)]
            local success = false
            
            if Config.Inventory == "qs-inventory" then
                success = exports["qs-inventory"]:AddItem(playerId, randomItem, 1)
            elseif Config.Inventory == "qb-inventory" then
                success = Player.Functions.AddItem(randomItem, 1)
            elseif Config.Inventory == "ox_inventory" then
                success = exports["ox_inventory"]:AddItem(playerId, randomItem, 1)
            end
            
            if Config.Debug then print("Versuchtes Item geben:", randomItem, "an Spieler", playerId) end
            
            if success then
                Notify(playerId, 'Du hast ein zufälliges Item erhalten ', 'success')
                if Config.Debug then print("Item gegeben:", randomItem, "an Spieler", playerId) end
                
                -- Zeitversetzt das Item entfernen
                CreateThread(function()
                    Wait(Config.RemoveAfter * 1000)
                    local PlayerCheck = QBCore.Functions.GetPlayer(playerId)
                    if PlayerCheck then
                        if Config.Inventory == "qs-inventory" then
                            exports["qs-inventory"]:RemoveItem(playerId, randomItem, 1)
                        elseif Config.Inventory == "qb-inventory" then
                            PlayerCheck.Functions.RemoveItem(randomItem, 1)
                        elseif Config.Inventory == "ox_inventory" then
                            exports["ox_inventory"]:RemoveItem(playerId, randomItem, 1)
                        end
                        Notify(playerId, 'Dein zufälliges Item wurde entfernt, da es nicht benutzt wurde.', 'error')
                        if Config.Debug then print("Item entfernt:", randomItem, "bei Spieler", playerId) end
                    end
                end)
            else
                Notify(playerId, 'Fehler beim Hinzufügen des Items: ' .. randomItem, 'error')
                if Config.Debug then print("Fehler beim Geben des Items:", randomItem, "an Spieler", playerId) end
            end
        end
    end
end

CreateThread(function()
    while true do
        Wait(Config.Interval * 1000)
        GiveRandomItem()
    end
end)