function Client_PresentSettingsUI(rootParent)

    local types  = {true = "fixed at ", false = "percentual at "}
	local WB = Mod.Settings.WeakenBlockades
    local vert = UI.CreateVerticalLayoutGroup(rootParent);	
    if WB.percentualOrFixed then
        UI.CreateLabel(vert).SetText('The removal of armies will be fixed at ' .. WB.fixedArmiesRemoved).SetColor('#4EFFFF');   
    else
        UI.CreateLabel(vert).SetText('The removal of armies will be percentual at ' .. WB.percentualArmiesRemoved).SetColor('#FF4EFF');   
    end

    UI.CreateLabel(vert).SetText(WB.delayFromStart .. " turns must pass before the mod may have effect").SetColor('#FFFF4E');
    
    if WB.appliesToAllNeutrals then
        UI.CreateLabel(vert).SetText("It applies to all neutral territories")
    else
        UI.CreateLabel(vert).SetText("It applies only to territories with at least " .. WB.appliesToMinArmies)
    end

    if WB.ADVANCEDVERSION then
        UI.CreateLabel(vert).SetText("This game is using the advanced version!")
    end
end