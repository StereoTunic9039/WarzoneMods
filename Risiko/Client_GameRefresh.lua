require("Annotations");
require('Utilities');
require('consolelog');

--Remember if we've alerted the instructions so we don't do it twice
ShownInstructions = false;
ShownTurn = 0;

function Client_GameRefresh(game)
    CheckShowInstructions(game);
end

function CheckShowInstructions(game)

    if (game.Us == nil) then return; end --Skip if we're not in the game.

    local order = Mod.PublicGameData.PlayerOrder;
    local ourIndex = OurIndex(game.Us.ID);

    if (game.Game.NumberOfTurns == 0) then
        if (ShownInstructions) then return; end --Skip if we've already shown it

        ShownInstructions = true;

        textt = "This game uses the Risiko mod. The first turn (this one) is for army deployment.  \nEach player will play once every " .. #order .. " turns.  When it's not your turn, you should just commit without entering any orders as they would be ignored anyway.  \nA sanctions card will be used to remove your income so you don't have to deploy if it's not your turn.  \nYour randomly-determined position is " .. (ourIndex+1) .. ", you can check the full turn order in the Menu tab (click on the green 'Game' button)."

        UI.Alert(textt);
    else
        if (ShownTurn >= game.Game.NumberOfTurns) then return; end --Skip if we've already shown it
        ShownTurn = game.Game.NumberOfTurns;

        local currTurn = order[game.Game.NumberOfTurns % #order + 1];

        if (currTurn == game.Us.ID) then
            UI.Alert("It's your turn! \nMake it count!");
        end
    end
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