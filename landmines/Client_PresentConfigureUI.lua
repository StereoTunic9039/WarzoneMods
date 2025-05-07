require("UI");
function Client_PresentConfigureUI(rootParent)
	Init(rootParent);
    local textcolor = GetColors().TextColor;
    local root = GetRoot();

	mainWin = "mainWindow"
	costWin = "costWindow"

	AddSubWindow(mainWin, costWin);
	


    local isFixedCost = Mod.Settings.IsFixedCost;
	if isFixedCost == nil then isFixedCost = true; end						-- if true then the cost of landmines is a fixed amount, otherwise it progressively increases 
	local unitCost = Mod.Settings.UnitCost;
    if unitCost == nil then unitCost = 10; end							-- fixed amount cost of landmines
	local unitInitialCost = Mod.Settings.UnitInitialCost;
    if unitInitialCost == nil then unitInitialCost = 10; end			-- fixed amount cost of landmines
	local arithmeticIncrease = Mod.Settings.ArithmeticIncrease;
	if arithmeticIncrease == nil then arithmeticIncrease = true; end	-- if true then the cost of landmines is a fixed amount, otherwise it progressively increases 
	local IncreaseCost = Mod.Settings.IncreaseCost;
    if IncreaseCost == nil then IncreaseCost = 5; end					-- fixed amount cost of landmines
	local isFixedDamage = Mod.Settings.IsFixedDamage;
	if isFixedDamage == nil then isFixedDamage = true; end					-- if true then the damage inflicted by landmines is a fixed amount, otherwise it's a % of the armies on the territory
    local damageValue = Mod.Settings.Damage;
    if damageValue == nil then damageValue = 25; end					-- fixed amount damage inflicted by landmines
    local maxUnits = Mod.Settings.MaxUnits;
    if maxUnits == nil then maxUnits = 3; end							-- maximum number of landmines that a player can position
	local turnNeutral = Mod.Settings.TurnNeutral;
	if turnNeutral == nil then turnNeutral = true; end
    local cooldownTime = Mod.Settings.Cooldown;
    if cooldownTime == nil then cooldownTime = 0; end       				-- if true then there is a cooldown between each time a player positions a landmine
	local turnsNeutral = Mod.Settings.TurnsNeutral;
    if turnsNeutral == nil then turnsNeutral = true; end       				-- if true then there is a cooldown between each time a player positions a landmine




	function typeCost()
		CreateLabel(root).SetText("COST").SetColor("#FF0000").SetPreferredHeight(20);
		CreateLabel(root).SetText("Is the cost of a landmine fixed rather than progressive?").SetColor(textcolor);
		typeCostInput = CreateCheckBox(root).SetIsChecked(isFixedCost).SetText("").SetOnValueChanged(function(IsChecked) showedreturnmessage = false; changeTypeCost(IsChecked) end)

		CreateEmpty(root).SetPreferredHeight(5);
	end

	function changeTypeCost(IsChecked)
		isFixedCost = IsChecked
		
		if IsChecked then 
			SetWindow(costWin)
			DestroyWindow(costWin)
			DestroyWindow(damgWin)
			DestroyWindow(funcWin)
			costWin = "CostWindow"
			AddSubWindow(mainWin, costWin);
			SetWindow(costWin)
			fixedCost() 
		else 
			SetWindow(costWin)
			DestroyWindow(costWin)
			DestroyWindow(damgWin)
			DestroyWindow(funcWin)
			costWin = "CostWindow"
			AddSubWindow(mainWin, costWin);
			SetWindow(costWin)
			progressiveCost() 
		end
	end

	function fixedCost()
		CreateLabel(root).SetText("The amount of gold a landmine will cost").SetColor(textcolor);
		unitCostInput = CreateNumberInputField(root).SetSliderMaxValue(100).SetSliderMinValue(5).SetValue(unitCost);

		CreateEmpty(root).SetPreferredHeight(5);



		damgWin = "damageWindow"
		AddSubWindow(mainWin, damgWin);
		typeDamage()
		SetWindow(damgWin)
		damage()
	end

	function progressiveCost()
		CreateLabel(root).SetText("The initial amount of gold a landmine will cost").SetColor(textcolor);
		unitInitialCostInput = CreateNumberInputField(root).SetSliderMaxValue(100).SetSliderMinValue(5).SetValue(unitInitialCost);

		CreateEmpty(root).SetPreferredHeight(5);


		CreateLabel(root).SetText("Is the increase in the cost of a landmine arithmetic (addition of X) rather than geometric (multiplication by X)?").SetColor(textcolor);
		typeIncreaseInput = CreateCheckBox(root).SetText("").SetIsChecked(arithmeticIncrease)

		CreateEmpty(root).SetPreferredHeight(5);


		CreateLabel(root).SetText("The increase will be worth (this is X)").SetColor(textcolor);
		IncreaseCostInput = CreateNumberInputField(root).SetSliderMaxValue(50).SetSliderMinValue(1).SetValue(IncreaseCost);

		CreateEmpty(root).SetPreferredHeight(5);



		damgWin = "damageWindow"
		AddSubWindow(mainWin, damgWin);
		typeDamage()
		SetWindow(damgWin)
		damage()
	end
    
	function typeDamage()
		CreateLabel(root).SetText("DAMAGE").SetColor("#FF0000").SetPreferredHeight(20);
		CreateLabel(root).SetText("Is the damage inflicted by a landmine a fixed number rather than %?").SetColor(textcolor);
		typeDamageInput = CreateCheckBox(root).SetText("").SetIsChecked(isFixedDamage)

		CreateEmpty(root).SetPreferredHeight(5);
	end

	function damage()
		CreateLabel(root).SetText("The number/percentage of armies that will be killed upon this unit explosion").SetColor(textcolor);
		damageInput = CreateNumberInputField(root).SetSliderMaxValue(100).SetSliderMinValue(1).SetValue(damageValue);
		
		CreateEmpty(root).SetPreferredHeight(5);



		funcWin = "functionalitiesWindow"
 		AddSubWindow(mainWin, funcWin);
		SetWindow(funcWin)
		maxUnitsFunction()
	end
    
	function maxUnitsFunction()
		CreateLabel(root).SetText("OTHER").SetColor("#FF0000").SetPreferredHeight(20);
		CreateLabel(root).SetText("The maximum number of landmines a player may control (set 0 if there should be no limit)").SetColor(textcolor);
		maxUnitsInput = CreateNumberInputField(root).SetSliderMaxValue(10).SetSliderMinValue(0).SetValue(maxUnits);
		
		CreateEmpty(root).SetPreferredHeight(5);
	end
	
	function cooldown()
		CreateLabel(root).SetText("The cooldown between each time a player positions a landmine (set 0 if there should be no cooldown)").SetColor(textcolor);
		cooldownInput = CreateNumberInputField(root).SetSliderMaxValue(8).SetSliderMinValue(0).SetValue(cooldownTime);

		CreateEmpty(root).SetPreferredHeight(5);
	end

	function turningNeutral()
		CreateLabel(root).SetText("If the landmine kills all the armies, does the territory turn neutral?").SetColor(textcolor);
		turnsNeutralInput = CreateCheckBox(root).SetText("").SetIsChecked(turnsNeutral)

		CreateEmpty(root).SetPreferredHeight(5);
	end







	typeCost()
	SetWindow(costWin)
	if isFixedCost then
		fixedCost()
	else
		progressiveCost()
	end

end