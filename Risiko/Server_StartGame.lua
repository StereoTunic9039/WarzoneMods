require("Annotations");

---Server_StartGame
---@param game GameServerHook
---@param standing GameStanding
function Server_StartGame(game, standing)
    --When the game starts, take all of the playing players, randomize their order, and store this into Mod.PublicGameData
    --Also, give each player 13 gold to start with.
    
    if not WL.IsVersionOrHigher or not WL.IsVersionOrHigher("5.26.1") then 
        return;
    end

    local pids = {};                    --Store all player IDs in a list
    local res = standing.Resources;     --Copy existing resources (gold) so we don't wipe them out

    if res == nil then res = {}; end
    for pid, player in pairs(game.Game.PlayingPlayers) do

        pids[#pids+1] = pid;            --Add this player to the list of player IDs

        if res[player.ID] == nil then res[player.ID] = {}; end  --Ensure this player has a resources table
        local t = {};                                           --To modify that table we copy it here and change this one
        for i, v in pairs(res[player.ID]) do                    --Copying as just anticipated   
            t[i] = v;
        end
        local np = #game.Game.PlayingPlayers;                   --Number of players
        t[WL.ResourceType.Gold] = (50-(5*np)) - math.floor(42/np);        --Give each player 13 gold to start with
        res[player.ID] = t;                                     --Store t back into the resources table
    end

    --to randomly sort fairly, generate a random number for each player and then sort by that.
	local rnd = {};
	for _,pid in pairs(pids) do
		rnd[pid] = math.random();
	end
	table.sort(pids, function(a,b) return rnd[a] < rnd[b] end);


    local gameData = Mod.PublicGameData;
	gameData.PlayerOrder = pids;
	Mod.PublicGameData = gameData;
    standing.Resources = res;
end