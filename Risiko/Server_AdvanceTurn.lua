require("Annotations");
require('Utilities');
require('consolelog');
numTransfersTable = {};
limitSurpassedTransfers = {}; --array element = playerID; value indicates whether that user has been informed that they surpassed the transfer limit; if so, don't inform them again


function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if (order.proxyType == 'GameOrderEvent' or order.proxyType == 'GameOrderReceiveCard' or order.proxyType == 'GameOrderPlayCardSanctions') then
		return; --don't do anything to events, since they get inserted when we do .Skip below
	end
	
	if (game.Game.NumberOfTurns == 0) then
		if (order.proxyType == 'GameOrderDeploy') then return; else skipThisOrder(WL.ModOrderControl.Skip); end
	end			--Allow all deploy orders on the first turn, skip everything else
		
	--Check if this is an order by a player whose turn it isn't.
	local turnOrder = Mod.PublicGameData.PlayerOrder;
	local currTurn = turnOrder[game.Game.NumberOfTurns % #turnOrder + 1];

	if (order.PlayerID ~= currTurn and order.PlayerID ~= WL.PlayerID.Neutral) then
		skipThisOrder(WL.ModOrderControl.Skip);
		return;
	end


	--If we're here, it's not the first turn and it's this player's turn.  Enforce transfer limits.
	if (order.proxyType == 'GameOrderAttackTransfer') then
		if (result.IsAttack == false) then
			--this is a transfer order
			local numTransfers = numTransfersTable[order.PlayerID];
			if numTransfers == nil then numTransfers = 0; end
			if (numTransfers >= 1) then
				if (limitSurpassedTransfers [order.PlayerID] == nil) then
					addNewOrder(WL.GameOrderEvent.Create(order.PlayerID, "Remaining Transfer orders skipped; surpassed Transfer limit"));
					limitSurpassedTransfers [order.PlayerID] = true; --don't notify player again this turn for each remaining order that they have surpassed the transfer limit
				end
				skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage); --suppress the meaningless/detailless 'Mod skipped order' message, since in order with details has been added above
			else
				numTransfersTable[order.PlayerID] = numTransfers + 1;
			end
		end
	end
end


function Server_AdvanceTurn_End(game, addNewOrder)
	--Just for convenience, drop a 100% sanctions on anyone whose turn it isn't next turn.  This makes it so they don't have to deploy needlessly.
	local turnOrder = Mod.PublicGameData.PlayerOrder;
	local currTurn = turnOrder[game.Game.NumberOfTurns % #turnOrder + 1];
	local nextTurn = turnOrder[(game.Game.NumberOfTurns+1) % #turnOrder + 1];

	for _,sanction in pairs(turnOrder) do
		if (sanction ~= nextTurn) then
			local inst = WL.NoParameterCardInstance.Create(WL.CardID.Sanctions);
			addNewOrder(WL.GameOrderReceiveCard.Create(currTurn, {inst}));
			addNewOrder(WL.GameOrderPlayCardSanctions.Create(inst.ID, currTurn, sanction));
		end
	end
end