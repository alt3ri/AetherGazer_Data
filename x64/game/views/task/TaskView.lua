slot0 = class("TaskView", ReduxView)
slot1 = import("game.const.TaskConst")
slot2 = import("game.tools.TaskTools")

function slot0.UIName(slot0)
	return "Widget/System/Quest/UIQuest"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.taskSwitchView_ = {}
	slot0.taskContentView_ = {}
	slot0.taskSwitchView_[uv0.TASK_TYPE.DAILY] = TaskSwitchView.New(slot0.dailyTask_, uv0.TASK_TYPE.DAILY)
	slot0.taskSwitchView_[uv0.TASK_TYPE.PLOT] = TaskSwitchView.New(slot0.plotTask_, uv0.TASK_TYPE.PLOT)
	slot0.taskSwitchView_[uv0.TASK_TYPE.WEEK] = TaskSwitchView.New(slot0.weekTask_, uv0.TASK_TYPE.WEEK)

	slot0.taskSwitchView_[uv0.TASK_TYPE.DAILY]:SetBtnFunc(handler(slot0, slot0.RefreshSelect))
	slot0.taskSwitchView_[uv0.TASK_TYPE.PLOT]:SetBtnFunc(handler(slot0, slot0.RefreshSelect))
	slot0.taskSwitchView_[uv0.TASK_TYPE.WEEK]:SetBtnFunc(handler(slot0, slot0.RefreshSelect))

	slot0.taskViewObj = {
		[uv0.TASK_TYPE.DAILY] = "Widget/System/Quest/TaskDailyContentView",
		[uv0.TASK_TYPE.WEEK] = "Widget/System/Quest/TaskWeekContentView",
		[uv0.TASK_TYPE.PLOT] = "Widget/System/Quest/TaskPlotContentView"
	}
	slot0.refreshBtnStateHandle = handler(slot0, slot0.RefreshOnceBtnState)

	slot0:AddBtnListener(slot0.exploreBtn_, nil, function ()
		JumpTools.OpenPageByJump("/adminCatExploreView", nil, ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE)
	end)
	slot0:AddBtnListener(slot0.onceBtn_, nil, function ()
		uv0:OnClickOnceBtn()
	end)
end

function slot0.OnTop(slot0)
	slot0:ShowDefaultBar()
	slot0:RefreshSelect(slot0.params_.taskIndex)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot4 = slot0.params_.taskIndex

	slot0:RefreshSelect(slot4)

	for slot4, slot5 in pairs(slot0.taskSwitchView_) do
		slot5:OnEnter()
	end

	slot0:BindRedPoint()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.noticeContainer_, RedPointConst.EXPLORE_MAIN)
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.noticeContainer_, RedPointConst.EXPLORE_MAIN)
end

function slot0.OnMainHomeViewTop(slot0)
	for slot4, slot5 in pairs(slot0.taskContentView_) do
		slot5:ClearCache()
	end
end

function slot0.OnExit(slot0)
	slot0.selectIndex_ = nil

	slot0:RemoveAllEventListener()
	slot0:UnbindRedPoint()

	for slot4, slot5 in pairs(slot0.taskContentView_) do
		slot5:OnExit()
	end

	for slot4, slot5 in pairs(slot0.taskSwitchView_) do
		slot5:OnExit()
	end

	manager.windowBar:HideBar()
	slot0:RecordStay(slot0.params_.taskIndex)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.taskSwitchView_) do
		slot5:Dispose()
	end

	slot0.taskSwitchView_ = nil

	for slot4, slot5 in pairs(slot0.taskContentView_) do
		slot5:Dispose()
	end

	slot0.taskContentView_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnTaskListChange(slot0)
	for slot4, slot5 in pairs(slot0.taskContentView_) do
		if slot5.OnTaskListChange then
			slot5:OnTaskListChange()
		end
	end
end

function slot0.OnActivityPtUpdate(slot0)
	for slot4, slot5 in pairs(slot0.taskContentView_) do
		if slot5.OnSubActivityPtUpdate then
			slot5:OnSubActivityPtUpdate()
		end
	end
end

function slot0.RefreshSelect(slot0, slot1, slot2)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TASK_DAILY) then
		slot1 = uv0.TASK_TYPE.PLOT
	end

	for slot6, slot7 in pairs(slot0.taskSwitchView_) do
		slot7:SwitchButton(slot1)
	end

	if slot0.taskContentView_[slot1] == nil and slot0.taskViewObj[slot1] then
		if slot1 == uv0.TASK_TYPE.DAILY then
			slot0.taskContentView_[slot1] = TaskDailyContentView.New(slot0:InstView(slot1), uv0.TASK_TYPE.DAILY, ActivityPtConst.TASK_DAILY_ACTIVITY_PT)
		elseif slot1 == uv0.TASK_TYPE.PLOT then
			slot0.taskContentView_[slot1] = TaskPlotContentView.New(slot3)
		elseif slot1 == uv0.TASK_TYPE.WEEK then
			slot0.taskContentView_[slot1] = TaskWeekContentView.New(slot3, uv0.TASK_TYPE.WEEK, ActivityPtConst.TASK_WEEK_ACTIVITY_PT)
		end

		slot0.taskContentView_[slot1]:RegisterRefreshOnceStateCallback(slot0.refreshBtnStateHandle)
	end

	if slot0.selectIndex_ == slot1 then
		return
	end

	slot0.selectIndex_ = slot1

	for slot6, slot7 in pairs(slot0.taskContentView_) do
		if slot6 == slot1 then
			slot0.params_.taskIndex = slot1
		else
			slot0:RecordStay(slot6)
		end

		if slot7 then
			slot7:Show(slot6 == slot1, slot2)
		end
	end
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(PLAYER_LEVEL_UP, handler(slot0, slot0.OnLevelUp))
end

function slot0.OnLevelUp(slot0)
	if PlayerData:GetlevelUpInfos() and #slot1 > 0 then
		if not slot0.levelUpTimer_ then
			slot0.levelUpTimer_ = Timer.New(function ()
				PlayerAction.LevelUpFinish()
				uv0:Go("levelUp", {
					levelUpInfoList = uv1
				})

				uv0.levelUpTimer_ = nil
			end, 0.2, 0)
		end

		slot0.levelUpTimer_:Start()
	end
end

function slot0.RecordStay(slot0, slot1)
	if slot0:GetStayTime() == 0 then
		return
	end

	slot3 = 0

	if slot1 == uv0.TASK_TYPE.DAILY then
		slot3 = 10801
	elseif slot1 == uv0.TASK_TYPE.PLOT then
		slot3 = 10802
	end

	OperationRecorder.RecordStayView("STAY_VIEW_TASK", slot2, slot3)
	slot0:UpdateLastOpenTime()
end

function slot0.InstView(slot0, slot1)
	return Object.Instantiate(Asset.Load(slot0.taskViewObj[slot1]), slot0.pageContainer_)
end

function slot0.OnClickOnceBtn(slot0)
	if slot0.taskContentView_[slot0.selectIndex_] then
		slot1:OnOnceClick()
	end
end

function slot0.RefreshOnceBtnState(slot0, slot1)
	SetActive(slot0.btnGroupObj_, slot1)
end

return slot0
