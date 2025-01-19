require("UI")
	

function Client_PresentConfigureUI(rootParent)

	Init(rootParent)
    vert = GetRoot();

	phase = Mod.Settings.phase    --Basic relation with AIs
	InputCode = Mod.Settings.inputCodeB			-- a string
	if phase == nil then
		phase = 1 						--Normally it's 1 
	end
	

	mainWin = "mainWindow"
	f1Win = "Fase1Window"
	AddSubWindow(mainWin, f1Win);
	SetWindow(mainWin);
	
	local mainContainer = CreateVerticalLayoutGroup(rootParent)     --The main container I guess
	local phaseCont = CreateVerticalLayoutGroup(mainContainer)

	function confirm()
		
		local InputCode = codeInputField.GetText() -- getting the code
		if (#InputCode == 0 or InputCode == nil) then 
			UI.Alert("Mod set up failed\nInput Code is absent") return;
		else
			local array = {}
			for key, value in string.gmatch(InputCode, "{(%d+), (%d+)}") do
				array[tonumber(key)] = tonumber(value)
			end

			if #array == 0 then 
				UI.Alert("Mod set up failed\nInput Code is not valid") 
			else 
				Mod.Settings.inputCodeA = array
				Mod.Settings.inputCodeB = InputCode
			end
		end 

	end

	function phase1Fnt()
		f1Win = "Fase1Window"
		AddSubWindow(mainWin, f1Win);
		SetWindow(f1Win)

		local GroupYoureInPhase1 = CreateHorizontalLayoutGroup(phaseCont)			  -- Slider
		labelYoureInPhase1 = CreateLabel(GroupYoureInPhase1).SetText("You're on PHASE 1, use custom scenario distribution to deploy on each territory as many armies as the bonus for that territory (alone) should be worth. \n\ncheck below to activate phase 2")			  -- Label
		CreateEmpty(phaseCont)
		CreateEmpty(phaseCont)
		CreateEmpty(phaseCont)
		phase = 1

		CreateCheckBox(phaseCont).SetIsChecked(false).SetText("Phase 2").SetOnValueChanged(function(IsChecked) showedreturnmessage = false; phase2Fnt(IsChecked) end)
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
			phase = 2

			CreateEmpty(phaseCont)
			labelInputCode = CreateLabel(phaseCont).SetText("You've selected phase 2, insert the code produced by phase 1")			  -- Label
			
			if(InputCode == nil)then
				codeInputField = CreateTextInputField(phaseCont)
				.SetPlaceholderText("Paste here")
				.SetFlexibleWidth(1)
				.SetCharacterLimit(100000000)
			else
				codeInputField = CreateTextInputField(phaseCont)
				.SetPlaceholderText("Paste here")
				.SetText(InputCode)
				.SetFlexibleWidth(1)
				.SetCharacterLimit(100000000)
			end
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


	
	if(phase == 1)then 
		phase1Fnt()
	else
		phase2Fnt(true)
	end

end