require("consolelog")

function Server_Created(game,GameSettings)
    publicGameData = {}
    publicGameData.LandminesPlaced = {}
    Mod.PublicGameData = publicGameData
end