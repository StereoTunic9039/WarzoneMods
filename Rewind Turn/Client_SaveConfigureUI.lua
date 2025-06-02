require("Client_PresentConfigureUI")

function Client_SaveConfigureUI(alert, addCard)

	Mod.Settings.RewindTurn.NumPieces  = npSlider.GetValue()
	if (Mod.Settings.RewindTurn.NumPieces < 1) then
		Mod.Settings.RewindTurn.NumPieces = 1
	end

	if (Mod.Settings.RewindTurn.NumPieces > 1000) then
		Mod.Settings.RewindTurn.NumPieces = 1000
	end

	Mod.Settings.RewindTurn.CardWeight  = npSlider.GetValue()
	if (Mod.Settings.RewindTurn.CardWeight < 0) then
		Mod.Settings.RewindTurn.CardWeight = 0
	end

	if (Mod.Settings.RewindTurn.CardWeight > 1000) then
		Mod.Settings.RewindTurn.CardWeight = 1000
	end

	Mod.Settings.RewindTurn.MinPieces  = npSlider.GetValue()
	if (Mod.Settings.RewindTurn.MinPieces < 0) then
		Mod.Settings.RewindTurn.MinPieces = 0
	end

	if (Mod.Settings.RewindTurn.MinPieces > 100) then
		Mod.Settings.RewindTurn.MinPieces = 100
	end

	Mod.Settings.RewindTurn.StartPieces  = npSlider.GetValue()
	if (Mod.Settings.RewindTurn.StartPieces < 0) then
		Mod.Settings.RewindTurn.StartPieces = 0
	end

	if (Mod.Settings.RewindTurn.StartPieces > 100) then
		Mod.Settings.RewindTurn.StartPieces = 100
	end

	Mod.Settings.RewindTurn.RewindTurnCard = addCard("Rewind Turn Card", "Playing this card to, once this turn has ended, rewind the game to the starting conditions of the turn, while only allowing those who played the card to change their orders", "RewindTurnCard.png", Mod.Settings.RewindTurn.NumPieces, Mod.Settings.RewindTurn.MinPieces, Mod.Settings.RewindTurn.StartPieces, Mod.Settings.RewindTurn.CardWeight);

end  				-- Sets straight every unwanted input and such 
