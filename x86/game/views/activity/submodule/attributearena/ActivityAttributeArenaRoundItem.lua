slot0 = class("ActivityAttributeArenaRoundItem", ReduxView)

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

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, ActivityAttributeArenaTagItem)
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "stateBtn")
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot3 = ActivityAttributeArenaRoundCfg[slot1]
	slot0.m_lab.text = GetTipsF("ACTIVITY_ATTRIBUTE_ARENE_ROUND", slot3.round)
	slot5 = ActivityData:GetActivityRefreshTime(slot0.activity_id)

	if ActivityAttributeArenaData:GetRound(slot2) == slot3.round then
		slot0.stateController:SetSelectedIndex(0)

		slot0.m_timeLab.text = GetTips("ACTIVITY_ATTRIBUTE_ARENE_ROUND_START")
	elseif slot4 < slot3.round then
		slot0.stateController:SetSelectedIndex(1)

		if slot3.round - slot4 <= #ActivityData:GetActivityRefreshTimeList(slot2) then
			slot0.m_timeLab.text = GetTipsF("ACTIVITY_ATTRIBUTE_ARENE_ROUND_TIME", manager.time:GetLostTimeStr2(slot7[slot6]))
		else
			slot0.m_timeLab.text = ""
		end
	else
		slot0.stateController:SetSelectedIndex(2)

		slot0.m_timeLab.text = GetTips("ACTIVITY_ATTRIBUTE_ARENE_ROUND_OVER")
	end

	slot0.listData = slot3.arena_id_list

	slot0.list:StartScroll(#slot0.listData)
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.listData[slot1])
end

return slot0
