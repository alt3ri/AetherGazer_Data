slot1 = class("ActivityHeroEnhanceSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.InitCustomParams(slot0, slot1)
	slot0.needMimirPanel = false
	slot0.canChangeMimir = false
	slot0.needPresetReservePanel = false
	slot0.canChangePresetReserve = false
	slot0.heroEnhance_CfgID = slot1.heroEnhance_CfgID
end

function slot1.GetCustomeTeamInfoParams(slot0, slot1)
	return {
		heroEnhance_CfgID = slot0.heroEnhance_CfgID
	}
end

function slot1.GetStageData(slot0)
	return BattleActivityHeroEnhanceTemplate.New(slot0.stageID, slot0.activityID, slot0.heroEnhance_CfgID)
end

return slot1
