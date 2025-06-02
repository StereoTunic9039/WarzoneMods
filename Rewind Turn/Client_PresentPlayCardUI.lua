require('Utilities')

--Called when the player attempts to play your card.  You can call playCard directly if no UI is needed, or you can call game.CreateDialog to present the player with options.
function Client_PresentPlayCardUI(game, cardInstance, playCard, closeCardsDialog)
    Game = game;

    playCard("Detonate a smoke bomb on nowhere" , "SmokeBomb", WL.TurnPhase.Deploys)
end
