slot0 = class("DrawProbabilityItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.RefreshData(slot0, slot1)
	slot0:Show(true)

	slot0.labName_.text = GetI18NText(slot1.name)
	slot0.labRate_.text = GetI18NText(slot1.probability)
	slot0.labRate2_.text = ""

	if slot1.probability2 then
		slot0.labRate2_.text = GetI18NText(slot1.probability2)
	end

	for slot7, slot8 in pairs(slot1.itemid_) do
		if (DrawItemCfg[slot8].item_id or 0) ~= 0 then
			slot11 = ItemCfg[slot10]
			slot3 = ("" ~= "" or ItemTools.getItemName(slot10)) and ItemTools.getItemName(slot10) .. "/" .. ItemTools.getItemName(slot10)
		end
	end

	slot0.labContent_.text = GetI18NText(slot3)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
