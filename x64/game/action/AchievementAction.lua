manager.net:Bind(53001, function (slot0)
	AchievementData:UpdateAchievementList(slot0.achievement_list, true)
	AchievementData:InitAchievementStoryReadList(slot0.story_line)
end)
manager.net:Bind(53003, function (slot0)
	AchievementData:UpdateAchievementList(slot0.achievement_progress, false)
end)

slot1, slot2, slot3, slot4 = nil
slot5 = {}

manager.net:Bind(12089, function (slot0)
	uv0 = slot0.is_first_draw
	uv1 = slot0.is_first_draw_limited
	uv2 = slot0.is_first_draw_lucky
	uv3 = slot0.total_buy_fatigue_times
end)

return {
	GetReceiveReward = function (slot0, slot1)
		slot2 = AchievementData:GetCurrentPoint()

		manager.net:SendWithLoadingNew(53004, {
			id = {
				slot0
			}
		}, 53005, function (slot0, slot1)
			uv0.OnGetReceiveReward(slot0, slot1, uv1)
		end)
	end,
	OnGetReceiveReward = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			AchievementData:ChangedAchievementState(slot1.id[1], -1)

			slot3 = false
			slot4 = AchievementData:GetCurrentLevelPoint()
			slot5 = {}

			for slot9, slot10 in ipairs(slot0.reward_list) do
				table.insert(slot5, {
					id = slot10.id,
					num = slot10.num
				})
			end

			for slot9, slot10 in ipairs(slot5) do
				if slot10.id == CurrencyConst.CURRENCY_TYPE_ACHIEVEMENT_POINT and slot2 < slot4 and slot4 <= slot2 + slot10.num then
					slot3 = true
				end
			end

			getReward(slot5, nil, function ()
				if uv0 then
					JumpTools.OpenPageByJump("achievementUpgrade", {
						currentPoint = uv1,
						upgradePoint = uv2
					})
				end
			end, true)

			return
		end

		ShowTips(slot0.result)
	end,
	TryToSubmitAchievementList = function (slot0)
		slot2 = AchievementData:GetCurrentPoint()

		manager.net:SendWithLoadingNew(53004, {
			id = AchievementData:GetReadyAchievementList(slot0)
		}, 53005, function (slot0, slot1)
			uv0.OnTryToSubmitAchievementList(slot0, slot1, uv1)
		end)
	end,
	OnTryToSubmitAchievementList = function (slot0, slot1, slot2)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)

			return
		end

		slot3 = {}

		for slot7, slot8 in ipairs(slot1.id) do
			table.insert(slot3, slot8)
		end

		for slot7, slot8 in ipairs(slot3) do
			AchievementData:ChangedAchievementState(slot8, -1)
		end

		slot4 = {}
		slot5 = false
		slot6 = AchievementData:GetCurrentLevelPoint()

		for slot10, slot11 in ipairs(mergeReward(slot0.reward_list)) do
			if slot11.id == CurrencyConst.CURRENCY_TYPE_ACHIEVEMENT_POINT and slot2 < slot6 and slot6 <= slot2 + slot11.num then
				slot5 = true
			end
		end

		getReward(slot4, nil, function ()
			if uv0 then
				JumpTools.OpenPageByJump("achievementUpgrade", {
					currentPoint = uv1,
					upgradePoint = uv2
				})
			end
		end, true)
	end,
	ReadAchievementStory = function (slot0, slot1)
		manager.net:SendWithLoadingNew(53006, {
			id = slot0
		}, 53007, function (slot0)
			AchievementData:UpdateStoryRead(uv0)
			uv1(slot0)
		end)
	end,
	GetFirstDraw = function ()
		return uv0
	end,
	GetFirstDrawLimited = function ()
		return uv0
	end,
	GetFirstDrawLucky = function ()
		return uv0
	end,
	GetBuyFatigue = function ()
		return uv0
	end,
	SetFirstDraw = function (slot0)
		uv0 = slot0
	end,
	SetFirstDrawLimited = function (slot0)
		uv0 = slot0
	end,
	SetFirstDrawLucky = function (slot0)
		uv0 = slot0
	end,
	AddBuyFatigue = function (slot0)
		uv0 = uv0 + slot0
	end,
	SendMessageForDrawAction = function (slot0, slot1)
		if uv0 == 1 then
			uv0 = 0

			SendMessageManagerToSDK("gacha_complete")
		end

		if uv1 == 1 and DrawPoolCfg[slot1.pool].pool_type == 3 then
			uv1 = 0
		end

		slot2 = false

		for slot7, slot8 in ipairs(slot0.item) do
			if ItemCfg[slot8.id].rare == 5 then
				slot2 = true

				SendMessageManagerToSDK("roll_complete_140", {
					poolID = slot1.pool
				})
			end
		end

		if slot2 and uv2 == 1 and DrawPoolCfg[slot1.pool].pool_type == 5 then
			uv2 = 0

			SendMessageManagerToSDK("roll_complete_40")
		end
	end
}
