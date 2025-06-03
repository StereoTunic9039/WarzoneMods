require('Utilities')

--Called when the player attempts to play your card.  It creates the order with the name of the one who used the card
function Client_PresentPlayCardUI(game, cardInstance, playCard, closeCardsDialog)
    Game = game;

    local pl = Game.Us.ID
    local player = Game.Game.Players[pl]
    local name = player.DisplayName(nil, true)
    playCard(name .. " played a rewind card." , "RewindCard_" .. pl, WL.TurnPhase.CardsWearOff)
end


