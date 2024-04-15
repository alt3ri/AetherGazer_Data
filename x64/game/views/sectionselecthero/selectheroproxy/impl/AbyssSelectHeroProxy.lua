slot1 = class("AbyssSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.InitCustomParams(slot0, slot1)
	slot0.layer = slot1.layer
	slot0.curActivityID = slot1.curActivityID
	slot0.stageIndex = slot1.stageIndex
end

function slot1.CustomCheckBeforeBattle(slot0)
	if slot0.curActivityID ~= AbyssData:GetActivityId() then
		return false, "ERROR_ACTIVITY_NOT_OPEN"
	end

	return true
end

function slot1.GetHeroTeamInfoRoute(slot0)
	return "/abyssTeamInfo"
end

function slot1.GetCustomeTeamInfoParams(slot0, slot1)
	return {
		layer = slot0.layer
	}
end

function slot1.GetStageData(slot0)
	if AbyssData:GetAbyssCfg(slot0.layer).stage_list[slot0.stageIndex][1] == 3 then
		AbyssData:SetCurrentBossPhase(AbyssData:GetStageData(slot1.level, slot0.stageIndex).phase or 1)
	end

	slot3 = BattleStageFactory.Produce(slot0.stageType, slot0.stageID, {
		activityID = slot0.activityID,
		curActivityID = slot0.curActivityID
	})

	slot3:SetStageData(slot1.level, slot0.stageIndex)

	return slot3
end

return slot1
