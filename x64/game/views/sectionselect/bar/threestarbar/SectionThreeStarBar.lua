slot0 = class("SectionThreeStarBar", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.enabledController_ = slot0.controllerEx_:GetController("enabled")
end

function slot0.SetData(slot0, slot1)
	slot0.enabledController_:SetSelectedState(tostring(slot1))
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
