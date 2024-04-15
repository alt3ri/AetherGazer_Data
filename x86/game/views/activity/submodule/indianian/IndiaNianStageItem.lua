slot0 = class("InidaNianStageItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		IndiaNianData:SetSelectedStage(uv0.cfg_.stage_id)
		IndiaNianData:SetSelectedStageCost(uv0.cfg_.cost)

		if uv0.cfg_.round < IndiaNianData:GetRound() or uv0.cfg_.round == IndiaNianData:GetRound() and IndiaNianData:GetCurrentHpByID(uv0.cfg_.id) == 0 then
			for slot5, slot6 in ipairs(IndiaNianCfg.get_id_list_by_group_id[uv0.cfg_.group_id]) do
				if IndiaNianCfg[slot6].activity_id == uv0.cfg_.activity_id and IndiaNianCfg[slot6].stage_type == 1 then
					IndiaNianData:SetSelectedDestID(slot6)
				end
			end
		else
			IndiaNianData:SetSelectedDestID(uv0.cfg_.id)
		end

		if uv0.callback then
			uv0.callback(uv0.index_)
		end
	end)
	slot0:AddBtnListener(slot0.clearBtn_, nil, function ()
		ShowTips("ACTIVITY_INDIA_NIAN_DESC_CLEAR")
	end)
end

function slot0.SetCallBack(slot0, slot1)
	slot0.callback = slot1
end

function slot0.RefreshUI(slot0)
	slot0.nameText_.text = slot0.cfg_.name
	slot0.iconImg_.sprite = getSprite("Atlas/IndiaUI_2_8", slot0.cfg_.icon)

	slot0:RefreshState()
end

function slot0.RefreshState(slot0)
	slot2 = slot0.cfg_.round == IndiaNianData:GetRound()
	slot3 = slot0.cfg_.round < IndiaNianData:GetRound() or slot0.cfg_.round == IndiaNianData:GetRound() and IndiaNianData:GetCurrentHpByID(slot0.cfg_.id) == 0
	slot4 = IndiaNianData:GetStageHasClearedByID(slot0.cfg_.id)
	slot5 = slot0.index_ == IndiaNianData:GetMainSelectedIndex()

	if IndiaNianData:GetRound() < slot0.cfg_.round then
		slot0.controller_:SetSelectedState("lock")
	elseif slot4 then
		slot0.controller_:SetSelectedState("finished")
	elseif slot3 then
		slot0.controller_:SetSelectedState("final")
	elseif slot2 then
		slot0.controller_:SetSelectedState("open")
	end

	slot6 = IndiaNianData:GetCurrentHpByID(slot0.cfg_.id) / slot0.cfg_.boss_hp

	slot0.selectController_:SetSelectedState(tostring(slot5 and not slot4 and not slot1))

	slot0.silderImg_.fillAmount = slot6
	slot0.percentText_.text = math.ceil(slot6 * 100) .. "%"
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.cfg_ = slot2

	slot0:RefreshUI()
end

return slot0
