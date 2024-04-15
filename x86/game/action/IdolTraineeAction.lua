manager.net:Bind(58169, function (slot0)
	IdolTraineeData:InitDataFromServer(slot0)
end)
manager.net:Bind(58189, function (slot0)
	IdolTraineeData:UpdatePveChapterData(slot0)
end)
manager.net:Bind(58191, function (slot0)
	IdolTraineeData:UpdateQuestRankInfo(slot0.get_id_list)
end)

return {
	ParseBattleHistoryData = function (slot0, slot1)
		if slot1 then
			return {
				battleID = slot1.battle_id,
				friendType = slot1.battle_type,
				startTime = slot1.timestamp,
				is_attacker = slot1.is_attacker,
				battle_result = slot1.battle_result,
				userID = slot1.another_user_id,
				nick = slot1.another_profile_base.nick,
				icon = slot1.another_profile_base.icon,
				icon_frame = slot1.another_profile_base.icon_frame
			}
		end
	end,
	GetQuestRankReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(58192, {
			id = slot0,
			select_list = slot1
		}, 58193, function (slot0, slot1)
			if isSuccess(slot0.result) then
				IdolTraineeData:UpdateQuestRankInfo(slot0.get_id_list)

				if uv0 then
					uv0()
				end

				getReward(slot0.reward_list)
				manager.notify:CallUpdateFunc(TASK_LIST_CHANGE)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	TrainHeroProperty = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58166, {
			hero_id = slot0,
			attribute_index = slot1
		}, 58167, uv0.OnTrainHeroPropertyCallBack)
	end,
	OnTrainHeroPropertyCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			IdolTraineeData:UpdateTrainData(slot1, slot0)
			manager.notify:Invoke(IDOL_TRAINEE_TRAIN_HERO_PROPERTY_CALLBACK, slot1.hero_id, slot1.attribute_index, DormData:GetHeroTemplateInfo(slot1.hero_id).property[slot1.hero_id][slot1.attribute_index] - DormData:GetHeroTemplateInfo(slot1.hero_id).property[slot1.hero_id][slot1.attribute_index])
		else
			ShowTips(slot0.result)
		end
	end,
	RequestOpponentList = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(58180, {
			battle_type = slot0
		}, 58181, function (slot0, slot1)
			if isSuccess(slot0.result) then
				if slot1.battle_type == 1 then
					IdolTraineeData:UpdateFriendList(slot0.pvp_fight_list)
				elseif slot1.battle_type == 2 then
					IdolTraineeData:UpdateOpponentList(slot0.pvp_fight_list)
				end

				manager.notify:Invoke(IDOL_TRAINEE_REFRESH_OPPONENT)
			elseif uv0 then
				ShowTips(slot0.result)
			end

			if uv1 then
				uv1()
			end
		end)
	end,
	RequestSetHeroPos = function (slot0, slot1)
		for slot5, slot6 in pairs(slot0) do
			if GameSetting.dorm_idol_room_max_place.value[1] < slot6.pos or slot6.pos <= 0 then
				Debug.LogError("练舞房传入错误位置")

				if slot1 then
					slot1()
				end

				return
			end
		end

		manager.net:SendWithLoadingNew(58174, {
			hero_pos_list = slot0
		}, 58175, function (slot0, slot1)
			if isSuccess(slot0.result) then
				IdolTraineeData:UpdateHeroPosList(slot1)

				if uv0 then
					uv0()
				end

				manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	RequestSetAttackHero = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58176, {
			attack_hero_id_list = {
				slot0
			}
		}, 58177, function (slot0, slot1)
			if isSuccess(slot0.result) then
				IdolTraineeData:InitAttackHeroID(slot1)

				if uv0 then
					uv0()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	RequestSetDefendHero = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58178, {
			defend_hero_id_list = {
				slot0
			}
		}, 58179, function (slot0, slot1)
			if isSuccess(slot0.result) then
				IdolTraineeData:InitDefendHeroID(slot1)

				if uv0 then
					uv0()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	AskHistoryBattleData = function (slot0)
		manager.net:SendWithLoadingNew(58182, {}, 58183, function (slot0, slot1)
			if isSuccess(slot0.result) then
				for slot6, slot7 in ipairs(slot0.history_mini_battle_list) do
					slot8 = uv0:ParseBattleHistoryData(slot7)
				end

				IdolTraineeData:InitHistoryBattleData({
					[slot8.battleID] = slot8
				})
			end

			if uv1 then
				uv1()
			end
		end)
	end
}
