slot1 = class("HeroTeamInfoAttributeArenaView", import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView"))

function slot1.GetTrialHeroList(slot0)
	return AttributeArenaTools.GetTrialHeroList(slot0.params_.attribute_arena_id)
end

return slot1
