slot0 = class("RechargeTotalRechargeView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Recharge/RechargeTotalRechargeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, RechargeTotalRechargeItem)

	if getData("totalRecharge", "seeToggle") ~= nil then
		slot0.seeToggle_.isOn = slot1 == 1 and true or false
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(table.indexof(slot0.oriDataList_, slot0.dataList_[slot1]), slot0.dataList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddToggleListener(slot0.seeToggle_, function (slot0)
		saveData("totalRecharge", "seeToggle", slot0 and 1 or 0)
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0:UpdateList()
	slot0:UpdateView()
	slot0:RegistEventListener(TOTAL_RECHARGE_UPDATE, function (slot0)
		uv0:UpdateView()
	end)
	slot0:RegistEventListener(GET_TOTAL_RECHARGE_BONUS, function (slot0)
		uv0:UpdateList()
		uv0:UpdateView()
	end)
end

function slot0.UpdateList(slot0)
	slot0.dataList_ = {}
	slot0.oriDataList_ = {}
	slot0.jumpIndex_ = 0

	for slot4, slot5 in ipairs(TotalRechargeCfg.all) do
		table.insert(slot0.dataList_, slot5)
		table.insert(slot0.oriDataList_, slot5)

		if RechargeData:HaveGetTotalRechargeBonus(slot5) == false and slot0.jumpIndex_ == 0 then
			slot0.jumpIndex_ = slot4
		end
	end
end

function slot0.UpdateView(slot0)
	slot0.list_:StartScroll(#slot0.dataList_, slot0.jumpIndex_)

	slot0.currentLabel_.text = RechargeData:GetTotalRechargeNum()

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.currencyLayout_)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
