require("Annotations");
require('Utilities');
require('consolelog');

function Server_Created(game, settings)
	--Turn on sanctions card.  Ensure its weight is 0 so players never get it.  This means that the sanctions card can't be used normally by the game creator.  https://www.warzone.com/wiki/Mod_API_Reference:CardGameSanctions
	local cards = BuildMetatable(settings.Cards);
	cards[WL.CardID.Sanctions] = WL.CardGameSanctions.Create(2, 0, 0, 1, 1, 1);
	settings.Cards = cards;

    local commerceGame = settings.CommerceArmyCostMultiplier    --Disable commerce
    commerceGame = nil                                          -- if this doesnt work, try switching settings.CommerceArmyCostMultiplier to
    settings.CommerceArmyCostMultiplier = commerceGame          -- settings.commerceGame, and putting commerceGame = false

    --local strRef = "Play this card to gain an extra " .. X .. " armies\nPlay reinforcement cards before you start deploying";
    --Mod.Settings.ResurrectionCardID = addCard ("Reinforcement card", strRef, "resurrection_130x180.png", 3, 1, 0, 1);

    local publicGameData = Mod.PublicGameData;
    publicGameData.ArmyCard = {};
    Mod.PublicGameData = publicGameData;
end

