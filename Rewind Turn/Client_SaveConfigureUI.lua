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

	Mod.Settings.RewindTurn.RewindTurnCard = addCard("Rewind Turn Card", "you know", "RewindTurnCard.png", Mod.Settings.NumPieces, Mod.Settings.MinPieces, Mod.Settings.StartPieces, Mod.Settings.CardWeight);

end  				-- Sets straight every unwanted input and such 
