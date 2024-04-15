manager.net:Bind(44007, function (slot0)
	MythicData:InitMythicData(slot0)
	manager.notify:CallUpdateFunc(MYTHIC_UPDATE)
end)
manager.net:Bind(44039, function (slot0)
	MythicData:SetCurPoint(slot0.score)
end)
manager.net:Bind(44019, function (slot0)
	MythicData:InitMythicUserPublicData(slot0)
	MythicAction:UpdateMythicRedTip()
	MythicAction:UpdateMythicFinalRedPoint()
	manager.notify:CallUpdateFunc(MYTHIC_UPDATE)
end)
manager.net:Bind(44009, function (slot0)
	MythicData:InitMythicUserData(slot0)
	MythicAction:UpdateMythicRedTip()
	MythicAction:UpdateMythicFinalRedPoint()
end)
manager.net:Bind(44021, function (slot0)
	MythicData:InitFinalMythicData(slot0)
end)
manager.net:Bind(44023, function (slot0)
	MythicData:InitFinalMythicUserData(slot0)
	MythicAction.UpdateMythicFinalRedPoint()
	manager.notify:CallUpdateFunc(MYTHIC_FINAL_UPDATE)
end)

return {
	QueryMythicInfo = function (slot0)
		manager.net:SendWithLoading(44010, {}, 44011):next(function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("HAZARD_ZONE_REFRESH")
				MythicData:SetIsNew(true)
			else
				print("QueryMythicInfo error")
			end
		end)
	end,
	QueryMythicRead = function (slot0)
		MythicData:SetIsNewDifficulty(false)
		manager.net:SendWithLoading(44014, {}, 44015):next(function (slot0)
			if isSuccess(slot0.result) then
				-- Nothing
			end
		end)
	end,
	QueryMythicFinalRead = function (slot0)
		MythicData:SetIsNewHotLevel(false)
		manager.net:SendWithLoading(44032, {}, 44033):next(function (slot0)
			if isSuccess(slot0.result) then
				-- Nothing
			end
		end)
	end,
	QueryMythicStar = function (slot0)
		manager.net:SendWithLoadingNew(44012, {
			star = slot0
		}, 44013, uv0.MythicStarBack)
	end,
	MythicStarBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = slot1.star

			if MythicCfg[MythicData:GetDifficulty()].difficulty == 1 then
				slot4 = {}

				for slot8, slot9 in ipairs(slot0.item_list) do
					table.insert(slot4, {
						id = slot9.id,
						num = slot9.num
					})
				end

				sortMergeGetReward(slot4)
				MythicData:SetStarRewardState(slot2)
				MythicAction:UpdateMythicRedTip()
				manager.notify:CallUpdateFunc(MYTHIC_STAR_REWARD_UPDATE)
			end
		else
			ShowTips(slot0.result)
		end
	end,
	QueryChangeDifficulty = function (slot0)
		manager.net:SendWithLoadingNew(44016, {
			difficulty = slot0
		}, 44017, uv0.OnQueryChangeDifficulyuBack)
	end,
	OnQueryChangeDifficulyuBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			MythicData:SetDifficulty(slot1.difficulty)

			if slot1.difficulty == MythicData:GetFinalId() then
				gameContext:Go("/mythicUltimateView", nil, true)
				uv0.UpdateMythicFinalRedPoint()
			else
				gameContext:Go("/mythic", nil, true)
				uv0.UpdateMythicRedTip()
			end
		else
			ShowTips(slot0.result)
		end
	end,
	UpdateMythicRedTip = function (slot0)
		if MythicData:GetDifficulty() ~= MythicData:GetFinalId() then
			if MythicData:GetDifficulty() and slot1 ~= 0 then
				for slot6 = 1, MythicData:GetStarCount() do
					if not MythicData:GetStarRewardState(slot6) then
						manager.redPoint:setTip(RedPointConst.MYTHIC_TIMES_AWARD, 1)

						return
					end
				end
			end

			manager.redPoint:setTip(RedPointConst.MYTHIC_TIMES_AWARD, 0)
		end
	end,
	UpdateMythicFinalRedPoint = function ()
		if MythicData:GetFinalRewardNotGet() then
			manager.redPoint:setTip(RedPointConst.MYTHIC_FINAL_AWARD, 1)
		else
			manager.redPoint:setTip(RedPointConst.MYTHIC_FINAL_AWARD, 0)
		end
	end,
	GetFinalReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(44028, {
			difficulty_id = slot1
		}, 44029, function (slot0, slot1)
			if isSuccess(slot0.result) then
				slot2 = {}

				for slot6, slot7 in ipairs(slot0.item_list) do
					table.insert(slot2, {
						id = slot7.id,
						num = slot7.num
					})
				end

				sortMergeGetReward(slot2)
				MythicData:GetFinalReward(slot1.difficulty_id)
				MythicAction.UpdateMythicFinalRedPoint()
				manager.notify:CallUpdateFunc(MYTHIC_FINAL_GETREWARD)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	GetAllFinalReward = function (slot0)
		manager.net:SendWithLoadingNew(44030, {}, 44031, function (slot0, slot1)
			if isSuccess(slot0.result) then
				slot2 = {}

				for slot6, slot7 in ipairs(slot0.item_list) do
					table.insert(slot2, {
						id = slot7.id,
						num = slot7.num
					})
				end

				sortMergeGetReward(slot2)
				MythicData:GetAllFinalReward()
				MythicAction.UpdateMythicFinalRedPoint()
				manager.notify:CallUpdateFunc(MYTHIC_FINAL_GETREWARD)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	QuitBattle = function ()
		manager.net:SendWithLoadingNew(44026, {}, 44027, function (slot0)
			if isSuccess(slot0.result) then
				MythicData:ClearBattleData()
				manager.notify:CallUpdateFunc(MYTHIC_FINAL_QUITBATTLE)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	SelectLevel = function (slot0, slot1)
		manager.net:SendWithLoadingNew(44024, {
			difficulty_id = slot1
		}, 44025, function (slot0, slot1)
			if isSuccess(slot0.result) then
				MythicData:SetCurHotLevelId(slot1.difficulty_id)
				manager.notify:CallUpdateFunc(MYTHIC_FINAL_HOTITEM_CLICK)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ReSetTeam = function (slot0)
		manager.net:SendWithLoadingNew(44026, {}, 44027, function (slot0)
			if isSuccess(slot0.result) then
				MythicData:ClearBattleData()
				ReserveTools.ResetContData(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI)

				if uv0 then
					uv0()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end
}
