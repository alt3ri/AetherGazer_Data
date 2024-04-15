slot0 = class("SurpassUpAttrItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUi(slot0, slot1, slot2, slot3)
	slot4 = PublicAttrCfg[slot1]
	slot0.icon01Img_.sprite = getSprite("Atlas/SystemCommonAtlas", slot4.icon)
	slot0.textattack01Text_.text = slot4.name
	slot0.textnum01Text_.text = slot4.percent == 1 and string.format("%.2f", (slot3 - slot2) / 10) .. "%" or string.format("%.0f", slot3 - slot2)
	slot0.textnumup01Text_.text = slot4.percent == 1 and string.format("%.2f", slot3 / 10) .. "%" or string.format("%.0f", slot3)

	slot0:SetActive(true)
end

function slot0.SetActive(slot0, slot1)
	slot0.gameObject_:SetActive(slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
