slot1 = class("AttributeArenaSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.InitCustomParams(slot0, slot1)
	slot0.attribute_arena_id = slot1.attribute_arena_id
end

function slot1.GetHeroTeamInfoRoute(slot0)
	return "/heroTeamInfoAttributeArena"
end

function slot1.GetCustomeTeamInfoParams(slot0, slot1)
	return {
		attribute_arena_id = slot0.attribute_arena_id
	}
end

function slot1.GetStageData(slot0)
	return BattleActivityAttributeArenaTemplate.New(slot0.stageID, slot0.activityID, slot0.attribute_arena_id)
end

return slot1
