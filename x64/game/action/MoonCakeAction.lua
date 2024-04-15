slot1 = false

manager.net:Bind(72001, function (slot0)
	if not uv0.inited then
		MoonCakeTools.InitConst()
		uv0.InitRedPoint()

		uv0.inited = true
	end

	MoonCakeData:InitCakeData(slot0)

	slot1 = slot0.activity_id

	uv0.UpdateFillingMakeRedPoint(slot1)
	uv0.UpdateCakeMakeRedPoint(slot1)
	uv0.UpdateCakeCollectTaskPoint(slot1)
	uv0.UpdateDelegateDispatchPoint(slot1)
	uv0.UpdateDelegateRewardPoint(slot1)
end)
manager.net:Bind(72013, function (slot0)
	MoonCakeData:UpdateOwnDelegate(slot0)
	uv0.UpdateDelegateRewardPoint(slot0.activity_id)
	manager.notify:Invoke(MOON_DELEGATE_UPDATE)
end)
manager.net:Bind(72101, function (slot0)
	if not uv0.inited then
		MoonCakeTools.InitConst()
		uv0.InitRedPoint()

		uv0.inited = true
	end

	MoonCakeData:InitPartyData(slot0)

	slot1 = slot0.activity_id

	uv0.UpdatePartyOpenPoint(slot1)
	uv0.UpdatePartyRewardPoint(slot1)
	manager.notify:CallUpdateFunc(MOON_PARTY_RESET)
end)
manager.net:Bind(72111, function (slot0)
	MoonCakeData:ResetPartyData(slot0)

	slot1 = slot0.activity_id

	uv0.UpdatePartyOpenPoint(slot1)
	uv0.UpdatePartyRewardPoint(slot1)
end)

return {
	MakeFilling = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(72002, {
			activity_id = slot0,
			patties_id = slot1,
			num = slot2
		}, 72003, function (slot0)
			if isSuccess(slot0.result) then
				getReward2(slot0.item_list)
				uv0.UpdateFillingMakeRedPoint(uv1)
				uv0.UpdateCakeMakeRedPoint(uv1)
				manager.notify:CallUpdateFunc(MOON_FILLING_MADE)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	MoonCakeMakeResult = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(72004, {
			activity_id = slot0,
			moon_cakes_id = slot1,
			qte = slot2 == true and 1 or 0
		}, 72005, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 == true then
					MoonCakeData:SetUnlockCake(uv1, uv2)
				end

				uv3.UpdateCakeMakeRedPoint(uv1)
				uv3.UpdateCakeCollectTaskPoint(uv1)
				manager.notify:CallUpdateFunc(MOON_CAKE_MAKE_RESULT, slot0.item_id)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	RefreshRecommendDelegate = function (slot0, slot1)
		manager.net:SendWithLoadingNew(72020, {
			activity_id = slot0
		}, 72021, function (slot0)
			if isSuccess(slot0.result) then
				MoonCakeData:SetRecommendDelegate(uv0, slot0.recommend_list)
				manager.notify:Invoke(MOON_RECOMMEND_DELEGATE_UPDATE)

				if uv1 then
					uv1()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	QueryRecommendDelegate = function (slot0, slot1)
		manager.net:SendWithLoadingNew(72014, {
			activity_id = slot0
		}, 72015, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("MID_AUTUMN_FESTIVAL_TASK_REFRESH_SUCCESS")
				MoonCakeData:SetLastRefreshDelegateTime(uv0, slot0.timestamp)
				MoonCakeData:SetRecommendDelegate(uv0, slot0.recommend_list)

				if uv1 then
					uv1()
				end

				manager.notify:Invoke(MOON_RECOMMEND_DELEGATE_UPDATE)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	SubmitDelegate = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(72010, {
			activity_id = slot0,
			receive_id = slot1,
			entrust_id = slot2
		}, 72011, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("MID_AUTUMN_FESTIVAL_TASK_GIFT_SUCCESS")
				MoonCakeData:SubmitDelegate(uv0, uv1, uv2)

				if uv3 then
					uv3()
				end

				manager.notify:Invoke(MOON_DELEGATE_SUBMIT)
			else
				ShowTips(slot0.result)

				if slot0.result == 24201 then
					uv4.RefreshRecommendDelegate(uv0)
				end
			end
		end)
	end,
	DispatchDelegate = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(72008, {
			activity_id = slot0,
			moon_cakes_id = slot1
		}, 72009, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("MID_AUTUMN_FESTIVAL_TASK_PUBLISH_TASK")

				if uv0 then
					uv0()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	CancelDelegate = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(72016, {
			activity_id = slot0,
			entrust_id = slot1
		}, 72017, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("MID_AUTUMN_FESTIVAL_TASK_CANCEL_TASK")
				MoonCakeData:CancelDelegate(uv0, uv1)
				uv2.UpdateDelegateDispatchPoint(uv0)

				if uv3 then
					uv3()
				end
			else
				ShowTips(slot0.result)
			end

			manager.notify:Invoke(MOON_DELEGATE_CALCEL)
		end)
	end,
	ReceiveDelegateReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(72018, {
			activity_id = slot0,
			entrust_id = slot1
		}, 72019, function (slot0)
			if isSuccess(slot0.result) then
				MoonCakeData:ReceivedDelegateReward(uv0, uv1)
				getReward2(slot0.item_list)
				uv2.UpdateDelegateRewardPoint(uv0)
				uv2.UpdateDelegateDispatchPoint(uv0)
				uv2.UpdateCakeCollectTaskPoint(uv0)
				manager.notify:Invoke(MOON_DELEGATE_REWARD_RECEIVE)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ReceiveCakeCollectReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(72006, {
			activity_id = slot0,
			group_id = slot1
		}, 72007, function (slot0)
			if isSuccess(slot0.result) then
				MoonCakeData:SetReceivedGroup(uv0, uv1)
				getReward2(slot0.item_list)
				uv2.UpdateCakeCollectTaskPoint(uv0)
				manager.notify:CallUpdateFunc(MOON_CAKE_COLLECT_RECEIVE)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	OpenParty = function (slot0, slot1)
		manager.net:SendWithLoadingNew(72102, {
			open_type = slot1,
			activity_id = slot0
		}, 72103, function (slot0)
			if isSuccess(slot0.result) then
				MoonCakeData:OpenParty(uv0, uv1)
				uv2.UpdatePartyOpenPoint(uv0)
				manager.notify:CallUpdateFunc(MOON_PARTY_OPEN)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	TryQueryRecommendParty = function (slot0)
		if not MoonCakeData:IsRefreshedRecommend(slot0) then
			uv0.RefreshRecommendParty(slot0, function ()
				JumpTools.OpenPageByJump("moonPartyVisit", {
					activityID = uv0
				})
			end)
		else
			JumpTools.OpenPageByJump("moonPartyVisit", {
				activityID = slot0
			})
		end
	end,
	RefreshRecommendParty = function (slot0, slot1)
		manager.net:SendWithLoadingNew(72104, {
			activity_id = slot0
		}, 72105, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("MID_AUTUMN_FESTIVAL_TASK_REFRESH_SUCCESS")
				MoonCakeData:UpdateRecommendParty(uv0, slot0.recommend_list, slot0.timestamp)
				manager.notify:CallUpdateFunc(MOOD_PARTY_RECOMMEND_UPDATE)

				if uv1 then
					uv1()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	RequirePartyOwnerData = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(72112, {
			activity_id = slot0,
			user_id = slot1
		}, 72113, function (slot0)
			if isSuccess(slot0.result) then
				MoonCakeData:SaveVisitPartyOwnerData(uv0, slot0.user_info)

				if uv1 then
					uv1()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	VisitParty = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(72106, {
			user_id = slot1,
			activity_id = slot0
		}, 72107, function (slot0)
			if isSuccess(slot0.result) then
				MoonCakeData:SaveVisitPartyData(uv0, slot0.banquet, uv1)
				JumpTools.OpenPageByJump("/moonCakeParty", {
					activityID = uv0,
					mainActivityID = MoonCakeTools.GetMainActivityID(uv0),
					partyOwnerUID = uv1,
					visitWay = uv2
				})
				uv3.UpdatePartyOpenPoint(uv0)
				SDKTools.SendMessageToSDK("activity_mid_autumn_phase2_party_visit", {
					activity_id = uv0,
					host_player_uid = uv1,
					way = uv2
				})
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	VisitNextParty = function (slot0)
		slot1 = MoonCakeData:GetTempVisitIndex(slot0)
		slot3 = slot1.index
		slot4 = {}

		if slot1.type == MoonCakeConst.VISIT_TYPE.ALL then
			slot4 = MoonCakeData:GetSortedRecommendPartyList(slot0)
		elseif slot2 == MoonCakeConst.VISIT_TYPE.FRIEND then
			slot4 = MoonCakeData:GetSortedFriendPartyList(slot0)
		end

		if slot3 + 1 > #slot4 then
			return
		end

		visitData = slot4[slot5]

		MoonCakeData:SetTempVisitIndex(slot0, slot2, slot5)
		uv0.VisitParty(slot0, visitData.uid, MoonCakeConst.VISIT_WAY.NEXT_BTN)
	end,
	ReceiveVisitReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(72108, {
			user_id = slot1,
			activity_id = slot0
		}, 72109, function (slot0)
			if isSuccess(slot0.result) then
				MoonCakeData:ReceivedVisitReward(uv0, uv1)
				getReward2(slot0.item_list)
				uv2.UpdatePartyRewardPoint(uv0)
				manager.notify:CallUpdateFunc(MOON_PARTY_VISIT_REWARD_RECEIVED)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	OnOpenGift = function (slot0, slot1)
		if not ActivityData:GetActivityIsOpen(slot0) then
			return
		end

		if ActivityData:GetActivityIsOpen(slot0) then
			for slot6, slot7 in ipairs(slot1) do
				if ItemCfg[slot7.id].sub_type == ItemConst.ITEM_SUB_TYPE.MOON_CAKE and MoonCakeTools.GetCakeIdDicByCakeItemID()[slot7.id] ~= nil then
					MoonCakeData:SetUnlockCake(slot0, slot8)
				end
			end

			MoonCakeAction.UpdateFillingMakeRedPoint(slot0)
			MoonCakeAction.UpdateCakeCollectTaskPoint(slot0)
		end
	end,
	InitRedPoint = function ()
		for slot4, slot5 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.MOON_CAKE]) do
			slot6, slot7 = nil

			for slot12, slot13 in ipairs(ActivityCfg[slot5].sub_activity_list) do
				slot14 = {}

				for slot19, slot20 in ipairs(ActivityCfg[slot13].sub_activity_list) do
					if ActivityCfg[slot20].activity_template == ActivityTemplateConst.TASK then
						slot14[#slot14 + 1] = string.format("%s_%d", RedPointConst.ACTIVITY_TASK, slot20)
					end
				end

				manager.redPoint:addGroup(string.format("%s_%d", RedPointConst.ACTIVITY_TASK, slot13), slot14)

				if ActivityCfg[slot13].activity_template == ActivityTemplateConst.MOON_CAKE_MAKE then
					slot17 = string.format("%s_%s", RedPointConst.MOON_DELEGATE, slot13)

					manager.redPoint:addGroup(slot17, {
						string.format("%s_%s", RedPointConst.MOON_DELEGATE_DISPATCH, slot13),
						string.format("%s_%s", RedPointConst.MOON_DELEGATE_REWARD, slot13)
					})
					manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.MOON_CAKE_STAGE, slot13), {
						string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, slot13),
						string.format("%s_%s", RedPointConst.MOON_CAKE_MAKE, slot13),
						slot17,
						slot16,
						string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, slot13)
					})
				elseif ActivityCfg[slot13].activity_template == ActivityTemplateConst.MOON_CAKE_PARTY then
					manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.MOON_PARTY_STAGE, slot13), {
						string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, slot13),
						string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, slot13),
						slot16,
						string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.ACTIVITY_2_4_MOONBO)
					})
				end
			end

			manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.MOON_CAKE, slot5), {
				slot6,
				slot7
			})
		end
	end,
	UpdateFillingMakeRedPoint = function (slot0)
		slot1 = MoonCakeFillingCfg.get_id_list_by_activity[slot0]

		if not MoonCakeData:GetSelectMakeFillingBtn(slot0) then
			for slot6, slot7 in ipairs(slot1) do
				slot10 = true

				for slot14, slot15 in ipairs(MoonCakeFillingCfg[slot7].recipe) do
					if ItemTools.getItemNum(slot15[1]) < slot15[2] then
						slot10 = false

						break
					end
				end

				if slot10 == true then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, slot0), 1)

					return
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, slot0), 0)
	end,
	UpdateCakeMakeRedPoint = function (slot0)
		slot1 = MoonCakeCfg.get_id_list_by_activity[slot0]
		slot2 = 0

		if not MoonCakeData:GetSelectMakeCakeBtn(slot0) then
			for slot7, slot8 in ipairs(slot1) do
				if ItemTools.getItemNum(MoonCakeFillingCfg[MoonCakeCfg[slot8].patties].patties) > 0 then
					slot2 = 1

					break
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_CAKE_MAKE, slot0), slot2)
	end,
	UpdateCakeCollectTaskPoint = function (slot0)
		slot2 = MoonCakeData:GetUnlockCakeDic(slot0)
		slot3 = MoonCakeData:GetReceivedGroupDic(slot0)
		slot4 = 0

		for slot8, slot9 in ipairs(MoonCakeGroupCfg.get_id_list_by_activity[slot0]) do
			slot12 = true

			for slot16, slot17 in ipairs(MoonCakeGroupCfg[slot9].collect_condition) do
				if not slot2[slot17] then
					slot12 = false

					break
				end
			end

			if slot12 and not slot3[slot9] then
				slot4 = 1

				break
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, slot0), slot4)
	end,
	UpdateDelegateDispatchPoint = function (slot0)
		slot1 = 0

		if not MoonCakeData:GetSelectDelegateDispatchBtn(slot0) and MoonCakeData:GetTodayDisptachTimes(slot0) < GameSetting.activity_mid_autumn_entrust_release_limit.value[1] and MoonCakeData:GetOwnRunningDelegate(slot0).delegateID == nil then
			slot1 = 1
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_DELEGATE_DISPATCH, slot0), slot1)
	end,
	UpdateDelegateRewardPoint = function (slot0)
		slot2 = 0

		if MoonCakeData:GetOwnRunningDelegate(slot0).delegateID ~= nil and slot1.isCompleted == true and slot1.isReceived == false then
			slot2 = 1
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_DELEGATE_REWARD, slot0), slot2)
	end,
	CloseCakeStageRedPoint = function (slot0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, slot0), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_CAKE_MAKE, slot0), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, slot0), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_DELEGATE_DISPATCH, slot0), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_DELEGATE_REWARD, slot0), 0)
		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.ACTIVITY_TASK, slot0), 0)
	end,
	UpdatePartyOpenPoint = function (slot0)
		slot1 = 0

		if not MoonCakeData:GetOwnPartyData(slot0).isOpened then
			slot3, slot4, slot5 = MoonCakeTools.CheckPartyPlanValid(slot0, MoonCakeConst.PARTY_TYPE.CAKE)

			if slot3 then
				slot1 = 1
			else
				slot6, slot7, slot8 = MoonCakeTools.CheckPartyPlanValid(slot0, MoonCakeConst.PARTY_TYPE.VISIT)

				if slot6 then
					slot1 = 1
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, slot0), slot1)
	end,
	UpdatePartyRewardPoint = function (slot0)
		slot1 = 0

		if not MoonCakeData:GetTodayVisitRewardTimes(slot0) or slot2 < GameSetting.activity_mid_autumn_present_limit.value[1] then
			slot1 = 1
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, slot0), slot1)
	end,
	ClosePartytageRedPoint = function (slot0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, slot0), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, slot0), 0)
		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.ACTIVITY_TASK, slot0), 0)
	end
}
