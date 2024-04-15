local var_0_0 = class("ChapterEquipItemView", import(".ChapterEquipItemBaseView"))

function var_0_0.AddRedPoint(arg_1_0)
	manager.redPoint:bindUIandKey(arg_1_0.panelTf_, ChapterTools.GetRedPoint(arg_1_0.chapterClientID_))
end

function var_0_0.RemoveRedPoint(arg_2_0)
	manager.redPoint:unbindUIandKey(arg_2_0.panelTf_, ChapterTools.GetRedPoint(arg_2_0.chapterClientID_))
end

return var_0_0
