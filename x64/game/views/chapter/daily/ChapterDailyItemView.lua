slot0 = class("ChapterDailyItemView", import("..ChapterBaseItemView"))

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:AddRedPoint()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:RemoveRedPoint()
end

function slot0.RefreshCustomItem(slot0, slot1)
	if slot0.oldCfgID_ ~= slot1.id then
		slot0.nameText_.text = GetI18NText(slot1.name)

		SetSpriteWithoutAtlasAsync(slot0.icon_, slot1.drop_icon)

		slot0.oldCfgID_ = slot1.id
	end
end

function slot0.ClickItem(slot0, slot1)
	if slot0.isLock_ then
		ShowTips(slot0.lockTips_)

		return
	end

	slot4 = ChapterClientCfg[slot1].chapter_list[1]

	if BattleFieldData:GetStageByClientID(slot1) then
		slot4 = getChapterIDByStageID(slot5)
	end

	JumpTools.OpenPageByJump("/daily", {
		chapterID = slot4
	})
end

function slot0.AddRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.panelTf_, ChapterTools.GetRedPoint(slot0.chapterClientID_))
end

function slot0.RemoveRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.panelTf_, ChapterTools.GetRedPoint(slot0.chapterClientID_))
end

return slot0
