slot0 = class("XH3rdFlipCardRewardView", ReduxView)

function slot0.UIName(slot0)
	return XH3rdFlipCardTool:GetRewardUI()
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, XH3rdFlipCardRewardItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityId = slot0.params_.activityId

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshScroll()
end

function slot0.RefreshScroll(slot0)
	slot0.rewardList = {}

	for slot5, slot6 in pairs(TaskData2:GetActivityTaskSortList(slot0.activityId)) do
		table.insert(slot0.rewardList, slot6.id)
	end

	table.sort(slot0.rewardList, function (slot0, slot1)
		slot3 = TaskData2:GetTask(slot1)
		slot4 = AssignmentCfg[slot0].need <= TaskData2:GetTask(slot0).progress
		slot5 = AssignmentCfg[slot1].need <= slot3.progress

		if slot2.complete_flag ~= slot3.complete_flag then
			return slot2.complete_flag < slot3.complete_flag
		elseif slot4 ~= slot5 then
			return slot4 and not slot5
		else
			return slot0 < slot1
		end
	end)
	slot0.scrollHelper_:StartScroll(#slot0.rewardList)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.rewardList[slot1])
	slot2:SetReveivedHandler(handler(slot0, slot0.RefreshScroll))
end

function slot0.Dispose(slot0)
	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()

		slot0.scrollHelper_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
