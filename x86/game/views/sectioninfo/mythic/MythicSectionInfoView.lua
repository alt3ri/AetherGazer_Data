slot0 = class("MythicSectionInfoView", import("..SectionInfoBaseView"))

function slot0.Init(slot0)
	uv0.super.Init(slot0)
	slot0.hideStageNumController_:SetSelectedState("true")

	slot0.sectionInfoThreeStarBar_ = SectionInfoThreeStarBar.New(slot0.threeStarGo_)
	slot0.sectionInfoAffixBar_ = SectionInfoAffixBar.New(slot0.affixGo_)
end

function slot0.RefreshData(slot0)
	slot1 = BattleMythicStageCfg[slot0.stageID_]
	slot0.lock_ = false
	slot0.lockTips_ = ""
	slot0.cost_ = 0
	slot0.dropLibID_ = {}
	slot0.isFirstClear_ = MythicData:GetIsFirstClear(slot0.partition_)

	slot0:RefreshThreeStarData()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.partition_ = slot0.params_.partition
	slot0.stageID_ = slot0.params_.stageID

	slot0:RefreshData()
	slot0:RefreshUI()

	slot0.stageType_ = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC

	slot0:RefreshTitleDesc()
end

function slot0.OnExit(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RemoveListener(CURRENCY_UPDATE, slot0.currencyUpdateHandle_)
	SetActive(slot0.debuffAffixBtn_.gameObject, true)
end

function slot0.OnUpdate(slot0)
	if slot0.partition_ == slot0.params_.partition and slot0.stageID_ == slot0.params_.stageID then
		return
	end

	slot0.partition_ = slot0.params_.partition
	slot0.stageID_ = slot0.params_.stageID

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.RefreshThreeStarData(slot0)
	slot0.threeStarDataList_ = {}
	slot2 = MythicData:GetStarOpen(slot0.stageID_)

	for slot6 = 1, 3 do
		slot0.threeStarDataList_[slot6] = {
			slot2 and slot2.stars[slot6] == 1 or false,
			BattleMythicStageCfg[slot0.stageID_].three_star_need[slot6]
		}
	end
end

function slot0.RefreshUI(slot0)
	slot0:RefreshStageInfo()
	slot0.hideFatigueController_:SetSelectedState("close")
	slot0.hideBattleAffixController_:SetSelectedState("true")
	slot0.hideAffixController_:SetSelectedState("false")

	if slot0.params_.isMain then
		slot0.hideStageDescController_:SetSelectedState("true")
		slot0.sectionInfoAffixBar_:SetData(slot0.params_.isMain, slot0.params_.affix, GetTips("MYTHIC_CUR_AFFIX"))
		slot0.hideThreeStarController_:SetSelectedState("false")
		slot0.sectionInfoThreeStarBar_:SetData(slot0.threeStarDataList_)
	else
		slot0.hideStageDescController_:SetSelectedState("false")
		slot0.sectionInfoAffixBar_:SetData(slot0.params_.isMain, slot0.params_.affix, GetTips("MYTHIC_LEVEL_UNLOCK_AFFIX"))
		slot0.hideThreeStarController_:SetSelectedState("true")
	end
end

function slot0.RefreshStageInfo(slot0)
	slot2 = BattleMythicStageCfg[slot0.stageID_]
	slot0.sectionName_.text = GetI18NText(slot2.name)
	slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot2.background_1))
	slot0.storyText_.text = GetI18NText(slot2.tips)
end

function slot0.OnClickBtn(slot0)
	slot0:Go("/sectionSelectHero", {
		section = slot0.stageID_,
		partition = slot0.partition_,
		difficulty = slot0.params_.difficulty,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC
	})
end

function slot0.Dispose(slot0)
	slot0.sectionInfoThreeStarBar_:Dispose()

	slot0.sectionInfoThreeStarBar_ = nil

	slot0.sectionInfoAffixBar_:Dispose()

	slot0.sectionInfoAffixBar_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
