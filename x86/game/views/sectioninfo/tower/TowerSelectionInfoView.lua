slot0 = class("TowerSelectionInfoView", import("..SectionInfoBaseView"))

function slot0.Init(slot0)
	uv0.super.Init(slot0)
	slot0.hideStageDescController_:SetSelectedState("false")
	slot0.hideDropPanelController_:SetSelectedState("false")
	slot0.guildStateController_:SetSelectedState("hide")
	slot0.hideFatigueController_:SetSelectedState("close")
end

function slot0.OnEnter(slot0)
	slot0.towerId_ = slot0.params_.towerId
	slot0.curId = slot0.params_.curId
	slot0.clickBackFunc_ = slot0.params_.clickBackFunc
	slot0.btnTips_ = slot0.params_.btnTips

	slot0:RefreshData()
	slot0:RefreshUI()

	slot0.stageType_ = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER

	slot0:RefreshTitleDesc()
end

function slot0.OnUpdate(slot0)
	if slot0.towerId_ == slot0.params_.towerId then
		return
	end

	slot0.towerId_ = slot0.params_.towerId
	slot0.btnTips_ = slot0.params_.btnTips

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.RefreshData(slot0)
	slot0.cfg_ = BattleTowerStageCfg[slot0.towerId_]
	slot0.lock_ = false
	slot0.lockTips_ = ""
	slot0.cost_ = 0
	slot0.dropLibID_ = slot0.cfg_.drop_lib_id
	slot0.isFirstClear_ = slot0.curId and slot0.curId <= slot0.towerId_
end

function slot0.RefreshUI(slot0)
	slot0:RefreshReward()

	slot0.sectionName_.text = GetI18NText(slot0.cfg_.name)
	slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot0.cfg_.background_1))
	slot0.storyText_.text = GetI18NText(slot0.cfg_.tips)
	slot0.btnText_.text = slot0.btnTips_
end

function slot0.OnClickBtn(slot0)
	slot1 = slot0.towerId_

	if not slot0.curId or slot1 <= slot0.curId then
		if BattleTowerStageCfg[slot1].level <= PlayerData:GetPlayerInfo().userLevel then
			JumpTools.Back()
			slot0:Go("/sectionSelectHero", {
				section = slot1,
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER
			})
		else
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot3))
		end
	else
		slot0.clickBackFunc_()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
