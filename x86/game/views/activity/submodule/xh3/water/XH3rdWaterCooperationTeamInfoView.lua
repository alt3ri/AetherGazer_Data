slot1 = class("XH3rdWaterCooperationTeamInfoView", import("game.views.cooperation.HeroTeamInfoCooperationView"))

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	SetActive(slot0.filterGo_, false)
end

return slot1
