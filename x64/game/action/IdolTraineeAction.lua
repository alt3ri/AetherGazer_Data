local var_0_0 = {
	ParseBattleHistoryData = function(arg_1_0, arg_1_1)
		if arg_1_1 then
			return {
				battleID = arg_1_1.battle_id,
				friendType = arg_1_1.battle_type,
				startTime = arg_1_1.timestamp,
				is_attacker = arg_1_1.is_attacker,
				battle_result = arg_1_1.battle_result,
				userID = arg_1_1.another_user_id,
				nick = arg_1_1.another_profile_base.nick,
				icon = arg_1_1.another_profile_base.icon,
				icon_frame = arg_1_1.another_profile_base.icon_frame
			}
		end
	end
}

manager.net:Bind(58169, function(arg_2_0)
	IdolTraineeData:InitDataFromServer(arg_2_0)
end)
manager.net:Bind(58189, function(arg_3_0)
	IdolTraineeData:UpdatePveChapterData(arg_3_0)
end)
manager.net:Bind(58191, function(arg_4_0)
	IdolTraineeData:UpdateQuestRankInfo(arg_4_0.get_id_list)
end)

function var_0_0.GetQuestRankReward(arg_5_0, arg_5_1, arg_5_2)
	manager.net:SendWithLoadingNew(58192, {
		id = arg_5_0,
		select_list = arg_5_1
	}, 58193, function(arg_6_0, arg_6_1)
		if isSuccess(arg_6_0.result) then
			IdolTraineeData:UpdateQuestRankInfo(arg_6_0.get_id_list)

			if arg_5_2 then
				arg_5_2()
			end

			getReward(arg_6_0.reward_list)
			manager.notify:CallUpdateFunc(TASK_LIST_CHANGE)
		else
			ShowTips(arg_6_0.result)
		end
	end)
end

function var_0_0.TrainHeroProperty(arg_7_0, arg_7_1)
	manager.net:SendWithLoadingNew(58166, {
		hero_id = arg_7_0,
		attribute_index = arg_7_1
	}, 58167, var_0_0.OnTrainHeroPropertyCallBack)
end

function var_0_0.OnTrainHeroPropertyCallBack(arg_8_0, arg_8_1)
	if isSuccess(arg_8_0.result) then
		local var_8_0 = DormData:GetHeroTemplateInfo(arg_8_1.hero_id).property[arg_8_1.hero_id][arg_8_1.attribute_index]

		IdolTraineeData:UpdateTrainData(arg_8_1, arg_8_0)

		local var_8_1 = DormData:GetHeroTemplateInfo(arg_8_1.hero_id).property[arg_8_1.hero_id][arg_8_1.attribute_index] - var_8_0

		manager.notify:Invoke(IDOL_TRAINEE_TRAIN_HERO_PROPERTY_CALLBACK, arg_8_1.hero_id, arg_8_1.attribute_index, var_8_1)
	else
		ShowTips(arg_8_0.result)
	end
end

function var_0_0.RequestOpponentList(arg_9_0, arg_9_1, arg_9_2)
	manager.net:SendWithLoadingNew(58180, {
		battle_type = arg_9_0
	}, 58181, function(arg_10_0, arg_10_1)
		if isSuccess(arg_10_0.result) then
			if arg_10_1.battle_type == 1 then
				IdolTraineeData:UpdateFriendList(arg_10_0.pvp_fight_list)
			elseif arg_10_1.battle_type == 2 then
				IdolTraineeData:UpdateOpponentList(arg_10_0.pvp_fight_list)
			end

			manager.notify:Invoke(IDOL_TRAINEE_REFRESH_OPPONENT)
		elseif arg_9_2 then
			ShowTips(arg_10_0.result)
		end

		if arg_9_1 then
			arg_9_1()
		end
	end)
end

function var_0_0.RequestSetHeroPos(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0) do
		if iter_11_1.pos > GameSetting.dorm_idol_room_max_place.value[1] or iter_11_1.pos <= 0 then
			Debug.LogError("练舞房传入错误位置")

			if arg_11_1 then
				arg_11_1()
			end

			return
		end
	end

	manager.net:SendWithLoadingNew(58174, {
		hero_pos_list = arg_11_0
	}, 58175, function(arg_12_0, arg_12_1)
		if isSuccess(arg_12_0.result) then
			IdolTraineeData:UpdateHeroPosList(arg_12_1)

			if arg_11_1 then
				arg_11_1()
			end

			manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
		else
			ShowTips(arg_12_0.result)
		end
	end)
end

function var_0_0.RequestSetAttackHero(arg_13_0, arg_13_1)
	manager.net:SendWithLoadingNew(58176, {
		attack_hero_id_list = {
			arg_13_0
		}
	}, 58177, function(arg_14_0, arg_14_1)
		if isSuccess(arg_14_0.result) then
			IdolTraineeData:InitAttackHeroID(arg_14_1)

			if arg_13_1 then
				arg_13_1()
			end
		else
			ShowTips(arg_14_0.result)
		end
	end)
end

function var_0_0.RequestSetDefendHero(arg_15_0, arg_15_1)
	manager.net:SendWithLoadingNew(58178, {
		defend_hero_id_list = {
			arg_15_0
		}
	}, 58179, function(arg_16_0, arg_16_1)
		if isSuccess(arg_16_0.result) then
			IdolTraineeData:InitDefendHeroID(arg_16_1)

			if arg_15_1 then
				arg_15_1()
			end
		else
			ShowTips(arg_16_0.result)
		end
	end)
end

function var_0_0.AskHistoryBattleData(arg_17_0)
	manager.net:SendWithLoadingNew(58182, {}, 58183, function(arg_18_0, arg_18_1)
		if isSuccess(arg_18_0.result) then
			local var_18_0 = {}

			for iter_18_0, iter_18_1 in ipairs(arg_18_0.history_mini_battle_list) do
				local var_18_1 = var_0_0:ParseBattleHistoryData(iter_18_1)

				var_18_0[var_18_1.battleID] = var_18_1
			end

			IdolTraineeData:InitHistoryBattleData(var_18_0)
		end

		if arg_17_0 then
			arg_17_0()
		end
	end)
end

return var_0_0
