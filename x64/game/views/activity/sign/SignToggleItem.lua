slot0 = class("SignToggleItem", ReduxView)

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

	slot0.selectController = slot0.m_ControllerEx_:GetController("select")
	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.iconControllerUnselect = slot0.m_iconControllerEx1_:GetController("icon")
	slot0.iconControllerSelect = slot0.m_iconControllerEx2_:GetController("icon")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.index)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	manager.redPoint:unbindUIandKey(slot0.transform_)

	slot0.index = slot1

	if slot2:RedPointKey() then
		manager.redPoint:bindUIandKey(slot0.transform_, slot2:RedPointKey())
	end

	slot0.m_title.text = GetI18NText(slot2:Title())
	slot0.m_selectTitle.text = GetI18NText(slot2:Title())

	if slot2:Image() then
		slot0.iconControllerUnselect:SetSelectedState(slot3)
		slot0.iconControllerSelect:SetSelectedState(slot3)
	end

	if PlayerData:GetPlayerInfo().userLevel < slot2:GetLimitLevel() then
		slot0.lockController:SetSelectedIndex(1)
	else
		slot0.lockController:SetSelectedIndex(0)
	end
end

function slot0.SetSelect(slot0, slot1)
	if slot0.index == slot1 then
		slot0.selectController:SetSelectedIndex(1)
	else
		slot0.selectController:SetSelectedIndex(0)
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
