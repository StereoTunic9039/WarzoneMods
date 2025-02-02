require("consolelog")

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

    if Mod.Settings.IsFixedCost then
        if Mod.Settings.UnitCost < 0 then Mod.Settings.UnitCost = 0;
        elseif Mod.Settings.UnitCost > 10000 then Mod.Settings.UnitCost = 10000; end
    else
        if Mod.Settings.UnitInitialCost < 0 then Mod.Settings.UnitInitialCost = 0;
        elseif Mod.Settings.UnitInitialCost > 10000 then Mod.Settings.UnitInitialCost = 10000; end
        if Mod.Settings.IncreaseCost < 1 then Mod.Settings.IncreaseCost = 1;
        elseif Mod.Settings.IncreaseCost >10000 then Mod.Settings.IncreaseCost = 10000; end
    end

    if Mod.Settings.IsFixedDamage then 
        if Mod.Settings.Damage < 1 then Mod.Settings.Damage = 1; 
        elseif Mod.Settings.Damage > 10000 then Mod.Settings.Damage = 10000; end
    else
        if Mod.Settings.Damage < 1 then Mod.Settings.Damage = 1; 
        elseif Mod.Settings.Damage > 100 then Mod.Settings.Damage = 100; end
    end

    if Mod.Settings.MaxUnits < 0 then Mod.Settings.MaxUnits = 0;
    elseif Mod.Settings.MaxUnits > 1000 then Mod.Settings.MaxUnits = 1000; end

    Mod.Settings.TurnNeutral = false

    tblprint(Mod.Settings)
end