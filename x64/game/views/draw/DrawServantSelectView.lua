slot0 = class("DrawServantSelectView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Pool/TreasurePop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.selectID_ = nil

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, DrawServantSelectItem)
	slot0.btnController = slot0.controller_:GetController("btn")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnrenewalBtn_, nil, function ()
		if DrawData:GetPollUpID(uv0.poolID_) == uv0.selectID_ then
			ShowTips("DRAW_NOT_SELECT_WEAPON_TIPS")

			return
		end

		DrawAction.SetPollUpID(uv0.poolID_, uv0.selectID_)
	end)
end

function slot0.OnSetPollUpID(slot0, slot1, slot2)
	slot0:Back()

	slot0.selectID_ = nil
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot1, slot0.itemList_[slot1], DrawPoolCfg[slot0.poolID_].optional_detail[slot1])
	slot2:ShowSelect(slot0.selectID_)
	slot2:RegisterListener(function (slot0)
		for slot5, slot6 in pairs(uv0.scrollHelper:GetItemList()) do
			slot6:ShowSelect(slot0)
		end

		uv0.selectID_ = slot0

		uv0:RefreshTitle(uv0.selectID_)
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.UpdateData(slot0)
	slot0.itemList_ = {}
	slot0.itemList_ = deepClone(DrawPoolCfg[slot0.poolID_].optional_lists_poolId)
end

function slot0.OnEnter(slot0)
	slot0.poolID_ = 10002
	slot0.selectID_ = nil

	if not slot0.selectID_ then
		slot0.selectID_ = DrawData:GetPollUpID(slot0.poolID_)
	end

	slot0:RefreshTitle(slot0.selectID_)

	if slot0.selectID_ ~= 0 then
		slot0.btnController:SetSelectedState("current")
	else
		slot0.titleText_.text = GetTips("DRAW_SELECT_WEAPON_TIPS")

		slot0.btnController:SetSelectedState("false")
	end

	slot0:UpdateData()
	slot0.scrollHelper:StartScroll(#slot0.itemList_)
end

function slot0.RefreshTitle(slot0, slot1)
	slot0.btnController:SetSelectedState(DrawData:GetPollUpID(slot0.poolID_) ~= slot0.selectID_ and "true" or "current")

	if table.indexof(DrawPoolCfg[slot0.poolID_].optional_lists_poolId, slot1) and slot2.optional_detail[slot3] then
		slot0.titleText_.text = string.format(GetTips("CHOOSE_SERVANT_COMBINATION"), GetI18NText(RaceEffectCfg[WeaponServantCfg[slot2.optional_detail[slot3]].race].name))
	end
end

function slot0.Dispose(slot0)
	slot0.scrollHelper:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
