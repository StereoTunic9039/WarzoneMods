require("consolelog")

function Server_GameCustomMessage(game, ID, payload)
    if(payload.Mod == 8063520)then
        actualPl = payload.Content
        id = next(actualPl)
        n = actualPl[id]
        local playerGameData = Mod.PlayerGameData
        local publicGameData = Mod.PublicGameData
        local playersStatus = publicGameData.PlayersStatus
        local Lvl = playersStatus[ID][id]
        p1a = playerGameData[ID].Action
        p2a = playerGameData[id].Action
        p1o = playerGameData[ID].Object
        p2o = playerGameData[id].Object
        if(n==2)then                                    -- Refuse peace offer
            p1o[id] = nil
            p2a[ID] = nil
        elseif(n==1)then                                -- Declare war
            p1a[id] = 1
            p2o[ID] = nil
            if(p1o[id] ~= nil)then        ---CHECK THIS!!!!   
                p1o[id] = nil
                p2a[ID] = nil
                playerGameData[id].ActsTot = playerGameData[id].ActsTot -1
                playerGameData[id].ActsOff = playerGameData[id].ActsOff -1
            end
            playerGameData[ID].ActsTot = playerGameData[ID].ActsTot +1
            playerGameData[ID].ActsDec = playerGameData[ID].ActsDec +1
        elseif(n==0)then                                -- Retract declaration/offering
            if(p1a[id] == 1)then
                p1a[id] = nil
                playerGameData[ID].ActsDec = playerGameData[ID].ActsDec -1
            else
                p1a[id] = nil
                p2o[ID] = nil
                playerGameData[ID].ActsOff = playerGameData[ID].ActsOff -1
            end
            playerGameData[ID].ActsTot = playerGameData[ID].ActsTot -1
            
        elseif(n==-1)then                               -- Offer peace
            p1a[id] = -1
            p2o[ID] = -1
            playerGameData[ID].ActsTot = playerGameData[ID].ActsTot +1
            playerGameData[ID].ActsOff = playerGameData[ID].ActsOff +1
        elseif(n==-2)then                               -- Accept peace offer
            p1a[id] = nil
            p2o[ID] = nil
            p1o[id] = nil
            p2a[ID] = nil
            playersStatus[ID][id] = (Lvl -1)
            playersStatus[id][ID] = (Lvl -1)
            playerGameData[ID].ActsTot = playerGameData[ID].ActsTot +1
            playerGameData[ID].ActsOff = playerGameData[ID].ActsOff +1
            publicGameData.PlayersStatus = playersStatus
            Mod.PublicGameData = publicGameData
        end
        playerGameData[ID].Action = p1a
        playerGameData[id].Action = p2a
        playerGameData[ID].Object = p1o
        playerGameData[id].Object = p2o
        Mod.PlayerGameData = playerGameData
    end
end

