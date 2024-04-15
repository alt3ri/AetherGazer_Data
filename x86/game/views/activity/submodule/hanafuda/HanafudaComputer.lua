slot1 = {
	COMPUTER_TURN = 2,
	STOP = 0,
	PLAYER_TURN = 1
}

return {
	ComputerPlay = function (slot0)
		if uv0.GetGameState() ~= uv1.COMPUTER_TURN then
			return
		end

		uv0.timer_ = Timer.New(function ()
			if uv0.GetGameState() ~= uv1.COMPUTER_TURN then
				uv0.timer_:Stop()

				uv0.timer_ = nil

				if uv0.playTimer_ then
					uv0.playTimer_:Stop()

					uv0.playTimer_ = nil
				end
			end

			if not table.isEmpty(uv0.GetMatchingCardsIndexList(uv0.GetPoolCardIndex())) then
				uv0.ClickPlaceCard(slot1[math.random(1, #slot1)])
			else
				uv0.PlayCardByIndex(slot0)
			end
		end, 1, 1, true)
		uv0.playTimer_ = Timer.New(function ()
			if uv0.GetGameState() ~= uv1.COMPUTER_TURN then
				uv0.playTimer_:Stop()

				uv0.playTimer_ = nil
			end

			if not table.isEmpty(uv0.GetMatchingCardsIndexList(uv0.GetRandomCardIndex())) then
				uv0.ClickPlaceCard(slot1[math.random(1, #slot1)])
			else
				uv0.PlayCardByIndex(slot0)
			end

			uv0.timer_:Start()
		end, 2, 1, true)

		uv0.playTimer_:Start()
	end,
	GetRandomCardIndex = function ()
		slot0 = HanafudaData:GetRandomCardIndex()

		manager.notify:CallUpdateFunc(CLICK_PLAYER_CARD, slot0)

		return slot0
	end,
	GetMatchingCardsIndexList = function (slot0)
		return HanafudaData:GetMatchingCardsIndexList(slot0)
	end,
	PlayCardByIndex = function (slot0)
		manager.notify:CallUpdateFunc(PLAY_CARD_BY_INDEX, slot0)
	end,
	ClickPlaceCard = function (slot0)
		manager.notify:CallUpdateFunc(CLICK_PLACE_CARD, slot0)
	end,
	GetPoolCardIndex = function ()
		return HanafudaData:GetPoolCardIndex()
	end,
	GetGameState = function ()
		return HanafudaData:GetGameState()
	end,
	Stop = function ()
		if uv0.timer_ then
			uv0.timer_:Stop()

			uv0.timer_ = nil
		end

		if uv0.playTimer_ then
			uv0.playTimer_:Stop()

			uv0.playTimer_ = nil
		end
	end
}
