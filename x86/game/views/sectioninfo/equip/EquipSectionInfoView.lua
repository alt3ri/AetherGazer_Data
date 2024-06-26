slot0 = class("EquipSectionInfoView", import("..SectionInfoMultipleBaseView"))

function slot0.OnClickBtn(slot0)
	slot0:Go("/sectionSelectHero", {
		section = slot0.stageID_,
		multiple = slot0.multiple_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP
	})
end

function slot0.Init(slot0)
	uv0.super.Init(slot0)
	slot0.hideStageDescController_:SetSelectedState("false")
	slot0.hideDropPanelController_:SetSelectedState("false")
end

function slot0.RefreshData(slot0)
	slot1 = BattleEquipStageCfg[slot0.stageID_]
	slot0.lock_ = JumpTools.IsConditionLocked({
		ViewConst.SYSTEM_LOCK_TYPE.LEVEL,
		GameSetting.equip_stage_unlock.value[BattleInstance.GetHardLevel(slot0.stageID_)]
	}) and true or false
	slot0.lockTips_ = JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.BATTLE_EQUIP_SECTION, {
		ViewConst.SYSTEM_LOCK_TYPE.LEVEL,
		slot2[slot3]
	})
	slot0.cost_ = slot1.cost
	slot0.dropLibID_ = slot1.drop_lib_id
	slot0.isFirstClear_ = false

	uv0.super.RefreshData(slot0)
end

function slot0.RefreshStageInfo(slot0)
	slot2 = BattleInstance.GetHardLevel(slot0.stageID_)

	if slot0.oldCfgID_ ~= BattleEquipStageCfg[slot0.stageID_].id then
		slot0.sectionName_.text = GetI18NText(slot1.name)
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
		slot0.oldCfgID_ = slot1.id
	end

	slot3 = BattleEquipData:GetGuaranteeNum()[slot2] or 0

	if EquipStageInsureCfg[slot2].insure_times == 0 then
		slot0.storyText_.text = GetI18NText(slot1.tips)
	else
		slot0.storyText_.text = GetI18NText(slot1.tips) .. string.format(GetTips("EQUIP_STAGE_INSURE"), slot4 - slot3)
	end

	slot5, slot6 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP, slot0.stageID_)
	slot0.sectionText_.text = string.format("%s%s", GetI18NText(slot5), GetI18NText(slot6))
end

return slot0
