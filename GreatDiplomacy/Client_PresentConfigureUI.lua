require("UI")
	

function Client_PresentConfigureUI(rootParent)

	Init(rootParent)
    vert = GetRoot();


	ValueAi = Mod.Settings.lvlAi    --Basic relation with AIs
	ValuePc = Mod.Settings.lvlPc    --Basic relation with Players
	ValueWar = Mod.Settings.lvlWar    --
	ValueBomb = Mod.Settings.lvlBomb    --Basic relation with AIs
	ValueSanction = Mod.Settings.lvlSanction    --Basic relation with Players
	ValueSpy = Mod.Settings.lvlSpy    --
	ValueGift = Mod.Settings.lvlGift    --Basic relation with AIs
	ValueSee = Mod.Settings.lvlSee    --Basic relation with Players
	ValueTransfer = Mod.Settings.lvlTransfer    --
	Valuempdps = Mod.Settings.mpdps
	ValueLO = Mod.Settings.LO
	ValueLD = Mod.Settings.LD
	ValueUA = Mod.Settings.UA
	ValueLA = Mod.Settings.LA
	if ValueAi == nil then
		ValueAi = 4 						--Normally it's 4 
	end
	if ValuePc == nil then
		ValuePc = 4						 	--Normally it's 4 
	end
	if ValueWar == nil then
		ValueWar = 7						--Normally it's 7 
	end
	if ValueBomb == nil then
		ValueBomb = 6 						--Normally it's 6 
	end
	if ValueSanction == nil then
		ValueSanction = 5				 	--Normally it's 5 
	end
	if ValueSpy == nil then
		ValueSpy = 4						--Normally it's 4
	end
	if ValueGift == nil then
		ValueGift = 3					 	--Normally it's 3
	end
	if ValueSee == nil then
		ValueSee = 2					    --Normally it's 2
	end
	if ValueTransfer == nil then
		ValueTransfer = 1				 	--Normally it's 1 
	end
	if Valuempdps == nil then
		Valuempdps = 5 						--Normally it's 5 
	end
	if ValueLO == nil then
		ValueLO = 1				 			--Normally it's 1 
	end
	if ValueLD == nil then
		ValueLD = -1						--Normally it's 1
	end
	if ValueUA == nil then
		ValueUA = false
	end
	if ValueLA == nil then
		ValueLA = false
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
			numberInputFieldAi = CreateNumberInputField(sliderLvlRelationsAi).SetSliderMinValue(1).SetSliderMaxValue(7).SetValue(ValueAi)  -- Both united in the selection for Ai relations

			local sliderLvlRelationsPc = CreateHorizontalLayoutGroup(bscbCont)			  -- Slider
			labelLvlRelationsPc = CreateLabel(sliderLvlRelationsPc).SetText("Relation level with Players at the start")			  -- Label
			numberInputFieldPc = CreateNumberInputField(sliderLvlRelationsPc).SetSliderMinValue(1).SetSliderMaxValue(7).SetValue(ValuePc)  -- Both united in the selection for Players relations
		
			lacbCont = CreateVerticalLayoutGroup(bscbCont)
			CreateCheckBox(lacbCont).SetIsChecked(ValueLA).SetText("Limit actions per turn").SetOnValueChanged(function(IsChecked) showedreturnmessage = false; limitActions(IsChecked) end)
			CreateEmpty(lacbCont)
			if(ValueLA==true)then
				limitActions(true)
			end
		else
			ValueAi = numberInputFieldAi.GetValue()
			ValuePc = numberInputFieldPc.GetValue()
			if(numberInputFieldLO ~= nil)then
				ValueLO = numberInputFieldLO.GetValue()
				ValueLD = numberInputFieldLD.GetValue()
			end 
			SetWindow(bsWin)
			DestroyWindow(bsWin, true)
			SetWindow(mainWin)
		end
	end

	function limitActions(check)
		ValueLA = check
		if(check)then
			laWin = "LimActWindow"
			AddSubWindow(bsWin, laWin);
			SetWindow(laWin)

			labelTip = CreateLabel(lacbCont).SetText("-1 means infinite, if you check the cumulative option the offers' slider will be the one used.")				  -- Label

			local sliderLimitOffers = CreateHorizontalLayoutGroup(lacbCont)            -- Slider
			labelLimitOffers = CreateLabel(sliderLimitOffers).SetText("Maximum number of upgrades per turn")				  -- Label
			numberInputFieldLO = CreateNumberInputField(sliderLimitOffers).SetSliderMinValue(-1).SetSliderMaxValue(10).SetValue(ValueLO)  -- Both united in the selection for Ai relations

			local sliderLimitDeclarations = CreateHorizontalLayoutGroup(lacbCont)			  -- Slider
			labelLimitDeclarations = CreateLabel(sliderLimitDeclarations).SetText("Maximum number of downgrades per turn")			  -- Label
			numberInputFieldLD = CreateNumberInputField(sliderLimitDeclarations).SetSliderMinValue(-1).SetSliderMaxValue(10).SetValue(ValueLD)  -- Both united in the selection for Players relations
		
			local uacbCont = CreateVerticalLayoutGroup(lacbCont)
			CreateCheckBox(uacbCont).SetIsChecked(ValueUA).SetText("Upgrades and downgrades are cumulative").SetOnValueChanged(function(IsChecked) showedreturnmessage = false; uniteActions(isChecked) end)
		else
			ValueLO = numberInputFieldLO.GetValue()
			ValueLD = numberInputFieldLD.GetValue()
			SetWindow(laWin)
			DestroyWindow(laWin, true)
			SetWindow(bsWin)
		end
	end


	function relLvlAttFnt(check)
		if(check)then
			rlaWin = "RelLevAttWindow"
			AddSubWindow(mainWin, rlaWin);
			SetWindow(rlaWin)

			local sliderLvlWar = CreateHorizontalLayoutGroup(rlacbCont)			  
			labelLvlWar = CreateLabel(sliderLvlWar).SetText("First status able to attack")			  -- Label
			numberInputFieldWar = CreateNumberInputField(sliderLvlWar).SetSliderMinValue(4).SetSliderMaxValue(7).SetValue(ValueWar)   

			local sliderLvlBomb = CreateHorizontalLayoutGroup(rlacbCont)           
			labelLvlBomb = CreateLabel(sliderLvlBomb).SetText("Relation level with bombs")				  -- Label
			numberInputFieldBomb = CreateNumberInputField(sliderLvlBomb).SetSliderMinValue(5).SetSliderMaxValue(7).SetValue(ValueBomb)  -- Both united in the selection for Ai relations

			local sliderLvlSanction = CreateHorizontalLayoutGroup(rlacbCont)			 
			labelLvlSanction = CreateLabel(sliderLvlSanction).SetText("Relation level with sanctions")			  -- Label
			numberInputFieldSanction = CreateNumberInputField(sliderLvlSanction).SetSliderMinValue(1).SetSliderMaxValue(7).SetValue(ValueSanction)  -- Both united in the selection for Players relations
			
			local sliderLvlSpy = CreateHorizontalLayoutGroup(rlacbCont)			  
			labelLvlSpy = CreateLabel(sliderLvlSpy).SetText("First status able to spy")			  -- Label
			numberInputFieldSpy = CreateNumberInputField(sliderLvlSpy).SetSliderMinValue(3).SetSliderMaxValue(7).SetValue(ValueSpy)  

			local sliderLvlGift = CreateHorizontalLayoutGroup(rlacbCont)            
			labelLvlGift = CreateLabel(sliderLvlGift).SetText("Relation level with gifts")				  -- Label
			numberInputFieldGift = CreateNumberInputField(sliderLvlGift).SetSliderMinValue(1).SetSliderMaxValue(7).SetValue(ValueGift)  -- Both united in the selection for Ai relations

			local sliderLvlSee = CreateHorizontalLayoutGroup(rlacbCont)			  
			labelLvlSee = CreateLabel(sliderLvlSee).SetText("Relation level with See")			  -- Label
			numberInputFieldSee = CreateNumberInputField(sliderLvlSee).SetSliderMinValue(1).SetSliderMaxValue(7).SetValue(ValueSee)  -- Both united in the selection for Players relations
			
			local sliderLvlTransfer = CreateHorizontalLayoutGroup(rlacbCont)			  
			labelLvlTransfer = CreateLabel(sliderLvlTransfer).SetText("First status able to tranfer")			  -- Label
			numberInputFieldTransfer = CreateNumberInputField(sliderLvlTransfer).SetSliderMinValue(1).SetSliderMaxValue(2).SetValue(ValueTransfer) 
		else
			ValueWar = numberInputFieldWar.GetValue()
			ValueBomb = numberInputFieldBomb.GetValue()
			ValueSanction = numberInputFieldSanction.GetValue()
			ValueSpy = numberInputFieldSpy.GetValue()
			ValueGift = numberInputFieldGift.GetValue()
			ValueSee = numberInputFieldSee.GetValue()
			ValueTransfer = numberInputFieldTransfer.GetValue()
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
			if(mpdps ~= nil)then
				Valuempdps = mpdps.GetValue()
			end
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
			mpdps = CreateNumberInputField(mpdpc).SetSliderMinValue(2).SetSliderMaxValue(10).SetValue(Valuempdps)  				-- Slider
		else 
			Valuempdps = mpdps.GetValue()
			SetWindow(defWin)
			DestroyWindow(defWin)
			SetWindow(coopWin)
		end
	end
end

function uniteActions(check)
	ValueUA = check
end