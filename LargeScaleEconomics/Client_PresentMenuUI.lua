require("UI")
require("consolelog")  
--[[
    Ok so basically with this the menu of the mod in game willwork on windows, 
    each time you want to add something you need to have a windown and when you destroy it
    all it's contentes vanishes which is really useful.
]]--

-- To translate from numbers to english:
relationLevel = {
    [1] = "Teammate",
    [2] = "Ally",
    [3] = "Trading partner",
    [4] = "Neutral",
    [5] = "Embargo",
    [6] = "Military intervention",
    [7] = "War enemy"
}    
relationUp = {
    [1] = "Offer to team up with ",
    [2] = "Offer to ally with ",
    [3] = "Offer to trade with ",
    [4] = "Offer to resume trades with ",
    [5] = "Offer to stop military conflict with ",
    [6] = "Offer to deescalate the conflict with ",
} 
relationDown = {
    [2] = "Dissolve the team with ",
    [3] = "Terminate the alliance with ",
    [4] = "Terminate trades with ",
    [5] = "Force an embargo on ",
    [6] = "Intervene militarily on ",
    [7] = "Declare war on "
} 
coopTypes = {
    [1] = "Defensive pact",
    [2] = "Federation",
    [3] = "Empire ",
}

function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game, closeAll)
	Game = game;
	Init(rootParent)
    vert = GetRoot();
	setMaxSize(450, 350);
	writeMenu()
end                             -- This part you shall not touch unless you're expert which I'm not

function writeMenu()
    DestroyWindow()             -- With this you destroy the previous window
    SetWindow("Home");          -- With this you create the windown you need to create stuff on. This one is the home.    

        openYourRelations = CreateButton(vert).SetText("Your relations").SetOnClick(function()
            yourRelationsFnt();        -- This creates the button to see your diplomatic relations with the various players
        end);



end

function  tablelength(T)
	local count = 0;
	for _, elem in pairs(T)do
		count = count + 1;
	end
	return count;
end

function yourRelationsFnt()            --Your diplomatic relations with the various players
    DestroyWindow();
    SetWindow("yourRelations")
    labelYourRelations = CreateLabel(vert).SetText("Your relations with:")
    CreateEmpty(vert)
    CreateEmpty(vert)
    listPlayers={}
    players = Game.Game.Players
    for key, player in pairs(players) do
        if (Game.Us.ID ~= key) then
            local name = player.DisplayName(nil, true)
            local color = player.Color.Name
            local level = Mod.PublicGameData.PlayersStatus[Game.Us.ID][key]
            local relation = relationLevel[level]
            listPlayers[key] = CreateButton(vert).SetText(name.." ("..color.."): "..relation).SetOnClick(function()
                yourRelationsWithFnt(key, name, color, level)
            end);
        end
    end
    returnFnt()                     -- The return button
end

function yourRelationsWithFnt(key, name, color, level)
    DestroyWindow();
    SetWindow("yourRelationsWith")
    labelYourRelations = CreateLabel(vert).SetText("Your relations with:")
    CreateEmpty(vert)
    labelYourRelationsWith = CreateLabel(vert).SetText(name.." ("..color..")")
    CreateEmpty(vert)
    labelCurrentRelation = CreateLabel(vert).SetText("Currently: "..relationLevel[level])
    CreateEmpty(vert)
    labelPartOf = CreateLabel(vert).SetText("He is part of:")
    coops = Mod.PublicGameData.Cooperations
    listCoopsPartOf = {}
    for coopName, coop in pairs(coops) do
        for i, id in ipairs(coop) do
            if id == key then
                listCoopsPartOf[coopName] = CreateLabel(vert).SetText(coopName.. ", "..coopTypes[coop.Type])
            break
            end
        end
    end
    if(level ~= 1)then
        CreateEmpty(vert)
        labelUpgrade = CreateButton(vert).SetText("Upgrade to: "..relationLevel[level-1]).SetOnClick(function()
            changeLevel(key, -1)
            writeMenu()
        end);
    end
    if(level ~= 7)then
        CreateEmpty(vert)
        labelDowngrade = CreateButton(vert).SetText("Downgrade to: "..relationLevel[level+1]).SetOnClick(function()
            changeLevel(key, 1)
            writeMenu()
        end);
    end
    CreateEmpty(vert)
    CreateEmpty(vert)
    back = CreateButton(vert).SetText("Go back").SetOnClick(function()
        yourRelationsFnt()                 -- Brings you back
    end);
end;

function globalRelationsFnt()       -- The diplomatic relations of all the players
    DestroyWindow();
    SetWindow("globalRelations")
    labelYourRelations = CreateLabel(vert).SetText("Whose relations do you want to see?")
    CreateEmpty(vert)
    CreateEmpty(vert)
    listPlayers={}
    for key, player in pairs(Game.Game.Players) do
        if (Game.Us.ID ~= key) then
            local name = player.DisplayName(nil, true)
            local color = player.Color.Name
            listPlayers[key] = CreateButton(vert).SetText(name.." ("..color..")").SetOnClick(function()
                theirRelationsFnt(key, name)
            end);
        end
    end
    returnFnt()             -- The return button
end

function theirRelationsFnt(theirID, them)    -- Their diplomatic relations to the various players
    DestroyWindow();
    SetWindow("theirRelations")
    labelYourRelations = CreateLabel(vert).SetText(them .."'s relations with:")
    CreateEmpty(vert)
    CreateEmpty(vert)
    listPlayers={}
    for key, player in pairs(Game.Game.Players) do
        if (theirID ~= key) then
            local name = player.DisplayName(nil, true)
            local color = player.Color.Name
            local level = Mod.PublicGameData.PlayersStatus[theirID][key]
            local relation = relationLevel[level]
            listPlayers[key] = CreateButton(vert).SetText(name.." ("..color.."): "..relation);
        end
    end
    CreateEmpty(vert)
    CreateEmpty(vert)
    back = CreateButton(vert).SetText("Go back").SetOnClick(function()
        globalRelationsFnt()                 -- Brings you back
    end);                   
end

function returnFnt()                --The return button
    CreateEmpty(vert)
    CreateEmpty(vert)
    returnButton = CreateButton(vert).SetText("Go back").SetOnClick(function()
        writeMenu()                 -- Brings you to the home
    end);
end

function changeLevel(id, n)
    if(Mod.Settings.LA)then
        if(Mod.Settings.UA)then
            if((n < 0) or (n == 1))then
                if((Mod.PlayerGameData.ActsTot >= Mod.Settings.LO) or (Mod.Settings.LO == -1))then
                    print("cant")
                    return
                end
            end
        else
            if(n < 0)then
                if((Mod.PlayerGameData.ActsOff >= Mod.Settings.LO) or (Mod.Settings.LO == -1))then
                    print("can't")
                    return
                end
            elseif(n==1)then
                if((Mod.PlayerGameData.ActsDec >= Mod.Settings.LD) or (Mod.Settings.LD == -1))then
                    print("cannot")
                    return
                end
            end
        end
    end
    payload = {Mod = 8063520}
    local actualPl = {}
    actualPl[id] = n
    payload.Content = actualPl
    Game.SendGameCustomMessage("Forcing...", payload, function()	showedreturnmessage = false; end);
end;

function yourActionsFnt()            --Your diplomatic relations with the various players
    DestroyWindow();
    SetWindow("yourActions")
    labelYourActions = CreateLabel(vert).SetText("Your actions this turn:")
    CreateEmpty(vert)
    CreateEmpty(vert)
    listActions = {}
    for id, action in pairs(Mod.PlayerGameData.Action) do
        local player = Game.Game.Players[id]
        local name = player.DisplayName(nil, true)
        local color = player.Color.Name
        local level = Mod.PublicGameData.PlayersStatus[Game.Us.ID][id]
        local relation 
        if(0 > action)then
            relation = relationUp[level+action]
        else
            relation = relationDown[level+action]
        end
        listActions[id] = CreateButton(vert).SetText(relation .. name .. " (" .. color .. ")").SetOnClick(function()
            yourActionWithFnt(id, name, color, relation)
        end);
    end
    returnFnt()                     -- The return button
end

function yourActionWithFnt(key, name, color, relation)
    DestroyWindow();
    SetWindow("yourActionsWith")
    labelYourActionsWith = CreateLabel(vert).SetText("Are you sure you want to rescind the " ..relation .. name .. " (" .. color .. ")?")
    CreateEmpty(vert)
    CreateEmpty(vert)
    yes = CreateButton(vert).SetText("Yes").SetOnClick(function()
        changeLevel(key, 0)
        writeMenu()
    end) 
    CreateEmpty(vert)
    CreateEmpty(vert)
    specBack()
end

function specBack()
    CreateEmpty(vert)
    CreateEmpty(vert)
    back = CreateButton(vert).SetText("Go back").SetOnClick(function()
        yourActionsFnt()                 -- Brings you back
    end); 
end

function offersReceivedFnt()
    DestroyWindow();
    SetWindow("offersReceived")
    labelOffersReceived = CreateLabel(vert).SetText("Offers received:")
    CreateEmpty(vert)
    CreateEmpty(vert)
    listOffers = {}
    for id, object in pairs(Mod.PlayerGameData.Object) do
        local player = Game.Game.Players[id]
        local name = player.DisplayName(nil, true)
        local color = player.Color.Name
        local level = Mod.PublicGameData.PlayersStatus[Game.Us.ID][id]
        local relation = relationLevel[level-1]
        listOffers[id] = CreateButton(vert).SetText(relation .. name .. " (" .. color .. ")").SetOnClick(function()
            acceptOfferFnt(id, name, color, relation)
        end);
    end
    returnFnt()  
end

function acceptOfferFnt(id, name, color, relation)
    DestroyWindow();
    SetWindow("acceptOffer")
    labelAcceptOffer = CreateLabel(vert).SetText("Do you want to accept the " ..relation .. name .. " (" .. color .. ")?")
    CreateEmpty(vert)
    CreateEmpty(vert)
    CreateEmpty(vert)
    choice = CreateHorizontalLayoutGroup(vert)
    yes = CreateButton(choice).SetText("Yes, accept offer").SetOnClick(function()
        changeLevel(id, -2)
    end) 
    CreateEmpty(choice)
    CreateEmpty(choice)
    no = CreateButton(choice).SetText("No, refuse offer").SetOnClick(function()
        changeLevel(id, 2)
    end)
    CreateEmpty(vert)
    CreateEmpty(vert)
    CreateEmpty(vert)
    back = CreateButton(vert).SetText("Go back").SetOnClick(function()
        writeMenu()                 -- Brings you back
    end); 
end

function yourCooperationsFnt()
    DestroyWindow();
    SetWindow("yourCooperations")
    labelYourCooperations = CreateLabel(vert).SetText("Cooperations you are part of:")
    CreateEmpty(vert)
    CreateEmpty(vert)
    listCooperations={}
    for name, coop in pairs(Mod.PublicGameData.Cooperations) do
        for i = 1, #coop.Members do
            if (Game.Us.ID == coop.Members[i]) then
                local type = coop.Type
                listCooperations[name] = CreateButton(vert).SetText(name.." ("..type..")").SetOnClick(function()
                    lookIntoCooperation(name, true)
                end);
                break
            end
        end 
    end
    CreateEmpty(vert)
    CreateEmpty(vert)
    returnFnt()  
end;

function createCooperationsFnt()
    DestroyWindow();
    SetWindow("createCooperations")
    labelCreateCooperation = CreateLabel(vert).SetText("Create a cooperation:")
    CreateEmpty(vert)
    CreateEmpty(vert)
    local sliderType = CreateHorizontalLayoutGroup(vert)
    labelType = CreateLabel(sliderType).SetText("Select the type")
    sliderType = CreateNumberInputField(sliderType).SetSliderMinValue(1).SetSliderMaxValue(3).SetValue(1)
    CreateEmpty(vert)
    CreateEmpty(vert)
    writerName = CreateTextInputField(vert).SetText("Enter the name for your cooperation here").SetPlaceholderText("Enter the name here").SetCharacterLimit(24)
    CreateEmpty(vert)
    CreateEmpty(vert)
    create = CreateButton(vert).SetText("Create").SetOnClick(function()
        typeCoop = sliderType.GetValue()
        nameCoop = writerName.GetText()
        if(typeCoop < 1)then
            typeCoop = 1
        elseif(typeCoop > 3)then
            typeCoop = 3
        end
        if((nameCoop ~= nil) and (nameCoop ~= "Enter the name for your cooperation here"))then 
            createTheCooperation(typeCoop, nameCoop)
            writeMenu()   
        end
    end)
    CreateEmpty(vert)
    CreateEmpty(vert)
    returnFnt()  
end

function globalCooperationsFnt()
    DestroyWindow();
    SetWindow("globalCooperations")
    labelGlobalCooperations = CreateLabel(vert).SetText("All cooperations present:")
    CreateEmpty(vert)
    CreateEmpty(vert)
    listCooperations={}
    if Mod.PublicGameData.Cooperations ~= nil then
        for name, coop in pairs(Mod.PublicGameData.Cooperations) do
            tblprint(coop)
            local type = coop.Type
            listCooperations[name] = CreateButton(vert).SetText(name.." ("..coopTypes[type]..")").SetOnClick(function()
                lookIntoCooperation(name, false)
            end);
        end
    else
        CreateLabel(vert).SetText("No cooperation present right now")
    end
    CreateEmpty(vert)
    CreateEmpty(vert)
    returnFnt()
end;

function lookIntoCooperation(name, w) --isin, wheter whoever is calling the function is inside the coop
    DestroyWindow();
    SetWindow("lookIntoCooperation")
    coop = Mod.PublicGameData.Cooperations[name]
    labelCooperationName = CreateLabel(vert).SetText(name)
    CreateEmpty(vert)
    CreateEmpty(vert)
    labelCooperationType = CreateLabel(vert).SetText(coopTypes[coop.Type])
    CreateEmpty(vert)
    if(coop.Type == Empire)then
        labelCooperationLeader = CreateLabel(vert).setText("Lead by "..coop.Leader)
        CreateEmpty(vert)
    end
    labelCooperationMembersNumber = CreateLabel(vert).SetText("Number of members: "..#coop.Members)
    CreateEmpty(vert)
    CreateEmpty(vert)
    local isin = false
    for i = 1, #coop.Members do
        if (Game.Us.ID == coop.Members[i]) then
            isin = true 
            break
        end
    end
    if(isin)then
        leaveCooperation = CreateButton(vert).SetText("Leave").SetOnClick(function()
            leaveCoop(name)
            writeMenu()
        end)
        CreateEmpty(vert)
        pendingRequests = CreateButton(vert).SetText("See pending requests ("..#coop.JoinRequests..")").SetOnClick(function()
            if(#coop.JoinRequests > 0)then
                seePendingRequestsFnt(name)
            end
        end)
    else
        joinCooperation = CreateButton(vert).SetText("Request to join").SetOnClick(function()
            requestJoinCoop(name)
        end)
    end
    CreateEmpty(vert)
    moreSettings = CreateButton(vert).SetText("Additional settings").SetOnClick(function()
        ulteriorSettings(name, w)
    end)
    CreateEmpty(vert)
    CreateEmpty(vert)
    CreateEmpty(vert)
    back = CreateButton(vert).SetText("Go back").SetOnClick(function()
        if(w)then 
            yourCooperationsFnt() 
        else 
            globalCooperationsFnt() 
        end
    end); 
end

function createTheCooperation(typeCoop, nameCoop)
    if(Mod.Settings.LA)then
        if(Mod.Settings.UA)then
            if((Mod.PlayerGameData.ActsTot >= Mod.Settings.LO) or (Mod.Settings.LO == -1))then
                print("cant")
                return
            end
        else
            if((Mod.PlayerGameData.ActsOff >= Mod.Settings.LO) or (Mod.Settings.LO == -1))then
                print("can't")
                return
            end
        end
    end
    if(Mod.PublicGameData.Cooperations ~= nil)then
        for name, _ in pairs(Mod.PublicGameData.Cooperations)do
            if(name == nameCoop)then
                return
            end
        end
    end
    payload = {Mod = 8063521}
    local actualPl = {}
    actualPl.Type = typeCoop
    actualPl.Name = nameCoop
    payload.Content = actualPl
    Game.SendGameCustomMessage("Waiting...", payload, function()    showedreturnmessage = false; end);
end         -- Cooperations

function leaveCoop(name)
    if(Mod.Settings.LA)then
        if(Mod.Settings.UA)then
            if((Mod.PlayerGameData.ActsTot >= Mod.Settings.LO) or (Mod.Settings.LO == -1))then
                print("cant")
                return
            end
        else
            if((Mod.PlayerGameData.ActsDec >= Mod.Settings.LD) or (Mod.Settings.LD == -1))then
                print("can't")
                return
            end
        end
    end
    payload = {Mod = 8063522}
    local actualPl = {}
    actualPl.Name = name
    payload.Content = actualPl
    print("send")
    Game.SendGameCustomMessage("Waiting...", payload, function()    showedreturnmessage = false; end);
end

function requestJoinCoop(name)
    if(Mod.Settings.LA)then
        if(Mod.Settings.UA)then
            if((Mod.PlayerGameData.ActsTot >= Mod.Settings.LO) or (Mod.Settings.LO == -1))then
                print("cant")
                return
            end
        else
            if((Mod.PlayerGameData.ActsOff >= Mod.Settings.LO) or (Mod.Settings.LO == -1))then
                print("can't")
                return
            end
        end
    end
    payload = {Mod = 8063523}
    local actualPl = {}
    actualPl.Name = name
    payload.Content = actualPl
    Game.SendGameCustomMessage("Waiting...", payload, function()    showedreturnmessage = false; end);
end

function treatCoopRequestFtn(name)
    DestroyWindow();
    SetWindow("treatJoinRequests")
    labelJoinRequests = CreateLabel(vert).SetText("All requests to join:")
    CreateEmpty(vert)
    CreateEmpty(vert)
    listRequests={}
    coop = Mod.PublicGameData.Cooperations[name]
    players = Game.Game.Players
    for i, id in ipairs(coop.JoinRequests) do
        local name = players[id].DisplayName(nil, true)
        local color = players[id].Color.Name
        local level = Mod.PublicGameData.PlayersStatus[Game.Us.ID][id]
        local relation = relationLevel[level]
        listRequests[id] = CreateButton(vert).SetText(name.." ("..color.."). Your relation with him is: "..relation).SetOnClick(function()
            print("B")
        end);
    end
end

function seePendingRequestsFnt(name)
    DestroyWindow();
    SetWindow("seePendingRequestes")
    coop = Mod.PublicGameData.Cooperations[name]
    labelPendingRequests = CreateLabel(vert).SetText("Players who requested to join "..name..":")
    CreateEmpty(vert)
    CreateEmpty(vert)
    listRequesters={}
    players = Game.Game.Players
    requesters = coop.JoinRequests
    for i, id in ipairs(requesters) do
        player = players[id]
        local playerName = player.DisplayName(nil, true)
        local color = player.Color.Name
        local level = Mod.PublicGameData.PlayersStatus[Game.Us.ID][key]
        local relation = relationLevel[level]
        listRequesters[id] = CreateButton(vert).SetText(name.." ("..color..").").SetOnClick(function()
            decidePendingRequest(id, name, color, relation)
        end);
    end
end

function decidePendingRequest(id, name, color, relation)
    DestroyWindow();
    SetWindow("seePendingRequestes")
    coop = Mod.PublicGameData.Cooperations[name]
    player = Game.Game.Players[id]
    labelPendingRequests = CreateLabel(vert).SetText("Do you wish to accept "..player.. " ("..color..") into the cooperation? Your relation with him is "..relation..".")
    CreateEmpty(vert)
    CreateEmpty(vert)
    choice = CreateHorizontalLayoutGroup(vert)
    yes = CreateButton(choice).SetText("Yes, accept request").SetOnClick(function()
        decidePR(name, id, true)
    end) 
    CreateEmpty(choice)
    CreateEmpty(choice)
    no = CreateButton(choice).SetText("No, refuse request").SetOnClick(function()
        decidePR(name, id, false)
    end)
    CreateEmpty(vert)
    CreateEmpty(vert)
    CreateEmpty(vert)
    back = CreateButton(vert).SetText("Go back").SetOnClick(function()
        writeMenu()                 -- Brings you back
    end); 
end

function decidePR(name, id, n)
    payload = {Mod = 8063524}
    local actualPl = {}
    actualPl.Name = name
    actualPl.Id = id
    actualPl.N = n
    payload.Content = actualPl
    Game.SendGameCustomMessage("Waiting...", payload, function()    showedreturnmessage = false; end);
end

function ulteriorSettings(name, w)
    DestroyWindow();
    SetWindow("ulteriorSettings")
    coop = Mod.PublicGameData.Cooperations[name]
    labelCooperationName = CreateLabel(vert).SetText(name..", all settings:")
    CreateEmpty(vert)
    CreateEmpty(vert)
    labelCooperationType = CreateLabel(vert).SetText(coopTypes[coop.Type])
    CreateEmpty(vert)
    if(coop.Type == Empire)then
        labelCooperationLeader = CreateLabel(vert).setText("Lead by "..coop.Leader)
        CreateEmpty(vert)
    end
    labelCooperationMembersNumber = CreateLabel(vert).SetText("Number of members: "..#coop.Members)
    CreateEmpty(vert)
    CreateEmpty(vert)
    labelCooperationMembersList = CreateLabel(vert).SetText("List of members:")
    CreateEmpty(vert)
    listMembers = {}
    for i, member in ipairs(coop.Members) do
        for pid, player in pairs(Game.Game.Players) do
            if pid == member then    
                listMembers[i] = CreateLabel(vert).SetText(player.DisplayName(nil, true))
                CreateEmpty(vert)
            end
        end
    end
    back = CreateButton(vert).SetText("Go back").SetOnClick(function()
        lookIntoCooperation(name, w)
    end)
end
