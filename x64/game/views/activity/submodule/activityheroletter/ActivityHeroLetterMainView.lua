slot0 = class("ActivityHeroLetterMainView", ReduxView)

function slot0.UIName(slot0)
	return ActivityHeroLetterTools.GetMainUIName(slot0.params_.activityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardCon_ = slot0.conCollecter_:GetController("reward")
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ActivityHeroLetterItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.list_[slot1])
	slot0:RefreshRewardType()
	slot0:RefreshItemTime()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.playBackBtn_, nil, function ()
		uv0:GotoView()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	slot0:BindRedPointUI()
	slot0:CheckEnter()
	slot0:RefreshUI()
end

function slot0.CheckEnter(slot0)
	if not getData("activityHeroLetter", "enter_" .. slot0.activityID_) or slot1 == 0 then
		slot0:GotoView()
		saveData("activityHeroLetter", "enter_" .. slot0.activityID_, 1)
	end
end

function slot0.RefreshUI(slot0)
	slot0:RefreshData()
	slot0:RefreshTime()
	slot0:RefreshList()
end

function slot0.RefreshData(slot0)
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
end

function slot0.RefreshTime(slot0)
	slot0:StopTimer()

	slot0.timeLable_.text = manager.time:GetLostTimeStr2(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		uv0.timeLable_.text = manager.time:GetLostTimeStr2(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshList(slot0)
	slot0.list_ = ActivityHeroTaskCfg.get_id_list_by_main_activity_id[slot0.activityID_]

	if slot0.params_.isEnter then
		slot0.scrollHelper_:StartScroll(#slot0.list_)

		slot0.params_.isEnter = false
	else
		slot0.scrollHelper_:Refresh()
	end

	slot0:StopItemTimer()
	slot0:RefreshItemTime()

	slot0.itemTimer_ = Timer.New(function ()
		uv0:RefreshItemTime()
	end, 1, -1)

	slot0.itemTimer_:Start()
end

function slot0.StopItemTimer(slot0)
	if slot0.itemTimer_ then
		slot0.itemTimer_:Stop()

		slot0.itemTimer_ = nil
	end
end

function slot0.RefreshItemTime(slot0)
	slot4 = slot0.scrollHelper_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		slot6:RefreshTime(manager.time:GetServerTime())
	end
end

function slot0.GotoView(slot0)
	JumpTools.OpenPageByJump("activityHeroLetterPlayBack", {
		activityID = slot0.activityID_
	})
end

function slot0.RefreshRewardType(slot0)
	slot1 = slot0.scrollHelper_:GetItemList() or {}

	if not slot1[#slot1] then
		return
	end

	for slot8 = table.indexof(slot0.list_, slot2.id_) + 1, #slot0.list_ do
		slot9 = ActivityHeroTaskCfg[slot0.list_[slot8]].task_id

		if ActivityData:GetActivityData(ActivityHeroTaskCfg[slot0.list_[slot8]].activity_id):IsActivitying() and (TaskData2:GetTask(slot9) and slot11.complete_flag == 0 and AssignmentCfg[slot9].need <= slot11.progress) then
			slot0.rewardCon_:SetSelectedState("on")

			return
		end
	end

	slot0.rewardCon_:SetSelectedState("off")
end

function slot0.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.playBackBtn_.transform, RedPointConst.ACTIVITY_HERO_LETTER_REPORT .. "_" .. slot0.activityID_)
end

function slot0.UnbindRedPointUI(slot0)
	manager.redPoint:unbindUIandKey(slot0.playBackBtn_.transform, RedPointConst.ACTIVITY_HERO_LETTER_REPORT .. "_" .. slot0.activityID_)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopTimer()
	slot0:StopItemTimer()
	slot0:UnbindRedPointUI()
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:Dispose()
	end

	slot0.scrollHelper_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
