slot0 = class("ActivityAttributeArenaRoundView", ReduxView)

function slot0.UIName(slot0)
	return AttributeArenaTools.GetRoundUI(slot0.params_.activityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, ActivityAttributeArenaRoundItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_mask, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.activity_id = slot0.params_.activityID
	slot0.listData = ActivityAttributeArenaRoundCfg.get_id_list_by_activity_id[slot0.activity_id] or {}
	slot1 = ActivityAttributeArenaData:GetRound(slot0.activity_id)

	table.sort(slot0.listData, function (slot0, slot1)
		slot4 = ActivityAttributeArenaRoundCfg[slot0].round == uv0
		slot5 = ActivityAttributeArenaRoundCfg[slot1].round == uv0

		if slot2 == uv0 then
			return true
		elseif slot3 == uv0 then
			return false
		elseif uv0 < slot2 and uv0 < slot3 then
			return slot2 < slot3
		elseif slot2 < uv0 and slot3 < uv0 then
			return slot2 < slot3
		else
			return uv0 < slot2
		end
	end)
	slot0.list:StartScroll(#slot0.listData)
end

function slot0.OnExit(slot0)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.listData[slot1], slot0.activity_id)
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
