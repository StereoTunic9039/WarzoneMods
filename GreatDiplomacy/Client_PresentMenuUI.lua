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

    if(Game.Us ~= nil)then      -- Only if you are a player you'll have diplomatic relations with players
        openYourRelations = CreateButton(vert).SetText("Your relations").SetOnClick(function()
            yourRelationsFnt();        -- This creates the button to see your diplomatic relations with the various players
        end);
	end

    if(Game.Us ~= nil)then      -- Only if you are a player you'll have diplomatic relations with players
        openYourCooperations = CreateButton(vert).SetText("Cooperations you are part of").SetOnClick(function()
            yourCooperationsFnt();        -- This creates the button to see your diplomatic relations with the various players
        end);
	end

    if(Game.Us ~= nil)then             -- Only if you are a player you'll have diplomatic relations with players
        openYourActions = CreateButton(vert).SetText("Your actions").SetOnClick(function()
            yourActionsFnt();        -- This creates the button to see your diplomatic actions with the various players
        end);
	end

    if(Game.Us ~= nil)then             -- Only if you are a player you'll have diplomatic relations with players
        offersReceived = CreateButton(vert).SetText("Offers received").SetOnClick(function() 
            offersReceivedFnt();   -- No matter if you're a player or not, you'll be able to see the relations of everyone
        end);
	end

    globalCooperations = CreateButton(vert).SetText("All cooperations present").SetOnClick(function() 
        globalCooperationsFnt();   -- No matter if you're a player or not, you'll be able to see the relations of everyone
    end);

    globalRelations = CreateButton(vert).SetText("Everyone's relations").SetOnClick(function() 
        globalRelationsFnt();   -- No matter if you're a player or not, you'll be able to see the relations of everyone
    end);
end

function addOrder(order)
	local orders = Game.Orders;
	if(Game.Us.HasCommittedOrders == true)then
		UI.Alert("You need to uncommit first");
		return;
	end
	table.insert(orders, order);
	Game.Orders = orders;
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
    for key, player in pairs(Game.Game.Players) do
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
    if(level ~= 1)then
        CreateEmpty(vert)
        labelUpgrade = CreateButton(vert).SetText("Upgrade to: "..relationLevel[level-1]).SetOnClick(function()
            changeLevel(key, -1)
            yourRelationsFnt()
        end);
    end
    if(level ~= 7)then
        CreateEmpty(vert)
        labelDowngrade = CreateButton(vert).SetText("Downgrade to: "..relationLevel[level+1]).SetOnClick(function()
            changeLevel(key, 1)
            yourRelationsFnt()
        end);
    end
    CreateEmpty(vert)
    CreateEmpty(vert)
    back = CreateButton(vert).SetText("GO BACK").SetOnClick(function()
        yourRelationsFnt()                 -- Brings you back
    end);
end;

function globalRelationsFnt()       -- The diplomatic relations of all the players
    DestroyWindow();
    SetWindow("globalRelations")
    labelYourRelations = CreateLabel(vert).SetText("Whose relations do you want to see?:")
    CreateEmpty(vert)
    CreateEmpty(vert)
    listPlayers={}
    for key, player in pairs(Game.Game.Players) do
        if (Game.Us.ID ~= key) then
            local name = player.DisplayName(nil, true)
            local color = player.Color.Name
            listPlayers[key] = CreateButton(vert).SetText(name.."; "..color).SetOnClick(function()
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
    back = CreateButton(vert).SetText("GO BACK").SetOnClick(function()
        globalRelationsFnt()                 -- Brings you back
    end);                   
end

function returnFnt()                --The return button
    CreateEmpty(vert)
    CreateEmpty(vert)
    returnButton = CreateButton(vert).SetText("GO BACK").SetOnClick(function()
        writeMenu()                 -- Brings you to the home
    end);
end

function changeLevel(id, n)
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
    for id, action in pairs(Mod.PlayerGameData) do
        if(action ~= -1)then
            local player = Game.Game.Players[id]
            local name = player.DisplayName(nil, true)
            local color = player.Color.Name
            local level = Mod.PublicGameData.PlayersStatus[Game.Us.ID][id]
            local relation 
            if(level > action)then
                relation = relationUp[action]
            else
                relation = relationDown[action]
            end
            listActions[id] = CreateButton(vert).SetText(relation .. name .. " (" .. color .. ")").SetOnClick(function()
                yourActionWithFnt(id, name, color, relation)
            end);
        end
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
    back = CreateButton(vert).SetText("GO BACK").SetOnClick(function()
        yourActionsFnt()                 -- Brings you back
    end); 
end

function offersReceivedFnt()
    DestroyWindow();
    SetWindow("offersReceived")
    labelOffersReceived = CreateLabel(vert).SetText("Offers Received")
    CreateEmpty(vert)
    CreateEmpty(vert)
    listOffers = {}
    for id, o in pairs(Mod.PlayerGameData) do
        if(o == -1)then
            local player = Game.Game.Players[id]
            local name = player.DisplayName(nil, true)
            local color = player.Color.Name
            local level = Mod.PublicGameData.PlayersStatus[Game.Us.ID][id]
            local relation = relationLevel[level-1]
            listOffers[id] = CreateButton(vert).SetText(relation .. name .. " (" .. color .. ")").SetOnClick(function()
                acceptOfferFnt(id, name, color, relation)
            end);
        end
    end
    returnFnt()  
end

function acceptOfferFnt(id, name, color, relation)
    DestroyWindow();
    SetWindow("acceptOffer")
    labelAcceptOffer = CreateLabel(vert).SetText("Are you sure you want to accept the " ..relation .. name .. " (" .. color .. ")?")
    CreateEmpty(vert)
    CreateEmpty(vert)
    yes = CreateButton(vert).SetText("Yes").SetOnClick(function()
        changeLevel(id, n)
    end) 
    CreateEmpty(vert)
    CreateEmpty(vert)
    CreateEmpty(vert)
    CreateEmpty(vert)
    back = CreateButton(vert).SetText("GO BACK").SetOnClick(function()
        offersReceived()                 -- Brings you back
    end); 
end

function yourCooperationsFnt()
    DestroyWindow();
    SetWindow("yourCooperations")
    labelYourCooperations = CreateLabel(vert).SetText("Cooperations you are part of:")
    CreateEmpty(vert)
    CreateEmpty(vert)
    listCooperations={}
    for key, coop in pairs(Mod.PublicGameData.Cooperations) do
        for i = 1, #coop.Players do
            if (Game.Us.ID == coop.Players[i]) then
                local name = coop.Name
                local type = coop.Type
                listCooperations[key] = CreateButton(vert).SetText(name.." ("..type..")").SetOnClick(function()
                    lookIntoCooperation(key)
                end);
            end
        end 
    end
    returnFnt()  
end;

function globalCooperationsFnt()
    DestroyWindow();
    SetWindow("globalCooperations")
    labelGlobalCooperations = CreateLabel(vert).SetText("All cooperations existent:")
    CreateEmpty(vert)
    CreateEmpty(vert)
    listCooperations={}
    for key, coop in pairs(Mod.PublicGameData.Cooperations) do
        for i = 1, #coop.Players do
            if (Game.Us.ID == coop.Players[i]) then
                local name = coop.Name
                local type = coop.Type
                listCooperations[key] = CreateButton(vert).SetText(name.." ("..type..")").SetOnClick(function()
                    lookIntoCooperation(key)
                end);
            end
        end 
    end
    returnFnt()
end;

function lookIntoCooperation(key)

end

-- Cooperations