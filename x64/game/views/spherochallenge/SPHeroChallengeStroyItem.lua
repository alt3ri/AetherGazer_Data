slot0 = class("SPHeroChallengeStroyItem", import("game.views.sectionSelect.SectionBaseItem"))

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("spHeroChallengeSectionView")
end

function slot0.InitCustom(slot0)
	SetActive(slot0.collectGo_, false)
	SetActive(slot0.storyIconGo_, false)
end

function slot0.OnClick(slot0)
	if not slot0.isLock_ then
		slot0:Go("spHeroChallengeSectionView", {
			challengeType = SpHeroChallengeConst.ChapterType.story,
			sectionType = BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1,
			section = slot0.stageID_
		})
	end
end

function slot0.RefreshData(slot0)
end

function slot0.RefreshUI(slot0)
	slot1 = slot0:GetPosition()
	slot0.transform_.localPosition = Vector3(slot1[1], slot1[2], 0)
	slot0.isLock_ = not table.indexof(SPHeroChallengeTools:GetStoryOpenStageList(SPHeroChallengeData.activityCfg[SPHeroChallengeData:GetActivityID()].storyChapter, BattleVerthandiExclusiveCfg), slot0.stageID_)

	slot0.isBossController_:SetSelectedState("false")
	SetActive(slot0.gameObject_, not slot0.isLock_)
	slot0:RefreshText()
	slot0:RefreshStar()
end

function slot0.GetPosition(slot0)
	return BattleVerthandiExclusiveCfg[slot0.stageID_] and slot1.position or {
		0,
		0
	}
end

function slot0.RefreshText(slot0)
	slot0.text_.text = BattleVerthandiExclusiveCfg[slot0.stageID_].name
end

function slot0.RefreshStar(slot0)
	if SPHeroChallengeData:GetCurActivityInfo():CheckStoryFinState(slot0.stageID_) then
		for slot6 = 1, 3 do
			slot0.threeStarBarList_[slot6]:SetData(true)
		end
	else
		for slot6 = 1, 3 do
			slot0.threeStarBarList_[slot6]:SetData(false)
		end
	end
end

return slot0
