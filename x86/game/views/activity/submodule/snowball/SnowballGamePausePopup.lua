slot0 = class("SnowballGamePausePopup", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/SnowballGamePausePopup"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		JumpTools.Back()

		if uv0.OkCallback then
			uv0.OkCallback()
		end
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		JumpTools.Back()

		if uv0.CancelCallback then
			uv0.CancelCallback()
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.OkCallback = slot0.params_.OkCallback
	slot0.CancelCallback = slot0.params_.CancelCallback
end

return slot0
