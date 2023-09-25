require("UI")
	

function Client_PresentConfigureUI(rootParent)

	Init(rootParent)
    vert = GetRoot();

	if Mod.Settings.WeakenBlockades == nil then
		Mod.Settings.WeakenBlockades = {}
	end

	percentualOrFixed = Mod.Settings.WeakenBlockades.percentualOrFixed 
	fixedArmiesRemoved = Mod.Settings.WeakenBlockades.fixedArmiesRemoved
	percentualArmiesRemoved = Mod.Settings.WeakenBlockades.percentualArmiesRemoved
	delayFromStart = Mod.Settings.WeakenBlockades.delayFromStart
	appliesToAllNeutrals = Mod.Settings.WeakenBlockades.appliesToAllNeutrals
	appliesToMinArmies = Mod.Settings.WeakenBlockades.appliesToMinArmies
	ADVANCEDVERSION = Mod.Settings.WeakenBlockades.ADVANCEDVERSION

	if percentualOrFixed == nil then
		percentualOrFixed = false
	end
	if fixedArmiesRemoved == nil then
		fixedArmiesRemoved = 50
	end
	if percentualArmiesRemoved == nil then
		percentualArmiesRemoved = 25
	end
	if delayFromStart == nil then
		delayFromStart = 0
	end
	if appliesToAllNeutrals == nil then
		appliesToAllNeutrals = false
	end
	if appliesToMinArmies == nil then
		appliesToMinArmies = 25
	end
	if ADVANCEDVERSION == nil then
		ADVANCEDVERSION = false
	end


	mainWin = "mainWindow"
	SetWindow(mainWin);
	

	local mainContainer = CreateVerticalLayoutGroup(rootParent)     --The main container I guess

	local pofCont = CreateVerticalLayoutGroup(mainContainer)		-- What's the type of army removal (percentual or fixed)
	CreateCheckBox(pofCont).SetIsChecked(percentualOrFixed).SetText("The removal of armies will be of a fixed amount instead of a percentual one").SetOnValueChanged(function(IsChecked) showedreturnmessage = false; typeOfRemovalFnt(IsChecked) end)
	if (percentualOrFixed) then
		farWin = "fixedAmountRemovalWindow"
		AddSubWindow(mainWin, farWin);
		SetWindow(farWin)
		farCont = CreateHorizontalLayoutGroup(pofCont)															   
		farLabel = CreateLabel(farCont).SetText("Fixed amount of armies removed:")				  				-- Label
		farSlider = CreateNumberInputField(farCont).SetSliderMinValue(1).SetSliderMaxValue(100).SetValue(fixedArmiesRemoved) 
	else
		parWin = "percentualAmountRemovalWindow"
		AddSubWindow(mainWin, parWin);
		SetWindow(parWin)
		parCont = CreateHorizontalLayoutGroup(pofCont)															   
		parLabel = CreateLabel(parCont).SetText("Percentual amount of armies removed: ")				  				-- Label
		parSlider = CreateNumberInputField(parCont).SetSliderMinValue(1).SetSliderMaxValue(100).SetValue(percentualArmiesRemoved) 
	end

	
	function typeOfRemovalFnt(check)
		percentualOrFixed = check
		if(check)then									
			percentualArmiesRemoved = parSlider.GetValue()
			SetWindow(parWin)
			DestroyWindow(parWin)
			SetWindow(mainWin)
			farWin = "fixedAmountRemovalWindow"
			AddSubWindow(mainWin, farWin);
			SetWindow(farWin)
			farCont = CreateHorizontalLayoutGroup(pofCont)															   
			farLabel = CreateLabel(farCont).SetText("Fixed amount of armies removed:")				  				-- Label
			farSlider = CreateNumberInputField(farCont).SetSliderMinValue(1).SetSliderMaxValue(100).SetValue(fixedArmiesRemoved)  				-- Slider
		else 
			fixedArmiesRemoved = farSlider.GetValue()
			SetWindow(farWin)
			DestroyWindow(farWin)
			SetWindow(mainWin)
			parWin = "percentualAmountRemovalWindow"
			AddSubWindow(mainWin, parWin);
			SetWindow(parWin)
			parCont = CreateHorizontalLayoutGroup(pofCont)															   
			parLabel = CreateLabel(parCont).SetText("Percentual amount of armies removed:")				  				-- Label
			parSlider = CreateNumberInputField(parCont).SetSliderMinValue(1).SetSliderMaxValue(100).SetValue(percentualArmiesRemoved)  				-- Slider
		end
	end


	SetWindow(mainWin)

	local dlsCont = CreateHorizontalLayoutGroup(mainContainer)
	dlsLabel = CreateLabel(dlsCont).SetText("Turns that must pass before the mod has effect: ")
	dlsSlider = CreateNumberInputField(dlsCont).SetSliderMinValue(0).SetSliderMaxValue(10).SetValue(delayFromStart) 

	local atanCont = CreateVerticalLayoutGroup(mainContainer) 					

	function appliesToFnt(check)
		appliesToAllNeutrals = check
		if(check)then
			appliesToMinArmies = atmaSlider.GetValue()
			SetWindow(atmaWin)
			DestroyWindow(atmaWin)
			SetWindow(mainWin)
		else
			atmaWin = "appliesToMinArmiesWindow"
			AddSubWindow(mainWin, atmaWin);
			SetWindow(atmaWin)
			atmaCont = CreateHorizontalLayoutGroup(atanCont)															   
			atmaLabel = CreateLabel(atmaCont).SetText("Only applies to neutral territories whose armies are at least: ")				  				-- Label
			atmaSlider = CreateNumberInputField(atmaCont).SetSliderMinValue(10).SetSliderMaxValue(100).SetValue(appliesToMinArmies)
		end
	end

	CreateCheckBox(atanCont).SetIsChecked(appliesToAllNeutrals).SetText("Applies to all neutrals").SetOnValueChanged(function(IsChecked) showedreturnmessage = false; appliesToFnt(IsChecked) end)
	if appliesToAllNeutrals == false then
		appliesToFnt(appliesToAllNeutrals)
	end

	SetWindow(mainWin)
	local ADVVERCont = CreateVerticalLayoutGroup(mainContainer)
	CreateCheckBox(ADVVERCont).SetIsChecked(ADVANCEDVERSION).SetText("Use advanced version").SetOnValueChanged(function(IsChecked) showedreturnmessage = false; setADVVER(IsChecked) end)
	function setADVVER(check)
		ADVANCEDVERSION = check
	end

end