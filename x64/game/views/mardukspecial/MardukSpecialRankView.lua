slot0 = class("MardukSpecialRankView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/special/MardukSpecialTaskUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.activityOpenHandler_ = handler(slot0, slot0.ActivityOpen)
	slot0.tree_ = LuaTree.New(slot0.treeGo_)
	slot8 = slot0.GroupRenderer

	slot0.tree_:SetRenderer(handler(slot0, slot8))

	slot2 = ActivityCfg[slot0.params_.activityID].sub_activity_list
	slot0.resultActivityIds_ = {}
	slot0.activityIds_ = slot2
	slot4 = {}

	for slot8, slot9 in ipairs(slot2) do
		if ActivityCfg[slot9].sub_activity_list ~= nil and #slot10.sub_activity_list > 0 then
			table.insert(slot3, slot9)
			table.insert(slot4, ActivityQuickTrainingCfg[slot9].stage_id)
		end
	end

	slot5 = UITreeData.New()
	slot0.activityIds_ = slot3
	slot0.battleIds_ = slot4

	for slot9 = 1, #slot3 do
		slot10 = slot3[slot9]
		slot11 = ActivityCfg[slot10]
		slot13 = UITreeGroupData.New()
		slot13.id = slot10
		slot13.text = GetI18NText(BattleQuickTrainingCfg[slot4[slot9]].name)

		slot5.groupDatas:Add(slot13)
	end

	slot0.tree_:SetData(slot5)
	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect))

	slot0.rankContentView_ = MardukSpecialRankContentView.New(slot0.rankContentGo_)
end

function slot0.GroupRenderer(slot0, slot1, slot2)
	if ActivityData:GetActivityIsOpen(slot1) then
		ControllerUtil.GetController(slot2.transform, "lock"):SetSelectedState("false")
	else
		slot3:SetSelectedState("true")
	end
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	if not ActivityData:GetActivityIsOpen(slot0.activityIds_[slot1]) then
		if ActivityData:GetActivityData(slot5).stopTime < manager.time:GetServerTime() then
			ShowTips(GetTips("TIME_OVER"))
		else
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(slot5).startTime)))
		end

		slot0.tree_:SelectGroup(slot0.curIndex_)

		return
	end

	slot0.curIndex_ = slot1
	slot7 = slot0.activityIds_[slot1]

	slot0.rankContentView_:SetMySelfData(slot0.battleIds_[slot1])
	slot0:GetRankData(slot1)
end

function slot0.GetRankData(slot0, slot1, slot2)
	RankAction.QueryActivityRank(ActivityCfg[slot0.activityIds_[slot1]].sub_activity_list[1])
end

function slot0.UpdateGroupView(slot0, slot1)
	slot0.rankContentView_:SetData(slot0.battleIds_[slot1], ActivityCfg[slot0.activityIds_[slot1]].sub_activity_list[1])
end

function slot0.AddEventListeners(slot0)
	manager.notify:RegistListener(ACTIVITY_UPDATE, slot0.activityOpenHandler_)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	slot0:ShowDefaultBar()
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot1 = 1

	for slot5 = 1, #slot0.resultActivityIds_ do
		if slot0.resultActivityIds_[slot5] == slot0.params_.subActivityId then
			slot1 = slot5
		end
	end

	slot2 = slot0.activityIds_[slot1]

	slot0.rankContentView_:SetMySelfData(slot0.battleIds_[slot1])
	slot0:GetRankData(slot1)
	slot0.tree_:SelectGroup(slot1)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.notify:RemoveListener(ACTIVITY_UPDATE, slot0.activityOpenHandler_)
	manager.windowBar:HideBar()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.ActivityOpen(slot0, slot1)
	if table.indexof(slot0.activityIds_, slot1) then
		slot0.tree_:Refresh()
	end
end

function slot0.Dispose(slot0)
	if slot0.tree_ then
		slot0.tree_:Dispose()

		slot0.tree_ = nil
	end

	if slot0.rankContentView_ then
		slot0.rankContentView_:Dispose()

		slot0.rankContentView_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnRankUpdate(slot0)
	slot0:UpdateGroupView(slot0.curIndex_)
end

return slot0
