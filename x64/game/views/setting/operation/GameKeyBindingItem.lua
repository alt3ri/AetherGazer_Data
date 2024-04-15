slot0 = class("GameKeyBindingItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()

	slot0.fixedController_ = slot0.controllerEx_:GetController("fixed")
	slot0.styleController_ = slot0.controllerEx_:GetController("style")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.keyBtn_, nil, function ()
		uv0:StartListeningNewKey()
	end)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.layoutName_ = slot1
	slot0.itemData_ = slot2
	slot0.gamepadType_ = slot3
end

function slot0.SetKeyChangedCallback(slot0, slot1)
	slot0.onKeyChanged_ = slot1
end

function slot0.RefreshUI(slot0)
	slot0.fixedController_:SetSelectedState(tostring(slot0:IsOpNotAllow(slot0.itemData_.buttonName)))

	slot0.nameText_.text = LuaHidTools.GetOpName(slot0.itemData_.buttonName)

	if slot0:GetKeyIcon(slot0.itemData_.keyName) ~= nil then
		slot0.styleController_:SetSelectedState(LuaForGamepad.IsGamepadKey(KeyCode[slot0.itemData_.keyName] and tostring(slot4:ToInt()) or slot0.itemData_.keyName) and "gamepad" or "keyboard")

		slot0.keyImage_.sprite = slot2

		slot0.keyImage_:SetNativeSize()
	else
		slot0.styleController_:SetSelectedState("text")

		slot0.keyText_.text = GetKeyCodeMappedName(slot0.itemData_.keyName)
	end
end

function slot0.SetKey(slot0, slot1)
	slot4 = slot0:GetKeyIcon(LuaForGamepad.ConvertName(slot1)) ~= nil

	if slot0.onKeyChanged_ then
		if KeyCode[slot0.itemData_.keyName] then
			slot5 = tostring(KeyCode[slot5]:ToInt())
		end

		slot0:onKeyChanged_({
			layoutName = slot0.layoutName_,
			buttonName = slot0.itemData_.buttonName,
			buttonInt = slot0.itemData_.buttonInt,
			key = slot1,
			keyName = slot2,
			oldKey = slot5,
			oldKeyName = slot0.itemData_.keyName
		})
	end
end

function slot0.StartListeningNewKey(slot0)
	if slot0:IsOpNotAllow(slot0.itemData_.buttonName) then
		ShowTips("INPUT_KEY_UNCHANGEABLE")

		return
	end

	gameContext:Go("gameKeyListening", {
		gamepadType = slot0.gamepadType_,
		listenCallback = function (slot0)
			uv0:SetKey(slot0)
		end
	})
end

function slot0.IsOpNotAllow(slot0, slot1)
	return LuaHidTools.IsOpNotAllow(slot0.gamepadType_, slot1)
end

function slot0.GetKeyIcon(slot0, slot1)
	return LuaForGamepad.GetKeyIcon(slot1, slot0.gamepadType_)
end

return slot0
