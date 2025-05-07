require("Client_PresentConfigureUI")

function Client_SaveConfigureUI(alert)

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

end  				-- Sets straight every unwanted input and such 
