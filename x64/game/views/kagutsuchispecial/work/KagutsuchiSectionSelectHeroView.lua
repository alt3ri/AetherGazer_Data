slot1 = class("KagutsuchiSectionSelectHeroView", import("game.views.sectionSelectHero.SectionSelectHeroBaseView"))

function slot1.GoHeroInfoUI(slot0, slot1)
	if type(BattleStageTools.GetRestrictHeroList(slot0.stageType_, slot0.stageID_)) == "table" and (slot2[slot1][1] == 0 or slot3[1] ~= 0 and HeroCfg[slot3[1]] and not table.keyof(HeroCfg.get_id_list_by_private[0], slot3[1])) then
		ShowTips("CAN_NOT_CHANGE_HERO")

		return
	end

	slot0:Go("/kagutsuchiTeamInfo", {
		isEnter = true,
		selectHeroPos = slot1,
		stageID = slot0.stageID_,
		activityID = slot0.params_.activityID,
		stageType = slot0.stageType_,
		reserveParams = slot0.reserveParams_
	})
end

return slot1
