slot0 = class("HeroTrammelsSwitchNetItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index = slot2

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.indexController = ControllerUtil.GetController(slot0.transform_, "index")

	slot0.indexController:SetSelectedIndex(slot0.index - 1)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_btn, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.index)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.stateController:SetSelectedIndex(slot1)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

return slot0
