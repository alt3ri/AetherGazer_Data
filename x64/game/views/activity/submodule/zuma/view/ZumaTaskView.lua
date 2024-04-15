slot0 = class("ZumaTalentView", ReduxView)
slot1 = {
	showState = {
		showOneClick = "showOneClick",
		name = "clear",
		normal = "normal"
	}
}

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaQuestPopup"
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

	slot0.showStateController = slot0.controllerexcollection_:GetController(uv0.showState.name)
	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiList_, ZumaTaskItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskDataList[slot1])
end

function slot0.OnTaskListChange(slot0)
	slot0.taskDataList = ZumaData:GetZumaTaskData()

	slot0.list_:StartScroll(#slot0.taskDataList)
	slot0:UpdateTaskData()
end

function slot0.UpdateTaskData(slot0)
	slot0.taskDataList = ZumaData:GetZumaTaskData()

	slot0.list_:StartScroll(#slot0.taskDataList)

	slot1 = false

	for slot5, slot6 in ipairs(slot0.taskDataList) do
		if AssignmentCfg[slot6.id].need <= slot6.progress and slot6.complete_flag < 1 then
			slot1 = true

			return
		end
	end

	slot0.showStateController:SetSelectedState(slot1 and uv0.showState.showOneClick or uv0.showState.normal)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		uv0:OnReceive()
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnReceive(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.taskDataList) do
		if AssignmentCfg[slot6.id].need <= slot6.progress and slot6.complete_flag < 1 then
			table.insert(slot1, slot6.id)
		end
	end

	TaskAction:SubmitTaskList(slot1)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0:UpdateTaskData()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
