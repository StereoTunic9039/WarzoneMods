require("Client_PresentConfigureUI")

function Client_SaveConfigureUI(alert)
	
	if (not UI.IsDestroyed(farSlider)) and farSlider ~= nil then
		Mod.Settings.WeakenBlockades.fixedArmiesRemoved = farSlider.GetValue()
		if (Mod.Settings.WeakenBlockades.fixedArmiesRemoved < -100) then
			Mod.Settings.WeakenBlockades.fixedArmiesRemoved = -100
		end

		if (Mod.Settings.WeakenBlockades.fixedArmiesRemoved > 1000) then
			Mod.Settings.WeakenBlockades.fixedArmiesRemoved = 1000
		end
	else
		Mod.Settings.WeakenBlockades.fixedArmiesRemoved = fixedArmiesRemoved
		if (Mod.Settings.WeakenBlockades.fixedArmiesRemoved < -100) then
			Mod.Settings.WeakenBlockades.fixedArmiesRemoved = -100
		end

		if (Mod.Settings.WeakenBlockades.fixedArmiesRemoved > 1000) then
			Mod.Settings.WeakenBlockades.fixedArmiesRemoved = 1000
		end
	end

	if((not UI.IsDestroyed(parSlider)) and parSlider ~= nil)then
		Mod.Settings.WeakenBlockades.percentualArmiesRemoved = parSlider.GetValue()
		if (Mod.Settings.WeakenBlockades.percentualArmiesRemoved < -100) then
			Mod.Settings.WeakenBlockades.percentualArmiesRemoved = -100
		end

		if (Mod.Settings.WeakenBlockades.percentualArmiesRemoved > 100) then
			Mod.Settings.WeakenBlockades.percentualArmiesRemoved = 100
		end
	else
		Mod.Settings.WeakenBlockades.percentualArmiesRemoved = percentualArmiesRemoved
		if (Mod.Settings.WeakenBlockades.percentualArmiesRemoved < -100) then
			Mod.Settings.WeakenBlockades.percentualArmiesRemoved = -100
		end

		if (Mod.Settings.WeakenBlockades.percentualArmiesRemoved > 100) then
			Mod.Settings.WeakenBlockades.percentualArmiesRemoved = 100
		end
	end

	if not UI.IsDestroyed(dlsSlider) then
		Mod.Settings.WeakenBlockades.delayFromStart = dlsSlider.GetValue()
		if (Mod.Settings.WeakenBlockades.delayFromStart < 0) then
			Mod.Settings.WeakenBlockades.delayFromStart = 0
		end
		if (Mod.Settings.WeakenBlockades.delayFromStart > 50) then
			Mod.Settings.WeakenBlockades.delayFromStart = 50
		end
	end

	if((not UI.IsDestroyed(atmaSlider)) and atmaSlider ~= nil)then
		Mod.Settings.WeakenBlockades.appliesToMinArmies = atmaSlider.GetValue()
		if (Mod.Settings.WeakenBlockades.appliesToMinArmies < 1) then
			Mod.Settings.WeakenBlockades.appliesToMinArmies = 1
		end

		if (Mod.Settings.WeakenBlockades.appliesToMinArmies > 1000) then
			Mod.Settings.WeakenBlockades.appliesToMinArmies = 1000
		end
	else
		Mod.Settings.WeakenBlockades.appliesToMinArmies = appliesToMinArmies
		if (Mod.Settings.WeakenBlockades.appliesToMinArmies < 1) then
			Mod.Settings.WeakenBlockades.appliesToMinArmies = 1
		end

		if (Mod.Settings.WeakenBlockades.appliesToMinArmies > 1000) then
			Mod.Settings.WeakenBlockades.appliesToMinArmies = 1000
		end
	end

	Mod.Settings.WeakenBlockades.percentualOrFixed  = percentualOrFixed
	Mod.Settings.WeakenBlockades.appliesToAllNeutrals = appliesToAllNeutrals
	Mod.Settings.WeakenBlockades.ADVANCEDVERSION = ADVANCEDVERSION
end  				-- Sets straight every unwanted input and such 
