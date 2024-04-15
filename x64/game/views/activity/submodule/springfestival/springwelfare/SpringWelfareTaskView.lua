slot0 = class("SpringWelfareTaskView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeWishUIRewardsPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.taskList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.taskListGo_, SpringWelfareTaskItem)
	slot0.dailyRewardCon_ = ControllerUtil.GetController(slot0.ptTaskRect_, "state")
	slot0.allReceiveController_ = ControllerUtil.GetController(slot0.transform_, "clear")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.allReceiveBtn_, nil, function ()
		uv0:OnClickAllReceiveBtn()
	end)
	slot0:AddBtnListener(slot0.receiveDailyBtn_, nil, function ()
		uv0:OnClickReceiveDailyBtn()
	end)
	slot0:AddBtnListener(slot0.dailyPreviewBtn_, nil, function ()
		uv0:OnClickDailyBtn()
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:RefreshUI()
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.OnTop(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.OnBehind(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Dispose(slot0)
	slot0.taskList_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnClickAllReceiveBtn(slot0)
	if not TaskTools:GetCanGetActivityTaskList(slot0:GetActivityID()) or #slot1 <= 0 then
		return
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, slot7.id)
	end

	slot0:SubmitTaskList(slot2)
end

function slot0.OnClickReceiveDailyBtn(slot0)
	SpringWelfareAction:AcquireDailyPointReward(SpringWelfareData:GetTodayPtCfg().id, function ()
		uv0:RefreshDailyTaskUI()
		SpringWelfareAction:UpdateRedPoint(uv0:GetActivityID())
	end)
end

function slot0.OnClickDailyBtn(slot0)
	if #SpringWelfareData:GetTodayPtCfg().reward_item_list > 1 then
		JumpTools.OpenPageByJump("rewardPreview", {
			rewardList = slot2
		}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
	else
		ShowPopItem(POP_ITEM, slot2[1])
	end
end

function slot0.RefreshUI(slot0)
	slot0:RefreshTimeUI()
	slot0:RefreshTaskUI()
	slot0:RefreshDailyTaskUI()
end

function slot0.RefreshTimeUI(slot0)
	slot0.timeText_.text = manager.time:GetLostTimeStr2(manager.time:GetNextFreshTime())
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.sortedTaskIDList_[slot1].id, slot0:GetActivityID())
	slot2:SetClickHandler(function (slot0, slot1)
		uv0:SubmitTaskList({
			slot1
		})
	end)
end

function slot0.RefreshTaskUI(slot0)
	slot1 = TaskData2:GetActivityTaskSortList(slot0:GetActivityID())
	slot0.sortedTaskIDList_ = slot1

	slot0.taskList_:StartScroll(#slot1)
	slot0.allReceiveController_:SetSelectedState(SpringWelfareData:HasTaskCanAcquire() and "true" or "false")
end

function slot0.RefreshDailyTaskUI(slot0)
	slot1 = SpringWelfareData:GetTodayPtCfg()
	slot5 = slot1.reward_item_list[1]
	slot0.ptNeedIcon_.sprite = ItemTools.getItemSprite(SpringWelfareData:GetPtItemId())
	slot0.ptTaskRewardIcon_.sprite = ItemTools.getItemSprite(slot5[1])
	slot0.ptTaskRewardText_.text = string.format("x%d", slot5[2])
	slot0.ptNeedText_.text = string.format("%d/%d", SpringWelfareData:GetTodayPtProgress(), slot1.need)
	slot0.ptTaskTitleText_.text = GetTips("SPRING_BLESSING_TASK_ITEM_TITLE")
	slot0.ptTaskDescText_.text = GetTips("SPRING_BLESSING_TASK_ITEM_DESC")

	if SpringWelfareData:IsTodayPtAcquired() then
		slot0.dailyRewardCon_:SetSelectedState("received")
	else
		slot0.dailyRewardCon_:SetSelectedState(SpringWelfareData:IsTodayPtCanAcquire() and "complete" or "unfinish")
	end
end

function slot0.SubmitTaskList(slot0, slot1)
	slot0.curSubmitIdList_ = slot1

	TaskAction:SubmitTaskList(slot1)
end

function slot0.OnTaskListChange(slot0)
	slot0.curSubmitIdList_ = {}
	slot2 = 0

	for slot6, slot7 in ipairs(slot0.curSubmitIdList_ or {}) do
		slot8 = AssignmentCfg[slot7]

		if TaskData2:GetTask(slot7).complete_flag >= 1 then
			for slot14, slot15 in ipairs(slot8.reward) do
				if slot15[1] == 53089 then
					slot2 = slot2 + slot15[2]
				end
			end
		end
	end

	SpringWelfareData:AddTodayPtProgress(slot2)
	slot0:RefreshUI()
	slot0.taskList_:Refresh()
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		uv0:RefreshTimeUI()
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.GetActivityID(slot0)
	return SpringWelfareData:GetActivityId()
end

return slot0
