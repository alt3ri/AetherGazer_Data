slot0 = class("GameKeyOperationView", ReduxView)
slot1 = require("cjson")
slot2 = {
	PS = "PS4Layout",
	Keyboard = "KeyboardLayout",
	Xbox = "XboxLayout",
	Other = "OtherLayout"
}
slot3 = {
	MiniGame = 7,
	View = 2,
	System = 6,
	Battle = 4,
	SubJoystick = 3,
	Operation = 5,
	Move = 1,
	None = 0
}

function slot0.SetActive(slot0, slot1)
	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, slot1)
	end
end

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.settingView_ = slot1
	slot0.params_ = slot3

	slot0:Init()
	slot0:OnEnter()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.keysChangeInfo_ = {}
	slot0.cursorSensitivity = {}
	slot0.remapNotice_ = {}
	slot0.oldRemapNotice_ = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.bindings_ = {
		[uv0.Move] = GameKeyBindingContent.New(slot0.moveBindingGo_),
		[uv0.View] = GameKeyBindingContent.New(slot0.viewBindingGo_),
		[uv0.SubJoystick] = GameKeyBindingContent.New(slot0.subJoyBindingGo_),
		[uv0.Battle] = GameKeyBindingContent.New(slot0.battleBindingGo_),
		[uv0.Operation] = GameKeyBindingContent.New(slot0.operBindingGo_),
		[uv0.System] = GameKeyBindingContent.New(slot0.sysBindingGo_)
	}
	slot5 = slot0.miniGameBindingGo_
	slot0.bindings_[uv0.MiniGame] = GameKeyBindingContent.New(slot5)

	for slot4, slot5 in pairs(slot0.bindings_) do
		slot5:SetKeyChangedCallback(function (slot0, slot1, slot2)
			uv0:OnKeyChanged(slot0, slot1, slot2)
		end)
	end

	slot0:RegistEventListener(BATTLE_UI_ADJUSTED, handler(slot0, slot0.RefreshBattleUIName))
	slot0:RegistEventListener(JOYSTICK_TYPE_SELECT, handler(slot0, slot0.OnJoystickTypeSelect))

	slot0.remapToggleCon_ = slot0.remapToggleConEx_:GetController("default0")
	slot0.gamepadToggleCon_ = slot0.gamepadToggleConEx_:GetController("default0")
	slot0.hidTypeCon_ = slot0.controllerEx_:GetController("hidType")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.keyboardBtn_, nil, function ()
		uv0:SwitchToHID(HID_TYPES.Keyboard)
	end)
	slot0:AddBtnListener(slot0.gamepadBtn_, nil, function (slot0)
		uv0:SwitchToHID(LuaHidTools.GetPlayerSelectJoystick() == 0 and HID_TYPES.Xbox or slot1)
	end)
	slot0:AddBtnListener(slot0.gamepadSelBtn_, nil, function (slot0)
		LuaHidTools.OpenGamepadSelectWin(LuaHidTools.GetPlayerSelectJoystick())
	end)
	slot0:AddToggleListener(slot0.gamepadToggle_, function (slot0)
		uv0.gamepadEnable_ = slot0

		uv0.gamepadToggleCon_:SetSelectedState(slot0 and "on" or "off")
		uv0:RefreshSlider()
		uv0:UpdateBindingVisibility()

		if slot0 then
			uv0:RebuildUILayout()
		else
			uv0.remapNoticeToggle_.isOn = false
		end
	end)
	slot0:AddToggleListener(slot0.remapNoticeToggle_, function (slot0)
		uv0:SetRemapNotice(slot0)
	end)
	slot0:AddBtnListener(slot0.battleUiAdjBtn_, nil, function ()
		uv0:Go("battleUIAdjust", {})
	end)
	slot0.cursorSenSlider_.onValueChanged:AddListener(function (slot0)
		uv0.cursorSensitivity[uv0.gamepadType_] = slot0
		slot1 = uv0:GetLayoutName(uv0.gamepadType_)

		LuaForGamepad.SetCursorSensitivity(slot1, LuaForGamepad.GetDefaultLayoutFileName(slot1), slot0)
	end)
	slot0:AddPressingByTimeListener(slot0.cursorSenSubGo_, 3, 0.5, 0.5, function ()
		if uv0.cursorSenSlider_.value > 0 then
			uv0.cursorSenSlider_.value = uv0.cursorSenSlider_.value - 1

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.cursorSenAddGo_, 3, 0.5, 0.5, function ()
		if uv0.cursorSenSlider_.value < 100 then
			uv0.cursorSenSlider_.value = uv0.cursorSenSlider_.value + 1

			return true
		end

		return false
	end)
end

function slot0.OnEnter(slot0)
	slot0.keysChangeInfo_ = {}
	slot0.gamepadType_ = LuaForGamepad.GetGamepadType()
	slot0.layoutName_ = slot0:GetLayoutName(slot0.gamepadType_)
	slot0.gamepadEnable_ = slot0:IsJoystickEnable()
	slot0.oldGamepadEnable_ = slot0.gamepadEnable_
	slot0.oldGamepadType_ = slot0.gamepadType_
	slot0.oldLayoutJson_ = LuaForGamepad.GetLayoutJson(slot0.layoutName_, LuaForGamepad.GetDefaultLayoutFileName(slot0.layoutName_))
	slot0.oldCursorSensitivity = {}

	slot0:RefreshHIDToggles()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	for slot4, slot5 in pairs(slot0.bindings_) do
		slot5:OnExit()
	end

	slot0:StopRebuildTimer()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.bindings_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshBattleUIName()
	slot0:RefreshGamepadName()
	slot0:RefreshRemapNoticeToggle()
end

function slot0.RefreshBindingUI(slot0)
	slot0.controlGroupsData_ = uv0.decode(LuaForGamepad.GetLayoutControlGroups(slot0.layoutName_))

	slot0:ApplyTmpChanges()

	for slot5, slot6 in ipairs(slot0.controlGroupsData_.groups) do
		slot8 = slot0.bindings_[slot6.controlType]

		slot8:SetData(slot0.layoutName_, "", slot6, slot0.gamepadType_)
		slot8:RefreshUI()
	end

	slot0:RebuildUILayout()
end

function slot0.StopRebuildTimer(slot0)
	if slot0.timerRebuild_ then
		slot0.timerRebuild_:Stop()

		slot0.timerRebuild_ = nil
	end
end

function slot0.ApplyTmpChanges(slot0)
	if #slot0.keysChangeInfo_ <= 0 then
		return
	end

	slot1 = {}

	for slot5, slot6 in ipairs(slot0.controlGroupsData_.groups) do
		for slot11, slot12 in ipairs(slot6.items) do
			-- Nothing
		end

		slot1[slot6.controlType] = {
			[slot12.buttonInt] = slot12
		}
	end

	for slot5, slot6 in ipairs(slot0.keysChangeInfo_) do
		if slot6.layoutName == slot0.layoutName_ and slot1[slot6.controlType] and slot7[slot6.buttonInt] then
			slot8.keyName = slot6.keyName
		end
	end
end

function slot0.RebuildUILayout(slot0)
	slot0:StopRebuildTimer()

	slot0.timerData_counter = 0
	slot0.timerRebuild_ = FrameTimer.New(function ()
		LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.contentTrans_)

		uv0.timerData_counter = uv0.timerData_counter + 1

		if uv0.timerData_counter == 3 then
			uv0:StopRebuildTimer()
		end
	end, 1, 3)

	slot0.timerRebuild_:Start()
end

function slot0.RefreshHIDToggles(slot0)
	slot0:SwitchToHID(slot0.gamepadType_)

	slot0.gamepadToggle_.isOn = slot0.gamepadEnable_
end

function slot0.RefreshSlider(slot0)
	slot1 = slot0.gamepadType_ == HID_TYPES.Xbox or slot0.gamepadType_ == HID_TYPES.PS4

	SetActive(slot0.cursorSenGo_, slot1 and slot0.gamepadEnable_)

	if not slot1 then
		return
	end

	if slot0.oldCursorSensitivity[slot0.gamepadType_] == nil then
		slot0.oldCursorSensitivity[slot0.gamepadType_] = LuaForGamepad.GetCursorSensitivity(slot0.layoutName_, LuaForGamepad.GetDefaultLayoutFileName(slot0.layoutName_))
	end

	if slot0.cursorSensitivity[slot0.gamepadType_] == nil then
		slot0.cursorSensitivity[slot0.gamepadType_] = slot0.oldCursorSensitivity[slot0.gamepadType_]
	end

	slot0.cursorSenSlider_.value = slot0.cursorSensitivity[slot0.gamepadType_]
end

function slot0.SwitchToHID(slot0, slot1)
	if slot1 == HID_TYPES.Keyboard then
		slot0.hidTypeCon_:SetSelectedState("keyboard")
	elseif slot1 == HID_TYPES.Xbox then
		slot0.hidTypeCon_:SetSelectedState("gamepad")
	elseif slot1 == HID_TYPES.PS4 then
		slot0.hidTypeCon_:SetSelectedState("gamepad")
	else
		slot0.hidTypeCon_:SetSelectedState("none")
	end

	slot0:SetHidType(slot1)
	slot0:RefreshSlider()
	slot0:RefreshRemapNoticeToggle()
	slot0:RefreshBindingUI()
	slot0:UpdateBindingVisibility()
end

function slot0.SwitchBindingVisibility(slot0, slot1)
	for slot5, slot6 in pairs(slot0.bindings_) do
		if slot1 then
			SetActive(slot6.gameObject_, slot0.controlGroupsData_.groups[slot5] and #slot7.items > 0)
		else
			SetActive(slot6.gameObject_, false)
		end
	end
end

function slot0.UpdateBindingVisibility(slot0)
	if slot0.gamepadType_ == HID_TYPES.Keyboard then
		slot0:SwitchBindingVisibility(true)
		SetActive(slot0.remapNoticeGo_, true)
	elseif slot1 == HID_TYPES.Xbox then
		slot0:SwitchBindingVisibility(slot0.gamepadEnable_)
		SetActive(slot0.gamepadGo_, slot0.gamepadEnable_)
		SetActive(slot0.remapNoticeGo_, slot0.gamepadEnable_)
	elseif slot1 == HID_TYPES.PS4 then
		slot0:SwitchBindingVisibility(slot0.gamepadEnable_)
		SetActive(slot0.gamepadGo_, slot0.gamepadEnable_)
		SetActive(slot0.remapNoticeGo_, slot0.gamepadEnable_)
	else
		slot0:SwitchBindingVisibility(false)
	end
end

function slot0.OnKeyChanged(slot0, slot1, slot2, slot3)
	slot4 = true

	for slot8, slot9 in ipairs(slot0.controlGroupsData_.groups) do
		if slot9.conflictGroup == slot3.conflictGroup then
			for slot13, slot14 in ipairs(slot9.items) do
				if slot14.keyName == slot3.keyName and slot14.buttonInt ~= slot3.buttonInt then
					slot4 = false

					if LuaHidTools.IsOpNotAllow(slot0.gamepadType_, slot14.buttonName) then
						ShowTips(GetTipsF("INPUT_KEY_NOT_ALLOW", GetKeyCodeMappedName(slot3.keyName)))
						slot2:StartListeningNewKey()

						return
					end

					JumpTools.Back()
					slot0:Go("gameKeyConflict", {
						listenCallback = function (slot0)
							if not slot0 then
								uv0:StartListeningNewKey()

								return
							end

							uv1:AddKeyChangeInfo({
								conflictGroup = uv2.conflictGroup,
								controlType = uv2.controlType,
								layoutName = uv1.layoutName_,
								buttonInt = uv3.buttonInt,
								key = uv4.oldKey,
								keyName = uv4.oldKeyName
							})
							uv1:AddKeyChangeInfo(uv4)
							uv1:RefreshBindingUI()
						end,
						opName = slot3.buttonName,
						conflictOpName = slot14.buttonName,
						key = slot3.key,
						keyName = slot3.keyName,
						gamepadType = slot0.gamepadType_
					})

					return
				end
			end
		end
	end

	if slot4 then
		slot0:AddKeyChangeInfo(slot3)
		slot0:RefreshBindingUI()
	end

	JumpTools.Back()
end

function slot0.AddKeyChangeInfo(slot0, slot1)
	slot0:RemoveChangesIf(function (slot0)
		return slot0.conflictGroup == uv0.conflictGroup and slot0.buttonInt == uv0.buttonInt
	end)
	table.insert(slot0.keysChangeInfo_, slot1)
end

function slot0.RemoveChangesIf(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.keysChangeInfo_) do
		if slot1(slot7) then
			table.insert(slot2, slot7)
		end
	end

	for slot6, slot7 in ipairs(slot2) do
		table.removebyvalue(slot0.keysChangeInfo_, slot7)
	end
end

function slot0.SaveData(slot0)
	for slot4, slot5 in ipairs(slot0.keysChangeInfo_) do
		LuaForGamepad.SetLayoutItem(slot5.layoutName, LuaForGamepad.GetDefaultLayoutFileName(slot5.layoutName), slot5.buttonInt, slot5.key)
	end

	for slot4, slot5 in pairs(slot0.cursorSensitivity) do
		slot6 = slot0:GetLayoutName(slot4)

		LuaForGamepad.SetCursorSensitivity(slot6, LuaForGamepad.GetDefaultLayoutFileName(slot6), slot5)
	end

	LuaForGamepad.ReloadLayout()

	slot0.keysChangeInfo_ = {}
	slot1 = slot0:GetRemapNotice()
	slot0.oldGamepadType_ = slot0.gamepadType_
	slot0.oldLayoutJson_ = LuaForGamepad.GetLayoutJson(slot0.layoutName_, LuaForGamepad.GetDefaultLayoutFileName(slot0.layoutName_))

	LuaForGamepad.SetDeviceEnable(HID_TYPES.Xbox, slot0.gamepadEnable_)

	slot5 = slot0.gamepadEnable_

	LuaForGamepad.SetDeviceEnable(HID_TYPES.PS4, slot5)

	slot0.oldGamepadEnable_ = slot0.gamepadEnable_

	slot0:NotifyKeyChange()

	slot0.cursorSensitivity = {}
	slot0.oldCursorSensitivity = {}

	slot0:RefreshHIDToggles()

	for slot5, slot6 in pairs(slot0.remapNotice_) do
		LuaHidTools.SetRemapNotice(slot5, slot6)
	end

	slot0.remapNotice_ = {}
	slot0.oldRemapNotice_ = {}
	slot0.remapNoticeToggle_.isOn = slot1
end

function slot0.RecoverTmpData(slot0)
	for slot4, slot5 in pairs(slot0.oldCursorSensitivity) do
		slot6 = slot0:GetLayoutName(slot4)

		LuaForGamepad.SetCursorSensitivity(slot6, LuaForGamepad.GetDefaultLayoutFileName(slot6), slot5)
	end

	slot0.keysChangeInfo_ = {}
	slot0.gamepadType_ = slot0.oldGamepadType_
	slot4 = slot0.gamepadType_
	slot0.layoutName_ = slot0:GetLayoutName(slot4)
	slot0.gamepadEnable_ = slot0.oldGamepadEnable_
	slot0.cursorSensitivity = {}

	slot0:RefreshHIDToggles()

	for slot4, slot5 in pairs(slot0.oldRemapNotice_) do
		LuaHidTools.SetRemapNotice(slot4, slot5)
	end

	slot0.remapNotice_ = {}
	slot0.oldRemapNotice_ = {}

	slot0:RefreshRemapNoticeToggle()
end

function slot0.ResetDefaultData(slot0)
	LuaForGamepad.DeleteLayoutJson(slot0.layoutName_)
	LuaForGamepad.ReloadLayout()
	LuaForGamepad.SetDeviceEnable(HID_TYPES.Xbox, true)
	LuaForGamepad.SetDeviceEnable(HID_TYPES.PS4, true)

	slot0.gamepadToggle_.isOn = true

	slot0:NotifyKeyChange()

	slot0.keysChangeInfo_ = {}
	slot0.cursorSensitivity = {}
	slot0.oldCursorSensitivity = {}

	slot0:RefreshSlider()
	slot0:RefreshBindingUI()

	slot0.remapNotice_ = {}
	slot0.oldRemapNotice_ = {}

	LuaHidTools.ResetRemapNotice()
	slot0:RefreshRemapNoticeToggle()
end

function slot0.CheckDataChange(slot0)
	return #slot0.keysChangeInfo_ > 0 or slot0.gamepadEnable_ ~= slot0.oldGamepadEnable_ or (slot0.remapNotice_[HID_TYPES.Keyboard] ~= slot0.oldRemapNotice_[HID_TYPES.Keyboard] or slot0.remapNotice_[HID_TYPES.Xbox] ~= slot0.oldRemapNotice_[HID_TYPES.Xbox] or slot0.remapNotice_[HID_TYPES.PS4] ~= slot0.oldRemapNotice_[HID_TYPES.PS4]) or (slot0.cursorSensitivity[HID_TYPES.Xbox] ~= slot0.oldCursorSensitivity[HID_TYPES.Xbox] or slot0.cursorSensitivity[HID_TYPES.PS4] ~= slot0.oldCursorSensitivity[HID_TYPES.PS4])
end

function slot0.SetRemapNotice(slot0, slot1)
	slot0.remapToggleCon_:SetSelectedState(slot1 and "on" or "off")

	if slot0.gamepadType_ == HID_TYPES.Xbox or slot0.gamepadType_ == HID_TYPES.PS4 then
		slot0.remapNotice_[HID_TYPES.Xbox] = slot1
		slot0.remapNotice_[HID_TYPES.PS4] = slot1

		LuaHidTools.SetRemapNotice(HID_TYPES.Xbox, slot1)
		LuaHidTools.SetRemapNotice(HID_TYPES.PS4, slot1)
	else
		LuaHidTools.SetRemapNotice(slot0.gamepadType_, slot1)

		slot0.remapNotice_[slot0.gamepadType_] = slot1
	end
end

function slot0.GetRemapNotice(slot0)
	slot1 = LuaHidTools.GetRemapNotice(slot0.gamepadType_)

	if slot0.oldRemapNotice_[slot0.gamepadType_] == nil then
		if slot0.gamepadType_ == HID_TYPES.Xbox or slot0.gamepadType_ == HID_TYPES.PS4 then
			slot0.oldRemapNotice_[HID_TYPES.Xbox] = slot1
			slot0.oldRemapNotice_[HID_TYPES.PS4] = slot1
		else
			slot0.oldRemapNotice_[slot0.gamepadType_] = slot1
		end
	end

	return slot1
end

function slot0.RefreshRemapNoticeToggle(slot0)
	slot0.remapNoticeToggle_.isOn = slot0:GetRemapNotice()
end

function slot0.IsJoystickEnable(slot0)
	return LuaForGamepad.IsDeviceEnable(LuaHidTools.GetPlayerSelectJoystick())
end

function slot0.NotifyKeyChange(slot0)
	if not slot0.remapNoticeToggle_.isOn then
		return
	end

	LuaHidTools.SetRemapNotice(slot0.gamepadType_, false)
	FrameTimer.New(function ()
		LuaHidTools.SetRemapNotice(uv0.gamepadType_, true)
	end, 1, 1):Start()
end

function slot0.RefreshBattleUIName(slot0)
	slot1 = ""
	slot2 = SettingData:GetBattleUISettingData()
	slot0.battleUiText_.text = (slot2.battle_ui_cur_type ~= slot2.battle_ui_type_0 or GetTips("BATTLE_UI_DEFAULT_PRESET")) and (slot2.battle_ui_cur_type ~= slot2.battle_ui_type_1 or string.format(GetTips("BATTLE_UI_SCHEME_INDEX"), 1)) and (slot2.battle_ui_cur_type ~= slot2.battle_ui_type_2 or string.format(GetTips("BATTLE_UI_SCHEME_INDEX"), 2)) and (slot2.battle_ui_cur_type ~= slot2.battle_ui_type_3 or string.format(GetTips("BATTLE_UI_SCHEME_INDEX"), 3)) and GetTips("BATTLE_UI_DEFAULT_PRESET")
end

function slot0.RefreshGamepadName(slot0)
	slot0.gamepadSelText_.text = GetTips("GAMEPAD_ICON_PATTERN_" .. (LuaHidTools.GetPlayerSelectJoystick() == HID_TYPES.Xbox and 2 or 1))
end

function slot0.OnJoystickTypeSelect(slot0, slot1)
	slot0:RefreshGamepadName()
	slot0:SwitchToHID(slot1)
end

function slot0.SetHidType(slot0, slot1)
	slot0.gamepadType_ = slot1
	slot0.layoutName_ = slot0:GetLayoutName(slot0.gamepadType_)
end

function slot0.GetLayoutName(slot0, slot1)
	if slot1 == HID_TYPES.Keyboard then
		return uv0.Keyboard
	elseif slot1 == HID_TYPES.Xbox then
		return uv0.Xbox
	elseif slot1 == HID_TYPES.PS4 then
		return uv0.PS
	else
		return uv0.Other
	end
end

return slot0
