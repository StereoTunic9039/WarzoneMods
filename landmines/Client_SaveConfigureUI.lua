function Client_SaveConfigureUI(alert)
	Mod.Settings.UnitCost = unitCostInput.GetValue();
    Mod.Settings.UnitInitialCost = unitInitialCostInput.GetValue();
    Mod.Settings.IncreaseCost = IncreaseCostInput.GetValue();
    Mod.Settings.Damage = damageInput.GetValue();
    Mod.Settings.MaxUnits = maxUnitsInput.GetValue();
end