slot0 = class("ActivityMatrixAffixMiniView", MatrixAffixMiniView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/SoloRoguelike/ActivityMatrixAffixMiniUI"
end

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id
	slot0.regularData = {}
	slot0.customData = ActivityMatrixData:GetCustomAffix(slot0.matrix_activity_id) or {}

	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot0:RefreshRegularItems(slot0.regularData)
	slot0.stateController_:SetSelectedIndex(#slot0.customData == 0 and 1 or 0)
	slot0:RefreshCustomItems(slot0.customData)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_contentRect)

	for slot7, slot8 in ipairs(slot0.regularData) do
		slot9 = ActivityAffixPoolCfg[slot8]
		slot2 = 0 + slot9.point
		slot3 = 0 + slot9.multiple
	end

	for slot7, slot8 in ipairs(slot0.customData) do
		slot9 = ActivityAffixPoolCfg[slot8]
		slot2 = slot2 + slot9.point
		slot3 = slot3 + slot9.multiple
	end

	slot0.m_scoreLab.text = "" .. slot2
	slot0.m_retaLab.text = string.format(GetTips("MATRIX_AFFIX_RATE"), slot3 / 10 .. "%")
end

return slot0
