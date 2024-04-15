slot1 = class("SoloChallengeSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.InitCustomParams(slot0)
	slot0.needMimirPanel = false
	slot0.canChangeTeam = false
end

return slot1
