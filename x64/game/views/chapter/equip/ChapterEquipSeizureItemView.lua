slot0 = class("ChapterEquipSeizureItemView", import(".ChapterEquipItemBaseView"))

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.panelTf_, ChapterTools.GetRedPoint(slot0.chapterClientID_))
	slot0:AddRefreshTimer()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.panelTf_, ChapterTools.GetRedPoint(slot0.chapterClientID_))
	slot0:StopRefreshTimer()
end

function slot0.AddRefreshTimer(slot0)
end

function slot0.StopRefreshTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
