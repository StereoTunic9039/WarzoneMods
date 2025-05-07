require("UI")
	

function Client_PresentConfigureUI(rootParent)

	Init(rootParent)
    vert = GetRoot();

	if Mod.Settings.RewindTurn == nil then
		Mod.Settings.RewindTurn = {}
	end

	numPieces = Mod.Settings.RewindTurn.NumPieces 
	cardWeight = Mod.Settings.RewindTurn.CardWeight
	minPieces = Mod.Settings.RewindTurn.MinPieces
	startPieces = Mod.Settings.RewindTurn.StartPieces

	if numPieces == nil then
		numPieces = 12
	end
	if cardWeight == nil then
		cardWeight = 1
	end
	if minPieces == nil then
		minPieces = 1
	end
	if startPieces == nil then
		startPieces = 0
	end


	mainWin = "mainWindow"
	SetWindow(mainWin);

	local mainCont = CreateVerticalLayoutGroup(rootParent)
	explLabel = CreateLabel(mainCont).SetText("When playing the card the turn goes on as normal, until the end. When the turn has ended, the card will reset everything to how it was at the start of the turn. The turn would so be repeated, but everyone who did not play the Rewind Turn card will have, already by the mod, all orders set as they made them the previous turn, while those who played the card will be able to choose their moves now knowing what the other players will do. The only exception is if you get eliminated, in that case you would not get back to life and all the territories you owned would become neutral. ")

	npCont = CreateHorizontalLayoutGroup(mainCont)															   
	npLabel = CreateLabel(npCont).SetText("Number of pieces to divide the card into: ")				  				-- Label
	npSlider = CreateNumberInputField(npCont).SetSliderMinValue(1).SetSliderMaxValue(25).SetValue(numPieces) 

	cwCont = CreateHorizontalLayoutGroup(mainCont)															   
	cwLabel = CreateLabel(cwCont).SetText("Card weight (how common the card is): ")				  				-- Label
	cwSlider = CreateNumberInputField(cwCont).SetSliderMinValue(0).SetSliderMaxValue(2).SetValue(cardWeight) 

	mpCont = CreateHorizontalLayoutGroup(mainCont)															   
	mpLabel = CreateLabel(mpCont).SetText("Minimum pieces awarded per turn: ")				  				-- Label
	mpSlider = CreateNumberInputField(mpCont).SetSliderMinValue(0).SetSliderMaxValue(10).SetValue(minPieces) 

	spCont = CreateHorizontalLayoutGroup(mainCont)															   
	spLabel = CreateLabel(spCont).SetText("Pieces given to each player at the start: ")				  				-- Label
	spSlider = CreateNumberInputField(spCont).SetSliderMinValue(0).SetSliderMaxValue(10).SetValue(startPieces) 


	

end