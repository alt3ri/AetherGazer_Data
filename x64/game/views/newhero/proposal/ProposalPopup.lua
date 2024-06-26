slot0 = class("ProposalPopup", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_equip/EquipSchemeNamePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.backHandler_ = handler(slot0, slot0.Back)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:GetOrAddComponent(slot0.input_.gameObject, typeof(InputFieldHelper))
	dealEnter(slot0.input_.gameObject)
end

function slot0.OnEnter(slot0)
	slot1, slot2 = gameContext:GetLastHistoryAndParams()

	if string.char(string.byte(slot1)) == "/" then
		slot1 = string.sub(slot1, 2)
	end

	slot0.lastRecord_ = slot1
	slot0.input_.text = GetI18NText(slot0.params_.defaultText) or ""

	manager.notify:RegistListener(INPUT_POP_BACK, slot0.backHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(INPUT_POP_BACK, slot0.backHandler_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cancelbtnBtn_, nil, function ()
		OperationRecorder.Record(uv0.lastRecord_, "proposal_cancelBtn")
		manager.notify:Invoke(INPUT_POP_CLICK_CANCEL)
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		manager.notify:Invoke(INPUT_POP_CLICK_CLOSE, uv0.input_.text, uv0.input_)
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.okbtnBtn_, nil, function ()
		OperationRecorder.Record(uv0.lastRecord_, "proposal_okBtn")
		manager.notify:Invoke(INPUT_POP_CLICK_OK, uv0.input_.text, uv0.input_)
	end)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.backHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
