require("Client_PresentConfigureUI")

function Client_SaveConfigureUI(alert)

    local inputCode = codeInputField.GetValue()
    if inputCode == nil or string.len(inputCode) == 0 then alert("Mod set up failed\nInput Code is absent") return
    else 
        Mod.Settings.inputCode = inputCode
    end 

end  				-- Sets straight every unwanted input and such 