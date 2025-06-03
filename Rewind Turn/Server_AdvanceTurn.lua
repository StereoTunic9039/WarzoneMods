require("Utilities");
require("consolelog")

local GS = {}

function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)   -- when the order of the played card is called idk im too tired to properly comment goodday
    if (order.proxyType == 'GameOrderPlayCardCustom' and startsWith(order.ModData, "RewindCard")) then
        local playerID = tonumber(string.sub(order.ModData, 11));
		
		local pub = Mod.PublicGameData;
		local allIDs = pub.RwcIDs;

		if allIDs == nil then
			allIDs = {}

			GS = game.ServerGame.LatestTurnStanding
			tblprint("GameStanding")



		end

		table.insert(allIDs, playerID);
		pub.RwcIDs = allIDs;
		Mod.PublicGameData = pub;

		--local priority = 7000; -- between 6000 and 8999 means it won't obscure a player's own territories
		--local fogMod = WL.FogMod.Create('Obscured by smoke bomb', WL.StandingFogLevel.Fogged, priority, terrs, nil);

		--local event = WL.GameOrderEvent.Create(order.PlayerID, 'Detonated a smoke bomb', {});
		--event.FogModsOpt = {fogMod};
		--event.JumpToActionSpotOpt = WL.RectangleVM.Create(td.MiddlePointX, td.MiddlePointY, td.MiddlePointX, td.MiddlePointY);

		--if (WL.IsVersionOrHigher("5.34.1")) then
		--	event.TerritoryAnnotationsOpt = { [targetTerritoryID] = WL.TerritoryAnnotation.Create("Smoke Bomb") };
		--end
		
		--addNewOrder(event);

		--Store the ID so we can later disable it
		
    end
end


function Server_AdvanceTurn_End(game, addNewOrder)
	--If we have any existing rewind  mods, remove them
	local pub = Mod.PublicGameData;
	if (pub.RwcIDs == nil) then
		return; 
	end

	game.ServerGame.LatestTurnStanding = GS

	--local event = WL.GameOrderEvent.Create(WL.PlayerID.Neutral, 'Smoke bombs dissipate', {});
	--event.RemoveFogModsOpt = priv.FogModIDs;
	--addNewOrder(event);

	pub.RwcIDs = nil;
	Mod.PublicGameData = pub;
end