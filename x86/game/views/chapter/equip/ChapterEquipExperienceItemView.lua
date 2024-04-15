slot0 = class("ChapterEquipExperienceItemView", import(".ChapterEquipItemView"))

function slot0.AddRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.panelTf_, ChapterTools.GetRedPoint(slot0.chapterClientID_))
end

function slot0.RemoveRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.panelTf_, ChapterTools.GetRedPoint(slot0.chapterClientID_))
end

return slot0
