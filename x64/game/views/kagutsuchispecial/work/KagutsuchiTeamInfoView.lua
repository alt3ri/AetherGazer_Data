slot1 = class("KagutsuchiTeamInfoView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.GetHeroList(slot0)
	slot1 = 1158

	return HeroTools.Sort({
		[slot1] = HeroData:GetHeroData(slot1)
	})
end

return slot1
