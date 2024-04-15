slot0 = class("ActivityHeroEnhanceSectionAttachView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot2), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.heroItem_ = ActivityHeroEnhanceHeroItem.New(slot0.heroGo_)
	slot0.talentList_ = LuaList.New(handler(slot0, slot0.IndexTalentItem), slot0.talentListGo_, ActivityHeroEnhanceTalentItem)
end

function slot0.AddUIListener(slot0)
end

function slot0.IndexTalentItem(slot0, slot1, slot2)
	slot3 = slot0.talentIdList_[slot1]

	slot2:SetData(slot0.activityId_, slot3)

	if slot3 then
		slot2:SetLock(ActivityHeroEnhanceTools.IsTalentLock(slot0.activityId_, slot3))
		slot2:SetFirstAddFlag(false)
	else
		slot4 = slot1
		slot5 = ActivityHeroEnhanceCfg[slot0.cfgId_]

		slot2:SetLock(ActivityHeroEnhanceTools.IsCfgTalentStageLock(slot5, slot4, true))
		slot2:SetFirstAddFlag(ActivityHeroEnhanceTools.IsCfgTalentStageFirstCanAdd(slot5, slot4))
	end

	slot2:SetClickHandler(function (slot0)
		JumpTools.OpenPageByJump("/activityHeroEnhanceHero", {
			activityID = uv0.activityId_,
			cfgId = uv0.cfgId_,
			stageToView = uv1,
			talentIdToView = slot0
		})
	end)
	slot2:RefreshUI()
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.cfgId_ = slot1
	slot0.activityId_ = ActivityHeroEnhanceCfg[slot1].activity_id
	slot0.talentIdList_ = slot2

	slot0.heroItem_:SetData(slot1)
end

function slot0.RefreshUI(slot0)
	slot0.heroItem_:SetIgnorePass(true)
	slot0.heroItem_:RefreshUI()
	slot0.talentList_:StartScroll(ActivityHeroEnhanceTools.GetCfgTalentMaxStage(ActivityHeroEnhanceCfg[slot0.cfgId_]))
end

function slot0.Dispose(slot0)
	slot0.heroItem_:Dispose()
	slot0.talentList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
