slot0 = class("PopFukubukuroProbabilityItem", ReduxView)

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

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot4 = slot1[1]
	slot7 = ItemCfg[slot4]
	slot0.m_name.text = ItemTools.getItemName(slot4) .. "x" .. slot1[2]
	slot8 = slot1[3] / slot3

	for slot13, slot14 in ipairs(slot2) do
		slot16 = slot14[2]
		slot18 = slot14[3] / slot3

		if slot14[1] ~= slot4 then
			slot9 = slot8 / (1 - slot8) * slot18 + slot18 / (1 - slot18) * slot8 + 0
		end
	end

	slot0.m_probability.text = string.format("%.2f", math.floor(slot9 * 10000) / 100) .. "%"
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
