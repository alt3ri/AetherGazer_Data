slot0 = class("AffixDescriptionView", ReduxView)

function slot0.SetActive(slot0, slot1)
	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, slot1)
	end
end

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.hander_ = slot1
	slot0.transform_ = slot2.transform
	slot0.gameObject_ = slot2
	slot0.data = slot3

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.emptyController = ControllerUtil.GetController(slot0.transform_, "empty")
	slot0.items = {}

	slot0:CreatItems()
end

function slot0.CreatItems(slot0)
	slot1 = 1

	for slot7, slot8 in ipairs(slot0.data) do
		slot9 = slot8[3] == 3
		slot2 = false or slot9
		slot3 = false or not slot9

		if not slot0.items[slot1] then
			slot10 = Object.Instantiate(slot0.m_item, slot9 and slot0.m_playerContent or slot0.m_monsterContent)
			slot0.items[slot1] = {
				go = slot10,
				desc = slot10.transform:Find("text"):GetComponent("Text"),
				name = slot10.transform:Find("title/name"):GetComponent("Text"),
				icon = slot10.transform:Find("title/icon"):GetComponent("Image")
			}
		end

		slot0:RenderItme(slot0.items[slot1], slot8)

		slot1 = slot1 + 1
	end

	if slot2 and slot3 then
		slot0.emptyController:SetSelectedIndex(0)
	elseif slot3 then
		slot0.emptyController:SetSelectedIndex(1)
	elseif slot2 then
		slot0.emptyController:SetSelectedIndex(2)
	else
		slot0.emptyController:SetSelectedIndex(3)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_content)
end

function slot0.RenderItme(slot0, slot1, slot2)
	slot1.icon.sprite = getAffixSprite(slot2)
	slot1.name.text = getAffixName(slot2)
	slot1.desc.text = getAffixDesc(slot2)

	SetActive(slot1.go, true)
end

function slot0.Dispose(slot0)
	slot0.items = {}

	uv0.super.Dispose(slot0)

	slot0.hander_ = nil
	slot0.data = nil
end

return slot0
