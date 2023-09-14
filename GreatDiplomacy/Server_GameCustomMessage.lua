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
        if(n==0)then
            playerGameData[ID][id] =  nil
            playerGameData[id][ID] =  nil
        elseif(n==1)then
            playerGameData[ID][id] = (Lvl +1)
            playerGameData[id][ID] =  nil
        elseif(n==-1)then
            if(playerGameData[ID][id] == -1)then
                playerGameData[ID][id] =  nil 
                playersStatus[ID][id] = (Lvl -1)
                playersStatus[id][ID] = (Lvl -1)
                publicGameData.PlayersStatus = playersStatus
                Mod.PublicGameData = publicGameData
            else
                playerGameData[id] = {[ID] = -1}
                playerGameData[ID] = {[id] = Lvl-1}
            end
        end

        Mod.PlayerGameData = playerGameData
        tblprint(Mod.PlayerGameData)
    end
end
