require("consolelog")
coopTypes = {
    [1] = "Defensive pact",
    [2] = "Federation",
    [3] = "Empire ",
}

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

    if(payload.Mod == 8063521)then
        actualPl = payload.Content
        coopName = actualPl.Name
        coopType = actualPl.Type
        publicGameData = Mod.PublicGameData
        coops = Mod.PublicGameData.Cooperations
        coops[coopName] = {}
        coops[coopName].Type = coopType
        coops[coopName].Members = {ID}
        coops[coopName].JoinRequests = {}
        if(coopType == 3)then
            coops[coopName].Leader = ID
        end
        publicGameData.Cooperations = coops
        Mod.PublicGameData = publicGameData
    end

    if(payload.Mod == 8063522)then
        name = payload.Content.Name
        publicGameData = Mod.PublicGameData
        coop = publicGameData.Cooperations[name]
        if(#coop.Members == 1)then 
            publicGameData.Cooperations[name] = nil
        else
            for i, value in ipairs(coop.Members)do
                if(value == ID)then
                    table.remove(coop.Members, i)
                    break
                end
            end
            publicGameData.Cooperations[name] = coop
        end
        Mod.PublicGameData = publicGameData
    end

    if(payload.Mod == 8063523)then
        name = payload.Content.Name
        publicGameData = Mod.PublicGameData
        coop = publicGameData.Cooperations[name]
        coopJR = coop.JoinRequests
        coopJR[ID] = {["Favor"]={}, ["Against"]={}}
        coop.JoinRequests = coopJR
        publicGameData.Cooperations = coop
        Mod.PublicGameData = publicGameData
    end

    if(payload.Mod == 8063524)then
        name = payload.Content.Name
        n = payload.Content.N 
        id = payload.Content.Id 
        publicGameData = Mod.PublicGameData
        coop = publicGameData.Cooperations[name]
        coopJR = coop.JoinRequests
        favor = coopJR[id].Favor
        against = coopJR[id].Against
        if(Mod.Settings.VP)then
            if(n)then
                if not favor[ID] then
                    favor[ID] = true
                    if #favor == #coop.Members then
                        table.insert(coop.Members, id)
                        coopJR[id] = nil
                        if #coop.Members >= Mod.Settings.mpdps then
                            coop.JoinRequests = {}
                        end
                    end
                end
            else
                coopJR[id] = nil
            end
        else
            if(n)then
                if not favor[ID] then
                    favor[ID] = true
                    if (#favor > (#coop.Members - #favor))then
                        table.insert(coop.Members, id)
                        coopJR[id] = nil
                        if #coop.Members >= Mod.Settings.mpdps then
                            coop.JoinRequests = {}
                        end
                    end
                end
            else
                if not against[ID] then
                    against[ID] = true
                    if (#against >= (#coop.Members - #against))then 
                        coopJR[id] = nil
                    end
                end
            end
        end
        publicGameData.Cooperations[name] = coop
        Mod.PublicGameData = publicGameData
    end
end

