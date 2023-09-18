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
		if (Mod.Settings.lvlAi < 1) then
			Mod.Settings.lvlAi = 1
		end

		if (Mod.Settings.lvlAi > 7) then
			Mod.Settings.lvlAi = 7
		end
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
		if (Mod.Settings.lvlPc < 1) then
			Mod.Settings.lvlPc = 1
		end

		if (Mod.Settings.lvlPc > 7) then
			Mod.Settings.lvlPc = 7
		end
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
		if (Mod.Settings.lvlWar < 2) then
			Mod.Settings.lvlWar = 2
		end

		if (Mod.Settings.lvlWar > 7) then
			Mod.Settings.lvlWar = 7
		end
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
		if (Mod.Settings.lvlBomb < 1) then
			Mod.Settings.lvlBomb = 1
		end

		if (Mod.Settings.lvlBomb > 7) then
			Mod.Settings.lvlBomb = 7
		end
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
		Mod.Settings.lvlSanction = ValueSanction
		if (Mod.Settings.lvlSanction < 1) then
			Mod.Settings.lvlSanction = 1
		end

		if (Mod.Settings.lvlSanction > 7) then
			Mod.Settings.lvlSanction = 7
		end
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
		Mod.Settings.lvlSpy = ValueSpy
		if (Mod.Settings.lvlSpy < 1) then
			Mod.Settings.lvlSpy = 1
		end

		if (Mod.Settings.lvlSpy > 7) then
			Mod.Settings.lvlSpy = 7
		end
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
		if (Mod.Settings.lvlGift < 1) then
			Mod.Settings.lvlGift = 1
		end

		if (Mod.Settings.lvlGift > 7) then
			Mod.Settings.lvlGift = 7
		end
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
		if (Mod.Settings.lvlSee < 1) then
			Mod.Settings.lvlSee = 1
		end

		if (Mod.Settings.lvlSee > 7) then
			Mod.Settings.lvlSee = 7
		end
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
		if (Mod.Settings.lvlTransfer < 1) then
			Mod.Settings.lvlTransfer = 1
		end

		if (Mod.Settings.lvlTransfer > 1) then
			Mod.Settings.lvlTransfer = Mod.Settings.lvlWar -1
		end
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
		if (Mod.Settings.mpdps < 2) then
			Mod.Settings.mpdps = 2
		end

		if (Mod.Settings.mpdps > 100) then
			Mod.Settings.mpdps = 100
		end
	end

	if(takesEffSlider ~= nil)then
		Mod.Settings.TE = takesEffSlider.GetValue()
		if (Mod.Settings.TE < 2) then
			Mod.Settings.TE = 2
		end

		if (Mod.Settings.TE > 7) then
			Mod.Settings.TE = 7
		end
	else
		Mod.Settings.TE = ValueTE
		if (Mod.Settings.TE < 2) then
			Mod.Settings.TE = 2
		end

		if (Mod.Settings.TE > 7) then
			Mod.Settings.TE = 7
		end
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
		if (Mod.Settings.LO < -1) then
			Mod.Settings.LO = -1
		end

		if (Mod.Settings.LO > 1000) then
			Mod.Settings.LO = 1000
		end
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
		if (Mod.Settings.LD < 2) then
			Mod.Settings.LD = 2
		end

		if (Mod.Settings.LD > 100) then
			Mod.Settings.LD = 100
		end
	end

	Mod.Settings.LA = ValueLA
	Mod.Settings.UA = ValueUA
	Mod.Settings.VP = ValueVP
	Mod.Settings.ACS = ValueACS
end  				-- Sets straight every unwanted input and such 