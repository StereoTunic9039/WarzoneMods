require("consolelog")

--[[
function Server_AdvanceTurn_Start(game, addNewOrder)
	if Mod.PublicGameData.LandminesFound ~= nil then
        for _, t in pairs(Mod.PublicGameData.LandminesFound) do
            local terrID = t.TerrID;
            local mod = WL.TerritoryModification.Create(terrID);
            local rem = {};
            local add = {};
            for _, sp in pairs(game.ServerGame.LatestTurnStanding.Territories[terrID].NumArmies.SpecialUnits) do
                if isLandmine(sp) and sp.ImageFilename ~= "Landmine.png" then
                    table.insert(rem, sp.ID);
                    local clone = WL.CustomSpecialUnitBuilder.CreateCopy(sp);
                    clone.ImageFilename = "Landmine.png";
                    table.insert(add, clone.Build());
                end
            end
            if #rem > 0 then
                mod.AddSpecialUnits = add;
                mod.RemoveSpecialUnitsOpt = rem;
                local event = WL.GameOrderEvent.Create(t.Player, "Spotted landmine(s) on " .. game.Map.Territories[terrID].Name, {}, {mod});
                event.JumpToActionSpotOpt = WL.RectangleVM.Create(game.Map.Territories[terrID].MiddlePointX, game.Map.Territories[terrID].MiddlePointY, game.Map.Territories[terrID].MiddlePointX, game.Map.Territories[terrID].MiddlePointY);
                addNewOrder(event);
            end
        end
    end
end ]]--


function Server_AdvanceTurn_Order(game, order, orderResult, skipThisOrder, addNewOrder)
    local publicGameData = Mod.PublicGameData
    LP = publicGameData.LandminesPlaced
    Nlandmines = getNLandmines(game.ServerGame.LatestTurnStanding.Territories, order.PlayerID)
    if order.proxyType == "GameOrderCustom" and startsWith(order.Payload, "BuyLandmine_") and order.CostOpt ~= nil and Nlandmines < Mod.Settings.MaxUnits then
        local terrID = tonumber(string.sub(order.Payload, #"BuyLandmine_" + 1));
        if terrID ~= nil and game.ServerGame.LatestTurnStanding.Territories[terrID].OwnerPlayerID == order.PlayerID then
            if LP[terrID] == nil then
                LP[terrID] = 1
            else
                LP[terrID] = LP[terrID] + 1
            end
            local event = WL.GameOrderEvent.Create(order.PlayerID, "Placed a Landmine on " .. game.Map.Territories[terrID].Name, {}, {mod});
            event.JumpToActionSpotOpt = WL.RectangleVM.Create(game.Map.Territories[terrID].MiddlePointX, game.Map.Territories[terrID].MiddlePointY, game.Map.Territories[terrID].MiddlePointX, game.Map.Territories[terrID].MiddlePointY);
            event.AddResourceOpt = {[order.PlayerID] = {[WL.ResourceType.Gold] = -order.CostOpt[WL.ResourceType.Gold]}};
            skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
            addNewOrder(event);
        end    
        publicGameData.LandminesPlaced = LP
        Mod.PublicGameData = publicGameData
    elseif order.proxyType == "GameOrderAttackTransfer" then
        local condition = false
        if orderResult.IsAttack and orderResult.IsSuccessful then
            for id, _ in pairs(LP) do
                if id == order.To then
                    condition = true
                    break
                end
            end
        end
        if condition then
            terr = game.ServerGame.LatestTurnStanding.Territories[order.To]
            local dmg; local n;
            if Mod.Settings.IsFixedDamage then
                dmg = Mod.Settings.Damage
            else 
                dmg = Mod.Settings.Damage * (orderResult.ActualArmies.NumArmies - orderResult.AttackingArmiesKilled.NumArmies) /100
            end
            local exploded = WL.TerritoryModification.Create(order.To);
            exploded.AddArmies = math.ceil(-dmg)
            if Mod.Settings.TurnNeutral and orderResult.ActualArmies.NumArmies - orderResult.AttackingArmiesKilled.NumArmies + exploded.AddArmies <= 0 then
                exploded.SetOwnerOpt = WL.PlayerID.Neutral;
                n = orderResult.ActualArmies.NumArmies - orderResult.AttackingArmiesKilled.NumArmies
            else
                n = math.ceil(dmg)
            end
            local event = WL.GameOrderEvent.Create(order.PlayerID, "A Landmine exploded in " .. game.Map.Territories[order.To].Name .. " killing " .. n .. " armies. ", {}, {exploded});
            event.JumpToActionSpotOpt = WL.RectangleVM.Create(game.Map.Territories[order.To].MiddlePointX, game.Map.Territories[order.To].MiddlePointY, game.Map.Territories[order.To].MiddlePointX, game.Map.Territories[order.To].MiddlePointY);
            addNewOrder(event); 
            LP[order.To] = nil
        end
    end
end

function startsWith(s, sub)
    return string.sub(s, 1, #sub) == sub;
end
function getNLandmines(territories, p)
    local c = 0;
    for _, terr in pairs(territories) do
        if terr.NumArmies.SpecialUnits ~= nil and #terr.NumArmies.SpecialUnits > 0 then
            for _, sp in pairs(terr.NumArmies.SpecialUnits) do
                if isLandmine(sp) then
                    c = c + 1;
                end
            end
        end
    end
    return c;
end

function isLandmine(sp)
    return sp.proxyType == "CustomSpecialUnit" and sp.Name == "Landmine";
end

