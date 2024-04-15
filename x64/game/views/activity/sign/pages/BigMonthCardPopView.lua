slot0 = class("BigMonthCardPopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/ActivitySign/BigMonthCard/BigMonthcardPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, BigMonthCardPopItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot4 = slot0.list_[slot1]
	slot5 = clone(ItemTemplateData)
	slot5.id = slot4[1]
	slot5.number = slot4[2]

	function slot5.clickFun()
		ShowPopItem(POP_ITEM, {
			uv0[1]
		})
	end

	slot2:RefreshData(slot5)

	slot6 = slot4[3]
	slot7 = ""

	slot2:SetText(BigMonthCardData:GetRecord()[slot1] and slot6 - slot3[slot1] .. "/" .. slot6 or slot6 .. "/" .. slot6)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.list_ = GameSetting.big_monthly_card_reward_daily.value

	slot0.scrollHelper_:StartScroll(#slot0.list_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()

		slot0.scrollHelper_ = nil
	end

	slot0.super.Dispose(slot0)
end

return slot0
