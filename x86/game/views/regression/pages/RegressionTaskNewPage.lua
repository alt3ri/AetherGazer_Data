slot1 = class("RegressionTaskNewPage", import("game.views.regression.pages.RegressionTaskPage"))

function slot1.OnCtor(slot0, slot1)
	slot3 = Object.Instantiate(Asset.Load("Widget/System/ReturnTwo/RT2stReturnMissionUI"), slot1)
	slot0.gameObject_ = slot3
	slot0.transform_ = slot3.transform

	slot0:Init()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.scrollView_, RegressionTaskNewItem)
	slot0.allReceiveBtnState_ = ControllerUtil.GetController(slot0.transform_, "allReceive")
end

function slot1.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot1.SetData(slot0, slot1)
	if slot1 == nil then
		return
	end

	slot0.taskType_ = slot1
	slot0._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(slot0.taskType_)
	slot0._finishList = TaskTools:GetFinishTaskIds(slot0.taskType_)
	slot0.maxRewardNum_ = 0

	for slot5, slot6 in ipairs(slot0._taskIDList) do
		if not AssignmentCfg[slot6.id] then
			print(slot7)
		else
			slot0.maxRewardNum_ = slot0.maxRewardNum_ < #AssignmentCfg[slot7].reward and slot8 or slot0.maxRewardNum_
		end
	end

	slot0.scrollHelper_:StartScroll(#slot0._taskIDList)
	slot0:RefreshRecivedAll()
end

function slot1.RefreshRecivedAll(slot0)
	slot0.allReceiveBtnState_:SetSelectedState(#slot0._finishList > 0 and "true" or "false")
end

function slot1.indexItem(slot0, slot1, slot2)
	slot2:ReEnter(slot0._taskIDList[slot1].id, slot0.maxRewardNum_)
end

return slot1
