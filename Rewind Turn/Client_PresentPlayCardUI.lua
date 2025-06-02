require('Utilities')

--Called when the player attempts to play your card.  You can call playCard directly if no UI is needed, or you can call game.CreateDialog to present the player with options.
function Client_PresentPlayCardUI(game, cardInstance, playCard, closeCardsDialog)
    Game = game;

    --If this dialog is already open, close the previous one. This prevents two copies of it from being open at once which can cause errors due to only saving one instance of TargetTerritoryBtn
    if (Close ~= nil) then
        Close();
    end
    
    if (WL.IsVersionOrHigher("5.34")) then --closeCardsDialog callback did not exist prior to 5.34
        closeCardsDialog();
    end

    --If your mod has multiple cards, you can look at game.Settings.Cards[cardInstance.CardID].Name to see which one was played
    game.CreateDialog(function(rootParent, setMaxSize, setScrollable, game, close)
        Close = close;
        setMaxSize(400, 200);
        local vert = UI.CreateVerticalLayoutGroup(rootParent).SetFlexibleWidth(1); --set flexible width so things don't jump around while we change InstructionLabel

        TargetTerritoryBtn = UI.CreateButton(vert).SetText("Select Territory").SetOnClick(TargetTerritoryClicked);
        TargetTerritoryInstructionLabel = UI.CreateLabel(vert).SetText("");

        UI.CreateButton(vert).SetText("Play Card").SetOnClick(function() 

            local annotations = nil
            annotations = { [TargetTerritoryID] = WL.TerritoryAnnotation.Create("Smoke Bomb") };
            if (playCard("This " .. TargetTerritoryName, "SmokeBomb_" .. TargetTerritoryID, WL.TurnPhase.Deploys, annotations)) then
                close();
            end
        end);
    end);
end

