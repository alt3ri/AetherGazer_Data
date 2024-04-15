local var_0_0 = class("ChapterEquipEnchantmentItemView", import(".ChapterEquipItemBaseView"))

function var_0_0.AddRedPoint(arg_1_0)
	manager.redPoint:bindUIandKey(arg_1_0.panelTf_, RedPointConst.DAILY_EQUIP_ENCHANT)
end

function var_0_0.RemoveRedPoint(arg_2_0)
	manager.redPoint:unbindUIandKey(arg_2_0.panelTf_, RedPointConst.DAILY_EQUIP_ENCHANT)
end

return var_0_0
