slot0 = class("SoloHeartDemonRewardView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Challenge_SoloHeartDemonUI/SoloHeartDemonRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.OnSwitchLeftBtnTypeHandler_ = handler(slot0, slot0.OnSwitchLeftBtnType)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.normalList = LuaList.New(handler(slot0, slot0.SetRewardItem), slot0.list1_, SoloHeartDemonRewardItem)
	slot4 = SoloHeartDemonRewardItem
	slot0.rankList = LuaList.New(handler(slot0, slot0.SetRewardItem), slot0.list2_, slot4)
	slot0.controller = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.leftBtnList_ = {}

	for slot4 = 1, 2 do
		slot0.leftBtnList_[slot4] = StoreBtnView.New(slot0[string.format("leftBtnGo%s_", slot4)], CommonBtnTypeConst.DEMON, slot4)
	end
end

function slot0.SetRewardItem(slot0, slot1, slot2)
	slot2:SetData((slot0.selectIndex == 1 and slot0.normalTaskList or slot0.rankTaskList)[slot1], slot1, slot0.selectIndex)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.allBtn_, nil, function ()
		slot0 = {
			reward_list = {}
		}

		for slot4, slot5 in ipairs(uv0.normalTaskList) do
			slot7 = SoloHeartDemonData:GetDataByPara("taskData")[slot5]

			if SoloHeartDemonData:GetDataByPara("rewardList")[slot5] ~= 1 and slot7[2] <= slot7[1] then
				table.insert(slot0.reward_list, slot5)
			end
		end

		if #slot0.reward_list == 0 then
			return
		end

		SoloHeartDemonAction.GetReward(slot0)
	end)
end

function slot0.UpdateView(slot0)
	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	slot0.normalTaskList = SoloHeartDemonData:GetDataByPara("normalTaskList")
	slot0.rankTaskList = SoloHeartDemonData:GetDataByPara("rankTaskList")

	slot0:UpdateList()

	slot0.remainTime = ActivityData:GetActivityRefreshTime(ActivityConst.SOLO_HEART_DEMON)
	slot0.remainTxt_.text = manager.time:GetLostTimeStr2(slot0.remainTime)
	slot0.updateTimer_ = Timer.New(function ()
		uv0 = uv1.remainTime - manager.time:GetServerTime()
		uv1.remainTxt_.text = manager.time:GetLostTimeStr2(uv1.remainTime)

		if ActivityData:GetActivityIsOpen(uv1.activityId) == false then
			JumpTools.GoToSystem("/soloHeartDemonMain", {
				activityId = uv1.activityId
			})
			uv1:Back()
			ShowTips("SOLO_HEART_DEMON_REFRESH_TIPS")
		end
	end, 1, slot0.remainTime - manager.time:GetServerTime() + 1, 1)

	slot0.updateTimer_:Start()
	SetActive(slot0.rankSelectGo_, slot0.selectIndex == 2)
	SetActive(slot0.normalSelectGo_, slot0.selectIndex == 1)
	slot0.controller:SetSelectedState(slot0:GetControllerState())
	slot0:OnRankUpdate()
	slot0:RefreshLeftBtn()
end

function slot0.GetControllerState(slot0)
	if slot0.selectIndex == 2 then
		return "message"
	else
		return slot0:IsShowAllReceiveBtn() and "receive" or "noReceive"
	end
end

function slot0.UpdateList(slot0)
	SetActive(slot0.list1_, slot0.selectIndex == 1)
	SetActive(slot0.list2_, slot0.selectIndex == 2)
	slot0[slot0.selectIndex == 1 and "normalList" or "rankList"]:StartScroll(#SoloHeartDemonRewardCfg.get_id_list_by_reward_type[2 - slot0.selectIndex])
end

function slot0.IsShowAllReceiveBtn(slot0)
	slot2 = SoloHeartDemonData:GetDataByPara("taskData")

	for slot6, slot7 in ipairs(slot0.normalTaskList) do
		if SoloHeartDemonData:GetDataByPara("rewardList")[slot7] ~= 1 and slot2[slot7][2] <= slot2[slot7][1] then
			return true
		end
	end

	return false
end

function slot0.OnSoloDemonHeartRewardUpdate(slot0, slot1)
	slot0.controller:SetSelectedState(slot0:GetControllerState())
	slot0:UpdateList()
end

function slot0.OnRankUpdate(slot0)
	slot0.rankData = RankData:GetCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON)

	if slot0.selectIndex == 1 or slot0.rankData == nil then
		return
	end
end

function slot0.OnEnter(slot0)
	slot0.selectIndex = slot0.params_.selectIndex or 1
	slot0.activityId = slot0.params_.activityId

	slot0:UpdateView()
	slot0:BindRedPoint()
	manager.notify:RegistListener(COMMON_BTN_TYPE_SWITCH, slot0.OnSwitchLeftBtnTypeHandler_)
end

function slot0.OnSoloDemonHeartUpdate(slot0)
	slot0:UpdateView()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.leftBtnGo1_.transform, RedPointConst.SOLO_HEART_DEMON_REWARD)
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.leftBtnGo1_.transform, RedPointConst.SOLO_HEART_DEMON_REWARD)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(COMMON_BTN_TYPE_SWITCH, slot0.OnSwitchLeftBtnTypeHandler_)
	slot0:UnbindRedPoint()
	manager.windowBar:HideBar()

	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnSoloDemonHeartUpdate(slot0)
	slot0:UpdateView()
end

function slot0.RefreshLeftBtn(slot0)
	for slot4, slot5 in pairs(slot0.leftBtnList_) do
		slot5:RefreshUI(slot0.selectIndex)
	end
end

function slot0.OnSwitchLeftBtnType(slot0, slot1, slot2)
	if slot1 ~= CommonBtnTypeConst.DEMON or slot0.selectIndex == slot2 then
		return
	end

	slot0.selectIndex = slot2

	slot0:UpdateView()
end

function slot0.Dispose(slot0)
	slot0.OnSwitchLeftBtnTypeHandler_ = nil

	for slot4, slot5 in pairs(slot0.leftBtnList_) do
		slot5:Dispose()
	end

	slot0.leftBtnList_ = nil

	if slot0.normalList then
		slot0.normalList:Dispose()

		slot0.normalList = nil
	end

	if slot0.rankList then
		slot0.rankList:Dispose()

		slot0.rankList = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
