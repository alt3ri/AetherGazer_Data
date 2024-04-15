slot1 = class("XH3rdWaterSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.InitCustomParams(slot0, slot1)
	slot0.roomProxy = slot1.roomProxy
	slot0.mainActivityID = slot1.mainActivityID
	slot0.needComboSkillPanel = false
	slot0.needMimirPanel = false
	slot0.needPresetReservePanel = false
end

function slot1.GetHeroTeamInfoRoute(slot0)
	return "/xH3rdWaterTeamInfo"
end

function slot1.GetCustomeTeamInfoParams(slot0, slot1)
	return {
		mainActivityID = slot0.mainActivityID,
		roomProxy = slot0.roomProxy
	}
end

function slot1.GetStageData(slot0)
	slot1 = BattleStageFactory.Produce(slot0.stageType_, slot0.stageID_, slot0.activityID)

	slot1:SetMainActivityId(slot0.mainActivityID)

	return slot1
end

return slot1
