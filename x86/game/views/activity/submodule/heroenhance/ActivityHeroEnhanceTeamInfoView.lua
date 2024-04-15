slot1 = class("ActivityHeroEnhanceTeamInfoView", import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView"))

function slot1.GetHeroList(slot0)
	slot3 = ActivityHeroEnhanceCfg[slot0.params_.heroEnhance_CfgID].hero_id

	return HeroTools.Sort({
		[slot3] = HeroData:GetHeroData(slot3)
	})
end

return slot1
