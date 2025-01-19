require("UI")
require("consolelog")  
--[[
    Ok so basically with this the menu of the mod in game willwork on windows, 
    each time you want to add something you need to have a windown and when you destroy it
    all it's contentes vanishes which is really useful.
]]--

function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game, closeAll)
	Game = game;
	Init(rootParent)
    vert = GetRoot();
	setMaxSize(450, 350);
	writeMenu()
end                             -- This part you shall not touch unless you're expert which I'm not

function writeMenu()
    DestroyWindow()             -- With this you destroy the previous window
    SetWindow("Home");          -- With this you create the windown you need to create stuff on. This one is the home.    
    if(rawCode == nil)then
        rawCode = Mod.PublicGameData        -- Server_StartGame got all the bonuses new value associated with their ID
    end
    code = ""
    --deltedCode = delta(rawCode)

    for i, j in pairs(rawCode) do
        code = code .. "{" .. i .. ", " .. j .. "}, "
    end
    code = string.sub(code, 1, #code - 2)

    labelOutputCode = CreateLabel(vert).SetText("Your code is:")
    CreateEmpty(vert)
    copyOutputCode = CreateTextInputField(vert).SetText(code).SetPreferredWidth(400)
    CreateEmpty(vert)
    labelCopyCode = CreateLabel(vert).SetText("Use 'Ctrl + C' to copy")
    CreateEmpty(vert)
    CreateEmpty(vert)
    manualChange = CreateButton(vert).SetText("Manually change specific bonuses now").SetOnClick(manualChangeFunction)
end

function manualChangeFunction()
    DestroyWindow()             -- With this you destroy the previous window
    SetWindow("ChangeValue");          -- With this you create the windown you need to create stuff on. This one is the home.   
    UI.InterceptNextBonusLinkClick(getID)

    labelWatchOut = CreateLabel(vert).SetText("ID of the Bonus (click on the bonus and it will be added automatically):")
    bonusID = CreateTextInputField(vert).SetPreferredWidth(400).SetPlaceholderText("Click on a bonus")
    labelWatchOut = CreateLabel(vert).SetText("Value of the bonus (Negative numbers are allowed, if blank or not a number it'll be counted as 0):")
    bonusValue = CreateTextInputField(vert).SetPreferredWidth(400).SetPlaceholderText("Enter bonus value")
    CreateEmpty(vert)
    CreateEmpty(vert)

    
    buttons = CreateHorizontalLayoutGroup(vert)
    save = CreateButton(buttons).SetText("Save").SetOnClick(saveUpdate)
    CreateEmpty(buttons)
    CreateEmpty(buttons)
    CreateEmpty(buttons)
    cancel = CreateButton(buttons).SetText("Cancel").SetOnClick(manualChangeFunction)
    CreateEmpty(buttons)
    CreateEmpty(buttons)
    CreateEmpty(buttons)
    leave = CreateButton(buttons).SetText("Leave").SetOnClick(writeMenu)
    CreateEmpty(vert)
    labelWatchOut = CreateLabel(vert).SetText("Save each change, leave deletes all that has not been saved.")
end

function getID(bonus)
    if(bonus == nil)then return; end
    ID = bonus.ID
    bonusID.SetText(ID)
    return ID;
end

function saveUpdate()
    ID = bonusID.GetText()
    Value = bonusValue.GetText()
    ID = tonumber(ID)
    Value = tonumber(Value)
    if(ID == nil or ID ~= math.floor(ID) or ID < 0 or ID > 100000)then UI.Alert("Invalid Bonus ID"); return; end
    if(Value == nil)then Value = 0; end
    Value = math.floor(Value)
    if(Value>1000)then Value = 1000; end
    rawCode[ID] = Value
    manualChangeFunction()
end