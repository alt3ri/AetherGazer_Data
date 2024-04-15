slot0 = class("TrainInfoSkillItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.lockController_ = slot0.mainControllerEx_:GetController("lock")
end

function slot0.SetData(slot0, slot1, slot2)
	slot3 = IdolTraineeSkillCfg[slot1.skill]
	slot0.name_.text = slot3.name
	slot0.desc_.text = IdolTraineeTools:GetSkillDescString(slot1.skill)
	slot0.icon_.sprite = IdolTraineeTools:GetSkillIcon(slot1.skill)
	slot0.typeText_.text = GetTips("IDOL_DANCE_SKILL_TYPE_TIPS_" .. slot3.type)
	slot4 = slot1.property or 0
	slot0.lockText_.text = string.format(GetTips("IDOL_DANCE_SKILL_UNLOCK_TIPS"), slot2, slot4)

	if slot4 <= slot2 then
		slot0.lockController_:SetSelectedState("normal")
	else
		slot0.lockController_:SetSelectedState("lock")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
