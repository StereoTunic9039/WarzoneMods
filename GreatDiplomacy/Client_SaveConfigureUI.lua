function Client_SaveConfigureUI(alert)
	if(numberInputFieldAi ~= nil)then
		Mod.Settings.lvlAi = numberInputFieldAi.GetValue()
		if (Mod.Settings.lvlAi < 1) then
			Mod.Settings.lvlAi = 1
		end

		if (Mod.Settings.lvlAi > 7) then
			Mod.Settings.lvlAi = 7
		end
	else
		Mod.Settings.lvlAi = 4
	end

	if(numberInputFieldPc ~= nil)then
		Mod.Settings.lvlPc = numberInputFieldPc.GetValue()
		if (Mod.Settings.lvlPc < 1) then
			Mod.Settings.lvlPc = 1
		end

		if (Mod.Settings.lvlPc > 7) then
			Mod.Settings.lvlPc = 7
		end
	else
		Mod.Settings.lvlPc = 3
	end

	if(numberInputFieldWar ~= nil)then
		Mod.Settings.lvlWar = numberInputFieldWar.GetValue()
		if (Mod.Settings.lvlWar < 2) then
			Mod.Settings.lvlWar = 2
		end

		if (Mod.Settings.lvlWar > 7) then
			Mod.Settings.lvlWar = 7
		end
	else
		Mod.Settings.lvlWar = 7
	end

	if(numberInputFieldBomb ~= nil)then
		Mod.Settings.lvlBomb = numberInputFieldBomb.GetValue()
		if (Mod.Settings.lvlBomb < 1) then
			Mod.Settings.lvlBomb = 1
		end

		if (Mod.Settings.lvlBomb > 7) then
			Mod.Settings.lvlBomb = 7
		end
	else
		Mod.Settings.lvlBomb = 6
	end

	if(numberInputFieldSanction ~= nil)then
		Mod.Settings.lvlSanction = numberInputFieldSanction.GetValue()
		if (Mod.Settings.lvlSanction < 1) then
			Mod.Settings.lvlSanction = 1
		end

		if (Mod.Settings.lvlSanction > 7) then
			Mod.Settings.lvlSanction = 7
		end
	else
		Mod.Settings.lvlSanction = 5
	end

	if(numberInputFieldSpy ~= nil)then
		Mod.Settings.lvlSpy = numberInputFieldSpy.GetValue()
		if (Mod.Settings.lvlSpy < 1) then
			Mod.Settings.lvlSpy = 1
		end

		if (Mod.Settings.lvlSpy > 7) then
			Mod.Settings.lvlSpy = 7
		end
	else
		Mod.Settings.lvl = 4
	end

	if(numberInputFieldGift ~= nil)then
		Mod.Settings.lvlGift = numberInputFieldGift.GetValue()
		if (Mod.Settings.lvlGift < 1) then
			Mod.Settings.lvlGift = 1
		end

		if (Mod.Settings.lvlGift > 7) then
			Mod.Settings.lvlGift = 7
		end
	else
		Mod.Settings.lvlGift = 3
	end

	if(numberInputFieldSee ~= nil)then
		Mod.Settings.lvlSee = numberInputFieldSee.GetValue()
		if (Mod.Settings.lvlSee < 1) then
			Mod.Settings.lvlSee = 1
		end

		if (Mod.Settings.lvlSee > 7) then
			Mod.Settings.lvlSee = 7
		end
	else
		Mod.Settings.lvlSee = 2
	end

	if(numberInputFieldTransfer ~= nil)then
		Mod.Settings.lvlTransfer = numberInputFieldTransfer.GetValue()
		if (Mod.Settings.lvlTransfer < 1) then
			Mod.Settings.lvlTransfer = 1
		end

		if (Mod.Settings.lvlTransfer > 1) then
			Mod.Settings.lvlTransfer = Mod.Settings.lvlWar -1
		end
	else
		Mod.Settings.lvlTransfer = 1
	end

	if(mpdps ~= nil)then
		Mod.Settings.mpdps = mpdps.GetValue()
		if (Mod.Settings.mpdps < 2) then
			Mod.Settings.mpdps = 2
		end

		if (Mod.Settings.mpdps > 100) then
			Mod.Settings.mpdps = 100
		end
	else
		Mod.Settings.mpdps = 5
	end
end  				-- Sets straight every unwanted input and such 