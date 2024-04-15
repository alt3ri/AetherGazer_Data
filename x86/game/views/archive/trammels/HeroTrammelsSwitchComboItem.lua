slot0 = class("HeroTrammelsSwitchComboItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.level = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.m_lvLab.text = GetTips("LEVEL") .. slot0.level
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_btn, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.level)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	if slot0.level == slot2 then
		slot0.stateController:SetSelectedIndex(slot1 < slot0.level and 3 or 2)
	else
		slot0.stateController:SetSelectedIndex(slot3 and 0 or 1)
	end
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
