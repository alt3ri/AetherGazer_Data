slot1 = class("AdvanceTestTeamInfoView", import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView"))

function slot1.GetHeroList(slot0)
	return AdvanceTestData:GetSortedHeroList()
end

return slot1
