require("Annotations");
require('Utilities');
require('consolelog');


24T = {
    Message = "You need to conquer 24 territories to win the game.",
    CheckVictory = CheckVictory_Risk24T
}

function CheckVictory_Risk24T()
    if game.Us == nil or game.Us.State ~= WL.GamePlayerState.Playing == nil then
        return false;
    end
    local pid = game.Us.ID;

    local territoryCount = 0;
    
    for _, territory in pairs(Territories) do
        if territory.OwnerPlayerID == pid then
            territoryCount = territoryCount + 1;
        end
    end

    return territoryCount >= 24;
end