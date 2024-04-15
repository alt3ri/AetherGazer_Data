slot0 = class("PushSnowBallTeamTaskPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballQuestPopUI"
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

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.taskList_, PushSnowBallTeamTaskItem)
	slot0.rewardController_ = ControllerUtil.GetController(slot0.transform_, "clear")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		slot0 = {}

		for slot4, slot5 in ipairs(uv0.taskDataList_) do
			if AssignmentCfg[slot5.id].need <= slot5.progress and not (slot5.complete_flag >= 1) then
				slot0[#slot0 + 1] = slot5.id
			end
		end

		TaskAction:SubmitTaskList(slot0)
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.OnTaskListChange(slot0)
	slot0:RefreshUI()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.taskDataList_[slot1])
end

function slot0.RefreshUI(slot0)
	slot0.taskDataList_ = PushSnowBallData:GetTeamParticipateTaskList()

	slot0.uiList_:StartScroll(#slot0.taskDataList_)
	slot0.rewardController_:SetSelectedState(tostring(PushSnowBallData:GetHasCompeletedTeamTask()))
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
