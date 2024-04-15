slot0 = class("SPHeroChallengeTrainStageItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = slot0.controller:GetController("state")
	slot0.buffControler = slot0.controller:GetController("buff")

	slot0:AddUIListener()
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.uiIndex = slot3
	slot4 = BattleVerthandiExclusiveCfg[slot1]
	slot5 = table.indexof(BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[slot4.sub_type], slot1)

	if slot4 and slot5 then
		slot0.stageID = slot1
		slot6, slot7 = SPHeroChallengeTools:CheckStageIsOpen(slot1)
		slot0.trainnameText_.text = BattleVerthandiExclusiveCfg[slot1].name

		if not slot6 then
			slot0.stateController:SetSelectedState("unlock")

			slot8, slot9 = SPHeroChallengeTools:GetTrainPercentByStage(slot1, slot5)
			slot0.addexptextText_.text = GetTips("TIP_CLEARTIMES") .. slot8

			if slot9 and slot9 ~= 0 then
				slot0.buffControler:SetSelectedState("show")
			else
				slot0.buffControler:SetSelectedState("close")
			end

			slot0.buffText.text = slot9 .. "%"

			if slot2 == slot1 then
				slot0.stateController:SetSelectedState("selected")
			end
		else
			slot0.buffControler:SetSelectedState("close")
			slot0.stateController:SetSelectedState("lock")

			slot0.conditiontextText_.text = slot7
		end
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.trainstageitemBtn_, nil, function ()
		if uv0.stateController:GetSelectedState() == "lock" then
			return
		end

		if uv0.clickFunc then
			uv0.clickFunc(uv0.stageID, uv0.uiIndex)
		end
	end)
end

function slot0.RegisterClickCallBack(slot0, slot1)
	if slot1 then
		slot0.clickFunc = slot1
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
