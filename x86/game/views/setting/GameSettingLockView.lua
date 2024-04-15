slot0 = class("GameSettingLockView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Setting/GameSettingLockUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddToggleListener(slot0.lock1Tgl_, function (slot0)
		if slot0 then
			uv0.lockType = 0
		end
	end)
	slot0:AddToggleListener(slot0.lock2Tgl_, function (slot0)
		if slot0 then
			uv0.lockType = 1
		end
	end)
	slot0:AddToggleListener(slot0.lock3Tgl_, function (slot0)
		if slot0 then
			uv0.lockType = 2
		end
	end)
	slot0:AddBtnListener(slot0.yesBtn_, nil, function ()
		JumpTools.Back()

		if uv0.lockType and uv0.lockType ~= uv0.params_.type then
			SettingAction.ChangeGameSetting("battle_lock_type", uv0.lockType)
		end

		OperationRecorder.Record("setting", "setting_lock")
	end)
	slot0:AddBtnListener(slot0.noBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0.lockType = slot0.params_.type

	if slot0.lockType == 0 then
		slot0.lock1Tgl_.isOn = true
	elseif slot0.lockType == 1 then
		slot0.lock2Tgl_.isOn = true
	elseif slot0.lockType == 2 then
		slot0.lock3Tgl_.isOn = true
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.params_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
