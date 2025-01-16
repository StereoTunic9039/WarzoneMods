require("CreateTableStatus")
require("consolelog")

function Server_StartGame(game,standing)
	if (game.Settings.AutomaticTerritoryDistribution) then
		CTS(game,standing)
	end
end	 		
-- This always starts no matter if players pick their starting postions or not
-- so to avoid conflicting with the other one
-- the if lets this run only if it's automatic distribution
-- and when running it creates the Table for the Status of the various Relations
