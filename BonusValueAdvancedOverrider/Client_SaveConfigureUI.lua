require("Client_PresentConfigureUI")
require("consolelog")

function Client_SaveConfigureUI(alert)

    print(phase)
    phase = 1
    if phase == 2 then
        local inputCode = codeInputField.GetValue()
        if inputCode == nil or string.len(inputCode) == 0 then alert("Mod set up failed\nInput Code is absent") return
        else 
            Mod.Settings.inputCode = inputCode
        end 
    --else
        --.Settings.AutomaticTerritoryDistribution = true
    end

    acab = {43, 32, 64}
    
end  				-- Sets straight every unwanted input and such 