function Client_SaveConfigureUI(alert)
    Mod.Settings.IsFixedCost = typeCostInput.GetIsChecked();
    if Mod.Settings.IsFixedCost then
        Mod.Settings.UnitCost = unitCostInput.GetValue();
    else
        Mod.Settings.UnitInitialCost = unitInitialCostInput.GetValue();
        Mod.Settings.ArithmeticIncrease = typeIncreaseInput.GetIsChecked();
        Mod.Settings.IncreaseCost = IncreaseCostInput.GetValue();
    end;
    Mod.Settings.IsFixedDamage = typeDamageInput.GetIsChecked();
    Mod.Settings.Damage = damageInput.GetValue();
    Mod.Settings.MaxUnits = maxUnitsInput.GetValue();
end