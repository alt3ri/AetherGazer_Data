slot0 = class("GameSettingConnectView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Setting/GameSettingConnectUI"
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
	slot0:AddToggleListener(slot0.connect1Tgl_, function (slot0)
		if slot0 then
			uv0.connectType = 0
		end
	end)
	slot0:AddToggleListener(slot0.connect2Tgl_, function (slot0)
		if slot0 then
			uv0.connectType = 2
		end
	end)
	slot0:AddToggleListener(slot0.connect3Tgl_, function (slot0)
		if slot0 then
			uv0.connectType = 3
		end
	end)
	slot0:AddToggleListener(slot0.connect4Tgl_, function (slot0)
		if slot0 then
			uv0.connectType = 4
		end
	end)
	slot0:AddToggleListener(slot0.connect5Tgl_, function (slot0)
		if slot0 then
			uv0.connectType = 1
		end
	end)
	slot0:AddBtnListener(slot0.yesBtn_, nil, function ()
		if uv0.connectType and uv0.connectType ~= uv0.params_.type then
			SettingAction.ChangeGameSetting("cus_full_play_controlled_type", uv0.connectType)
		end

		JumpTools.Back()
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
	slot0.connectType = slot0.params_.type

	if slot0.connectType == 0 then
		slot0.connect1Tgl_.isOn = true
	elseif slot0.connectType == 2 then
		slot0.connect2Tgl_.isOn = true
	elseif slot0.connectType == 3 then
		slot0.connect3Tgl_.isOn = true
	elseif slot0.connectType == 4 then
		slot0.connect4Tgl_.isOn = true
	elseif slot0.connectType == 1 then
		slot0.connect5Tgl_.isOn = true
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.params_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
