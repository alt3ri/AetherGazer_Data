slot0 = class("SettingToggleItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn01, nil, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.index)
		end
	end)
	slot0:AddBtnListener(slot0.m_btn02, nil, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.index)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	manager.redPoint:unbindUIandKey(slot0.transform_)

	slot0.index = slot1
	slot3 = slot2:Image()
	slot0.icon_01.sprite = slot3
	slot0.icon_02.sprite = slot3
end

function slot0.SetSelect(slot0, slot1)
	if slot0.index == slot1 then
		slot0.selectController:SetSelectedIndex(0)
	else
		slot0.selectController:SetSelectedIndex(1)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
	uv0.super.Dispose(slot0)
end

return slot0
