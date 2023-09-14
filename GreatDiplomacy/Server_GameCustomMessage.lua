require("consolelog")

function Server_GameCustomMessage(game, ID, payload)
    if(payload.Mod == 8063520)then
	    print("started")
        actualPl = payload.Content
        id = next(actualPl)
        n = actualPl[id]
        local playerGameData = Mod.PlayerGameData
        local publicGameData = Mod.PublicGameData
        local playersStatus = publicGameData.PlayersStatus
        local Lvl = playersStatus[ID][id]
        if(n==2)then                                    -- Refuse peace offer
            playerGameData[ID][id].Object = nil
            playerGameData[id][ID].Action = nil
        elseif(n==1)then                                -- Declare war
            playerGameData[ID][id].Action = 1
            playerGameData[id][ID].Object = nil
            if(playerGameData[ID][id].Object == -1)then
                playerGameData[ID][id].Object = nil
                playerGameData[id][ID].Action = nil
            end
        elseif(n==0)then                                -- Retract declaration/offering
            playerGameData[ID][id].Action = nil
            playerGameData[id][ID].Object = nil
        elseif(n==-1)then                               -- Offer peace
            playerGameData[ID][id].Action = -1
            playerGameData[id][ID].Object = -1
        elseif(n==-2)then                               -- Accept peace offer
            playerGameData[ID][id].Action = nil 
            playerGameData[ID][id].Object = nil
            playerGameData[id][ID].Action = nil
            playerGameData[id][ID].Object = nil
            playersStatus[ID][id] = (Lvl -1)
            playersStatus[id][ID] = (Lvl -1)
            publicGameData.PlayersStatus = playersStatus
            Mod.PublicGameData = publicGameData
        end

        Mod.PlayerGameData = playerGameData
        tblprint(Mod.PlayerGameData)
    end
end
