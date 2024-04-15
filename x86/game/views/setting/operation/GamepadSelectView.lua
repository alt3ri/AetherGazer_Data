slot0 = class("GamepadSelectView")

function slot0.UIName(slot0)
	return "Widget/System/Setting/GameSettinghandleUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:UIName()), slot0:UIParent())
	slot0.transform_ = slot0.gameObject_.transform
	slot0.gamepadType_ = slot1

	slot0:Init()
	slot0:OnEnter()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)

	slot0.selectController_ = slot0.controllerEx_:GetController("select")
end

function slot0.AddUIListener(slot0)
	slot0.confirmBtn_.onClick:AddListener(function ()
		slot0 = uv0:GetGamepadType(uv0.selectIdx_)

		LuaHidTools.SetPlayerSelectJoystick(slot0)
		uv0:CloseWindow()
		manager.notify:Invoke(JOYSTICK_TYPE_SELECT, slot0)
	end)
	slot0.cancelBtn_.onClick:AddListener(function ()
		uv0:CloseWindow()
	end)

	for slot4 = 1, 2 do
		if slot0["btn_" .. slot4] then
			slot5.onClick:AddListener(function ()
				uv0:SelectGamepad(uv1)
			end)
		end
	end
end

function slot0.RemoveUIListeners(slot0)
	slot0.confirmBtn_.onClick:RemoveAllListeners()
	slot0.cancelBtn_.onClick:RemoveAllListeners()

	for slot4 = 1, 2 do
		if slot0["btn_" .. slot4] then
			slot5.onClick:RemoveAllListeners()
		end
	end
end

function slot0.OnEnter(slot0)
	slot0:SetGaussionBg()

	slot1 = slot0.gamepadType_

	if PlayerPrefs.HasKey("JoystickType") then
		slot1 = LuaHidTools.GetPlayerSelectJoystick()
	end

	slot0:SelectGamepad(slot0:GetGamepadIndex(slot1))
end

function slot0.SelectGamepad(slot0, slot1)
	slot0.selectController_:SetSelectedState(slot1)

	slot0.selectIdx_ = slot1
end

function slot0.GetGamepadIndex(slot0, slot1)
	if slot1 == HID_TYPES.PS4 then
		return 1
	end

	return 2
end

function slot0.GetGamepadType(slot0, slot1)
	if slot1 == 1 then
		return HID_TYPES.PS4
	end

	return HID_TYPES.Xbox
end

function slot0.CloseWindow(slot0)
	slot0:RevertSeparate()
	slot0:Dispose()

	LuaHidTools.selectWin_ = nil
end

function slot0.SetGaussionBg(slot0)
	if not manager.ui:GetUISeparateRender() then
		manager.ui:SetUISeparateRender(true)

		slot0.separateFlag_ = true
	end
end

function slot0.RevertSeparate(slot0)
	if slot0.separateFlag_ then
		manager.ui:SetUISeparateRender(false)

		slot0.separateFlag_ = false
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveUIListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
