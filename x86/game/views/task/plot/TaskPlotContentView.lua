slot0 = class("TaskPlotContentView", ReduxView)
slot1 = import("game.const.TaskConst")
slot2 = import("game.tools.TaskTools")
slot3 = import("game.const.ActivityPtConst")

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.isShow = false

	slot0:InitUI()

	slot0.systemItemList_ = {}
end

function slot0.Init(slot0)
	slot0._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(uv0.TASK_TYPE.PLOT)
	slot0._finishList = uv1:GetFinishTaskIds(uv0.TASK_TYPE.PLOT)

	slot0:RefreshAllFinish()
	slot0:RefreshRecivedAll()
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()

	if slot0.systemItemList_ then
		for slot4, slot5 in pairs(slot0.systemItemList_) do
			slot5:Dispose()
		end

		slot0.systemItemList_ = nil
	end

	slot0.phaseView_:Dispose()

	slot0.rectTrans = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.scrollView_, TaskPlotItemView)
	slot0.phaseView_ = TaskPlotPhaseView.New(slot0.goPhase_)
	slot0.rectTrans = slot0.scrollView_:GetComponent(typeof(RectTransform))
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

function slot0.OnEnter(slot0)
	slot0.isShow = true

	slot0:Init()
	slot0:OnTaskListChange(true)
	SetActive(slot0.gameObject_, true)
	slot0.phaseView_:RefreshUI()
end

function slot0.OnExit(slot0, slot1)
	slot0.isShow = false

	if slot0.systemItemList_ then
		for slot5, slot6 in pairs(slot0.systemItemList_) do
			slot6:Dispose()

			slot0.systemItemList_[slot5] = nil
		end
	end

	SetActive(slot0.gameObject_, false)

	if not slot1 then
		slot0.lastPosition_ = slot0.scrollHelper_:GetScrolledPosition()
	end
end

function slot0.ClearCache(slot0)
	slot0.lastPosition_ = nil
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

function slot0.UpdateData(slot0)
	slot0._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(uv0.TASK_TYPE.PLOT)
end

function slot0.OnTaskListChange(slot0, slot1)
	if slot0.isShow then
		slot0._finishList = uv0:GetFinishTaskIds(uv1.TASK_TYPE.PLOT)

		slot0:RefreshRecivedAll()
		slot0.phaseView_:RefreshUI()

		if not slot1 then
			slot0:RefreshScroll(true)
		else
			slot0:RefreshScroll(false)
		end

		slot0.lastPosition_ = nil
	end
end

function slot0.RefreshAllFinish(slot0)
end

function slot0.RefreshRecivedAll(slot0)
	if #slot0._finishList > 0 then
		slot0:RefreshOnceState(true)
	else
		slot0:RefreshOnceState(false)
	end
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
	TaskAction:SubmitTaskList(uv0:GetFinishTaskIds(uv1.TASK_TYPE.PLOT), uv1.TASK_TYPE.PLOT)
end

return slot0
