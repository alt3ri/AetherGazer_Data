slot0 = class("RechargeBlessBagView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Recharge/RechargeFukubukuroPopUI"
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

	slot0.rmbController_ = ControllerUtil.GetController(slot0.transform_, "rmb")
	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, CommonItemView)
	slot0.grey = slot0.okImage_.material
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_buyBtn, nil, function ()
		SendMessageManagerToSDK("purchase_click_gp_once")

		if ShopTools.IsPC() and ShopTools.IsRMB(uv0.goodId_) then
			ShowTips("PC_SHOP_TIPS2")

			return
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_giftbox_buy = uv0.goodId_
		})

		if OperationData:IsFunctionStoped(ShopListCfg[getShopCfg(uv0.goodId_).shop_id].operation_stop_id) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		if ShopTools.IsRMB(uv0.goodId_) then
			slot3 = nil

			PayAction.RequestGSPay(((not uv0:IsOnDiscountArea() or PaymentCfg[uv0.shopCfg_.cheap_cost_id]) and PaymentCfg[uv0.shopCfg_.cost_id]).id, uv0.selectNum_, uv0.shopCfg_.shop_id, uv0.shopCfg_.goods_id, nil, uv0.params_.buy_source or 0)
		else
			slot3 = uv0.params_.buy_source or 0

			if ShopTools.GetPrice(uv0.goodId_) == 0 then
				uv0:Back()
				ShopAction.BuyItem({
					{
						goodID = uv0.goodId_,
						buyNum = uv0.selectNum_
					}
				}, nil, slot3)

				return
			end

			ShopTools.ConfirmBuyItem(uv0.goodId_, uv0.selectNum_, function (slot0)
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_giftbox_check = 0
				})
				uv0:Back()
			end, function ()
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_giftbox_check = 1
				})
				uv0:UpdatePreview()
			end, slot3)
		end
	end)
	slot0:AddBtnListener(nil, slot0.m_chanceBtn, function ()
		JumpTools.OpenPageByJump("popFukubukuroProbability", {
			itemId = uv0.shopCfg_.description
		})
	end)
	slot0:AddBtnListener(nil, slot0.m_mask, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
end

function slot0.OnEnter(slot0)
	slot0.goodId_ = slot0.params_.goodID
	slot0.shopId_ = slot0.params_.shopID
	slot0.selectNum_ = 1
	slot0.shopCfg_ = getShopCfg(slot0.goodId_)
	slot0.itemDesCfg_ = RechargeShopDescriptionCfg[slot0.shopCfg_.description]
	slot0.m_name.text = slot0.itemDesCfg_.name
	slot0.items = ItemCfg[slot0.shopCfg_.description].param

	slot0.list:StartScroll(#slot0.items)
	slot0:UpdatePreview()
	slot0:RegistEventListener(RECHARGE_SUCCESS, function (slot0)
		uv0:Back()
	end)
end

function slot0.UpdatePreview(slot0)
	slot1 = ShopTools.GetPrice(slot0.goodId_)

	if #slot0.shopCfg_.close_time > 0 and #slot0.shopCfg_.open_time > 0 then
		slot0.m_timeLab.text = string.format("%s-%s", os.date("%Y/%m/%d", TimeMgr.GetInstance():parseTimeFromConfig(slot0.shopCfg_.open_time)), os.date("%Y/%m/%d", TimeMgr.GetInstance():parseTimeFromConfig(slot0.shopCfg_.close_time)))
	else
		slot0.m_timeLab.text = ""
	end

	if ShopTools.IsRMB(slot0.goodId_) then
		slot0.rmbController_:SetSelectedState("rmb")

		slot0.rmbLabel_.text = "¥" .. slot1
	else
		slot0.rmbController_:SetSelectedState("buy")

		slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot0.shopCfg_.cost_id)
		slot0.totleLabel_.text = slot1
	end

	if ShopTools.IsRMB(slot0.goodId_) and ShopTools.IsPC() then
		slot0.okImage_.material = slot0.grey
	else
		slot0.okImage_.material = nil
	end
end

function slot0.GetHave(slot0)
	return ItemTools.getItemNum(slot0.shopCfg_.cost_id)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnShopBuyResult(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 0 then
		slot5 = getShopCfg(slot2, slot0.shopId_)

		slot0:Back()

		if RechargeShopDescriptionCfg[slot5.goods_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			getReward({
				{
					id = slot6,
					num = slot5.give
				}
			}, {
				ItemConst.ITEM_TYPE.HERO_SKIN
			})
		elseif slot8 == ItemConst.ITEM_TYPE.EQUIP then
			if EquipData:GetEquipBagFull() then
				showEquipSendMail(nil)
				EquipAction.EquipBagFull(false)
			else
				ShowTips("TRANSACTION_SUCCESS")
			end
		else
			ShowTips("TRANSACTION_SUCCESS")
		end
	elseif slot1 == 899 then
		ShowMessageBox({
			content = GetTips("EQUIP_NUM_MAX"),
			OkCallback = function ()
				JumpTools.GoToSystem("/bag", {
					type = "equip"
				}, ViewConst.SYSTEM_ID.BAG)
			end
		})
	elseif slot1 == 406 then
		ShowTips("ITEM_INVALID")
	elseif slot1 then
		ShowTips(slot1)
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.items[slot1]

	CommonTools.SetCommonData(slot2, {
		id = slot3[1],
		number = slot3[2],
		clickFun = function (slot0)
			ShowPopItem(POP_ITEM, {
				uv0[1]
			})
		end
	})
end

return slot0
