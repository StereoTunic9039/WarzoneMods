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
	labelLvlRelationsPc = CreateLabel(sliderLvlRelationsPc).SetText("You're on PHASE 1, use custom scenario distribution to deploy on each territory as many armies as the bonus for that territory (alone) should be worth. \n\n\ncheck below to activate phase 2")			  -- Label
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

	function confirm()
		
		printSomething()
		local inputCode = codeInputField.GetValue() -- getting month value
		--if inputCode == nil or string.len(inputCode) == 0 then alert("Mod set up failed\nInput Code is absent") return
		--else 
		--	Mod.Settings.inputCode = inputCode
		--end 

	end

	function printSomething()
		print("something")
	end

	function phase1Fnt()
		f1Win = "Fase1Window"
		AddSubWindow(mainWin, f1Win);
		SetWindow(f1Win)

		local sliderLvlRelationsPc = CreateHorizontalLayoutGroup(phaseCont)			  -- Slider
		labelLvlRelationsPc = CreateLabel(sliderLvlRelationsPc).SetText("You're on PHASE 1, check below to activate phase 2")			  -- Label
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
			CreateButton(phaseCont).SetText("Confirm").SetOnClick(confirm)
		else
			SetWindow(f2Win)
			DestroyWindow(f2Win, true)
			SetWindow(mainWin)
			phase1Fnt()
		end
	end

end