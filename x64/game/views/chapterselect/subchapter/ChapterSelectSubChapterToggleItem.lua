slot0 = class("ChapterSelectSubChapterToggleItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectController_ = slot0.controllerEx_:GetController("select")
	slot0.lockController_ = slot0.controllerEx_:GetController("lock")
	slot0.isCompleteController_ = slot0.controllerEx_:GetController("clear")

	slot0:SetData(slot3)
	slot0:OnEnter()
end

function slot0.SetData(slot0, slot1)
	slot0.chapterClientID_ = slot1

	getSpriteWithoutAtlasAsync(SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[slot1].chapter_paint, function (slot0)
		if uv0.paintImage_ then
			uv0.paintImage_.sprite = slot0
		end
	end)
	slot0:Show(true)
end

function slot0.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.redRoot_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, slot0.chapterClientID_))
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.redRoot_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, slot0.chapterClientID_))
end

function slot0.SetSelect(slot0, slot1)
	slot0.isCompleteController_:SetSelectedState(tostring(ChapterTools.GetChapterClientFinishPercentage(slot0.chapterClientID_) == 1))
	slot0.selectController_:SetSelectedState(tostring(slot1))
	slot0.transform_:SetAsLastSibling()
end

function slot0.RefreshLock(slot0)
	slot0.isLock_ = not ChapterTools.IsUnlockSubPlotClient(ChapterClientCfg[slot0.chapterClientID_].chapter_list[1])

	slot0.lockController_:SetSelectedState(tostring(slot0.isLock_))
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.paintImage_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		slot0 = uv0.chapterClientID_

		if ChapterClientCfg[BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT)].id ~= slot0 then
			BattleFieldAction.ChangeSelectChapterID(BattleFieldData:GetCacheChapter(slot0))

			return
		end
	end)
end

function slot0.GetLocalPosition(slot0)
	return slot0.transform_.localPosition
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
