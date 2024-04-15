slot0 = class("SPHeroChallengeStoryView", import("game.views.sectionSelect.SectionBaseView"))
slot1 = 300

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.activityID_ = slot2
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:UIName()), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	uv0.super.Init(slot0)

	slot0.scrollMoveView_.viewportRect_.sizeDelta = Vector2(slot0.scrollViewTrs.sizeDelta.x - uv1, slot0.scrollMoveView_.viewportRect_.sizeDelta.y)
	slot0.scrollMoveView_.viewportRect_.anchoredPosition = Vector2(uv1 + slot0.scrollViewTrs.sizeDelta.x / 2, slot0.scrollMoveView_.viewportRect_.anchoredPosition.y)
end

function slot0.OnEnter(slot0)
	slot1 = SPHeroChallengeData:GetCurActivityInfo()

	if #slot1.storyFinStageList + 1 > #slot1.storyFinStageList then
		slot2 = #slot1.storyFinStageList
	end

	slot3 = slot0:GetCfgName().get_id_list_by_sub_type[SpHeroChallengeConst.BattleSubType.story][slot2]

	uv0.super.OnEnter(slot0)

	if slot0.params_.isDetailJump then
		for slot8, slot9 in pairs(slot0.missionItem_) do
			if slot9.stageID_ == SPHeroChallengeTools:GetNextCanBattleStageID(SpHeroChallengeConst.ScheduleSubType.story) then
				slot9:OnClick()
			end
		end

		slot0.params_.isDetailJump = nil
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.OnUpdate(slot0)
	if slot0:IsOpenSectionInfo() then
		slot0.state = 1
	else
		slot0.state = 2
	end

	uv0.super.OnUpdate(slot0)
end

function slot0.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)
	slot0:SwitchBG()
end

function slot0.OnExit(slot0)
	if slot0.state == 1 then
		slot0.state = 2
	end

	uv0.super.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.gameObject_ then
		GameObject.Destroy(slot0.gameObject_)

		slot0.gameObject_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.GetCfgName(slot0)
	return BattleVerthandiExclusiveCfg
end

function slot0.GetSectionItemClass(slot0)
	return SPHeroChallengeStroyItem
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("spHeroChallengeSectionView")
end

function slot0.RefreshData(slot0)
	slot0.chapterID_ = SPHeroChallengeData.activityCfg[slot0.activityID_].storyChapter
	slot0.stageData_ = {}
	slot0.stageList_ = ChapterCfg[slot0.chapterID_].section_id_list

	for slot4, slot5 in ipairs(slot0.stageList_) do
		slot0.stageData_[slot5] = {
			id = slot0.stageList_[slot4]
		}
	end

	slot0.oepnStageList_ = SPHeroChallengeTools:GetStoryOpenStageList(slot0.chapterID_, slot0:GetCfgName())
end

return slot0
