slot0 = class("FishStaminaRecoverOverflowNotify", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.okBtn_, nil, handler(slot0, slot0.OnOk))
	slot0:AddBtnListener(slot0.cancelBtn_, nil, handler(slot0, slot0.OnCancel))
end

function slot0.OnEnter(slot0)
	slot0.okCallback = slot0.params_.OkCallback
	slot0.cancelCallback = slot0.params_.CancelCallback
end

function slot0.OnOk(slot0)
	OperationRecorder.RecordButtonTouch("activity_kagutsuchi_energyspilling_ture")
	JumpTools.Back()

	if slot0.okCallback then
		slot0.okCallback()
	end
end

function slot0.OnCancel(slot0)
	OperationRecorder.RecordButtonTouch("activity_kagutsuchi_energyspilling_false")
	JumpTools.Back()

	if slot0.cancelCallback then
		slot0.cancelCallback()
	end
end

return slot0
