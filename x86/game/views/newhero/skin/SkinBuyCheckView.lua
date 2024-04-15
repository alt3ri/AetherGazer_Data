local var_0_0 = class("SkinBuyCheckView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/HeroSkin/SkinBuyCheckUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.costTypeController_ = ControllerUtil.GetController(arg_4_0.transform_, "price")
	arg_4_0.commonItem_ = CommonItem.New(arg_4_0.commonitemGo_)
	arg_4_0.give_backController_ = ControllerUtil.GetController(arg_4_0.transform_, "give_back")
	arg_4_0.dlcController = ControllerUtil.GetController(arg_4_0.transform_, "dlc")
	arg_4_0.dlcViewBtnController = ControllerUtil.GetController(arg_4_0.transform_, "dlcViewBtn")
	arg_4_0.dlcJumpController = ControllerUtil.GetController(arg_4_0.transform_, "dlcJump")
	arg_4_0.dlcList = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_dlcList, SkinBuyCheckDLCItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.checkBtn_, nil, function()
		local function var_7_0(arg_8_0)
			local var_8_0 = getShopCfg(arg_5_0.goodID_)

			if ShopTools.IsRMB(arg_8_0, var_8_0.shop_id) then
				local var_8_1, var_8_2, var_8_3 = ShopTools.IsOnDiscountArea(arg_8_0, var_8_0.shop_id)
				local var_8_4

				if var_8_1 and var_8_3 then
					var_8_4 = getShopCfg(arg_8_0).cheap_cost_id
				else
					var_8_4 = getShopCfg(arg_8_0).cost_id
				end

				local var_8_5 = getShopCfg(arg_8_0).shop_id

				PayAction.RequestGSPay(var_8_4, 1, var_8_5, arg_8_0)
			else
				local var_8_6, var_8_7 = arg_5_0:HaveDlc()

				if var_8_6 and var_8_7 then
					if #arg_5_0.selectList == 1 then
						ShopTools.ConfirmBuyItem(arg_5_0.selectList[1], 1)
					else
						ShopDlcAction.DlcConfirmBuyItem(arg_5_0.goodID_, arg_5_0.selectList)
					end
				else
					ShopTools.ConfirmBuyItem(arg_8_0, 1)
				end
			end
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_skin_buy_check = arg_5_0.params_.skinID
		})

		local var_7_1 = getShopCfg(arg_5_0.goodID_)
		local var_7_2 = arg_5_0.goodID_

		if ShopData.IsGoodOutOfDate(var_7_2, var_7_1.shop_id) then
			ShowTips("SKIN_SALE_FINISH")
			arg_5_0:Back()

			return
		end

		local var_7_3 = HeroData:GetHeroData(arg_5_0.params_.heroID)
		local var_7_4, var_7_5, var_7_6 = ShopTools.GetPrice(var_7_2, var_7_1.shop_id)
		local var_7_7, var_7_8 = arg_5_0:HaveDlc()

		if var_7_7 and var_7_8 then
			var_7_4 = 0

			for iter_7_0, iter_7_1 in ipairs(arg_5_0.selectList) do
				local var_7_9 = getShopCfg(iter_7_1)
				local var_7_10, var_7_11, var_7_12 = ShopTools.GetPrice(iter_7_1, var_7_9.shop_id)

				var_7_4 = var_7_4 + var_7_10
			end
		end

		if var_7_3.unlock == 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("NOT_HAVE_HERO_SKIN_CONFIRM"), GetI18NText(HeroCfg[arg_5_0.params_.heroID].name)),
				OkCallback = function()
					if ShopTools.IsSkin(arg_5_0.goodID_, var_7_1.shop_id) then
						if ShopTools.GetCostCount(arg_5_0.goodID_) < var_7_4 then
							arg_5_0:SkinIsdeficiency()
						else
							var_7_0(var_7_2)
							SDKTools.SendPaymentMessageToSDK("payment_touch", {
								payment_skin_buy_unlock = 0
							})
						end
					elseif ShopTools.IsRMB(var_7_2, var_7_1.shop_id) then
						var_7_0(var_7_2)
						SDKTools.SendPaymentMessageToSDK("payment_touch", {
							payment_skin_buy_unlock = 0
						})
					elseif ShopTools.GetCostCount(arg_5_0.goodID_) < var_7_4 then
						var_7_0(var_7_2)
					else
						var_7_0(var_7_2)
						SDKTools.SendPaymentMessageToSDK("payment_touch", {
							payment_skin_buy_unlock = 0
						})
					end
				end,
				CancelCallback = function()
					SDKTools.SendPaymentMessageToSDK("payment_touch", {
						payment_skin_buy_unlock = 1
					})
				end
			})
		elseif ShopTools.IsSkin(arg_5_0.goodID_, var_7_1.shop_id) then
			if var_7_4 > ShopTools.GetCostCount(arg_5_0.goodID_) then
				arg_5_0:SkinIsdeficiency()
			else
				var_7_0(var_7_2)
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_skin_buy_unlock = 0
				})
			end
		elseif ShopTools.IsRMB(var_7_2, var_7_1.shop_id) then
			var_7_0(var_7_2)
			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_skin_buy_unlock = 0
			})
		elseif var_7_4 > ShopTools.GetCostCount(arg_5_0.goodID_) then
			var_7_0(var_7_2)
		else
			var_7_0(var_7_2)
			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_skin_buy_unlock = 0
			})
		end
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_dlcViewBtn, function()
		JumpTools.OpenPageByJump("/skinDlcShow", {
			goodId = arg_5_0.dlcID_
		})
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_jumpBtn, function()
		local var_12_0, var_12_1 = arg_5_0:HaveDlc()

		if var_12_0 and not var_12_1 then
			local var_12_2 = getShopCfg(arg_5_0.dlcID_)

			JumpTools.GoToSystem("/shop", {
				shopId = var_12_2.shop_id
			}, ViewConst.SYSTEM_ID.SHOP)
		end
	end)
end

function var_0_0.SkinIsdeficiency(arg_13_0)
	ShowMessageBox({
		content = string.format(GetTips("ERROR_ITEM_NOT_SKIN_TICKET_C")),
		OkCallback = function()
			JumpTools.GoToSystem("/rechargeMain", {
				childShopIndex = 4,
				page = 2
			}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
		end,
		CancelCallback = function()
			arg_13_0:Back()
		end
	})
end

function var_0_0.RefreshUI(arg_16_0)
	local var_16_0 = getShopCfg(arg_16_0.goodID_)
	local var_16_1, var_16_2 = arg_16_0:HaveDlc()

	if not var_16_1 then
		arg_16_0.dlcController:SetSelectedIndex(0)

		local var_16_3 = {}
		local var_16_4 = RechargeShopDescriptionCfg[var_16_0.description]

		if var_16_4.type == 8 then
			var_16_3 = var_16_4.id
		else
			var_16_3 = HeroTools.GetSkinChangeItem(arg_16_0.skinID_)
		end

		arg_16_0.textnameText_.text = ItemTools.getItemName(var_16_3)
		arg_16_0.textinfoText_.text = string.format(GetTips("BUY_SKIN_CHANGE"), ItemTools.getItemName(var_16_3)) .. ItemTools.getItemDesc(var_16_3)
		arg_16_0.m_textinfoScroll.verticalNormalizedPosition = 1

		arg_16_0.commonItem_:RefreshData({
			number = 1,
			id = var_16_3
		})
		arg_16_0:UpdatePrice()
	else
		arg_16_0.dlcController:SetSelectedIndex(1)

		arg_16_0.selectList = {}

		if ShopTools.HaveSkin(arg_16_0.skinID_) or HeroTools.CanChangeSkin(arg_16_0.skinID_) then
			arg_16_0.selectIndex = 2

			if var_16_2 then
				arg_16_0.selectList = {
					arg_16_0.dlcID_
				}
			else
				arg_16_0.selectList = {}
			end
		else
			arg_16_0.selectIndex = 1
			arg_16_0.selectList = {
				arg_16_0.goodID_
			}
		end

		arg_16_0.dlcList:StartScroll(2)
		arg_16_0:RefreshDlcDes()
		arg_16_0:UpdatePriceByDlc()
	end
end

function var_0_0.UpdatePrice(arg_17_0)
	local var_17_0 = getShopCfg(arg_17_0.goodID_)
	local var_17_1 = arg_17_0.goodID_
	local var_17_2, var_17_3, var_17_4 = ShopTools.GetPrice(var_17_1, var_17_0.shop_id)
	local var_17_5 = PaymentCfg[1].currency_symbol
	local var_17_6 = var_17_0.give_back_list

	if var_17_6 == 0 or #var_17_6 == 0 then
		arg_17_0.give_backController_:SetSelectedState("false")

		if ShopTools.IsRMB(var_17_1, var_17_0.shop_id) then
			arg_17_0.costTypeController_:SetSelectedState("money")

			arg_17_0.rmbpriceText_.text = var_17_2
			arg_17_0.symbolText_.text = var_17_5
		else
			arg_17_0.costTypeController_:SetSelectedState("currency")

			arg_17_0.costiconImg_.sprite = ItemTools.getItemLittleSprite(var_17_0.cost_id)
			arg_17_0.symbolText_.text = " "
			arg_17_0.priceText_.text = var_17_2
		end
	else
		arg_17_0.give_backController_:SetSelectedState("true")

		arg_17_0.rebackSkinTicketText_.text = var_17_6[1].num or 0

		local var_17_7 = SettingData:GetCurrentLanguage()

		if var_17_7 == "fr" or var_17_7 == "de" then
			var_17_2 = string.gsub(tostring(var_17_2), "%.", ",")
		end

		arg_17_0.rmbpriceText_.text = var_17_2

		if ShopTools.IsRMB(var_17_1, var_17_0.shop_id) then
			arg_17_0.costTypeController_:SetSelectedState("money")

			arg_17_0.symbolText_.text = var_17_5
		elseif ShopTools.IsSkin(var_17_1, var_17_0.shop_id) then
			arg_17_0.costTypeController_:SetSelectedState("skin")

			arg_17_0.currencyiconImg_.sprite = ItemTools.getItemLittleSprite(var_17_0.give_back_list[1].id)
			arg_17_0.give_back_icon_.sprite = ItemTools.getItemLittleSprite(var_17_0.give_back_list[1].id)
			arg_17_0.costSkinTicketText_.text = var_17_2
		else
			arg_17_0.costTypeController_:SetSelectedState("currency")

			arg_17_0.currencyiconImg_.sprite = ItemTools.getItemLittleSprite(var_17_0.give_back_list[1].id)
			arg_17_0.give_back_icon_.sprite = ItemTools.getItemLittleSprite(var_17_0.give_back_list[1].id)
			arg_17_0.costSkinTicketText_.text = var_17_2
		end
	end
end

function var_0_0.OnShopBuyResult(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if arg_18_1 == 0 then
		local var_18_0 = getShopCfg(arg_18_2, arg_18_3)
		local var_18_1 = var_18_0.description
		local var_18_2 = var_18_0.give or 1
		local var_18_3 = {
			{
				var_18_1,
				var_18_2 * arg_18_4
			}
		}
		local var_18_4
		local var_18_5

		arg_18_0:Back()

		if var_18_0.description then
			local var_18_6 = var_18_0.description

			var_18_4 = RechargeShopDescriptionCfg[var_18_6]
		else
			var_18_4 = ItemCfg[var_18_1]
		end

		if var_18_4.type ~= 14 then
			return
		end

		if var_18_0.give_back_list ~= 0 and #var_18_0.give_back_list ~= 0 then
			local var_18_7 = {}

			for iter_18_0, iter_18_1 in ipairs(var_18_0.give_back_list) do
				table.insert(var_18_7, {
					iter_18_1.id,
					iter_18_1.num
				})
			end

			table.insertto(var_18_3, var_18_7)
		end

		local var_18_8 = formatRewardCfgList(var_18_3)
		local var_18_9 = mergeReward(var_18_8)

		getReward(var_18_9, nil, function()
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("USE_SKIN_CHANGE"), GetI18NText(RechargeShopDescriptionCfg[var_18_1].name)),
				OkCallback = function()
					CommonAction.TryToUseItem({
						{
							item_info = {
								num = 1,
								id = HeroTools.GetSkinChangeItem(arg_18_0.skinID_)
							},
							use_list = {}
						}
					})
				end
			})
		end, nil, true)
	else
		arg_18_0:Back()
	end
end

function var_0_0.UpdateBar(arg_21_0)
	if arg_21_0.params_.shopID == 1048 then
		manager.windowBar:SwitchBar({
			CurrencyConst.CURRENCY_TYPE_SKIN
		}, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
		manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	else
		manager.windowBar:SwitchBar({
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId(),
			CurrencyConst.CURRENCY_TYPE_SKIN
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
		manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	end
end

function var_0_0.OnTop(arg_22_0)
	arg_22_0:UpdateBar()
	manager.windowBar:SetAsLastSibling()
end

function var_0_0.OnEnter(arg_23_0)
	arg_23_0.goodID_ = arg_23_0.params_.goodID
	arg_23_0.heroID_ = arg_23_0.params_.heroID
	arg_23_0.skinID_ = arg_23_0.params_.skinID

	local var_23_0 = getShopCfg(arg_23_0.goodID_)

	arg_23_0.dlcID_ = var_23_0.dlc

	if ShopTools.IsRMB(arg_23_0.goodID_, var_23_0.shop_id) then
		arg_23_0.dlcID_ = nil
	end

	if arg_23_0.dlcID_ ~= nil and arg_23_0.dlcID_ ~= 0 then
		arg_23_0.dlcViewBtnController:SetSelectedIndex(1)
	else
		arg_23_0.dlcViewBtnController:SetSelectedIndex(0)
	end

	arg_23_0:RefreshUI()
	arg_23_0:RegistEventListener(RECHARGE_SUCCESS, function(arg_24_0)
		local var_24_0 = HeroTools.GetSkinChangeItem(arg_23_0.skinID_)

		arg_23_0:Back()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("USE_SKIN_CHANGE"), ItemTools.getItemName(var_24_0)),
			OkCallback = function()
				CommonAction.TryToUseItem({
					{
						num = 1,
						item_id = var_24_0,
						use_list = {}
					}
				})
			end
		})
	end)

	if (ShopTools.HaveSkin(arg_23_0.skinID_) or HeroTools.CanChangeSkin(arg_23_0.skinID_)) and arg_23_0.dlcID_ and arg_23_0.dlcID_ ~= 0 and ShopTools.CheckDlcPurchased(arg_23_0.dlcID_) then
		Timer.New(function()
			arg_23_0:Back()
		end, 0.033, 1):Start()
	end

	if arg_23_0.timer_ == nil then
		arg_23_0.timer_ = FrameTimer.New(function()
			local var_27_0, var_27_1 = arg_23_0:HaveDlc()

			if not var_27_0 then
				arg_23_0:UpdatePrice()
			else
				if arg_23_0.dlcList ~= nil then
					for iter_27_0, iter_27_1 in ipairs(arg_23_0.dlcList:GetItemList()) do
						iter_27_1:UpdateTimer()
					end
				end

				arg_23_0:UpdatePriceByDlc()
			end
		end, 1, -1)

		arg_23_0.timer_:Start()
	end
end

function var_0_0.OnExit(arg_28_0)
	if arg_28_0.timer_ ~= nil then
		arg_28_0.timer_:Stop()

		arg_28_0.timer_ = nil
	end

	arg_28_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_29_0)
	arg_29_0.commonItem_:Dispose()
	arg_29_0.dlcList:Dispose()
	var_0_0.super.Dispose(arg_29_0)
end

function var_0_0.HaveDlc(arg_30_0)
	if arg_30_0.dlcID_ == nil or arg_30_0.dlcID_ == 0 then
		return false, false
	else
		local var_30_0 = getShopCfg(arg_30_0.dlcID_)

		if var_30_0 == nil then
			return false, false
		elseif ShopTools.CheckDlcPurchased(arg_30_0.dlcID_) then
			return false, false
		else
			return true, ShopConst.SHOP_ID.DLC_SHOP == var_30_0.shop_id
		end
	end
end

function var_0_0.IndexItem(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_1 == 1 then
		if ShopTools.HaveSkin(arg_31_0.skinID_) or HeroTools.CanChangeSkin(arg_31_0.skinID_) then
			arg_31_2:SetState(2)
		elseif table.indexof(arg_31_0.selectList, arg_31_0.goodID_) then
			arg_31_2:SetState(1)
		else
			arg_31_2:SetState(0)
		end

		arg_31_2:SetData(arg_31_1, arg_31_0.goodID_)
	elseif arg_31_1 == 2 then
		local var_31_0, var_31_1 = arg_31_0:HaveDlc()

		if not var_31_1 then
			arg_31_2:SetState(3)
		elseif table.indexof(arg_31_0.selectList, arg_31_0.dlcID_) then
			arg_31_2:SetState(1)
		else
			arg_31_2:SetState(0)
		end

		arg_31_2:SetData(arg_31_1, arg_31_0.dlcID_)
	end

	arg_31_2:SetSelect(arg_31_1 == arg_31_0.selectIndex)
	arg_31_2:RegistCallBack(function(arg_32_0)
		arg_31_0:DlcItemClick(arg_32_0)
	end)
	arg_31_2:RegistSelectCallBack(function(arg_33_0)
		arg_31_0:DlcItemSelectClick(arg_33_0)
	end)
end

function var_0_0.DlcItemClick(arg_34_0, arg_34_1)
	arg_34_0.selectIndex = arg_34_1

	arg_34_0.dlcList:Refresh()
	arg_34_0:RefreshDlcDes()
	arg_34_0:UpdatePriceByDlc()
end

function var_0_0.DlcItemSelectClick(arg_35_0, arg_35_1)
	local var_35_0 = table.indexof(arg_35_0.selectList, arg_35_1)

	if var_35_0 then
		table.remove(arg_35_0.selectList, var_35_0)
	else
		table.insert(arg_35_0.selectList, arg_35_1)
	end

	arg_35_0.dlcList:Refresh()
	arg_35_0:UpdatePriceByDlc()
end

function var_0_0.RefreshDlcDes(arg_36_0)
	if arg_36_0.selectIndex == 1 then
		local var_36_0 = getShopCfg(arg_36_0.goodID_)
		local var_36_1 = {}
		local var_36_2 = RechargeShopDescriptionCfg[var_36_0.description]

		if var_36_2.type == 8 then
			var_36_1 = var_36_2.id
		else
			var_36_1 = HeroTools.GetSkinChangeItem(arg_36_0.skinID_)
		end

		arg_36_0.textnameText_.text = ItemTools.getItemName(var_36_1)
		arg_36_0.textinfoText_.text = string.format(GetTips("BUY_SKIN_CHANGE"), ItemTools.getItemName(var_36_1)) .. ItemTools.getItemDesc(var_36_1)
		arg_36_0.m_textinfoScroll.verticalNormalizedPosition = 1

		arg_36_0.dlcJumpController:SetSelectedIndex(0)
	else
		local var_36_3 = getShopCfg(arg_36_0.dlcID_)
		local var_36_4 = var_36_3.give_id or var_36_3.description

		if not var_36_3.give then
			local var_36_5 = 1
		end

		local var_36_6
		local var_36_7

		if var_36_3.description then
			local var_36_8 = var_36_3.description

			var_36_7 = RechargeShopDescriptionCfg[var_36_8]
		else
			var_36_7 = ItemCfg[var_36_4]
		end

		arg_36_0.textnameText_.text = ItemTools.getItemName(var_36_7.id)
		arg_36_0.textinfoText_.text = ItemTools.getItemDesc(var_36_7.id)
		arg_36_0.m_textinfoScroll.verticalNormalizedPosition = 1

		local var_36_9, var_36_10 = arg_36_0:HaveDlc()

		if var_36_9 and not var_36_10 then
			arg_36_0.dlcJumpController:SetSelectedIndex(1)
		else
			arg_36_0.dlcJumpController:SetSelectedIndex(0)
		end
	end
end

function var_0_0.UpdatePriceByDlc(arg_37_0)
	local var_37_0 = getShopCfg(arg_37_0.goodID_)
	local var_37_1 = PaymentCfg[1].currency_symbol
	local var_37_2 = arg_37_0.goodID_

	if #arg_37_0.selectList == 0 then
		arg_37_0.give_backController_:SetSelectedState("false")
		arg_37_0.costTypeController_:SetSelectedState("null")

		return
	end

	local var_37_3 = 0
	local var_37_4 = ""
	local var_37_5 = {}

	for iter_37_0, iter_37_1 in ipairs(arg_37_0.selectList) do
		local var_37_6, var_37_7, var_37_8 = ShopTools.GetPrice(iter_37_1, var_37_0.shop_id)

		var_37_3 = var_37_3 + var_37_6

		if iter_37_0 == 1 then
			var_37_4 = "(" .. var_37_3
		else
			var_37_4 = var_37_4 .. "+" .. var_37_6
		end

		local var_37_9 = getShopCfg(iter_37_1).give_back_list

		if type(var_37_9) == "table" then
			for iter_37_2, iter_37_3 in ipairs(var_37_9) do
				if not var_37_5[iter_37_3.id] then
					var_37_5[iter_37_3.id] = iter_37_3.num
				else
					var_37_5[iter_37_3.id] = var_37_5[iter_37_3.id] + iter_37_3.num
				end
			end
		end
	end

	local var_37_10 = var_37_4 .. ")"

	if table.length(var_37_5) == 0 then
		arg_37_0.give_backController_:SetSelectedState("false")
	else
		arg_37_0.give_backController_:SetSelectedState("true")

		for iter_37_4, iter_37_5 in pairs(var_37_5) do
			arg_37_0.currencyiconImg_.sprite = ItemTools.getItemLittleSprite(iter_37_4)
			arg_37_0.give_back_icon_.sprite = ItemTools.getItemLittleSprite(iter_37_4)
			arg_37_0.rebackSkinTicketText_.text = iter_37_5
		end
	end

	if #arg_37_0.selectList > 1 then
		arg_37_0.m_delPrice.text = var_37_10
	else
		arg_37_0.m_delPrice.text = ""
	end

	if ShopTools.IsRMB(var_37_2, var_37_0.shop_id) then
		arg_37_0.costTypeController_:SetSelectedState("money")

		arg_37_0.rmbpriceText_.text = var_37_3
		arg_37_0.symbolText_.text = var_37_1
	else
		arg_37_0.costTypeController_:SetSelectedState("currency")

		arg_37_0.costiconImg_.sprite = ItemTools.getItemLittleSprite(var_37_0.cost_id)
		arg_37_0.symbolText_.text = " "
		arg_37_0.priceText_.text = var_37_3
	end
end

return var_0_0
