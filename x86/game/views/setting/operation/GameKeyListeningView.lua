slot0 = class("GameKeyListeningView", ReduxView)
slot1 = require("cjson")

function slot0.UIName(slot0)
	return "Widget/System/Setting/SettingHandlUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.gamepadType_ = slot0.params_.gamepadType

	SetActive(slot0.confirmBtn_.gameObject, false)
	slot0:StartKeyListening()
end

function slot0.OnExit(slot0)
	slot0:StopKeyListening()

	slot0.params_.listenCallback = nil
end

function slot0.SendKeyResult(slot0, slot1)
	if slot0.params_.listenCallback then
		slot2(slot1)
	end
end

function slot0.StartKeyListening(slot0)
	slot0:StopKeyListening()

	slot0.contentText_.text = GetTips("PLEASE_INPUT_KEY")

	LuaForCursor.SetCanMove(false)
	LuaForGamepad.ClearInputValue()

	slot0.lastKey_ = nil
	slot0.timer_ = FrameTimer.New(function ()
		if not uv0:IsKeyLegal(uv0:GetInputKey()) then
			return
		end

		LuaForGamepad.ClearInputValue()
		uv0:SendKeyResult(slot0)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopKeyListening(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	LuaForCursor.SetCanMove(true)
end

function slot0.IsKeyLegal(slot0, slot1)
	if slot1 == "" then
		return false
	end

	if LuaHidTools.IsKeyNotAllow(slot0.gamepadType_, LuaForGamepad.ConvertName(slot1)) then
		ShowTips(GetTipsF("INPUT_KEY_NOT_ALLOW", GetKeyCodeMappedName(slot2)))

		return false
	end

	return (slot3 == 2 or slot3 == 3) == LuaForGamepad.IsGamepadKey(slot1)
end

function slot0.GetInputDataJson(slot0)
	if LuaForGamepad.GetFirstInputValue() == "" then
		slot1 = LuaForGamepad.GetFirstDeltaInputValue()
	end

	return slot1
end

function slot0.GetInputKey(slot0)
	if slot0:GetInputDataJson() == "" then
		if slot0.lastKey_ then
			slot0.lastKey_ = nil

			return slot2
		end

		return ""
	end

	slot0.lastKey_ = uv0.decode(slot1).m_axisName

	return ""
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
