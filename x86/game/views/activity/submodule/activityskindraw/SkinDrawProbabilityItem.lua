slot0 = class("SkinDrawProbabilityItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.RefreshData(slot0, slot1)
	slot0:Show(true)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
