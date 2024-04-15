slot1 = class("ActivityWorldBossSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.CustomCheckBeforeBattle(slot0)
	if not ActivityData:GetActivityIsOpen(slot0.activityID) then
		return false, "TIME_OVER"
	end

	return true
end

function slot1.GetStageData(slot0)
	return BattleActivityWorldBossTemplate.New(ActivityWorldBossData:GetStageId(slot0.activityID), slot0.activityID)
end

return slot1
