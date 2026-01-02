require("Annotations");
require('Utilities');
require('consolelog');

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
    local res = standing.IncomeMods;    --Copy existing income modification so not to wipe them out

    if res == nil then res = {}; end
    for pid, player in pairs(game.Game.PlayingPlayers) do

        pids[#pids+1] = pid;            --Add this player to the list of player IDs

        local np = #game.Game.PlayingPlayers;                               --Number of players 
        if np < 2 or np > 8 then
            error("Risiko mod only supports 2 to 6 players.");
        end
        local armies = {
            [2] = 12,
            [3] = 17,
            [4] = 17,
            [5] = 15,
            [6] = 11,
            [7] = 7,
            [8] = 4
        }
        local mod = armies[np];      --Give each player their armies

        res[#res+1] = WL.IncomeMod.Create(player.ID, mod, "how are you reading this?")
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
    standing.IncomeMods = res;
end