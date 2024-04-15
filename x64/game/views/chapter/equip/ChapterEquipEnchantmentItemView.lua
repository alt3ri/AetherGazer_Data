slot0 = class("ChapterEquipEnchantmentItemView", import(".ChapterEquipItemBaseView"))

function slot0.AddRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.panelTf_, RedPointConst.DAILY_EQUIP_ENCHANT)
end

function slot0.RemoveRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.panelTf_, RedPointConst.DAILY_EQUIP_ENCHANT)
end

return slot0
