slot0 = class("HeroFileRoleTabItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.onClick_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = slot0.roleControllerEx_:GetController("select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.selectBtn_, nil, slot0.onClick_)
end

function slot0.Show(slot0, slot1)
	slot0.iconImg_.sprite = getSpriteViaConfig("HeroLittleIcon", HeroTools.HeroUsingSkinInfo(slot1).id)

	SetActive(slot0.gameObject_, true)
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.SetSelectState(slot0, slot1)
	slot0.selectController_:SetSelectedState(slot1 and "select" or "cancel")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
