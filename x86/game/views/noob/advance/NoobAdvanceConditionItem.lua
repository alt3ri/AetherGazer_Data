slot0 = class("NoobAdvanceConditionItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	SetActive(slot0.gameObject_, true)
	slot0:BindCfgUI()

	slot0.stateController_ = slot0.controllerExcollection_:GetController("complate")
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	if slot1 == 1 then
		slot0.stateController_:SetSelectedState(tostring(TaskTools:IsCompletedAllNoobAdvanceTask(slot2)))

		slot0.descText_.text = GetTips("NOOB_ADVANCE_TASK_CONDITION_COMPLETE")
	else
		slot0.stateController_:SetSelectedState(tostring(NoobVersionCfg[ActivityNewbieTools:GetVersionID()].noob_advance_task_open[slot3] <= PlayerData:GetPlayerInfo().userLevel))

		slot0.descText_.text = string.format(GetTips("NOOB_ADVANCE_TASK_CONDITION_LEVEL"), slot6)
	end
end

return slot0
