require("Client_PresentConfigureUI")
require("consolelog")

function Server_StartGame(game,standing)

	phase = Mod.Settings.phase		-- at the strt of the game it checks the phase it was selected

	if phase == 1 then
		local publicGameData = {}
		for i, _ in pairs(game.Map.Bonuses) do		-- for every bonus in this map (i is the id)
			sum = 0									-- the sum of armies that are on all territories of the bonus
			for _, k in pairs(game.Map.Bonuses[i].Territories) do		-- for every territory in the bonus (k is the Territory)
				a = 0								-- I don't think I need this tbf
				a = game.ServerGame.TurnZeroStanding.Territories[k].NumArmies.NumArmies			-- how many armies are on that territory
				sum = sum + a																	-- sum that with the already counted armies
			end
			publicGameData[i] = sum					-- ties the bonus id to the sum or armies in that bonus
		end

		Mod.PublicGameData = publicGameData 		-- updates it to the mod storage for future access
	else
		print("phase is 2", phase)
	end

end	 		



