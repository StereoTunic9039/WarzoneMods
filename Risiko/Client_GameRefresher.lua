require('Utilities');

--Remember if we've alerted the instructions so we don't do it twice
ShownInstructions = false;
ShownTurn = 0;

function Client_GameRefresh(game)
    CheckShowInstructions(game);
    CheckYourTurn(game);
end

function CheckShowInstructions(game)

    if (game.Us == nil) then return; end --Skip if we're not in the game.

    if (game.Game.NumberOfTurns ~= 0) then return; end --Skip if it's not the first turn

    if (ShownInstructions) then return; end --Skip if we've already shown it

    local order = Mod.PublicGameData.PlayerOrder;
    local ourIndex = OurIndex(game.Us.ID);

    ShownInstructions = true;

    UI.Alert("This game uses the Risiko mod. The first turn (this one) is for armies deployment, everything that you do not deploy will be lost (this will always happen, not just the first turn!). \nEach player will get a turn once every " .. #order .. " turns.  When it's not your turn, you should just commit without entering any orders as they would be ignored anyway.  A sanctions card will be used to remove your income so you don't have to deploy if it's not your turn.  Your randomly-determined position is " .. (ourIndex+1) .. ", you can check the full turn order in the Menu tab (click on the green 'Game' button).");
end

function OurIndex(us)
    local ret = 0;
    for _,pid in pairs(Mod.PublicGameData.PlayerOrder) do
        if (pid == us) then
            return ret;
        end
        ret = ret + 1;
    end
    error("Not in game");
end

function CheckYourTurn(game)
    if (game.Us == nil) then return; end --Skip if we're not in the game.

    if (game.Game.NumberOfTurns == 0) then return; end --Skip if it is the first turn

    if (ShownTurn < game.Game.NumberOfTurns) then return; end --Skip if we've already shown it

    local order = Mod.PublicGameData.PlayerOrder;
    local ourIndex = OurIndex(game.Us.ID);
    local currTurn = order[game.Game.NumberOfTurns % #order + 1];

    ShownTurn = game.Game.NumberOfTurns;

    if (currTurn == game.Us.ID) then
        UI.Alert("It's your turn! \nMake it count!");
    end
end