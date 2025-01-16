require("UI")
	

function Client_PresentConfigureUI(rootParent)

	Init(rootParent)
    vert = GetRoot();

	ValueAi = Mod.Settings.lvlAi    --Basic relation with AIs
	if ValueAi == nil then
		ValueAi = 4 						--Normally it's 4 
	end
	

	mainWin = "mainWindow"
	SetWindow(mainWin);
	
	local mainContainer = CreateVerticalLayoutGroup(rootParent)     --The main container I guess
	local phaseCont = CreateVerticalLayoutGroup(mainContainer)

	f1Win = "Fase1Window"
	AddSubWindow(mainWin, f1Win);
	SetWindow(f1Win)

	local sliderLvlRelationsPc = CreateHorizontalLayoutGroup(phaseCont)			  -- Slider
	labelLvlRelationsPc = CreateLabel(sliderLvlRelationsPc).SetText("You're on phase 1, check below to activate phase 2")			  -- Label
		CreateEmpty(phaseCont)
		CreateEmpty(phaseCont)
		CreateEmpty(phaseCont)
		CreateEmpty(phaseCont)
		CreateEmpty(phaseCont)

	CreateCheckBox(phaseCont).SetIsChecked(false).SetText("Phase 2").SetOnValueChanged(function(IsChecked) showedreturnmessage = false; phase2Fnt(IsChecked) end)

	CreateEmpty(phaseCont)
	CreateEmpty(phaseCont)
	CreateEmpty(phaseCont)

	SetWindow(mainWin);

	function phase1Fnt()
		f1Win = "Fase1Window"
		AddSubWindow(mainWin, f1Win);
		SetWindow(f1Win)

		local sliderLvlRelationsPc = CreateHorizontalLayoutGroup(phaseCont)			  -- Slider
		labelLvlRelationsPc = CreateLabel(sliderLvlRelationsPc).SetText("You're on phase 1, check below to activate phase 2")			  -- Label
		CreateEmpty(phaseCont)

		CreateCheckBox(phaseCont).SetIsChecked(false).SetText("Phase 2").SetOnValueChanged(function(IsChecked) showedreturnmessage = false; phase2Fnt(IsChecked) end)

		CreateEmpty(phaseCont)
		CreateEmpty(phaseCont)
		CreateEmpty(phaseCont)
	end

	function phase2Fnt(check)
		if(check)then
			SetWindow(f1Win)
			DestroyWindow(f1Win, true)
			SetWindow(mainWin)
			f2Win = "Function2Window"
			AddSubWindow(mainWin, f2Win);
			SetWindow(f2Win)
			
			CreateCheckBox(phaseCont).SetIsChecked(true).SetText("Phase 2").SetOnValueChanged(function(IsChecked) showedreturnmessage = false; phase2Fnt(IsChecked) end)
			
			CreateEmpty(phaseCont)
			labelInputCode = CreateLabel(phaseCont).SetText("You've selected phase 2, insert the code produced by phase 1")			  -- Label
			codeInputField = CreateTextInputField(phaseCont)
			.SetPlaceholderText("Paste here")
			.SetFlexibleWidth(1)
			.SetCharacterLimit(1000)  -- Both united in the selection for Players relations
			CreateEmpty(phaseCont)
			CreateEmpty(phaseCont)
			confirmButton = CreateButton(phaseCont).SetText("Confirm")
		else
			SetWindow(f2Win)
			DestroyWindow(f2Win, true)
			SetWindow(mainWin)
			phase1Fnt()
		end
	end

end