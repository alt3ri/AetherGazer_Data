slot1 = class("ReserveProposalSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.CustomSaveTeam(slot0)
	ReserveTools.SetTeam(slot0.reserveParams, slot0:GetHeroIDList(), slot0:GetTrialIDList(), slot0.comboSkillID, slot0.mimirID, slot0.chipList)
end

function slot1.GetSelectHeroViewClass(slot0)
	return ReserveProposalSelectHeroView
end

return slot1
