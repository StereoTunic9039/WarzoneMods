require("UI");
function Client_PresentConfigureUI(rootParent)
	Init(rootParent);
    local textcolor = GetColors().TextColor;
    local root = GetRoot();

	mainWin = "mainWindow"
	fcWin = "fixedCostWindow"
	pcWin = "progressiveCostWindow"
	AddSubWindow(mainWin, fcWin);
	AddSubWindow(mainWin, pcWin);

    local fixedCost = Mod.Settings.FixedCost;
	if fixedCost == nil then fixedCost = true; end						-- if true then the cost of landmines is a fixed amount, otherwise it progressively increases 
	local unitCost = Mod.Settings.UnitCost;
    if unitCost == nil then unitCost = 10; end							-- fixed amount cost of landmines
	local unitInitialCost = Mod.Settings.UnitInitialCost;
    if unitInitialCost == nil then unitInitialCost = 10; end			-- fixed amount cost of landmines
	local arithmeticIncrease = Mod.Settings.arithmeticIncrease;
	if arithmeticIncrease == nil then arithmeticIncrease = true; end	-- if true then the cost of landmines is a fixed amount, otherwise it progressively increases 
	local IncreaseCost = Mod.Settings.IncreaseCost;
    if IncreaseCost == nil then IncreaseCost = 10; end					-- fixed amount cost of landmines
	local typeDamage = Mod.Settings.typeDamage;
	if typeDamage == nil then typeDamage = true; end					-- if true then the damage inflicted by landmines is a fixed amount, otherwise it's a % of the armies on the territory
    local damage = Mod.Settings.Damage;
    if damage == nil then damage = 25; end								-- fixed amount damage inflicted by landmines
    local maxUnits = Mod.Settings.MaxUnits;
    if maxUnits == nil then maxUnits = 3; end							-- maximum number of landmines that a player can position
    local cooldown = Mod.Settings.cooldown;
    if cooldown == nil then cooldown = false; end       				-- if true then there is a cooldown between each time a player positions a landmine

	function typeCost()
		CreateLabel(root).SetText("Is the cost of a landmine fixed rather than progressive?").SetColor(textcolor);
		CreateCheckBox(root).SetValue(fixedCost)

		CreateEmpty(root).SetPreferredHeight(5);
	end

	function fixedCost()
		CreateLabel(root).SetText("The amount of gold a landmine will cost").SetColor(textcolor);
		unitCostInput = CreateNumberInputField(root).SetSliderMaxValue(100).SetSliderMinValue(5).SetValue(unitCost);

		CreateEmpty(root).SetPreferredHeight(5);
	end

	function progressiveCost()
		CreateLabel(root).SetText("The initial amount of gold a landmine will cost").SetColor(textcolor);
		unitInitialCostInput = CreateNumberInputField(root).SetSliderMaxValue(100).SetSliderMinValue(5).SetValue(unitInitialCost);

		CreateEmpty(root).SetPreferredHeight(5);


		CreateLabel(root).SetText("Is the increase in the cost of a landmine arithmetic (addition of X) rather than geometric (multiplication by X)?").SetColor(textcolor);
		CreateCheckBox(root).SetValue(arithmeticIncrease)

		CreateEmpty(root).SetPreferredHeight(5);


		CreateLabel(root).SetText("The increase will be worth (this is X)").SetColor(textcolor);
		IncreaseCostInput = CreateNumberInputField(root).SetSliderMaxValue(50).SetSliderMinValue(1).SetValue(IncreaseCost);

		CreateEmpty(root).SetPreferredHeight(5);
	end

    
	function typeDamage()
		CreateLabel(root).SetText("Is the damage inflicted by a landmine a fixed number rather than %?").SetColor(textcolor);
		CreateCheckBox(root).SetValue(typeDamage)

		CreateEmpty(root).SetPreferredHeight(5);
	end

	function fixedDamage()
		CreateLabel(root).SetText("The damage this unit will inflict upon exploding").SetColor(textcolor);
		damageInput = CreateNumberInputField(root).SetSliderMaxValue(100).SetSliderMinValue(1).SetValue(damage);
		
		CreateEmpty(root).SetPreferredHeight(5);
	end
    
	function maxUnits()
		CreateLabel(root).SetText("The maximum number of landmines a player may control (set 0 if there should be no limit)").SetColor(textcolor);
		maxUnitsInput = CreateNumberInputField(root).SetSliderMaxValue(5).SetSliderMinValue(0).SetValue(maxUnits);
		
		CreateEmpty(root).SetPreferredHeight(5);
	end

	function cooldown()
		CreateLabel(root).SetText("Is there a cooldown between each time a player positions a landmine?").SetColor(textcolor);
		CreateCheckBox(root).SetValue(cooldown)

		CreateEmpty(root).SetPreferredHeight(5);
	end
end