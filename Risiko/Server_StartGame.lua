require("Annotations");
require('Utilities');
require('consolelog');

---Server_StartGame
---@param game GameServerHook
---@param standing GameStanding
function Server_StartGame(game, standing)
    local theTargets = {
        ["18"] = {
            Message = "You need to control 18 territories, each with 2 armies, to win the game.",
            --CheckVictory = CheckVictory_Risk18T
        },
        ["24"] = {
            Message = "You need to control 24 territories to win the game.",
            --CheckVictory = CheckVictory_Risk24T
        },
        ["NA&AF"] = {
            Message = "You need to control North America and Africa to win the game.",
            --CheckVictory = CheckVictory_NA_AF
        },
        ["NA&OC"] = {
            Message = "You need to control North America and Oceania to win the game.",
            --CheckVictory = CheckVictory_NA_OC
        },
        ["AS&OC"] = {
            Message = "You need to control Asia and Oceania to win the game.",
            --CheckVictory = CheckVictory_AS_OC
        },
        ["AS&AF"] = {
            Message = "You need to control Asia and Africa to win the game.",
            --CheckVictory = CheckVictory_AS_AF
        },
        ["EU&SA&"] = {
            Message = "You need to control Europe, South America and a third continent of your choice to win the game.",
            --CheckVictory = CheckVictory_EU_SA
        },
        ["EU&OC&"] = {
            Message = "You need to control Europe, Oceania and a third continent of your choice to win the game.",
            --CheckVictory = CheckVictory_EU_OC
        }
    };

    --tblprint(game);
    --When the game starts, take all of the playing players, randomize their order, and store this into Mod.PublicGameData
    --Also, give each player income modifications.
    
    if not WL.IsVersionOrHigher or not WL.IsVersionOrHigher("5.26.1") then 
        return;
    end

    if game.Map.ID ~= 2 then error("Risiko mod only supports the Small Earth map (for now)."); end

    local gameData = Mod.PublicGameData;

    worldMap = {};
    for tid, terr in pairs(standing.Territories) do
        worldMap[tid] = {terr.OwnerPlayerID, terr.NumArmies};
    end

    targets = {"18", "24", "NA&AF", "NA&OC", "AS&OC", "AS&AF", "EU&SA&", "EU&OC&"};
    for pid, player in pairs(game.Game.PlayingPlayers) do
        targets[#targets+1] = player.ID;
        local newT = {
            Message = "You need to eliminate " .. player.DisplayName(nil, nil) .. " to win the game."
        }

        theTargets[player.ID] = newT;
    end

    for i = 1, 6 - #game.Game.PlayingPlayers, 1 do
        targets[#targets+1] = "24";
    end

    PlayerGameData = Mod.PlayerGameData;
    for pid, player in pairs(game.Game.PlayingPlayers) do
        local secretTarget = PlayerGameData[player.ID];
        if secretTarget == nil then
            secretTarget = {};
            local rnd = math.random(#targets);
            secretTarget.Target = targets[rnd];
            table.remove(targets, rnd);
        end
        PlayerGameData[player.ID] = secretTarget;
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
        local armies = {    --Totaling armies
            [2] = 12,       --40
            [3] = 17,       --35    
            [4] = 17,       --30
            [5] = 15,       --25
            [6] = 11,       --20
            [7] = 7,        --15
            [8] = 4         --10
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

    Mod.PlayerGameData = PlayerGameData;
    gameData.theTargets = theTargets;
	gameData.PlayerOrder = pids;
    gameData.WorldMap = worldMap;
	Mod.PublicGameData = gameData;
    standing.IncomeMods = res;
end