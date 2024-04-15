slot0 = class("ChapterSelectChapterToggleItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectController_ = slot0.controllerEx_:GetController("select")
	slot0.lockController_ = slot0.controllerEx_:GetController("lock")
	slot0.isCompleteController_ = slot0.controllerEx_:GetController("isComplete")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.chapterClientID_ = slot1

	if ChapterClientCfg[slot1].toggle == BattleConst.TOGGLE.PLOT then
		slot0.nameText_.text = slot3.desc
	else
		slot0.nameText_.text = slot3.name
	end

	slot4 = ChapterTools.GetChapterClientFinishPercentage(slot1)
	slot0.percentageText_.text = string.format("%s%%", math.floor(slot4 * 100))

	slot0.isCompleteController_:SetSelectedState(tostring(slot4 == 1))

	slot0.isLock_ = not ChapterTools.IsFinishPreChapter(slot3.chapter_list[1])

	slot0.lockController_:SetSelectedState(tostring(slot0.isLock_))
	slot0.selectController_:SetSelectedState(tostring(slot2))
	slot0.transform_:SetAsLastSibling()
	slot0:Show(true)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		slot0 = uv0.chapterClientID_

		if ChapterClientCfg[BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)].id ~= slot0 then
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
