require("UI")
	

function Client_PresentConfigureUI(rootParent)

	Init(rootParent)
    vert = GetRoot();


	local initialValueAi = Mod.Settings.lvlAi    --Basic relation with AIs
	local initialValuePc = Mod.Settings.lvlPc    --Basic relation with Players
	local initialValueWar = Mod.Settings.lvlWar    --
	local initialValueBomb = Mod.Settings.lvlBomb    --Basic relation with AIs
	local initialValueSanction = Mod.Settings.lvlSanction    --Basic relation with Players
	local initialValueSpy = Mod.Settings.lvlSpy    --
	local initialValueGift = Mod.Settings.lvlGift    --Basic relation with AIs
	local initialValueSee = Mod.Settings.lvlSee    --Basic relation with Players
	local initialValueTransfer = Mod.Settings.lvlTransfer    --
	local initialValuempdps = Mod.Settings.mpdps
	if initialValueAi == nil then
		initialValueAi = 5 						 --Normally it's 5 (Mod Description)
	end
	if initialValuePc == nil then
		initialValuePc = 4						 --Normally it's 4 (Mod Description)
	end
	if initialValueWar == nil then
		initialValueWar = 7						 --Normally it's 7 (Mod Description)
	end
	if initialValueBomb == nil then
		initialValueBomb = 6 					 --Normally it's 6 (Mod Description)
	end
	if initialValueSanction == nil then
		initialValueSanction = 5				 --Normally it's 5 (Mod Description)
	end
	if initialValueSpy == nil then
		initialValueSpy = 4						 --Normally it's 4 (Mod Description)
	end
	if initialValueGift == nil then
		initialValueGift = 3					 --Normally it's 3 (Mod Description)
	end
	if initialValueSee == nil then
		initialValueSee = 2						 --Normally it's 2 (Mod Description)
	end
	if initialValueTransfer == nil then
		initialValueTransfer = 1				 --Normally it's 1 (Mod Description)
	end
	if initialValuempdps == nil then
		initialValuempdps = 5
	end


	mainWin = "mainWindow"
	SetWindow(mainWin);
	
	local mainContainer = CreateVerticalLayoutGroup(rootParent)     --The main container I guess

	local bscbCont = CreateVerticalLayoutGroup(mainContainer)
	CreateCheckBox(bscbCont).SetIsChecked(false).SetText("Check base settings").SetOnValueChanged(function(IsChecked) showedreturnmessage = false; baseSettingsFnt(IsChecked) end)

	local rlacbCont = CreateVerticalLayoutGroup(mainContainer) 						--relation level attributes checkbox
	CreateCheckBox(rlacbCont).SetIsChecked(false).SetText("Check relation level attributes").SetOnValueChanged(function(IsChecked) showedreturnmessage = false; relLvlAttFnt(IsChecked) end)

	local cscbCont = CreateVerticalLayoutGroup(mainContainer)
	CreateCheckBox(cscbCont).SetIsChecked(false).SetText("Activate cooperation settings").SetOnValueChanged(function(IsChecked) showedreturnmessage = false; cooperationSettingsFnt(IsChecked) end)
	CreateEmpty(cscbCont)
	CreateEmpty(cscbCont)
	CreateEmpty(cscbCont)

	function baseSettingsFnt(check)
		if(check)then
			bsWin = "BaseSettingsWindow"
			AddSubWindow(mainWin, bsWin);
			SetWindow(bsWin)
			
			local sliderLvlRelationsAi = CreateHorizontalLayoutGroup(bscbCont)            -- Slider
			labelLvlRelationsAi = CreateLabel(sliderLvlRelationsAi).SetText("Relation level with AIs at the start")				  -- Label
			numberInputFieldAi = CreateNumberInputField(sliderLvlRelationsAi).SetSliderMinValue(1).SetSliderMaxValue(7).SetValue(initialValueAi)  -- Both united in the selection for Ai relations

			local sliderLvlRelationsPc = CreateHorizontalLayoutGroup(bscbCont)			  -- Slider
			labelLvlRelationsPc = CreateLabel(sliderLvlRelationsPc).SetText("Relation level with Players at the start")			  -- Label
			numberInputFieldPc = CreateNumberInputField(sliderLvlRelationsPc).SetSliderMinValue(1).SetSliderMaxValue(7).SetValue(initialValuePc)  -- Both united in the selection for Players relations
		else
			SetWindow(bsWin)
			DestroyWindow(bsWin, true)
			SetWindow(mainWin)
		end
	end

	function relLvlAttFnt(check)
		if(check)then
			rlaWin = "RelLevAttWindow"
			AddSubWindow(mainWin, rlaWin);
			SetWindow(rlaWin)

			local sliderLvlWar = CreateHorizontalLayoutGroup(rlacbCont)			  
			labelLvlWar = CreateLabel(sliderLvlWar).SetText("First status able to attack")			  -- Label
			numberInputFieldWar = CreateNumberInputField(sliderLvlWar).SetSliderMinValue(4).SetSliderMaxValue(7).SetValue(initialValueWar)   

			local sliderLvlBomb = CreateHorizontalLayoutGroup(rlacbCont)           
			labelLvlBomb = CreateLabel(sliderLvlBomb).SetText("Relation level with bombs")				  -- Label
			numberInputFieldBomb = CreateNumberInputField(sliderLvlBomb).SetSliderMinValue(5).SetSliderMaxValue(7).SetValue(initialValueBomb)  -- Both united in the selection for Ai relations

			local sliderLvlSanction = CreateHorizontalLayoutGroup(rlacbCont)			 
			labelLvlSanction = CreateLabel(sliderLvlSanction).SetText("Relation level with sanctions")			  -- Label
			numberInputFieldSanction = CreateNumberInputField(sliderLvlSanction).SetSliderMinValue(1).SetSliderMaxValue(7).SetValue(initialValueSanction)  -- Both united in the selection for Players relations
			
			local sliderLvlSpy = CreateHorizontalLayoutGroup(rlacbCont)			  
			labelLvlSpy = CreateLabel(sliderLvlSpy).SetText("First status able to spy")			  -- Label
			numberInputFieldSpy = CreateNumberInputField(sliderLvlSpy).SetSliderMinValue(3).SetSliderMaxValue(7).SetValue(initialValueSpy)  

			local sliderLvlGift = CreateHorizontalLayoutGroup(rlacbCont)            
			labelLvlGift = CreateLabel(sliderLvlGift).SetText("Relation level with gifts")				  -- Label
			numberInputFieldGift = CreateNumberInputField(sliderLvlGift).SetSliderMinValue(1).SetSliderMaxValue(7).SetValue(initialValueGift)  -- Both united in the selection for Ai relations

			local sliderLvlSee = CreateHorizontalLayoutGroup(rlacbCont)			  
			labelLvlSee = CreateLabel(sliderLvlSee).SetText("Relation level with See")			  -- Label
			numberInputFieldSee = CreateNumberInputField(sliderLvlSee).SetSliderMinValue(1).SetSliderMaxValue(7).SetValue(initialValueSee)  -- Both united in the selection for Players relations
			
			local sliderLvlTransfer = CreateHorizontalLayoutGroup(rlacbCont)			  
			labelLvlTransfer = CreateLabel(sliderLvlTransfer).SetText("First status able to tranfer")			  -- Label
			numberInputFieldTransfer = CreateNumberInputField(sliderLvlTransfer).SetSliderMinValue(1).SetSliderMaxValue(2).SetValue(initialValueTransfer) 
		else
			SetWindow(rlaWin)
			DestroyWindow(rlaWin, true)
			SetWindow(mainWin)
		end
	end

	function cooperationSettingsFnt(check)
		if(check)then
			coopWin = "CooperationWindow"
			AddSubWindow(mainWin, coopWin);
			SetWindow(coopWin)
			allowDefLG = CreateVerticalLayoutGroup(cscbCont)
			allowDef = CreateCheckBox(allowDefLG).SetIsChecked(false).SetText("Allow defensive pacts").SetOnValueChanged(function(IsChecked) showedreturnmessage = false; allowDefFnt(IsChecked) end)
			allowFedLG = CreateVerticalLayoutGroup(cscbCont)
			allowFed = CreateCheckBox(allowFedLG).SetIsChecked(false).SetText("Allow federations").SetOnValueChanged(function(IsChecked) showedreturnmessage = false; end)
			allowEmpLG = CreateVerticalLayoutGroup(cscbCont)
			allowEmp = CreateCheckBox(allowEmpLG).SetIsChecked(false).SetText("Allow empires").SetOnValueChanged(function(IsChecked) showedreturnmessage = false;  end)
		else
			SetWindow(coopWin)
			DestroyWindow(coopWin, true)
			SetWindow(mainWin)
		end
	end

	function allowDefFnt(check)
		if(check)then																	-- Max Players Defensive Pact
			defWin = "DefensivePactWindow"
			AddSubWindow(coopWin, defWin);
			SetWindow(defWin)
			mpdpc = CreateHorizontalLayoutGroup(allowDefLG)															   
			mpdpl = CreateLabel(mpdpc).SetText("Max number of players in a defensive pact")				  				-- Label
			mpdps = CreateNumberInputField(mpdpc).SetSliderMinValue(2).SetSliderMaxValue(10).SetValue(initialValuempdps)  				-- Slider
		else 
			SetWindow(defWin)
			DestroyWindow(defWin)
			SetWindow(coopWin)
		end
	end
end