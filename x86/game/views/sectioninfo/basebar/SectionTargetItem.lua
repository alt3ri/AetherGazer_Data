slot0 = class("SectionTargetItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.controllerEx_ = slot0.controllerEx_:GetController("clear")
end

function slot0.Refresh(slot0, slot1, slot2)
	if slot1 then
		slot0.controllerEx_:SetSelectedState("state1")
	else
		slot0.controllerEx_:SetSelectedState("state0")
	end

	if slot2 then
		slot0.targetText_.text = BattleInstance.GetStarMissionText(slot2[1], slot2[2], slot2[3])

		SetActive(slot0.gameObject_, true)
	else
		SetActive(slot0.gameObject_, false)
	end
end

return slot0
