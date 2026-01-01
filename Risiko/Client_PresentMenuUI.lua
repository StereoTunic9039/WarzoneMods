require('Utilities');
require('consolelog');
require('Annotations');

function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game, close)
	Game = game;
	Close = close;

	setMaxSize(350, 330);

	local vert = UI.CreateVerticalLayoutGroup(rootParent);

    --[[
	if (game.Settings.CommerceGame == false) then
		UI.CreateLabel(vert).SetText("This mod only works in commerce games.  This isn't a commerce game.");
		return;
	end
	if (game.Us == nil or game.Us.State ~= WL.GamePlayerState.Playing) then
		UI.CreateLabel(vert).SetText("You cannot gift gold since you're not in the game");
	end
	if (game.LatestStanding == nil) then
		UI.CreateLabel(vert).SetText("Cannot use until game has begun");
		return;
	end
    ]]--


    local turnOrder = Mod.PublicGameData.PlayerOrder;
    if turnOrder == nil then
        UI.CreateLabel(vert).SetText("Turn order not yet determined.");
    else
        local row1 = UI.CreateHorizontalLayoutGroup(vert);
        UI.CreateLabel(row1).SetText("The turn order is as follows:");

        for index, pid in pairs(turnOrder) do
            local Players = game.Game.Players;
            local player = Players[pid].DisplayName(nil, nil);
            local playerName = "Unknown Player";
            if player ~= nil then
                playerName = player
            end
            local txt = tostring(index) .. ": " .. tostring(playerName);
            if( pid == game.Us.ID) then
                UI.CreateLabel(vert).SetText(txt).SetColor('#00b000');
            else
                UI.CreateLabel(vert).SetText(txt);
            end
        end
        UI.CreateLabel(vert).SetText(" ");
        UI.CreateLabel(vert).SetText(" ");
        UI.CreateLabel(vert).SetText(" ");
    end

    if (game.Us == nil or game.Us.State ~= WL.GamePlayerState.Playing) then
		UI.CreateLabel(vert).SetText("You do not have any objective as you're not in the game currently.");
    else
        local row2 = UI.CreateHorizontalLayoutGroup(vert);
        UI.CreateLabel(row2).SetText("Your objective is: ")
        local id = game.Us.ID
        local playerObj = Mod.PublicGameData.PlayerObjectives
        if playerObj ~= nil and playerObj[id] ~= nil then
            UI.CreateLabel(vert).SetText(playerObj[id]);
            return;
        else
            UI.CreateLabel(vert).SetText("yet to be built")
        end
	end
end