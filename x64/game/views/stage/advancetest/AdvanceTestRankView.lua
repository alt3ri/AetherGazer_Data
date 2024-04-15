slot0 = class("AdvanceTestRankView", ReduxView)

function slot0.UIName(slot0)
	return "UI/AdvancetestingUI/AtestingRankUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.rankTypeConst_ = AdvanceTestData:GetRankTypeConst()

	slot0:InitUI()

	slot0.subTypeToggleController_ = slot0.conExCollection_:GetController("subType")
	slot0.tabController_ = slot0.toggleConEx:GetController("tab")
	slot0.tabNumController_ = slot0.toggleConEx:GetController("num")
	slot0.itemGo_ = {
		slot0.m_easyBtn.gameObject,
		slot0.m_nomalBtn.gameObject,
		slot0.m_hardBtn.gameObject
	}
	slot0.clickIndex_ = {}

	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.RefreshUIHandler_ = handler(slot0, slot0.Refresh)
	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, AdvanceTestRankItem)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_allBtn, nil, function ()
		if AdvanceTestData:GetCurRankType() ~= uv0.rankTypeConst_.ALL then
			RankAction.QueryActivityRank(uv0.activityID, uv0.stageType)
		end

		AdvanceTestData:SetCurRankType(uv0.rankTypeConst_.ALL)
		uv0:Refresh()
	end)
	slot0:AddBtnListener(slot0.m_guildBtn, nil, function ()
		if AdvanceTestData:GetCurRankType() ~= uv0.rankTypeConst_.GUILD then
			RankAction.QueryGuildActivityRank(uv0.activityID, uv0.stageType)
		end

		AdvanceTestData:SetCurRankType(uv0.rankTypeConst_.GUILD)
	end)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		JumpTools.OpenPageByJump("advanceTestReward", {
			activityID = uv0.activityID
		})
	end)
	slot0:AddBtnListener(slot0.m_easyBtn, nil, function ()
		uv0:OnClickSubType(1)
	end)
	slot0:AddBtnListener(slot0.m_nomalBtn, nil, function ()
		uv0:OnClickSubType(2)
	end)
	slot0:AddBtnListener(slot0.m_hardBtn, nil, function ()
		uv0:OnClickSubType(3)
	end)
end

function slot0.OnClickSubType(slot0, slot1)
	if slot0.index ~= slot0.clickIndex_[slot1] then
		if AdvanceTestData:GetCurRankType() == slot0.rankTypeConst_.ALL then
			RankAction.QueryActivityRank(slot0.activityID, slot1)
		elseif slot2 == slot0.rankTypeConst_.GUILD then
			RankAction.QueryGuildActivityRank(slot0.activityID, slot1)
		end
	end

	slot0.index = slot3
	slot0.stageType = slot1

	slot0:Refresh()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.activityID = slot0.params_.activityID
	slot1 = ActivityData:GetActivityData(slot0.activityID)
	slot0.startTime_ = slot1.startTime
	slot0.stopTime_ = slot1.stopTime
	slot2 = AdvanceTestCfg.get_id_list_by_activity_id[AdvanceTestData:GetMainActivityID()]

	for slot6 = 1, 3 do
		SetActive(slot0.itemGo_[slot6], false)
	end

	for slot6 = 1, 3 do
		if slot2[slot6] then
			slot7 = AdvanceTestCfg[slot2[slot6]]

			SetActive(slot0.itemGo_[slot7.stage_type], true)

			slot0.clickIndex_[slot7.stage_type] = slot6
		end
	end

	slot0.stageType = slot0.params_.stageType
	slot0.index = slot0.clickIndex_[slot0.params_.stageType]

	manager.notify:RegistListener(ADVANCE_TEST_RANK_UPGRADE, slot0.RefreshUIHandler_)
	RankAction.QueryActivityRank(slot0.activityID, slot0.stageType)
	slot0:RefreshGuildRankGo()
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	slot0.pos_ = slot0.list_:GetScrolledPosition()

	slot0:StopTimer()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(ADVANCE_TEST_RANK_UPGRADE, slot0.RefreshUIHandler_)
	AdvanceTestData:SetCurRankType(slot0.rankTypeConst_.ALL)
end

function slot0.Refresh(slot0)
	if AdvanceTestData:GetCurRankType() == slot0.rankTypeConst_.ALL then
		slot0.rankList = RankData:GetActivityRank(slot0.activityID, slot0.stageType) and slot2.rankList or {}

		if slot2 then
			slot0.m_rank.text, slot0.m_score.text = slot2:GetCurRankDes()
		else
			slot0.m_rank.text = ""
			slot0.m_score.text = ""
		end

		SetActive(slot0.m_rewardBtn, true)
		slot0.tabController_:SetSelectedState("all")
	else
		slot0.rankList = RankData:GetGuildActivityRank(slot0.activityID, slot0.stageType) and slot2.rankList or {}

		if slot2 then
			slot0.m_rank.text, slot0.m_score.text = slot2:GetCurRankDes()
		else
			slot0.m_rank.text = ""
			slot0.m_score.text = ""
		end

		SetActive(slot0.m_rewardBtn, false)
		slot0.tabController_:SetSelectedState("club")
	end

	slot0.list_:StartScroll(#slot0.rankList)

	if slot0.pos_ then
		slot0.list_:SetScrolledPosition(slot0.pos_)
	end

	slot0.m_icon.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo() and slot2.portrait)
	slot0.m_frame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot2.icon_frame)

	slot0.subTypeToggleController_:SetSelectedState(slot0.stageType)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.rankList[slot1])
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.m_leftTimeText.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(slot0.stopTime_, nil, true)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ < manager.time:GetServerTime() then
			return
		end

		uv0.m_leftTimeText.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(uv0.stopTime_, nil, true)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshGuildRankGo(slot0)
	if GuildData:GetGuildInfo().id == nil then
		slot0.tabNumController_:SetSelectedState("01")
	else
		slot0.tabNumController_:SetSelectedState("02")
	end
end

function slot0.OnRankUpdate(slot0)
	slot0:Refresh()
end

return slot0
