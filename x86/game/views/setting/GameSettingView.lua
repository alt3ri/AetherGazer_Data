slot0 = class("GameSettingView", ReduxView)
slot1 = require("cjson")

function slot0.SetActive(slot0, slot1)
	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, slot1)
	end
end

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.hander_ = slot1
	slot0.transform_ = slot2.transform
	slot0.gameObject_ = slot2
	slot0.info_ = slot3

	slot0:Init()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0.sliderSlr_.onValueChanged:AddListener(function ()
		SettingAction.ChangeGameSetting("adapter_value", uv0.sliderSlr_.value)
	end)
	slot0:AddPressingByTimeListener(slot0.cutGo_, 3, 0.5, 0.5, function ()
		if uv0.sliderSlr_.value > 0 then
			SettingAction.ChangeGameSetting("adapter_value", uv0.sliderSlr_.value - 1)

			return true
		end

		return false
	end)

	slot4 = 3

	slot0:AddPressingByTimeListener(slot0.addGo_, slot4, 0.5, 0.5, function ()
		if uv0.sliderSlr_.value < 100 then
			SettingAction.ChangeGameSetting("adapter_value", uv0.sliderSlr_.value + 1)

			return true
		end

		return false
	end)

	for slot4 = 1, 3 do
		slot0:AddToggleListener(slot0["hitNumberTeammate" .. slot4 .. "Tgl_"], function (slot0)
			if not slot0 then
				return
			end

			if uv0.settingData_.battle_hit_num_teammate ~= uv1 - 1 then
				SettingAction.ChangeGameSetting("battle_hit_num_teammate", uv1 - 1)
			end
		end)
	end

	for slot4 = 1, 3 do
		slot0:AddToggleListener(slot0["hitNumberPlayer" .. slot4 .. "Tgl_"], function (slot0)
			if not slot0 then
				return
			end

			if uv0.settingData_.battle_hit_num_mine ~= uv1 - 1 then
				SettingAction.ChangeGameSetting("battle_hit_num_mine", uv1 - 1)
			end
		end)
	end

	slot0:AddToggleListener(slot0.moveableStickOnTgl_, function (slot0)
		if slot0 and uv0.settingData_.moveable_stick ~= 1 then
			SettingAction.ChangeGameSetting("moveable_stick", 1)
		end
	end)
	slot0:AddToggleListener(slot0.moveableStickOffTgl_, function (slot0)
		if slot0 and uv0.settingData_.moveable_stick ~= 0 then
			SettingAction.ChangeGameSetting("moveable_stick", 0)
		end
	end)
	slot0:AddBtnListener(slot0.lockBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameSettingLock", {
			type = uv0.settingData_.battle_lock_type
		})
	end)
	slot0:AddBtnListener(slot0.connectBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameSettingConnect", {
			type = uv0.settingData_.cus_full_play_controlled_type
		})
	end)
end

function slot0.RefreshHurtNum(slot0)
	if not slot0.gameObject_.activeSelf then
		for slot4 = 1, 3 do
			slot0["hitNumberPlayer" .. slot4 .. "Tgl_"].isOn = false
		end
	end

	slot0["hitNumberPlayer" .. slot0.settingData_.battle_hit_num_mine + 1 .. "Tgl_"].isOn = true
end

function slot0.RefreshHurtNumMate(slot0)
	if not slot0.gameObject_.activeSelf then
		for slot4 = 1, 3 do
			slot0["hitNumberTeammate" .. slot4 .. "Tgl_"].isOn = false
		end
	end

	slot0["hitNumberTeammate" .. slot0.settingData_.battle_hit_num_teammate + 1 .. "Tgl_"].isOn = true
end

function slot0.RefreshLockType(slot0)
	if slot0.settingData_.battle_lock_type == 0 then
		slot0.lockText_.text = GetI18NText("智能")
	elseif slot1 == 1 then
		slot0.lockText_.text = GetI18NText("距离")
	elseif slot1 == 2 then
		slot0.lockText_.text = GetI18NText("手动")
	end
end

function slot0.RefreshMoveableStick(slot0)
	if not slot0.gameObject_.activeSelf then
		slot0.moveableStickOnTgl_.isOn = false
		slot0.moveableStickOffTgl_.isOn = false
	end

	if slot0.settingData_.moveable_stick and slot1 == 1 then
		slot0.moveableStickOnTgl_.isOn = true
	else
		slot0.moveableStickOffTgl_.isOn = true
	end
end

function slot0.RefreshCUSFullPlay(slot0)
	if slot0.settingData_.cus_full_play_controlled_type then
		if slot1 == 2 then
			slot0.connectText_.text = GetI18NText("例战模式")
		elseif slot1 == 3 then
			slot0.connectText_.text = GetI18NText("例玩模式")
		elseif slot1 == 4 then
			slot0.connectText_.text = GetI18NText("例日模式")
		elseif slot1 == 1 then
			slot0.connectText_.text = GetI18NText("简洁模式")
		else
			slot0.connectText_.text = GetI18NText("完整模式")
		end
	end
end

function slot0.CheckDataChange(slot0, slot1)
	if slot0.tmpSettingData_ and not table.equal(slot0.tmpSettingData_, slot0.settingData_, "all") then
		return true
	end

	return false
end

function slot0.SaveData(slot0)
	if slot0:CheckDataChange() then
		slot0.json_ = require("cjson")
		slot1 = deepClone(slot0.settingData_)
		slot1.type = 3
		slot2 = slot0.json_.encode(slot1)

		SDKTools.SendMessageToSDK("game_setting", {
			gamepad_setting = 0,
			main_damage_num = slot0.settingData_.battle_hit_num_mine + 1,
			ass_damage_num = slot0.settingData_.battle_hit_num_teammate + 1,
			lock_setting = slot0.settingData_.battle_lock_type + 1,
			ss_screen = slot0.settingData_.adapter_value
		})
	end

	slot0.tmpSettingData_ = deepClone(slot0.settingData_)
end

function slot0.RecoverTmpData(slot0)
	if slot0:CheckDataChange() then
		SettingAction.ChangeGameSetting("allData", slot0.tmpSettingData_)
	end
end

function slot0.RefreshAdapterValue(slot0)
	slot0.sliderSlr_.value = slot0.settingData_.adapter_value
	ReduxView.VIEW_ADAPT_DISTANCE = slot0.settingData_.adapter_value
end

function slot0.OnGameSettingChange(slot0, slot1, slot2)
	if slot2.key == "allData" then
		slot0:RefreshHurtNum()
		slot0:RefreshHurtNumMate()
		slot0:RefreshLockType()
		slot0:RefreshMoveableStick()
		slot0:RefreshCUSFullPlay()
		slot0:RefreshAdapterValue()
	elseif slot2.key == "battle_hit_num_mine" then
		slot0:RefreshHurtNum()
	elseif slot2.key == "battle_hit_num_teammate" then
		slot0:RefreshHurtNumMate()
	elseif slot2.key == "battle_lock_type" then
		slot0:RefreshLockType()
	elseif slot2.key == "adapter_value" then
		slot0:RefreshAdapterValue()
	elseif slot2.key == "moveable_stick" then
		slot0:RefreshMoveableStick()
	elseif slot2.key == "cus_full_play_controlled_type" then
		slot0:RefreshCUSFullPlay()
	end
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:OnEnter()
end

function slot0.OnTop(slot0)
	slot0:RefreshLockType()
	slot0:RefreshCUSFullPlay()
end

function slot0.OnEnter(slot0)
	slot0.settingData_ = SettingData:GetGameSettingData()

	slot0:RefreshHurtNum()
	slot0:RefreshHurtNumMate()
	slot0:RefreshLockType()
	slot0:RefreshAdapterValue()
	slot0:RefreshMoveableStick()
	slot0:RefreshCUSFullPlay()

	slot0.tmpSettingData_ = deepClone(slot0.settingData_)

	SetActive(slot0.adapterGo_, (slot0.info_.setType or SettingConst.SETTING_TYPE.SYSTEM) == SettingConst.SETTING_TYPE.SYSTEM)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.hander_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnSoundSettingChange(slot0)
	slot0:RefreshLockType()
end

return slot0
