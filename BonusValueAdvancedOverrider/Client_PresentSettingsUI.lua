function Client_PresentSettingsUI(rootParent)  -- I have no idea if it is even needed, sure as hell I got no idea on what it does

	UI.CreateLabel(rootParent).SetText("Level relations for AI: " .. Mod.Settings.lvlAi)
	UI.CreateLabel(rootParent).SetText("Level relations for Players: " .. Mod.Settings.lvlPc)
	
end