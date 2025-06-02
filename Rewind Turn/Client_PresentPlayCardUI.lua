require('Utilities')

--Called when the player attempts to play your card.  You can call playCard directly if no UI is needed, or you can call game.CreateDialog to present the player with options.
function Client_PresentPlayCardUI(game, cardInstance, playCard, closeCardsDialog)
    Game = game;

    local pl = Game.Us.ID
    local player = Game.Game.Players[pl]
    local name = player.DisplayName(nil, true)
    playCard(name .. "played a rewind card." , "RewindCard", WL.TurnPhase.CardsWearOff)
end
