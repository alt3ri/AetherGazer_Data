slot0 = class("JumpToStep", BaseStep)

function slot0.Init(slot0, slot1)
	slot0.team = GuideStepCfg[slot0._stepId].params
end

function slot0.Play(slot0)
	slot2 = ReserveParams.New(ReserveConst.RESERVE_TYPE.PLOT, nil, )

	ReserveTools.SetHeroList(slot2, slot0.team, {
		0,
		0,
		0
	})
	ReserveTools.SetComboSkillID(slot2, ComboSkillTools.GetRecommendSkillID(slot0.team, true))
	slot0:OnStepEnd()
end

function slot0.GetShowMask(slot0)
	if slot0._stepId == 405 then
		return true
	end

	return false
end

return slot0
