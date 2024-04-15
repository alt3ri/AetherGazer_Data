slot0 = class("HeroTrammelsAttrItem", ReduxView)

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
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1)
	slot3 = ""
	slot0.m_attrName.text = PublicAttrCfg[slot1[1]].name
	slot0.m_attrAdd.text = (PublicAttrCfg[slot1[1]].percent ~= 1 or string.format("+%.2f%%", slot1[2] / 10)) and string.format("+%d", slot1[2])
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
