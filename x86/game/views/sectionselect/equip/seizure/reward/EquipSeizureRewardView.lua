slot0 = class("EquipSeizureRewardView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Equip_Seizure/EquipSeizuRerewardPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = slot0.controlExCo_:GetController("state")
	slot0.itemList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, EquipSeizureRewardItem)
	slot0.updateHandler_ = handler(slot0, slot0.RefreshUI)
	slot0.receiveHandler_ = handler(slot0, slot0.RefreshUI)
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(EQUIP_SEIZURE_UPDATE, slot0.updateHandler_)
	manager.notify:RegistListener(EQUIP_SEIZURE_REWARD, slot0.receiveHandler_)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.notify:RemoveListener(EQUIP_SEIZURE_UPDATE, slot0.updateHandler_)
	manager.notify:RemoveListener(EQUIP_SEIZURE_REWARD, slot0.receiveHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.itemList_:Dispose()

	slot0.itemList_ = nil
	slot0.updateHandler_ = nil
	slot0.receiveHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveAllBtn_, nil, function ()
		if #EquipSeizureData:GetCanReceiveList() <= 0 then
			return
		end

		uv0:ClickItem()
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.ClickItem(slot0)
	EquipSeizureAction.SendReceiveReward(EquipSeizureData:GetCanReceiveList(), function (slot0)
		uv0:RefreshUI()
	end)
end

function slot0.RefreshUI(slot0)
	if #EquipSeizureData:GetCanReceiveList() > 0 then
		slot0.controller_:SetSelectedState("canget")
	else
		slot0.controller_:SetSelectedState("unfinish")
	end

	slot0.itemList_:StartScroll(#EquipSeizurePointRewardCfg.all)

	slot0.pointText_.text = EquipSeizureData:GetTotalScore()

	slot0:AddTimer()
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(EquipSeizureData:GetSortRewardList()[slot1])
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:NextRefreshTimestamp(), nil, true))
	slot0.timer_ = Timer.New(function ()
		uv0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:NextRefreshTimestamp(), nil, true))
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
