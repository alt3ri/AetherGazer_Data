slot0 = class("TaskDailyContentView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.taskType_ = slot2
	slot0.pointType_ = slot3
	slot0.isShow = false

	slot0:InitUI()

	slot0.giftItems_ = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.scrollView_, TaskDailyItemView)
	slot0.receiveBtnController_ = ControllerUtil.GetController(slot0.transform_, "receiveBtn_all")
	slot0.rectTrans = slot0.scrollView_:GetComponent(typeof(RectTransform))
end

function slot0.Init(slot0)
	slot0._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(slot0.taskType_)
	slot0._finishList = TaskTools:GetFinishTaskIds(slot0.taskType_)

	slot0:RefreshActivityPoint()
	slot0:RefreshTimeText()
	slot0:RefreshGiftItems()
	slot0:RefreshRecivedAll()
end

function slot0.RefreshScroll(slot0, slot1)
	slot0:UpdateData()

	if slot1 then
		if slot0.lastPosition_ then
			slot2 = clone(slot0.lastPosition_)
			slot3 = nil

			FrameTimer.New(function ()
				if isNil(uv0.gameObject_) then
					return
				end

				uv0.scrollHelper_:StartScrollWithoutAnimator(#uv0._taskIDList, uv1)
				uv2:Stop()

				uv2 = nil
			end, 1, 1):Start()

			return
		end

		slot0.scrollHelper_:StartScrollWithoutAnimator(#slot0._taskIDList)
	else
		slot0.scrollHelper_:StartScroll(#slot0._taskIDList)
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:ReEnter(slot0._taskIDList[slot1].id)
end

function slot0.Show(slot0, slot1, slot2)
	if slot0.isShow == slot1 then
		return
	end

	slot0.isShow = slot1

	if slot1 then
		if slot2 then
			-- Nothing
		end

		slot0:OnEnter()
	else
		slot0:OnExit(true)
	end
end

function slot0.OnEnter(slot0)
	slot0.isShow = true

	slot0:Init()
	slot0:OnTaskListChange(true)
	SetActive(slot0.gameObject_, true)
end

function slot0.OnExit(slot0, slot1)
	slot0.isShow = false

	if slot0.dailyTimer_ then
		slot0.dailyTimer_:Stop()

		slot0.dailyTimer_ = nil
	end

	if not slot1 then
		slot0.lastPosition_ = slot0.scrollHelper_:GetScrolledPosition()
	end

	SetActive(slot0.gameObject_, false)
end

function slot0.ClearCache(slot0)
	slot0.lastPosition_ = nil
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()

	if slot0.giftItems_ then
		for slot4, slot5 in pairs(slot0.giftItems_) do
			slot5:Dispose()
		end
	end

	if slot0.dailyTimer_ then
		slot0.dailyTimer_:Stop()

		slot0.dailyTimer_ = nil
	end

	slot0.giftItems_ = nil
	slot0.rectTrans = nil

	uv0.super.Dispose(slot0)
end

function slot0.UpdateData(slot0)
	slot0._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(slot0.taskType_)
end

function slot0.OnTaskListChange(slot0, slot1)
	if slot0.isShow then
		slot0._finishList = TaskTools:GetFinishTaskIds(slot0.taskType_)

		slot0:RefreshRecivedAll()

		if not slot1 then
			slot0:RefreshScroll(true)
		else
			slot0:RefreshScroll(false)
		end

		slot0.lastPosition_ = nil
	end
end

function slot0.OnSubActivityPtUpdate(slot0)
	if slot0.isShow then
		for slot4, slot5 in pairs(slot0.giftItems_) do
			slot5:RefreshGift()
		end

		slot0:RefreshActivityPoint()
		slot0:RefreshRecivedAll()
	end
end

function slot0.RefreshActivityPoint(slot0)
	slot0.ptNumberText_.text = ActivityPtData:GetCurrentActivityPt(slot0.pointType_) or 0
	slot0.ptprogressbarImg_.value = Mathf.Clamp(slot1 / ActivityPtCfg[slot0.pointType_].target[#ActivityPtCfg[slot0.pointType_].target], 0, 1)
end

function slot0.RefreshTimeText(slot0)
	slot0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), slot0:GetTimeText(TimeMgr.GetInstance():GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0) - TimeMgr.GetInstance():GetServerTime()))

	if slot0.dailyTimer_ then
		slot0.dailyTimer_:Stop()
	end

	slot0.dailyTimer_ = Timer.New(function ()
		uv0 = uv1 - TimeMgr.GetInstance():GetServerTime()

		if uv0 < 0 then
			uv0 = TimeMgr.GetInstance():GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0) - TimeMgr.GetInstance():GetServerTime()
		end

		uv2.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), uv2:GetTimeText(uv0))
	end, 1, -1)

	slot0.dailyTimer_:Start()
end

function slot0.RefreshGiftItems(slot0)
	for slot4, slot5 in ipairs(ActivityPtCfg[slot0.pointType_].target) do
		if slot0.giftItems_[slot4] then
			slot0.giftItems_[slot4]:SetIndex(slot4)
		else
			slot0.giftItems_[slot4] = TaskDailyGiftItem.New(slot0.ptGiftItem_, slot0.ptGiftParent_, slot4, slot0.pointType_)
		end
	end
end

function slot0.IsGiftCanReceive(slot0)
	for slot5 = 1, #ActivityPtCfg[slot0.pointType_].target do
		if not TaskTools.ActivityPtIsReceived(slot0.pointType_, slot5) and TaskTools.ActivityPtCanReceive(slot0.pointType_, slot5) then
			return true
		end
	end
end

function slot0.RefreshRecivedAll(slot0)
	if #slot0._finishList > 0 or slot0:IsGiftCanReceive() then
		slot0:RefreshOnceState(true)
	else
		slot0:RefreshOnceState(false)
	end
end

function slot0.GetTimeText(slot0, slot1)
	slot3 = math.floor(slot1 / 3600)
	slot4 = math.floor(slot1 / 60 % 60)
	slot5 = math.floor(slot1 % 60)

	if math.ceil(slot1 / 3600 / 24) > 1 then
		return slot2 .. GetTips("DAY")
	end

	if slot5 < 10 then
		slot5 = "0" .. slot5
	end

	if slot4 < 10 then
		slot4 = "0" .. slot4
	end

	if slot3 < 10 then
		slot3 = "0" .. slot3
	end

	return table.concat({
		slot3,
		":",
		slot4,
		":",
		slot5
	})
end

function slot0.RegisterRefreshOnceStateCallback(slot0, slot1)
	slot0.refreshOnceCallback = slot1
end

function slot0.RefreshOnceState(slot0, slot1)
	if slot0.refreshOnceCallback then
		slot0.refreshOnceCallback(slot1)
	end

	if slot1 then
		slot0.rectTrans.offsetMin = Vector2.New(slot0.rectTrans.offsetMin.x, 70)
	else
		slot0.rectTrans.offsetMin = Vector2.New(slot2, 0)
	end
end

function slot0.OnOnceClick(slot0)
	TaskAction:SubmitTaskList(TaskTools:GetFinishTaskIds(slot0.taskType_), slot0.taskType_)
end

return slot0
