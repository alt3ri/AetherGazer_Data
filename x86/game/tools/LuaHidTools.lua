slot1 = P08.Gamepad.HIDInputPage

function slot2(slot0)
	if slot0.gameObject_ == nil or uv0 == nil then
		return nil
	end

	return slot1:GetComponent(typeof(uv0))
end

HID_TYPES = {
	PS4 = 3,
	Keyboard = 1,
	Other = 4,
	Xbox = 2,
	None = 0
}
slot3 = {
	[HID_TYPES.Xbox] = "Xbox_",
	[HID_TYPES.PS4] = "PS_"
}
slot4 = {
	KeypadMultiply = "Pad*",
	KeypadPlus = "Pad+",
	KeypadMinus = "Pad-",
	Alpha1 = "1",
	Alpha2 = "2",
	Escape = "Esc",
	BackQuote = "~",
	Alpha7 = "7",
	KeypadDivide = "Pad/",
	Keypad6 = "Pad6",
	Backslash = "\\",
	Keypad3 = "Pad3",
	Slash = "/",
	Comma = ",",
	Alpha3 = "3",
	Alpha4 = "4",
	Quote = "\"",
	Alpha9 = "9",
	Return = "Enter",
	Keypad8 = "Pad8",
	Keypad5 = "Pad5",
	Alpha0 = "0",
	Alpha5 = "5",
	Alpha6 = "6",
	Keypad7 = "Pad7",
	KeypadEnter = "PadEnter",
	Keypad0 = "Pad0",
	Minus = "-",
	Alpha8 = "8",
	Equals = "+",
	KeypadPeriod = "Pad.",
	Keypad9 = "Pad9",
	Keypad2 = "Pad2",
	Period = ".",
	Keypad4 = "Pad4",
	Keypad1 = "Pad1"
}

function GetKeyCodeMappedName(slot0)
	if TipsCfg.get_id_list_by_define["KEYCODE_" .. string.upper(slot0)] then
		return GetTips(slot2)
	elseif uv0[slot0] then
		return uv0[slot0]
	end

	return slot0
end

slot5 = {}
slot6 = nil

function OnGamepadDeviceAdded(slot0, slot1)
	print("OnGamepadDeviceAdded: " .. slot1)
	table.insert(uv0, {
		slot1,
		slot0
	})

	if uv1 then
		return
	end

	uv1 = Timer.New(function ()
		if uv0.selectWin_ then
			if manager.guide:IsPlaying() then
				uv0.selectWin_:CloseWindow()
			end

			return
		end

		if #uv1 <= 0 then
			uv0.StopDeviceAddTimer()

			return
		end

		if manager.guide:IsPlaying() then
			return
		end

		if manager.managerInit then
			uv0.OpenGamepadSelectWin(uv1[1].gamepadType)
			table.clean(uv1)
		end
	end, 1, -1)

	uv1:Start()
end

function OnGamepadDeviceRemoved(slot0, slot1)
	print("OnGamepadDeviceRemoved: " .. slot1)

	slot2 = nil

	for slot6, slot7 in ipairs(uv0) do
		if slot7[1] == slot1 then
			slot2 = slot7
		end
	end

	if slot2 then
		table.removebyvalue(uv0, slot2)
	end
end

slot7 = {
	PageDown = true,
	End = true,
	Delete = true,
	ScrollLock = true,
	PS_JoystickButton8 = true,
	Backspace = true,
	PS_JoystickButton10 = true,
	Pause = true,
	Xbox_JoystickButton6 = true,
	Xbox_JoystickButton8 = true,
	SysReq = true,
	Escape = true,
	RightMeta = true,
	Mouse0 = true,
	Home = true,
	Insert = true,
	LeftApple = true,
	Print = true,
	PageUp = true,
	Numlock = true,
	Menu = true
}
slot8 = {
	Sys_Confirm = true,
	Sys_Home = true,
	Sys_BattlePause = true,
	Sys_Back = true,
	Special_SwitchCursor = true,
	Special_JoystickClick = true
}
slot9 = "InputRemapNoticeEnableList"

return {
	EnsureHasInputPage = function (slot0)
		if slot0.gameObject_ == nil or uv0 == nil then
			return
		end

		if slot1:GetComponent(typeof(uv0)) == nil then
			return slot1:AddComponent(slot2)
		end
	end,
	EnterInputPage = function (slot0)
		if uv0(slot0) then
			slot1:EnablePageIfNeed()
		end
	end,
	ExitInputPage = function (slot0)
		if uv0(slot0) then
			slot1:DisablePageIfNeed()
		end
	end,
	StopDeviceAddTimer = function ()
		uv0:Stop()

		uv0 = nil
	end,
	OpenGamepadSelectWin = function (slot0)
		if uv0.selectWin_ then
			return
		end

		uv0.selectWin_ = GamepadSelectView.New(slot0)
	end,
	IsKeyNotAllow = function (slot0, slot1)
		if uv0[slot1] then
			return true
		end

		if uv1[slot0] and uv0[slot2 .. slot1] then
			return true
		end

		return false
	end,
	IsOpNotAllow = function (slot0, slot1)
		if uv0[slot1] then
			return true
		end

		return false
	end,
	GetOpName = function (slot0)
		return GetTips(string.format("INPUT_BUTTON_%s", string.upper(slot0)))
	end,
	GetPlayerSelectJoystick = function ()
		return LuaForGamepad.GetPlayerSelectJoystick()
	end,
	SetPlayerSelectJoystick = function (slot0)
		LuaForGamepad.SetPlayerSelectJoystick(slot0)
	end,
	SetRemapNotice = function (slot0, slot1)
		LuaForGamepad.SetNeedRemapNotice(slot0, slot1)
	end,
	GetRemapNotice = function (slot0)
		return LuaForGamepad.GetNeedRemapNotice(slot0)
	end,
	ResetRemapNotice = function ()
		PlayerPrefs.DeleteKey(uv0)
		uv1.SetRemapNotice(HID_TYPES.None, uv1.GetRemapNotice(HID_TYPES.None))
	end,
	HasSetRemapNotice = function ()
		if not GameToSDK.IsEditorOrPcPlatform() then
			return true
		end

		if PlayerPrefs.HasKey(uv0) then
			return true
		end

		return false
	end,
	SetAllRemapNotice = function (slot0)
		for slot4, slot5 in pairs(HID_TYPES) do
			uv0.SetRemapNotice(slot5, slot0)
		end
	end,
	QueryRemapNotice = function ()
		JumpTools.OpenPageByJump("blank")
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("INPUT_REMAP_NOTICE_QUERY"),
			OkCallback = function ()
				uv0.SetAllRemapNotice(true)
				JumpTools.Back()
			end,
			CancelCallback = function ()
				uv0.SetAllRemapNotice(false)
				JumpTools.Back()
			end
		})
	end
}
