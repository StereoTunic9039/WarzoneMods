require("consolelog")

function Server_AdvanceTurn_End(game, addNewOrder)
	WB = Mod.Settings.WeakenBlockades
	if game.ServerGame.Game.TurnNumber >= WB.delayFromStart then
		local territories = game.ServerGame.LatestTurnStanding.Territories --.GameStanding.Territories
		for tid, nterritory in pairs(territories) do
			if(nterritory.IsNeutral)then
				if(WB.appliesToAllNeutrals or WB.appliesToMinArmies <= nterritory.NumArmies.NumArmies)then
					connectedTerritories = game.Map.Territories[tid].ConnectedTo
					connectedTerritoriesOwners = {}
					for ID, cterritory in pairs(connectedTerritories) do
						if not connectedTerritoriesOwners[territories[ID].OwnerPlayerID] then
							connectedTerritoriesOwners[territories[ID].OwnerPlayerID] = true
						end
					end
					local length = 0
					for _ in pairs(connectedTerritoriesOwners) do
						length = length + 1
					end
					if(length == 1 and (next(connectedTerritoriesOwners) ~= WL.PlayerID.Neutral))then
						local negArmies
						if(WB.percentualOrFixed)then
							if(WB.fixedArmiesRemoved > nterritory.NumArmies.NumArmies)then
								negArmies = -nterritory.NumArmies.NumArmies
							else
								negArmies = -WB.fixedArmiesRemoved
							end
						else
							negArmies = -((nterritory.NumArmies.NumArmies * WB.percentualArmiesRemoved) / 100)
						end
						local decrement = WL.TerritoryModification.Create(tid);
						decrement.AddArmies = negArmies 
						local reduction = WL.GameOrderEvent.Create(next(connectedTerritoriesOwners), "Decrease armies", {}, {decrement});
						addNewOrder(reduction)
					end  
				end
			end
		end
	end
end

					