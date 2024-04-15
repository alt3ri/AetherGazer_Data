slot0 = class("IdolTraineeQuestView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeQuestPopup"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rankItems = {}
	slot0.questData_ = {}
	slot0.questUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.questList_, IdolTraineeQuestItem)
	slot0.rankBtnList_ = {
		slot0.rank1Btn_,
		slot0.rank2Btn_,
		slot0.rank3Btn_,
		slot0.rank4Btn_
	}
	slot0.rankRewardItem_ = CommonItemView.New(slot0.rankItemGo_, true)
	slot0.clearController_ = slot0.mainControllerEx_:GetController("clear")
	slot0.rankStateController_ = slot0.mainControllerEx_:GetController("rankState")
	slot0.rankSelectController_ = slot0.mainControllerEx_:GetController("rankSelect")
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot0.questData_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)

	slot4 = nil

	slot0:AddBtnListener(slot0.receiveBtn_, slot4, function ()
		slot0 = {}

		for slot4, slot5 in pairs(uv0.questData_) do
			if AssignmentCfg[slot5].need <= TaskData2:GetTaskProgress(slot5) and not TaskData2:GetTaskComplete(slot5) then
				table.insert(slot0, slot5)
			end
		end

		TaskAction:SubmitTaskList(slot0)
	end)

	for slot4 = 1, 4 do
		slot0:AddBtnListener(slot0.rankBtnList_[slot4], nil, function ()
			uv0:SelectRank(uv1)
		end)
	end
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	slot0:RefreshRankState()
end

function slot0.UpdateView(slot0)
	slot0.questData_ = TaskTools:GetIdolTraineeTaskSortList()

	slot0.questUIList_:StartScroll(#slot0.questData_)
	slot0.clearController_:SetSelectedState("false")

	for slot4, slot5 in pairs(slot0.questData_) do
		if AssignmentCfg[slot5].need <= TaskData2:GetTaskProgress(slot5) and not TaskData2:GetTaskComplete(slot5) then
			slot0.clearController_:SetSelectedState("true")
		end
	end
end

function slot0.RefreshRankState(slot0)
	slot1, slot2, slot3 = IdolTraineeTools:GetCurQuestRankInfo()

	slot0.rankStateController_:SetSelectedState(slot1)

	slot0.progressSlr_.value = slot3 <= slot2 and 1 or slot2 / slot3
	slot0.progressText_.text = slot2 .. "/" .. slot3

	slot0:SelectRank(slot1)

	if slot3 <= slot2 then
		if IdolTraineeRewardRankCfg[slot1].type == 1 then
			IdolTraineeAction.GetQuestRankReward(slot1, {})
		elseif slot4.type == 2 then
			JumpTools.OpenPageByJump("/idolTraineeQuestRankSelect", {
				rank = slot1
			})
		end
	end
end

function slot0.SelectRank(slot0, slot1)
	slot3 = IdolTraineeRewardRankCfg[slot1]

	slot0.rankSelectController_:SetSelectedState(slot1)

	slot4 = clone(ItemTemplateData)
	slot4.id = slot3.icon
	slot4.number = slot3.num
	slot4.clickFun = handler(slot0, slot0.OnClickCommonItem)

	slot0.rankRewardItem_:SetData(slot4)
	slot0.rankRewardItem_:RefreshCompleted(slot1 < IdolTraineeTools:GetCurQuestRankInfo())
end

function slot0.OnClickCommonItem(slot0, slot1)
	ShowPopItem(POP_ITEM, {
		slot1.id,
		slot1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function slot0.OnTaskListChange(slot0)
	slot0:UpdateView()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.questUIList_ then
		slot0.questUIList_:Dispose()

		slot0.questUIList_ = nil
	end

	if slot0.rankRewardItem_ then
		slot0.rankRewardItem_:Dispose()

		slot0.rankRewardItem_ = nil
	end
end

return slot0
