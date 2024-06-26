slot0 = class("SectionSelectHeroSoloChallengeView", SectionSelectHeroBaseView)

function slot0.GoHeroInfoUI(slot0, slot1)
	ShowTips("CAN_NOT_CHANGE_HERO")
end

function slot0.RefreshChip(slot0)
	slot1 = false

	SetActive(slot0.chipPanel_, slot1)

	if slot1 then
		slot0.chipView_:SetData(slot0.stageType_, slot0.stageID_)
	end
end

function slot0.RefreshRace(slot0)
	uv0.super.RefreshRace(slot0)
	SetActive(slot0.effectPanel_, false)
end

function slot0.GetSelectHero(slot0)
	slot1 = false
	slot0.cacheHeroTeam_, slot0.lockStateList_, slot0.lockList_, slot0.heroTrialList_, slot1 = ReserveTools.GetHeroList(slot0.reserveParams_)
end

return slot0
