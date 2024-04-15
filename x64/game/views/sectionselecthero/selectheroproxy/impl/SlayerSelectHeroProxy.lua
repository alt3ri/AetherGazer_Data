slot1 = class("SlayerSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.InitCustomParams(slot0, slot1)
	slot0.region_activity_id = slot1.region_activity_id
	slot0.slayer_activity_id = slot0.activityID
end

function slot1.CustomCheckBeforeBattle(slot0)
	if not ActivityData:GetActivityIsOpen(slot0.params_.region_activity_id) then
		return false, "TIP_EXPIRED"
	end

	return true
end

function slot1.GetStageData(slot0)
	return BattleStageFactory.Produce(slot0.stageType_, slot0.region_activity_id, slot0.slayer_activity_id)
end

return slot1
