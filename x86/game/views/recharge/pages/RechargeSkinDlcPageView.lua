slot1 = class("RechargeSkinDlcPageView", import("game.views.recharge.pages.RechargePageBase"))

function slot1.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.goodTypeController_ = ControllerUtil.GetController(slot0.transform_, "text")
	slot0.loopScrollView_ = LoopScrollView.New(slot0, slot0.scrollEx_, slot0.contTrs_, slot0.viewTrs_, slot0.viewTrs_.rect.width, slot0.contTrs_:GetComponent("HorizontalLayoutGroup").spacing, nil, true)
	slot0.item1Pool = {}
	slot0.item2Pool = {}
end

function slot1.OnItemOutOfDate(slot0, slot1)
	slot0:RefreshList()

	if #slot0.skinDataList_ == 0 and slot0.treeRefreshHandler_ ~= nil then
		slot0.treeRefreshHandler_()
	end
end

function slot1.AddEventListeners(slot0)
	slot0:RegistEventListener(SHOP_LIST_UPDATE, function (slot0)
		if slot0 > 0 and slot0 == uv0.curShopId_ then
			uv0:RefreshList()
		end
	end)
	slot0:RegistEventListener(SHOP_ITEM_UPDATE, function (slot0, slot1)
		uv0:RefreshShopGoodInfo(slot0, slot1)
	end)
	slot0:RegistEventListener(RECHARGE_SUCCESS, function (slot0)
		uv0:SwitchPage(uv0.curShopId_)
	end)
end

function slot1.AddUIListener(slot0)
	if SDKTools.GetIsInputServer("kr") then
		slot0:AddBtnListener(slot0.refundbtn_, nil, function ()
			JumpTools.OpenPageByJump("gameHelpPro", {
				pages = {
					"TextureConfig/RechargeUI/RefundPolicy@kr"
				}
			})
		end)
	end

	if slot0.fundsettlementmethodBtn_ and slot0.commercialBtn_ then
		slot0:AddBtnListener(slot0.fundsettlementmethodBtn_, nil, function ()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", fund_settlement_algorithm))
		end)
		slot0:AddBtnListener(slot0.commercialBtn_, nil, function ()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", specific_commercial_transaction_act))
		end)
	end
end

function slot1.SwitchPage(slot0, slot1)
	slot0.curShopId_ = slot1
	slot0.skinDataList_ = slot0:InitDataList(slot1)

	slot0.loopScrollView_:NavigateIndex(1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.loopScrollView_.rectGrid_)

	slot0.loopScrollView_.scrollView_.horizontalNormalizedPosition = 0
end

function slot1.RefreshList(slot0, slot1)
end

function slot1.InitDataList(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(ShopTools.FilterShopDataList(slot1)) do
		if SkinCfg[RechargeShopDescriptionCfg[getShopCfg(slot8.id).description].param[1]] then
			table.insert(slot3, slot8)
		end
	end

	return ShopTools.CommonSort(slot3)
end

function slot1.GetGoodStatus(slot0, slot1)
	if ShopTools.HaveSkin(RechargeShopDescriptionCfg[getShopCfg(slot1).description].param[1]) or HeroTools.CanChangeSkin(slot5) then
		return 2
	end

	if ShopData.IsGoodUnlock(slot1) == 0 then
		return 1
	end

	return 0
end

function slot1.RefreshShopGoodInfo(slot0, slot1, slot2)
	if slot0.curShopId_ ~= slot1 then
		return
	end
end

function slot1.OnEnter(slot0)
	slot0:AddEventListeners()
	SetActive(slot0.refundGo_, not SDKTools.GetIsInputServer("kr"))
	SetActive(slot0.refundbtn_.gameObject, false)

	if slot0.timer_ == nil then
		slot0.timer_ = FrameTimer.New(function ()
			for slot3, slot4 in ipairs(uv0.item1Pool) do
				slot4.itemView:UpdateTimerView()
			end

			for slot3, slot4 in ipairs(uv0.item2Pool) do
				slot4.itemView:UpdateTimerView()
			end

			uv0:UpdateTimer()
		end, 1, -1)

		slot0.timer_:Start()
	end

	SetActive(slot0.btnsGo_, GameToSDK.CURRENT_SERVER == SERVER_REGION.JAPAN)
	SetActive(slot0.refundGo_, not SDKTools.GetIsKorea())
	SetActive(slot0.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(slot0.refundbtn_.gameObject, slot0.curPageIndex_ ~= 4 and slot0.curPageIndex_ ~= 6)
	end
end

function slot1.UpdateTimer(slot0)
end

function slot1.Show(slot0)
	uv0.super.Show(slot0)
	slot0:RefreshList()
end

function slot1.OnExit(slot0)
	if slot0.timer_ ~= nil then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	for slot4, slot5 in pairs(slot0.item1Pool) do
		slot5.itemView:OnExit()
	end

	for slot4, slot5 in pairs(slot0.item2Pool) do
		slot5.itemView:OnExit()
	end
end

function slot1.Hide(slot0)
	uv0.super.Hide(slot0)
end

function slot1.SetTreeRefreshHandler(slot0, slot1)
	slot0.treeRefreshHandler_ = slot1
end

function slot1.Dispose(slot0)
	slot0:RemoveAllEventListener()

	if slot0.skinList_ then
		slot0.skinList_:Dispose()

		slot0.skinList_ = nil
	end

	slot0.treeRefreshHandler_ = nil

	for slot4, slot5 in ipairs(slot0.item1Pool) do
		slot5.itemView:Dispose()
	end

	for slot4, slot5 in ipairs(slot0.item2Pool) do
		slot5.itemView:Dispose()
	end

	slot0.item1Pool = nil
	slot0.item2Pool = nil
	slot0.itemEquipPool = nil

	uv0.super.Dispose(slot0)
end

function slot1.OnBuySuccess(slot0, slot1, slot2)
	if slot0.curShopId_ == slot2 or slot2 == 54 then
		slot0:RefreshList(true)
	end
end

function slot1.LsRemoveItem(slot0, slot1)
	slot1.itemView:Show(false)

	slot1.isFree = true
end

function slot1.GetFreeItem(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot1) do
		if slot7.isFree == true then
			slot7.isFree = false

			return slot7
		end
	end

	slot3 = {
		isFree = false,
		itemView = slot2()
	}

	table.insert(slot1, slot3)

	return slot3
end

function slot1.LsAddItem(slot0, slot1, slot2)
	slot3 = nil
	slot6 = nil

	if getShopCfg(slot1.id).dlc ~= nil and slot4.dlc ~= 0 then
		slot6 = getShopCfg(slot4.dlc)
	end

	slot3 = (not slot5 or not slot6 or slot0:GetFreeItem(slot0.item1Pool, function ()
		return RechargeSkinAllItem.New(uv0.item1Go_, uv0.contTrs_.gameObject)
	end)) and slot0:GetFreeItem(slot0.item2Pool, function ()
		return RechargeSkinNormalItem.New(uv0.item2Go_, uv0.contTrs_.gameObject)
	end)

	slot3.itemView:SetData(slot1, slot2)

	return slot3
end

function slot1.LsGetItemData(slot0)
	return slot0.skinDataList_
end

function slot1.LsUpdateItem(slot0, slot1, slot2, slot3)
	slot1.itemView:SetData(slot2, slot3)
end

return slot1
