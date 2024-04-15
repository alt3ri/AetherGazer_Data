slot0 = singletonClass("HanafudaData")
slot1 = {}
slot2 = {}
slot3 = {}
slot0.CARD_PLACE_TYPE = {
	PLACE = 3,
	PLAYER = 1,
	PLAYERCOMBINE = 5,
	POOL = 4,
	ENEMYCOMBINE = 6,
	COLLECTION = 7,
	ENEMY = 2
}
slot4 = {
	{},
	{},
	{},
	{},
	{},
	{}
}
slot0.GAME_STATE = {
	GAMEOVER = 4,
	DEALCARDS = 3,
	COMPUTER_TURN = 2,
	STOP = 0,
	PLAYER_TURN = 1
}
slot5 = slot0.GAME_STATE.STOP
slot6 = {}
slot7 = {}
slot8 = {}
slot9 = 0
slot10 = 0
slot11 = 1
slot12 = 0

function slot0.InitGameData(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {
		{},
		{},
		{},
		{},
		{},
		{}
	}
end

function slot0.InitTotalCardsList(slot0)
	slot0:InitGameData()

	for slot5, slot6 in pairs(HanafudaCardCfg) do
		if type(slot5) == "number" then
			slot6.rarity = KagutsuchiFishingEventData:GetRarity(slot5).order

			table.insert(uv0, slot6)
		end
	end
end

function slot0.GetTotoalCardsList(slot0)
	return uv0
end

function slot0.InitCombineList(slot0)
	uv0 = {}

	for slot5, slot6 in pairs(HanafudaCardCombineCfg) do
		if type(slot5) == "number" then
			table.insert(uv0, slot6)
		end
	end

	table.sort(uv0, function (slot0, slot1)
		return slot0.id < slot1.id
	end)
end

function slot0.GetCombineList(slot0)
	return uv0
end

function slot0.InitFromServer(slot0, slot1)
	slot0.activityID = slot1.activity_id
	slot0.completeCardCombineList = {}
	slot0.rewardedCardCombineList = {}
	slot0.streakInfo = {
		result = slot1.card_result.result or 0,
		num = slot1.card_result.num or 0
	}
	slot6 = slot1.card_combine_list

	for slot5, slot6 in ipairs(cleanProtoTable(slot6)) do
		table.insert(slot0.completeCardCombineList, slot6)
	end

	slot6 = slot1.card_reward_list

	for slot5, slot6 in ipairs(cleanProtoTable(slot6)) do
		table.insert(slot0.rewardedCardCombineList, slot6)
		table.insert(slot0.completeCardCombineList, slot6)
	end

	slot0:InitCombineList()
	slot0:InitCombineMap()
end

function slot0.GetActivityID(slot0)
	return slot0.activityID
end

function slot0.GetRewaredCardCombineList(slot0)
	return slot0.rewardedCardCombineList
end

function slot0.AddToRewardedCardCombineList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.rewardedCardCombineList, slot6)
	end
end

function slot0.GetCompleteCardCombineList(slot0)
	return slot0.completeCardCombineList
end

function slot0.AddToCompleteCardCombineList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.completeCardCombineList, slot6)
	end
end

function slot0.GetIsTasksUnRewarded(slot0)
	for slot5, slot6 in ipairs(slot0:GetCompleteCardCombineList()) do
		slot7 = false

		if table.isEmpty(slot0.rewardedCardCombineList) then
			return true
		end

		for slot11, slot12 in ipairs(slot0.rewardedCardCombineList) do
			if slot6 == slot12 then
				slot7 = true

				break
			end
		end

		if not slot7 then
			return true
		end
	end

	return false
end

function slot0.GetIsComplete(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.completeCardCombineList) do
		if slot1 == slot6 then
			return true
		end
	end

	return false
end

function slot0.GetIsRewarded(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.rewardedCardCombineList) do
		if slot1 == slot6 then
			return true
		end
	end

	return false
end

function slot0.RewardedCardCombineListByID(slot0, slot1)
	slot2, slot3 = table.indexof(slot0.completeCardCombineList, slot1)

	if slot2 then
		table.insert(slot0.rewardedCardCombineList, slot1)
	end
end

function slot0.GetStreakType(slot0)
	return slot0.streakInfo.result
end

function slot0.GetStreakNum(slot0)
	return slot0.streakInfo.num
end

function slot0.UpdateStreakInfo(slot0, slot1)
	if slot1 then
		if slot0.streakInfo.result == 0 then
			slot3 = slot0.streakInfo.num + 1
		else
			slot2 = 1
			slot3 = 1
		end
	elseif slot2 == 0 then
		slot2 = 0
		slot3 = 1
	else
		slot3 = slot3 + 1
	end

	slot0.streakInfo = {
		result = slot2,
		num = slot3
	}
end

function slot0.SetComputerDiffculty(slot0, slot1)
	uv0 = slot1
end

function slot0.GetComputerDiffculty(slot0)
	return uv0
end

function slot0.ShuffleCardList(slot0, slot1)
	uv0 = {}
	slot2 = deepClone(slot1)
	slot3 = #slot1
	slot4 = 1

	while slot3 > 0 do
		slot6 = table.remove(slot2, math.random(slot3))
		slot6.index = slot4

		table.insert(uv0, slot6)

		slot4 = slot4 + 1
		slot3 = slot3 - 1
	end

	return uv0
end

function slot0.GetSuffledCardsList(slot0)
	return uv0
end

function slot0.GetCardsListByType(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetMatchingCardsIndexList(slot0, slot1)
	if not uv0[slot1] then
		return {}
	end

	for slot7, slot8 in ipairs(uv1[3]) do
		if slot8.race == slot2.race then
			table.insert(slot3, slot8.index)
		end
	end

	return slot3
end

function slot0.InitCombineMap(slot0)
	uv0 = {}

	for slot5, slot6 in ipairs(HanafudaCardCombineCfg) do
		for slot10, slot11 in ipairs(slot6.card_list) do
			if not uv0[slot11] then
				uv0[slot11] = {}
			end

			table.insert(uv0[slot11], slot6.id)
			table.sort(uv0[slot11], function (slot0, slot1)
				return HanafudaCardCombineCfg[slot1].score < HanafudaCardCombineCfg[slot0].score
			end)
		end
	end
end

function slot0.ResetGameData(slot0)
	uv0 = {
		{},
		{},
		{},
		{},
		{},
		{}
	}
	uv1 = {}
	uv2 = {}
	uv3 = 0
	uv4 = 0
	uv5 = 0
end

function slot0.DealCards(slot0, slot1)
	slot2 = nil

	slot0:ResetGameData()

	uv0 = slot0.GAME_STATE.DEALCARDS
	slot3 = {}

	for slot7 = 1, 24 do
		if not slot3[slot1[slot7].race] then
			slot3[slot8] = 0
		end

		if slot7 <= 8 then
			slot2.placeType = slot0.CARD_PLACE_TYPE.POOL

			table.insert(uv1[4], slot2)
		elseif slot7 <= 16 then
			if slot3[slot8] >= 2 then
				for slot12 = 1, 24 do
					if not slot3[slot1[slot12].race] then
						slot3[slot1[slot12].race] = 0
					end

					if slot1[slot12].placeType ~= slot0.CARD_PLACE_TYPE.PLACE and slot1[slot12].race ~= slot8 and slot3[slot1[slot12].race] < 2 then
						slot13 = deepClone(slot1[slot12])
						slot2.placeType = slot0.CARD_PLACE_TYPE.POOL
						slot2.index = slot12
						slot13.placeType = slot0.CARD_PLACE_TYPE.PLACE
						slot13.index = slot7
						slot1[slot12] = slot2
						slot1[slot7] = slot13
						slot2 = slot13

						break
					end
				end

				slot3[slot2.race] = slot3[slot2.race] + 1
			else
				slot2.placeType = slot0.CARD_PLACE_TYPE.PLACE
				slot3[slot8] = slot3[slot8] + 1
			end

			table.insert(uv1[3], slot2)
		elseif slot7 <= 20 then
			slot2.placeType = slot0.CARD_PLACE_TYPE.ENEMY

			table.insert(uv1[2], slot2)
		elseif slot7 <= 24 then
			slot2.placeType = slot0.CARD_PLACE_TYPE.PLAYER

			table.insert(uv1[1], slot2)
		end
	end

	return slot1
end

function slot0.CheckPlayerCards(slot0, slot1)
	slot2 = true

	for slot7, slot8 in ipairs(uv0[slot1]) do
		if not nil then
			slot3 = slot8.race
		elseif slot3 ~= slot8.race then
			slot2 = false

			break
		end

		slot3 = slot8.race
	end

	if slot2 then
		uv1 = slot0.GAME_STATE.GAMEOVER

		if slot1 == slot0.CARD_PLACE_TYPE.PLAYER then
			uv2 = 1
		elseif slot1 == slot0.CARD_PLACE_TYPE.ENEMY then
			uv2 = -1
		end
	end
end

function slot0.MoveCardToList(slot0, slot1, slot2, slot3)
	slot4 = uv0[slot1]
	slot7 = table.remove(slot4, function (slot0, slot1)
		for slot5, slot6 in ipairs(slot0) do
			if slot6.index == slot1 then
				return slot5
			end
		end

		return nil
	end(slot4, slot3))
	slot7.placeType = slot2

	table.insert(uv0[slot2], slot7)
	slot0:RefreshScore()
end

function slot0.GetRandomCardIndex(slot0)
	slot1 = HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.ENEMY)

	return slot1[math.random(#slot1)].index
end

function slot0.GetNewCombineList(slot0, slot1, slot2, slot3)
	slot4 = {}
	slot5 = {}
	slot6 = {}

	if slot1 == slot0.CARD_PLACE_TYPE.PLAYERCOMBINE then
		slot4 = slot0:GetCardsListByType(slot0.CARD_PLACE_TYPE.PLAYERCOMBINE)
		slot5 = uv0
	elseif slot1 == slot0.CARD_PLACE_TYPE.ENEMYCOMBINE then
		slot4 = slot0:GetCardsListByType(slot0.CARD_PLACE_TYPE.ENEMYCOMBINE)
		slot5 = uv1
	end

	if not slot3 then
		slot4 = deepClone(slot4)
	end

	if table.isEmpty(slot4) then
		return slot6
	end

	for slot10, slot11 in ipairs(slot2) do
		slot16 = uv2[slot11].id

		for slot16, slot17 in ipairs(uv3[slot16]) do
			slot19 = true

			for slot23, slot24 in ipairs(HanafudaCardCombineCfg[slot17].card_list) do
				slot25 = true

				if slot24 ~= slot12.id then
					for slot29, slot30 in ipairs(slot4) do
						if slot30.id == slot24 then
							break
						end

						if slot29 == #slot4 and slot30.id ~= slot24 then
							slot25 = false
							slot19 = false

							break
						end
					end
				end

				if slot25 == false then
					break
				end
			end

			if slot19 then
				table.insert(slot6, slot17)

				if slot3 then
					table.insert(slot5, slot17)
					slot0:RefreshScore()
				end
			end
		end

		if not slot3 then
			table.insert(slot4, slot12)
		end
	end

	return slot6
end

function slot0.RefreshScore(slot0)
	slot2 = slot0:GetCardsListByType(slot0.CARD_PLACE_TYPE.PLAYERCOMBINE)

	for slot6, slot7 in ipairs(uv0) do
		slot1 = 0 + HanafudaCardCombineCfg[slot7].score
	end

	for slot6, slot7 in ipairs(slot2) do
		slot1 = slot1 + slot7.rarity - 1
	end

	uv1 = slot1
	slot6 = slot0.CARD_PLACE_TYPE.ENEMYCOMBINE
	slot2 = slot0:GetCardsListByType(slot6)

	for slot6, slot7 in ipairs(uv2) do
		slot1 = 0 + HanafudaCardCombineCfg[slot7].score
	end

	uv3 = slot1
end

function slot0.GetPlayerCombineIDList(slot0)
	return uv0
end

function slot0.GetIsSuccess(slot0)
	if uv0 == 1 then
		return true
	elseif uv0 == -1 then
		return false
	else
		return uv2 <= uv1
	end
end

function slot0.GetScoreByType(slot0, slot1)
	if slot1 == slot0.CARD_PLACE_TYPE.PLAYER then
		return uv0
	elseif slot0.CARD_PLACE_TYPE.ENEMY then
		return uv1
	end
end

function slot0.GetHasCardByPlaceTypeAndCardId(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot0:GetCardsListByType(slot1)) do
		if slot8.id == slot2 then
			return true
		end
	end

	return false
end

function slot0.StartGame(slot0, slot1)
	uv0 = slot1

	if uv0 == slot0.GAME_STATE.COMPUTER_TURN then
		HanafudaComputer.ComputerPlay()
	end
end

function slot0.GetGameState(slot0)
	return uv0
end

function slot0.NextTurn(slot0)
	if #slot0:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.POOL) == 0 then
		uv0 = slot0.GAME_STATE.GAMEOVER
	elseif uv0 == slot0.GAME_STATE.COMPUTER_TURN then
		uv0 = slot0.GAME_STATE.PLAYER_TURN
	elseif uv0 == slot0.GAME_STATE.PLAYER_TURN then
		uv0 = slot0.GAME_STATE.COMPUTER_TURN

		HanafudaComputer.ComputerPlay()
	end
end

function slot0.ResetGameState(slot0)
	uv0 = slot0.GAME_STATE.STOP
end

function slot0.GetPoolCardIndex(slot0)
	slot1 = slot0:GetCardsListByType(slot0.CARD_PLACE_TYPE.POOL)

	return slot1[#slot1].index
end

return slot0
