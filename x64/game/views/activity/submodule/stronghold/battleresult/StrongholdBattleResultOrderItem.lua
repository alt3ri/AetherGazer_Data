slot0 = class("StrongholdBattleResultOrderItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeController = ControllerUtil.GetController(slot0.gameObject_.transform, "type")
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot4 = nil

	if slot1 == 1 then
		slot4 = CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_1

		slot0.typeController:SetSelectedIndex(0)
	elseif slot1 == 2 then
		slot4 = CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_2

		slot0.typeController:SetSelectedIndex(1)
	else
		slot4 = CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_3

		slot0.typeController:SetSelectedIndex(2)
	end

	slot5 = 0

	for slot9, slot10 in ipairs(slot2) do
		if slot4 == slot10[1] then
			slot5 = slot10[2]
		end
	end

	slot6, slot7, slot8, slot9 = StrongholdData:GetStrongholdLevel(slot1)
	slot0.m_name.text = GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. slot1)
	slot0.m_lvLab.text = ActivityStrongholdLevelCfg[slot6].level_des

	if ActivityStrongholdLevelCfg[slot6 + 1] then
		slot0.m_expSlider.value = slot8 / (slot11.exp - slot10.exp)
		slot0.m_exoLab.text = "+" .. slot5
	else
		slot0.m_expSlider.value = 1
		slot0.m_exoLab.text = ""
	end

	slot0.m_ceilLab.text = GetTips("ACTIVITY_STRONGHOLD_COIN_WEEK_CEIL") .. StrongholdData:GetWeeklyExp(slot3, slot1) .. "/" .. StrongholdData:GetWeeklyMaxExp(slot3, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
