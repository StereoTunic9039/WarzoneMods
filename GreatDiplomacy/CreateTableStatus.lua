-- THIS WHOLE THING CREATES A TABLE WITH ALL THE RELATIONS AT THEIR START   

require("consolelog") 

xxx = 
    "****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
;  -- Just a placeholder to divide prints in case it's necessary

function CTS (game, standing)
    local publicGameData = Mod.PublicGameData
    local playerGameData = Mod.PlayerGameData
    local lvlAi = Mod.Settings.lvlAi
    local lvlPc = Mod.Settings.lvlPc
    local Cooperations = {}
    local PlayersStatus = {}                                -- Declaring the table where all the relations will be written
    
    for k, player in pairs(game.ServerGame.Game.Players) do   -- for everyone in the game ("k" will be their id)
        PlayersStatus[k] = {}                                   -- if I don't do this Lua won't know it's a table
        playerGameData[k] = {}
        playerGameData[k].Action = {}
        playerGameData[k].Object = {}
        playerGameData[k].ActsDec = 0
        playerGameData[k].ActsOff = 0
        playerGameData[k].ActsTot = 0
        for id, pid in pairs(game.ServerGame.Game.Players) do     -- for evryone in the game again ("id" will be their id this time)
            if (k ~= id) then                                       -- if they are not the same person
                if(pid.IsAI or player.IsAI) then                      -- if either of them is AI
                    PlayersStatus[k][id] = lvlAi                        -- then add to the person "k" their relation with person "id" at the Ai level
                else
                    PlayersStatus[k][id] = lvlPc                        -- otherwise add to the person "k" their relation with person "id" at the human level
                end
            end
        end
    end

    publicGameData.PlayersStatus = PlayersStatus;
    publicGameData.Cooperations = Cooperations;  
    Mod.PublicGameData = publicGameData             -- Just updates the publicGameData with the stuff
	Mod.PlayerGameData = playerGameData;
end