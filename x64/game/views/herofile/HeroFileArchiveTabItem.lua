slot0 = class("HeroFileArchiveTabItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.itemIndex = slot2
	slot0.onClick_ = slot3

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.titleText_.text = string.format(GetTips("HERO_RECORD_HEART_CHAIN"), slot0.itemIndex)
	slot0.lockController_ = slot0.linktabitemControllerEx_:GetController("lock")
	slot0.selectController_ = slot0.linktabitemControllerEx_:GetController("select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.selectBtn_, nil, slot0.onClick_)
end

function slot0.SetLockState(slot0, slot1)
	slot0.lockController_:SetSelectedState(slot1 and "lock" or "unlock")
end

function slot0.SetSelectState(slot0, slot1)
	slot0.selectController_:SetSelectedState(slot1 and "select" or "cancel")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
