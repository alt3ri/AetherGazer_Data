slot0 = class("NewWarChessHomeTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "ismain")
end

function slot0.SetData(slot0, slot1)
	slot0.taskID_ = slot1

	slot0:UpdateView()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if NewWarChessTaskPoolCfg[uv0.taskID_].clickevent ~= 0 then
			manager.NewChessManager:ExecutChess(NewChessConst.TIMING_INTERACT, nil, NewChessTools.ParseParameterLua(slot0))
			manager.NewChessManager:StartExecuteEvent()
		end
	end)
end

function slot0.UpdateView(slot0)
	if NewWarChessTaskPoolCfg[slot0.taskID_].type == NewChessConst.TASKTYPE.NORMAL then
		slot0.controller_:SetSelectedState("false")
	else
		slot0.controller_:SetSelectedState("true")
	end

	slot2 = manager.NewChessManager.taskManager_:GetTaskInfo(slot0.taskID_)
	slot0.nameText_.text = slot1.description

	if slot1.hide_need == 1 then
		SetActive(slot0.progressText_.gameObject, false)
	else
		SetActive(slot0.progressText_.gameObject, true)

		slot0.progressText_.text = slot2.cur .. "/" .. slot2.need
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
