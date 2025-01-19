require("Client_PresentConfigureUI")
require("consolelog")

function Client_SaveConfigureUI(alert)
    Mod.Settings.phase = phase
    if(Mod.Settings.inputCodeA == nil and phase == 2)then
        UI.Alert("BONUS VALUE ADVANCED OVERRIDER HAS NOT BEEN SET UP PROPERLY")
    end
end  				-- Sets straight every unwanted input and such 