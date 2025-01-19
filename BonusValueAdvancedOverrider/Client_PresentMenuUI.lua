require("UI")
require("consolelog")  
--[[
    Ok so basically with this the menu of the mod in game willwork on windows, 
    each time you want to add something you need to have a windown and when you destroy it
    all it's contentes vanishes which is really useful.
]]--

do
    b32t = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v"}
end

do
    b62t = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
end


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

    code = ""
    rawCode = Mod.PublicGameData        -- Server_StartGame got all the bonuses new value associated with their ID

    labelOutputCode = CreateLabel(vert).SetText("Your code is:")
    CreateEmpty(vert)
    openYourRelations = CreateTextInputField(vert).SetText(code).SetPreferredWidth(400)
end

function  tablelength(T)
	local count = 0;
	for _, elem in pairs(T)do
		count = count + 1;
	end
	return count;
end         -- I don't even think I need this tbh

function converter32(n)     -- for the value of the bonus
    if(n>1000)then n=1000 end   -- decimal value (max 1000)
    d = b32t[math.floor(n/32) +1]      
    u = b32t[(n%32) +1]              -- idk how to explain just look at it its obvious 
    du = d .. u             -- uniting unità and decine
    return du;
end

function converter62(n)     -- for the value of the IDs
    if n>61 then u = -1 else
        u = b62t[(n%62) +1]              -- idk how to explain just look at it its obvious 
    end
    return u;
end

function delta(array)           --to count the distance between IDs values
    local keys = {}
    for k in pairs(array) do
        table.insert(keys, k)
    end
    
    -- Step 2: Sort the keys
    table.sort(keys)
    
    deltedArray = {}
    i = #keys
    while 1<i do
        print(array[keys[i]])
        deltedArray[i] = {keys[i] - keys[i-1], array[keys[i]]}
        i = i-1
    end
    deltedArray[i] = {keys[i], array[keys[i]]}
    
    for k, j in pairs(deltedArray) do           -- so uhhhh future me figure it out. pushing to main right now :)
        j[2] = converter32(j[2])
        j[1] = converter62(j[1])
    end

    return deltedArray;
end
