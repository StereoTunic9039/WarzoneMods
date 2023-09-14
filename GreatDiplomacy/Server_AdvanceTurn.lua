require("consolelog")

function Server_AdvanceTurn_Order(game, orderSee, orderModify, skipOrder, addNewOrder)
	pStatus = Mod.PublicGameData.PlayersStatus        -- Relations between players

	if(orderSee.proxyType == "GameOrderAttackTransfer")then				-- Attacks 
		local toowner = game.ServerGame.LatestTurnStanding.Territories[orderSee.To].OwnerPlayerID;
		if(toowner ~= WL.PlayerID.Neutral and orderSee.PlayerID ~= WL.PlayerID.Neutral and toowner ~= orderSee.PlayerID)then
			relation = pStatus[orderSee.PlayerID][toowner]
			if(relation < Mod.Settings.lvlWar)then
				if(not (relation > Mod.Settings.lvlTransfer))then
					local armies = orderSee.NumArmies.NumArmies
					local increment = WL.TerritoryModification.Create(orderSee.To);
					local decrement = WL.TerritoryModification.Create(orderSee.From);
					increment.AddArmies = armies
					decrement.AddArmies = -armies
					local departure = WL.GameOrderEvent.Create(orderSee.PlayerID, "Transfer, departure", {}, {decrement});
					local arrive = WL.GameOrderEvent.Create(toowner, "Transfer, arrive", {}, {increment});
					addNewOrder(departure)
					addNewOrder(arrive)
				end
				skipOrder(WL.ModOrderControl.Skip);
			end
		end
	end

	if(orderSee.proxyType == "GameOrderPlayCardBomb")then				-- Bomb
		local toowner = game.ServerGame.LatestTurnStanding.Territories[orderSee.TargetTerritoryID].OwnerPlayerID;
		if(toowner ~= WL.PlayerID.Neutral and orderSee.PlayerID ~= WL.PlayerID.Neutral and toowner ~= orderSee.PlayerID)then
			relation = pStatus[orderSee.PlayerID][toowner]
			if(relation < Mod.Settings.lvlBomb)then
				skipOrder(WL.ModOrderControl.Skip);
			end
		end
	end
	
	if(orderSee.proxyType == "GameOrderPlayCardSanctions")then			-- Sanctions
		local toowner = orderSee.SanctionedPlayerID
		if(toowner ~= WL.PlayerID.Neutral and orderSee.PlayerID ~= WL.PlayerID.Neutral and toowner ~= orderSee.PlayerID)then
			relation = pStatus[orderSee.PlayerID][toowner]
			if(relation < Mod.Settings.lvlSanction)then
				skipOrder(WL.ModOrderControl.Skip);
			end
		end
	end
	
	if(orderSee.proxyType == "GameOrderPlayCardGift")then
		local toowner = orderSee.GiftTo
		if(toowner ~= WL.PlayerID.Neutral and orderSee.PlayerID ~= WL.PlayerID.Neutral and toowner ~= orderSee.PlayerID)then
			relation = pStatus[orderSee.PlayerID][toowner]
			if(relation > Mod.Settings.lvlGift)then
				skipOrder(WL.ModOrderControl.Skip);
			end
		end
	end

	
end






function Server_AdvanceTurn_End(game, addNewOrder)										-- At the end of the turn
	local playerGameData = Mod.PlayerGameData
	local publicGameData = Mod.PublicGameData
	local playersStatus = publicGameData.PlayersStatus
	for playerID, player in pairs(game.ServerGame.Game.Players) do						-- for every player get their income
		tot, sum = 0, 0									-- Declare tot and sum, tot for the total income of the adversaries and sum for the net gain between sanctions and trades
		for pID, p in pairs(game.ServerGame.Game.Players) do							-- for every player get their income	
			if (playerID ~= pID) then													-- ignore if the are the same as OP
				inc = p.Income(0, game.ServerGame.LatestTurnStanding, true, true)		-- if they aren't get their income correctly and all
				tot = tot + inc["Total"]												-- add it to the tot 
				if(playersStatus[playerID][pID] <4)then									-- and add it to the sum 
					sum = sum + inc["Total"]
				elseif(playersStatus[playerID][pID] >4)then								--or subtract it based on their relations with OP
					sum = sum - inc["Total"]
				end
			end
		end			
		basInc = player.Income(0, game.ServerGame.LatestTurnStanding, true, false)        -- Income of the current player
		local var = (sum/(2*tot))														  -- Total of sanctions and trades ranging from -0.5 to 0.5
		var = var*basInc["Total"]														  -- It multiplied by the player's income it gives its buff/sanction
		local incomeMod = WL.IncomeMod.Create(playerID, var, "Sanctions and trades")	  
		addNewOrder(WL.GameOrderEvent.Create(playerID, var .. " Sanctions and trades", nil, {}, nil, {incomeMod}))    	-- The order for the income change
	end

	for playerID, player in pairs(game.ServerGame.Game.Players) do
		local moves = playerGameData[playerID].Action
		for pID, newStatus in pairs(moves) do
			if(newStatus ~= -1)then
				playersStatus[playerID][pID] = playersStatus[pID][playerID] + newStatus
				playersStatus[pID][playerID] = playersStatus[pID][playerID] + newStatus
			end
		end
	end
	for ID, _ in pairs(game.ServerGame.Game.Players)do
		playerGameData[ID] = {}
	end

	if(game.Settings.Cards[WL.CardID.Spy] ~= nil) then
		for playerID, player in pairs(game.ServerGame.Game.Players) do						-- for every player to see their allies
			for pID, p in pairs(game.ServerGame.Game.Players) do	
				if (playerID ~= pID)then
					if(playersStatus[playerID][pID]<=Mod.Settings.lvlSee)then
						local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.Spy);
						addNewOrder(WL.GameOrderReceiveCard.Create(playerID, {cardinstance}));
						addNewOrder(WL.GameOrderPlayCardSpy.Create(cardinstance.ID, playerID, pID));
					end
				end
			end
		end
	end

	Mod.PlayerGameData = playerGameData;
	publicGameData.PlayersStatus = playersStatus;
    Mod.PublicGameData = publicGameData 
end