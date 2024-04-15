slot1 = class("ActivityHeroEnhanceSectionItem", import("game.views.sectionSelect.SectionBaseItem"))

function slot1.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("activityHeroEnhanceSectionInfo")
end

function slot1.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)
end

function slot1.RefreshStar(slot0)
	slot1 = BattleHeroEnhanceCfg[slot0.stageID_]

	for slot6 = 1, 3 do
		slot0.threeStarBarList_[slot6]:SetData(ActivityHeroEnhanceData:IsStageClear(slot0.activityId_, slot0.stageID_))
	end
end

function slot1.GetTag(slot0)
	return BattleHeroEnhanceCfg[slot0.stageID_] and slot1.tag or 0
end

function slot1.GetPosition(slot0)
	return BattleHeroEnhanceCfg[slot0.stageID_] and slot1.position or {
		0,
		0
	}
end

function slot1.RefreshData(slot0)
	slot0.enoughLevel_ = true
	slot0.isLock_ = not slot0:IsUnlockPreStage()
end

function slot1.IsUnlockPreStage(slot0)
	return ActivityHeroEnhanceTools.IsCfgStageUnlock(ActivityHeroEnhanceCfg[slot0.cfgId_], slot0.stageID_)
end

function slot1.SetData(slot0, slot1, slot2)
	slot0.cfgId_ = slot1
	slot0.activityId_ = ActivityHeroEnhanceCfg[slot1].activity_id
	slot0.stageID_ = slot2
	slot0.stageType_ = BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot1.SetClickHandler(slot0, slot1)
	slot0.onClickCallback_ = slot1
end

function slot1.OnClick(slot0)
	if slot0.onClickCallback_ then
		slot0.onClickCallback_(slot0.stageID_, slot0.isLock_)
	end
end

function slot1.RefreshText(slot0)
	slot0.text_.text = GetI18NText(BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).name)
end

return slot1
