slot0 = class("ActivityAttributeArenaView", ReduxView)

function slot0.UIName(slot0)
	return AttributeArenaTools.GetMainUIName(slot0.params_.activityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, ActivityAttributeArenaItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_rewardBtn, function ()
		JumpTools.OpenPageByJump("activityAttributeArenaReward", {
			task_activity_id = uv0.task_activity_id
		})
	end)
	slot0:AddBtnListener(nil, slot0.m_desBtn, function ()
		slot0 = "ACTIVITY_ATTRIBUTE_GAME_TIP"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(slot0),
			key = slot0
		})
	end)
	slot0:AddBtnListener(nil, slot0.m_roundBtn, function ()
		JumpTools.OpenPageByJump("activityAttributeArenaRound", {
			activityID = uv0.activity_id
		})
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.activity_id = slot0.params_.activityID

	ActivityAttributeArenaAction.SetRead(slot0.activity_id)

	slot0.task_activity_id = 0
	slot0.rank_activity_id = 0

	for slot5, slot6 in ipairs(ActivityCfg[slot0.activity_id].sub_activity_list) do
		if ActivityCfg[slot6].activity_template == ActivityTemplateConst.TASK then
			slot0.task_activity_id = slot6
		elseif slot7.activity_template == ActivityTemplateConst.ACTIVITY_ATTRIBUTE_ARENA_RANK then
			slot0.rank_activity_id = slot6
		end
	end

	slot0:RefreshUI()
	slot0:RefreshTime()

	slot0.timer = Timer.New(function ()
		uv0:RefreshTime()
	end, 1, -1)

	slot0.timer:Start()
	slot0:QueryRankData(1)
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_TASK, slot0.activity_id))
end

function slot0.QueryRankData(slot0, slot1)
	if slot0.rank_activity_id == 0 then
		return
	end

	if slot1 > 3 then
		return
	end

	RankAction.QueryActivityRank(slot0.rank_activity_id, slot1, function ()
		uv0:QueryRankData(uv1 + 1)
	end, 1)
end

function slot0.RefreshUI(slot0)
	slot0.arena_list_data = ActivityAttributeArenaData:GetArenaList(slot0.activity_id)

	slot0.list:StartScroll(#slot0.arena_list_data)
end

function slot0.RefreshTime(slot0)
	slot0.m_timeLab.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(slot0.activity_id).stopTime, nil, true)
	slot0.m_refreshTimeLab.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityRefreshTime(slot0.activity_id), nil, true)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()
	end

	slot0.timer = nil

	manager.redPoint:unbindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_TASK, slot0.activity_id))
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.arena_list_data[slot1], slot0.activity_id, slot0.rank_activity_id)
end

function slot0.OnActivityAttributeArenaUpdate(slot0)
	slot0:RefreshUI()
	slot0:QueryRankData(1)
end

function slot0.OnActivityAttributeArenaReset(slot0)
	slot0:RefreshUI()
end

function slot0.OnRankUpdate(slot0)
	slot0.list:Refresh()
end

return slot0
