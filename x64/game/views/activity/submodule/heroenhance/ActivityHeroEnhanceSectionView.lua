slot1 = class("ActivityHeroEnhanceSectionView", import("game.views.sectionSelect.SectionBaseView"))

function slot1.UIName(slot0)
	return ActivityHeroEnhanceTools.GetStageUIName(slot0.params_.activityID)
end

function slot1.GetCfgName(slot0)
	return BattleHeroEnhanceCfg
end

function slot1.GetSectionItemClass(slot0)
	return ActivityHeroEnhanceSectionItem
end

function slot1.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("activityHeroEnhanceSectionInfo")
end

function slot1.RefreshBGM(slot0)
end

function slot1.Init(slot0)
	uv0.super.Init(slot0)
end

function slot1.InitCustom(slot0)
	slot0:BindCfgUI()
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	if slot0.params_.exitFromBattle then
		ActivityHeroEnhanceHeroView.enterBattleCfgId_ = slot0.params_.cfgId
		slot0.params_.exitFromBattle = nil
	end
end

function slot1.RefreshData(slot0)
	slot1 = slot0.params_.cfgId
	slot0.activityId_ = slot0.params_.activityID
	slot0.cfgId_ = slot1
	slot0.stageList_ = ActivityHeroEnhanceCfg[slot1].stage_list
	slot0.oepnStageList_ = {}

	for slot6, slot7 in ipairs(slot0.stageList_) do
		if ActivityHeroEnhanceTools.IsCfgStageUnlock(slot2, slot7) then
			table.insert(slot0.oepnStageList_, slot7)
		end
	end

	slot3 = slot0:GetAttachView()

	slot3:SetData(slot1, ActivityHeroEnhanceTools.GetCfgActivatedTalentDict(slot2))
	slot3:RefreshUI()
end

function slot1.GetAttachView(slot0)
	if slot0.attachView_ == nil then
		slot0.attachView_ = ActivityHeroEnhanceSectionAttachView.New(slot0.setionAttachGo_, ActivityHeroEnhanceTools.GetStageAttachUIName(slot0.activityId_))
	end

	return slot0.attachView_
end

function slot1.OnClickSectionItem(slot0, slot1, slot2)
	if not slot2 then
		slot0:Go("activityHeroEnhanceSectionInfo", {
			section = slot1,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE,
			activityID = slot0.activityId_,
			heroEnhance_CfgID = slot0.cfgId_
		})
	end
end

function slot1.RefreshMissionList(slot0)
	for slot4 = #slot0.stageList_ + 1, #slot0.missionItem_ do
		slot0.missionItem_[slot4]:Show(false)
	end

	for slot4 = 1, #slot0.stageList_ do
		if slot0.missionItem_[slot4] == nil then
			slot5 = slot0:GetSectionItemClass().New(slot0.sectionItem_, slot0.content_)
			slot0.missionItem_[slot4] = slot5

			slot5:SetClickHandler(function (slot0, slot1)
				uv0:OnClickSectionItem(slot0, slot1)
			end)
		end

		slot5:SetData(slot0.cfgId_, slot0.stageList_[slot4])
		slot5:RefreshData()
		slot5:RefreshUI()
	end

	slot0:CreateLineItemList()
end

function slot1.CreateLineItemList(slot0)
	slot0.lineType_ = 0
	slot1 = 0

	for slot6, slot7 in ipairs(slot0.oepnStageList_) do
		for slot14, slot15 in ipairs(slot0:GetCfgName()[slot7].next_unlock_id_list or {}) do
			slot16 = slot0:GetCfgName()[slot7]

			if table.keyof(slot2, slot15) then
				slot0.lineList_[slot1] = slot0.lineList_[slot1 + 1] or slot0:GetLineClass(slot0.lineType_).New(slot0:GetLineGo(slot0.lineType_), slot0.content_, slot0:GetPointGo(slot0.lineType_))

				slot0.lineList_[slot1]:Show(true)
				slot0.lineList_[slot1]:RefreshUI(slot0.missionItem_[table.keyof(slot0.stageList_, slot7)]:GetLocalPosition() + Vector3(0, 0, 0), slot0.missionItem_[table.keyof(slot0.stageList_, slot15)]:GetLocalPosition() + Vector3(0, 0, 0))
			end
		end
	end

	for slot6, slot7 in pairs(slot0.lineList_) do
		slot7:Show(slot6 <= slot1)
	end
end

function slot1.Dispose(slot0)
	if slot0.attachView_ then
		slot0.attachView_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot1
