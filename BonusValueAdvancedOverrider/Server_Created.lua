require("Client_PresentConfigureUI")
require("consolelog")

function Server_Created(game,GameSettings)
    phase = Mod.Settings.phase		-- at the strt of the game it checks the phase it was selected

	if phase == 2 then
		local inputCode = Mod.Settings.inputCode
		GameSettings.OverriddenBonuses = inputCode
	end                     -- looks all pretty obvious to me
end
