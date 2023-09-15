require("Client_PresentConfigureUI")

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
		Mod.Settings.lvlAi = ValueAi
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
		Mod.Settings.lvlPc = ValuePc
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
		Mod.Settings.lvlWar = ValueWar
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
		Mod.Settings.lvlBomb = ValueBomb
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
		Mod.Settings.lvlSanction = Sanction
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
		Mod.Settings.lvl = ValueSpy
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
		Mod.Settings.lvlGift = ValueGift
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
		Mod.Settings.lvlSee = ValueSee
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
		Mod.Settings.lvlTransfer = ValueTransfer
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
		Mod.Settings.mpdps = Valuempdps
	end

	if(numberInputFieldLO ~= nil)then
		Mod.Settings.LO = numberInputFieldLO.GetValue()
		if (Mod.Settings.LO < -1) then
			Mod.Settings.LO = -1
		end

		if (Mod.Settings.LO > 1000) then
			Mod.Settings.LO = 1000
		end
	else
		Mod.Settings.LO = ValueLO
	end

	if(numberInputFieldLD ~= nil)then
		Mod.Settings.LD = numberInputFieldLD.GetValue()
		if (Mod.Settings.LD < 2) then
			Mod.Settings.LD = 2
		end

		if (Mod.Settings.LD > 100) then
			Mod.Settings.LD = 100
		end
	else
		Mod.Settings.LD = ValueLD
	end

	Mod.Settings.LA = ValueLA
	Mod.Settings.UA = ValueUA

	print(ValueLA, ValueLO, ValueLD, ValueUA)
end  				-- Sets straight every unwanted input and such 