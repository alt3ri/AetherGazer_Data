slot0 = class("PolyhedronOverBeaconItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2)
	slot0.transform_ = slot0.gameObject_.transform

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
	slot0.id = slot1
	slot2 = PolyhedronBeaconCfg[slot0.id]
	slot0.m_icon.sprite = getSpriteWithoutAtlas(PolyhedronConst.BEACON_ICON_PATH .. slot2.icon)
	slot0.m_name.text = GetI18NText(slot2.name)
	slot0.m_des.text = GetI18NText(slot2.desc)

	slot0:SetActive(true)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_desTrs)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
