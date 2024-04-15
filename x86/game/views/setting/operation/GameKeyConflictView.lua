slot0 = class("GameKeyConflictView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Setting/SettingHandl02UI"
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

	slot0.styleController_ = slot0.keyConEx_:GetController("style")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.confirmBtn_, nil, function ()
		uv0:InvokeCallback(true)
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:InvokeCallback(false)
	end)
end

function slot0.OnEnter(slot0)
	slot0.opName_ = slot0.params_.opName
	slot0.key_ = slot0.params_.key
	slot0.keyName_ = slot0.params_.keyName
	slot0.conflictOpName_ = slot0.params_.conflictOpName
	slot0.gamepadType_ = slot0.params_.gamepadType

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.RefreshUI(slot0)
	if LuaForGamepad.GetKeyIcon(slot0.keyName_, slot0.gamepadType_) then
		slot0.styleController_:SetSelectedState(LuaForGamepad.IsGamepadKey(slot0.key_) and "gamepad" or "keyboard")

		slot0.keyImage_.sprite = slot1

		slot0.keyImage_:SetNativeSize()
	else
		slot0.styleController_:SetSelectedState("text")

		slot0.keyText_.text = GetKeyCodeMappedName(slot0.keyName_)
	end

	slot0.conflictText_.text = string.format(GetTips("INPUT_KEY_CONFLICT_TIPS"), LuaHidTools.GetOpName(slot0.conflictOpName_))
end

function slot0.InvokeCallback(slot0, slot1)
	slot0:Back()

	if slot0.params_.listenCallback then
		slot0.params_.listenCallback(slot1)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
