require("CreateTableStatus")
require("consolelog")

function Server_StartGame(game,standing)
	--tblprint(game.Map.Bonuses)

	for i, territories in pairs(game.Map.Bonuses) do
		sum = 0
		for j, k in pairs(game.Map.Bonuses[i].Territories) do
			a = 0
			a = game.ServerGame.TurnZeroStanding.Territories[k].NumArmies.NumArmies
			sum = sum + a
		end
		tblprint(game.Map.Bonuses[i].Name)
		print(sum)
	end

end	 		
-- This always starts no matter if players pick their starting postions or not
-- so to avoid conflicting with the other one
-- the if lets this run only if it's automatic distribution
-- and when running it creates the Table for the Status of the various Relations




