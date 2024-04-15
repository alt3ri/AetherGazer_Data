local var_0_0 = {}
local var_0_1 = P08.Gamepad.HIDInputPage

function var_0_0.EnsureHasInputPage(arg_1_0)
	local var_1_0 = arg_1_0.gameObject_

	if var_1_0 == nil or var_0_1 == nil then
		return
	end

	local var_1_1 = typeof(var_0_1)

	if var_1_0:GetComponent(var_1_1) == nil then
		return var_1_0:AddComponent(var_1_1)
	end
end

local function var_0_2(arg_2_0)
	local var_2_0 = arg_2_0.gameObject_

	if var_2_0 == nil or var_0_1 == nil then
		return nil
	end

	return (var_2_0:GetComponent(typeof(var_0_1)))
end

function var_0_0.EnterInputPage(arg_3_0)
	local var_3_0 = var_0_2(arg_3_0)

	if var_3_0 then
		var_3_0:EnablePageIfNeed()
	end
end

function var_0_0.ExitInputPage(arg_4_0)
	local var_4_0 = var_0_2(arg_4_0)

	if var_4_0 then
		var_4_0:DisablePageIfNeed()
	end
end

HID_TYPES = {
	PS4 = 3,
	Keyboard = 1,
	Other = 4,
	Xbox = 2,
	None = 0
}

local var_0_3 = {
	[HID_TYPES.Xbox] = "Xbox_",
	[HID_TYPES.PS4] = "PS_"
}
local var_0_4 = {
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

function GetKeyCodeMappedName(arg_5_0)
	local var_5_0 = "KEYCODE_" .. string.upper(arg_5_0)
	local var_5_1 = TipsCfg.get_id_list_by_define[var_5_0]

	if var_5_1 then
		return GetTips(var_5_1)
	elseif var_0_4[arg_5_0] then
		return var_0_4[arg_5_0]
	end

	return arg_5_0
end

local var_0_5 = {}
local var_0_6

function var_0_0.StopDeviceAddTimer()
	var_0_6:Stop()

	var_0_6 = nil
end

function var_0_0.OpenGamepadSelectWin(arg_7_0)
	if var_0_0.selectWin_ then
		return
	end

	var_0_0.selectWin_ = GamepadSelectView.New(arg_7_0)
end

function OnGamepadDeviceAdded(arg_8_0, arg_8_1)
	print("OnGamepadDeviceAdded: " .. arg_8_1)
	table.insert(var_0_5, {
		arg_8_1,
		arg_8_0
	})

	if var_0_6 then
		return
	end

	var_0_6 = Timer.New(function()
		if var_0_0.selectWin_ then
			if manager.guide:IsPlaying() then
				var_0_0.selectWin_:CloseWindow()
			end

			return
		end

		if #var_0_5 <= 0 then
			var_0_0.StopDeviceAddTimer()

			return
		end

		if manager.guide:IsPlaying() then
			return
		end

		local var_9_0 = var_0_5[1]

		if manager.managerInit then
			var_0_0.OpenGamepadSelectWin(var_9_0.gamepadType)
			table.clean(var_0_5)
		end
	end, 1, -1)

	var_0_6:Start()
end

function OnGamepadDeviceRemoved(arg_10_0, arg_10_1)
	print("OnGamepadDeviceRemoved: " .. arg_10_1)

	local var_10_0

	for iter_10_0, iter_10_1 in ipairs(var_0_5) do
		if iter_10_1[1] == arg_10_1 then
			var_10_0 = iter_10_1
		end
	end

	if var_10_0 then
		table.removebyvalue(var_0_5, var_10_0)
	end
end

local var_0_7 = {
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

function var_0_0.IsKeyNotAllow(arg_11_0, arg_11_1)
	if var_0_7[arg_11_1] then
		return true
	end

	local var_11_0 = var_0_3[arg_11_0]

	if var_11_0 then
		local var_11_1 = var_11_0 .. arg_11_1

		if var_0_7[var_11_1] then
			return true
		end
	end

	return false
end

local var_0_8 = {
	Sys_Confirm = true,
	Sys_Home = true,
	Sys_BattlePause = true,
	Sys_Back = true,
	Special_SwitchCursor = true,
	Special_JoystickClick = true
}

function var_0_0.IsOpNotAllow(arg_12_0, arg_12_1)
	if var_0_8[arg_12_1] then
		return true
	end

	return false
end

function var_0_0.GetOpName(arg_13_0)
	return GetTips(string.format("INPUT_BUTTON_%s", string.upper(arg_13_0)))
end

function var_0_0.GetPlayerSelectJoystick()
	return LuaForGamepad.GetPlayerSelectJoystick()
end

function var_0_0.SetPlayerSelectJoystick(arg_15_0)
	LuaForGamepad.SetPlayerSelectJoystick(arg_15_0)
end

local var_0_9 = "InputRemapNoticeEnableList"

function var_0_0.SetRemapNotice(arg_16_0, arg_16_1)
	LuaForGamepad.SetNeedRemapNotice(arg_16_0, arg_16_1)
end

function var_0_0.GetRemapNotice(arg_17_0)
	return LuaForGamepad.GetNeedRemapNotice(arg_17_0)
end

function var_0_0.ResetRemapNotice()
	PlayerPrefs.DeleteKey(var_0_9)

	local var_18_0 = var_0_0.GetRemapNotice(HID_TYPES.None)

	var_0_0.SetRemapNotice(HID_TYPES.None, var_18_0)
end

function var_0_0.HasSetRemapNotice()
	if not GameToSDK.IsEditorOrPcPlatform() then
		return true
	end

	if PlayerPrefs.HasKey(var_0_9) then
		return true
	end

	return false
end

function var_0_0.SetAllRemapNotice(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(HID_TYPES) do
		var_0_0.SetRemapNotice(iter_20_1, arg_20_0)
	end
end

function var_0_0.QueryRemapNotice()
	JumpTools.OpenPageByJump("blank")
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("INPUT_REMAP_NOTICE_QUERY"),
		OkCallback = function()
			var_0_0.SetAllRemapNotice(true)
			JumpTools.Back()
		end,
		CancelCallback = function()
			var_0_0.SetAllRemapNotice(false)
			JumpTools.Back()
		end
	})
end

return var_0_0
