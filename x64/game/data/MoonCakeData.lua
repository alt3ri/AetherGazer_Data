require("game.data.MoonCakeDataTemplate")

slot0 = singletonClass("MoonCakeData")

function slot0.Init(slot0)
	slot0.receivedCakeGroupDic_ = {}
	slot0.unlockCakeDic_ = {}
	slot0.recommendDelegateDic_ = {}
	slot0.lastRefreshDelegateTime_ = {}
	slot0.submitedDelegateList_ = {}
	slot0.submitedDelegateDic_ = {}
	slot0.needSortSubmit_ = {}
	slot0.ownDelegateDic_ = {}
	slot0.ownDelegateList_ = {}
	slot0.ownRunningDelegate_ = {}
	slot0.todaySubmitDelegateTimes_ = {}
	slot0.todayDispatchDelegateTimes_ = {}
	slot0.selectedMakeFillingBtn_ = {}
	slot0.selectedMakeCakeBtn_ = {}
	slot0.selectedDelegateDispatchBtn_ = {}
	slot0.partyData_ = {}
	slot0.todayVisitTimes_ = {}
	slot0.todayVisitedDic_ = {}
	slot0.todayVisitRewardTimes_ = {}
	slot0.allPartyDic_ = {}
	slot0.friendPartyList_ = {}
	slot0.recommendPartyList_ = {}
	slot0.refreshRecommendPartyTime_ = {}
	slot0.tempVisitIndexList_ = {}
	slot0.tempPartyDataDic_ = {}
	slot0.lastShareTimestamp_ = 0
end

function slot0.InitCakeData(slot0, slot1)
	slot2 = slot1.activity_id
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in ipairs(slot1.give_list) do
		slot10 = MoonDelegateDataTemplate.New(slot9)
		slot10.isCompleted = true
		slot3[#slot3 + 1] = slot10
		slot4[slot11] = slot4[slot10.uid] or {}
		slot4[slot11][slot10.delegateID] = slot10
	end

	table.sort(slot3, function (slot0, slot1)
		return slot1.timestamp < slot0.timestamp
	end)

	slot0.submitedDelegateList_[slot2] = slot3
	slot0.submitedDelegateDic_[slot2] = slot4
	slot0.needSortSubmit_[slot2] = false
	slot6 = nil

	for slot10, slot11 in ipairs(slot1.entrust_list) do
		slot12 = MoonDelegateDataTemplate.New(slot11)

		if slot12.isCompleted == false or slot12.isReceived == false then
			slot6 = slot12
		end
	end

	slot0.ownDelegateDic_[slot2] = {
		[slot12.delegateID] = slot12
	}
	slot0.ownRunningDelegate_[slot2] = slot6
	slot0.todaySubmitDelegateTimes_[slot2] = slot1.today_present_num
	slot0.todayDispatchDelegateTimes_[slot2] = slot1.today_entrust_num
	slot0.unlockCakeDic_[slot2] = {}

	for slot10, slot11 in ipairs(slot1.moon_cakes_collect_list) do
		slot0.unlockCakeDic_[slot2][slot11] = true
	end

	slot0.receivedCakeGroupDic_[slot2] = {}

	for slot10, slot11 in ipairs(slot1.moon_cakes_collect_reward_list) do
		slot0.receivedCakeGroupDic_[slot2][slot11] = true
	end

	slot0:UpdateSubmitDelegateUserInfo(slot2)
	slot0:UpdateOwnDelegateUserInfo(slot2)
end

function slot0.UpdateSubmitDelegateUserInfo(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0:GetSubmitedDelegateList(slot1)) do
		if slot8.uid ~= "0" then
			slot3[#slot3 + 1] = slot8.uid
		end
	end

	if #slot3 > 0 then
		manager.net:SendWithLoadingNew(32036, {
			user_id_list = slot3
		}, 32037, function (slot0, slot1)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)

				return
			end

			slot2 = {
				[slot7.user_id] = slot7
			}

			for slot6, slot7 in ipairs(slot0.user_brief_list) do
				-- Nothing
			end

			for slot6, slot7 in ipairs(uv0) do
				slot7:UpdateUserInfo(slot2[slot7.uid])
			end
		end)
	end
end

function slot0.UpdateOwnDelegateUserInfo(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in pairs(slot0.ownDelegateDic_[slot1]) do
		if slot8.submiter_uid ~= "0" then
			slot3[#slot3 + 1] = slot8.submiter_uid
		end
	end

	if #slot3 > 0 then
		manager.net:SendWithLoadingNew(32036, {
			user_id_list = slot3
		}, 32037, function (slot0, slot1)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)

				return
			end

			slot2 = {
				[slot7.user_id] = slot7
			}

			for slot6, slot7 in ipairs(slot0.user_brief_list) do
				-- Nothing
			end

			for slot6, slot7 in pairs(uv0) do
				slot7:UpdateUserInfo(slot2[slot7.submiter_uid])
			end
		end)
	end
end

function slot0.UpdateOwnDelegate(slot0, slot1)
	if slot0.ownDelegateDic_[slot1.activity_id][slot1.entrust.entrust_id] then
		slot0.ownDelegateDic_[slot2][slot4]:UpdateData(slot3)
	else
		slot5 = MoonDelegateDataTemplate.New(slot3)
		slot0.ownDelegateDic_[slot2][slot4] = slot5
		slot0.ownRunningDelegate_[slot2] = slot5
	end

	slot5 = {}

	if slot0.ownDelegateDic_[slot2][slot4].submiter_uid ~= "0" then
		slot5[#slot5 + 1] = slot6.submiter_uid
	end

	if #slot5 > 0 then
		manager.net:SendWithLoadingNew(32036, {
			user_id_list = slot5
		}, 32037, function (slot0, slot1)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)

				return
			end

			uv0:UpdateUserInfo(slot0.user_brief_list[1])
		end)
	end
end

function slot0.CancelDelegate(slot0, slot1, slot2)
	if slot0.ownDelegateDic_[slot1][slot2] then
		slot0.ownDelegateDic_[slot1][slot2] = nil

		if slot0.ownRunningDelegate_[slot1].delegateID == slot2 then
			slot0.ownRunningDelegate_[slot1] = nil
		end
	end
end

function slot0.GetOwnSubmitedDelegateList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0.ownDelegateDic_[slot1]) do
		if slot7 ~= slot0.ownRunningDelegate_[slot1] then
			slot2[#slot2 + 1] = slot7
		end
	end

	table.sort(slot2, function (slot0, slot1)
		return slot1.timestamp < slot0.timestamp
	end)

	return slot2
end

function slot0.GetOwnRunningDelegate(slot0, slot1)
	return slot0.ownRunningDelegate_[slot1] or {}
end

function slot0.GetOwnDelegateData(slot0, slot1, slot2)
	return slot0.ownDelegateDic_[slot1][slot2] or {}
end

function slot0.ReceivedDelegateReward(slot0, slot1, slot2)
	slot3 = slot0.ownDelegateDic_[slot1][slot2]
	slot3.isReceived = true

	if slot3.delegateID == slot0.ownRunningDelegate_[slot1].delegateID then
		slot0.ownRunningDelegate_[slot1] = nil
	end

	slot0.todayDispatchDelegateTimes_[slot1] = slot0.todayDispatchDelegateTimes_[slot1] + 1

	slot0:SetUnlockCake(slot1, slot3.targetID)
end

function slot0.SubmitDelegate(slot0, slot1, slot2, slot3)
	slot4 = slot0.recommendDelegateDic_[slot1][slot2][slot3]
	slot4.isCompleted = true

	table.insert(slot0.submitedDelegateList_[slot1], slot4)

	slot0.needSortSubmit_[slot1] = true
	slot0.submitedDelegateDic_[slot1][slot2] = slot0.submitedDelegateDic_[slot1][slot2] or {}
	slot0.submitedDelegateDic_[slot1][slot2][slot3] = true
	slot0.todaySubmitDelegateTimes_[slot1] = slot0.todaySubmitDelegateTimes_[slot1] + 1
end

function slot0.GetSubmitedDelegateList(slot0, slot1)
	if slot0.needSortSubmit_[slot1] then
		slot0.needSortSubmit_[slot1] = false

		table.sort(slot0.submitedDelegateList_[slot1], function (slot0, slot1)
			return slot1.timestamp < slot0.timestamp
		end)
	end

	return slot0.submitedDelegateList_[slot1] or {}
end

function slot0.SetRecommendDelegate(slot0, slot1, slot2)
	slot3 = slot0.recommendDelegateDic_[slot1] or {}
	slot4 = {}

	for slot8, slot9 in ipairs(slot2) do
		slot11 = slot9.entrust_id
		slot4[slot10] = slot4[slot9.user_id] or {}

		if slot3[slot10] and slot3[slot10][slot11] then
			slot4[slot10][slot11] = slot3[slot10][slot11]

			slot4[slot10][slot11]:UpdateData(slot9)
		else
			slot4[slot10][slot11] = MoonDelegateDataTemplate.New(slot9)
		end
	end

	slot0.recommendDelegateDic_[slot1] = slot4

	slot0:UpdateRecommendDelegateUserInfo(slot1)
end

function slot0.UpdateRecommendDelegateUserInfo(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0:GetSortRecommendDelegateList(slot1)) do
		if slot8.uid ~= "0" then
			slot3[#slot3 + 1] = slot8.uid
		end
	end

	if #slot3 > 0 then
		manager.net:SendWithLoadingNew(32036, {
			user_id_list = slot3
		}, 32037, function (slot0, slot1)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)

				return
			end

			slot2 = {
				[slot7.user_id] = slot7
			}

			for slot6, slot7 in ipairs(slot0.user_brief_list) do
				-- Nothing
			end

			for slot6, slot7 in ipairs(uv0) do
				slot7:UpdateUserInfo(slot2[slot7.uid])
			end
		end)
	end
end

function slot0.GetRecommendDelegateDic(slot0, slot1)
	return slot0.recommendDelegateDic_[slot1]
end

function slot0.GetSortRecommendDelegateList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(slot0.recommendDelegateDic_[slot1]) do
		for slot12, slot13 in pairs(slot8) do
			slot2[#slot2 + 1] = slot13
		end
	end

	return slot2
end

function slot0.GetLastRefreshDelegateTime(slot0, slot1)
	return slot0.lastRefreshDelegateTime_[slot1] or 0
end

function slot0.SetLastRefreshDelegateTime(slot0, slot1, slot2)
	slot0.lastRefreshDelegateTime_[slot1] = slot2
end

function slot0.GetReceivedGroupDic(slot0, slot1)
	return slot0.receivedCakeGroupDic_[slot1]
end

function slot0.SetReceivedGroup(slot0, slot1, slot2)
	slot0.receivedCakeGroupDic_[slot1][slot2] = true
end

function slot0.GetUnlockCakeDic(slot0, slot1)
	return slot0.unlockCakeDic_[slot1]
end

function slot0.SetUnlockCake(slot0, slot1, slot2)
	slot0.unlockCakeDic_[slot1][slot2] = true
end

function slot0.GetTodayDisptachTimes(slot0, slot1)
	return slot0.todayDispatchDelegateTimes_[slot1]
end

function slot0.GetTodaySubmitTimes(slot0, slot1)
	return slot0.todaySubmitDelegateTimes_[slot1]
end

function slot0.SetSelectMakeFillingBtn(slot0, slot1)
	if not manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, slot1)) then
		return
	end

	slot0.selectedMakeFillingBtn_[slot1] = true
end

function slot0.GetSelectMakeFillingBtn(slot0, slot1)
	return slot0.selectedMakeFillingBtn_[slot1]
end

function slot0.SetSelectMakeCakeBtn(slot0, slot1)
	if not manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.MOON_CAKE_MAKE, slot1)) then
		return
	end

	slot0.selectedMakeCakeBtn_[slot1] = true
end

function slot0.GetSelectMakeCakeBtn(slot0, slot1)
	return slot0.selectedMakeCakeBtn_[slot1]
end

function slot0.SetSelectDelegateDispatchBtn(slot0, slot1)
	if not manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.MOON_DELEGATE_DISPATCH, slot1)) then
		return
	end

	slot0.selectedDelegateDispatchBtn_[slot1] = true
end

function slot0.GetSelectDelegateDispatchBtn(slot0, slot1)
	return slot0.selectedDelegateDispatchBtn_[slot1]
end

function slot0.InitPartyData(slot0, slot1)
	slot2 = slot1.activity_id
	slot0.todayVisitTimes_[slot2] = slot1.visit_reward_num
	slot0.todayVisitedDic_[slot2] = {}

	for slot6, slot7 in ipairs(slot1.visit_list) do
		slot0.todayVisitedDic_[slot2][slot7] = true
		slot0.todayVisitTimes_[slot2] = slot0.todayVisitTimes_[slot2] + 1
	end

	slot0.todayVisitRewardTimes_[slot2] = slot1.visit_reward_num
	slot0.partyData_[slot2] = MoonPartyDataTemplate.New(slot1.banquet)
	slot5 = {}

	for slot9, slot10 in ipairs(slot1.friend_list) do
		slot5[#slot5 + 1] = MoonPartyUserDataTemplate.New(slot10)
	end

	slot0.allPartyDic_[slot2] = {
		[slot11.uid] = slot11
	}
	slot0.friendPartyList_[slot2] = slot5
	slot0.isRefreshedRecommend_ = slot0.isRefreshedRecommend_ or {}
	slot0.isRefreshedRecommend_[slot2] = false

	slot0:UpdatePartyUserInfo(slot2)
end

function slot0.UpdatePartyUserInfo(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in pairs(slot0.allPartyDic_[slot1]) do
		slot3[#slot3 + 1] = slot8.uid
	end

	if #slot3 > 0 then
		manager.net:SendWithLoadingNew(32036, {
			user_id_list = slot3
		}, 32037, function (slot0, slot1)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)

				return
			end

			slot2 = {
				[slot7.user_id] = slot7
			}

			for slot6, slot7 in ipairs(slot0.user_brief_list) do
				-- Nothing
			end

			for slot6, slot7 in pairs(uv0) do
				slot7:UpdateUserInfo(slot2[slot7.uid])
			end
		end)
	end
end

function slot0.ResetPartyData(slot0, slot1)
	slot2 = slot1.activity_id
	slot0.todayVisitTimes_[slot2] = 0
	slot0.todayVisitRewardTimes_[slot2] = 0

	slot0.partyData_[slot2]:Reset()

	slot0.allPartyDic_[slot2] = {}
	slot0.isRefreshedRecommend_[slot2] = false
	slot0.refreshRecommendPartyTime_[slot2] = 0
end

function slot0.UpdateRecommendParty(slot0, slot1, slot2, slot3)
	slot4 = {}

	for slot8, slot9 in ipairs(slot2) do
		slot11 = nil

		if not slot0.allPartyDic_[slot1][slot9.user_id] then
			slot0.allPartyDic_[slot1][slot10] = MoonPartyUserDataTemplate.New(slot9)
		else
			slot0.allPartyDic_[slot1][slot10]:UpdateData(slot9)
		end

		slot4[#slot4 + 1] = slot11
	end

	slot0.recommendPartyList_[slot1] = slot4
	slot0.refreshRecommendPartyTime_[slot1] = slot3 + 1
	slot0.isRefreshedRecommend_[slot1] = true

	slot0:UpdatePartyUserInfo(slot1)
end

function slot0.OpenParty(slot0, slot1, slot2)
	slot0.partyData_[slot1].partyType = slot2
	slot0.partyData_[slot1].isOpened = true
	slot0.partyData_[slot1].visitNum = 0
	slot0.partyData_[slot1].closeTime = manager.time:GetNextFreshTime()
end

function slot0.GetOwnPartyData(slot0, slot1)
	return slot0.partyData_[slot1]
end

function slot0.GetSortedFriendPartyList(slot0, slot1)
	return slot0.friendPartyList_[slot1] or {}
end

function slot0.GetSortedRecommendPartyList(slot0, slot1)
	return slot0.recommendPartyList_[slot1] or {}
end

function slot0.GetRefreshRecommendPartyTime(slot0, slot1)
	return slot0.refreshRecommendPartyTime_[slot1] or 0
end

function slot0.SaveVisitPartyData(slot0, slot1, slot2, slot3)
	slot0.tempPartyDataDic_[slot1] = MoonPartyDataTemplate.New(slot2)

	if not slot0.todayVisitedDic_[slot1][slot3] then
		slot0.todayVisitedDic_[slot1][slot3] = true

		if not slot0:GetVisitPartyOwnerData(slot1, slot3).isVisited then
			slot0.todayVisitTimes_[slot1] = slot0.todayVisitTimes_[slot1] + 1
		end
	end
end

function slot0.GetVisitPartyData(slot0, slot1)
	return slot0.tempPartyDataDic_[slot1] or {}
end

function slot0.SaveVisitPartyOwnerData(slot0, slot1, slot2)
	slot4 = nil

	if slot0.allPartyDic_[slot1][slot2.user_id] then
		slot0.allPartyDic_[slot1][slot3]:UpdateData(slot2)
	else
		slot0.allPartyDic_[slot1][slot3] = MoonPartyUserDataTemplate.New(slot2)
	end

	slot0.tempVisitIndexList_[slot1] = nil

	manager.net:SendWithLoadingNew(32036, {
		user_id_list = {
			slot4.uid
		}
	}, 32037, function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)

			return
		end

		uv0:UpdateUserInfo(slot0.user_brief_list[1])
	end)
end

function slot0.GetVisitPartyOwnerData(slot0, slot1, slot2)
	return slot0.allPartyDic_[slot1][slot2]
end

function slot0.SetTempVisitIndex(slot0, slot1, slot2, slot3)
	slot0.tempVisitIndexList_[slot1] = slot0.tempVisitIndexList_[slot1] or {}
	slot0.tempVisitIndexList_[slot1].type = slot2
	slot0.tempVisitIndexList_[slot1].index = slot3
	slot4 = {}

	if slot2 == MoonCakeConst.VISIT_TYPE.ALL then
		slot4 = MoonCakeData:GetSortedRecommendPartyList(slot1)
	elseif slot2 == MoonCakeConst.VISIT_TYPE.FRIEND then
		slot4 = MoonCakeData:GetSortedFriendPartyList(slot1)
	end
end

function slot0.GetTempVisitIndex(slot0, slot1)
	return slot0.tempVisitIndexList_[slot1]
end

function slot0.ReceivedVisitReward(slot0, slot1, slot2)
	slot0:GetVisitPartyOwnerData(slot1, slot2).isVisited = true
	slot0.todayVisitRewardTimes_[slot1] = slot0.todayVisitRewardTimes_[slot1] + 1
end

function slot0.GetTodayVisitTimes(slot0, slot1)
	return slot0.todayVisitTimes_[slot1] or 0
end

function slot0.GetTodayVisitRewardTimes(slot0, slot1)
	return slot0.todayVisitRewardTimes_[slot1] or 0
end

function slot0.IsRefreshedRecommend(slot0, slot1)
	return slot0.isRefreshedRecommend_[slot1]
end

function slot0.SetLastShareTimestamp(slot0)
	slot0.lastShareTimestamp_ = manager.time:GetServerTime() + 1
end

function slot0.GetLastShareTimestamp(slot0)
	return slot0.lastShareTimestamp_ or 0
end

return slot0
