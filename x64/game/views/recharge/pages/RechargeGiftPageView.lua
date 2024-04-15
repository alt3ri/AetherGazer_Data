local var_0_0 = import("game.views.recharge.pages.RechargePageBase")
local var_0_1 = class("RechargeGiftPageView", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.giftList_ = LuaList.New(handler(arg_2_0, arg_2_0.indexItem), arg_2_0.listGo_, RechargeGiftItem)
end

function var_0_1.indexItem(arg_3_0, arg_3_1, arg_3_2)
	arg_3_2:SetData(arg_3_0.shopDataList_[arg_3_1])
	arg_3_2:SetOutOfDateHandler(handler(arg_3_0, arg_3_0.OnItemOutOfDate))
end

function var_0_1.OnItemOutOfDate(arg_4_0, arg_4_1)
	arg_4_0:RefreshList()

	if #arg_4_0.shopDataList_ == 0 and arg_4_0.treeRefreshHandler_ ~= nil then
		arg_4_0.treeRefreshHandler_()
	end
end

function var_0_1.OnBuySuccess(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.curShopId_ == arg_5_2 then
		arg_5_0:RefreshList(true)
	end
end

function var_0_1.AddUIListener(arg_6_0)
	if SDKTools.GetIsInputServer("kr") then
		arg_6_0:AddBtnListener(arg_6_0.refundbtn_, nil, function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				pages = {
					"TextureConfig/RechargeUI/RefundPolicy@kr"
				}
			})
		end)
	end
end

function var_0_1.SwitchPage(arg_8_0, arg_8_1)
	arg_8_0.curShopId_ = arg_8_1
	arg_8_0.shopDataList_ = arg_8_0:InitShopList(arg_8_1)

	arg_8_0.giftList_:StartScroll(#arg_8_0.shopDataList_)
end

function var_0_1.RefreshList(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or false
	arg_9_0.shopDataList_ = arg_9_0:InitShopList(arg_9_0.curShopId_)

	if arg_9_1 then
		local var_9_0 = arg_9_0.giftList_:GetScrolledPosition()

		arg_9_0.giftList_:StartScrollByPosition(#arg_9_0.shopDataList_, var_9_0)
	else
		arg_9_0.giftList_:StartScroll(#arg_9_0.shopDataList_)
	end
end

function var_0_1.InitShopList(arg_10_0, arg_10_1)
	local var_10_0 = ShopTools.FilterShopDataList(arg_10_1)

	table.sort(var_10_0, function(arg_11_0, arg_11_1)
		local var_11_0 = getShopCfg(arg_11_0.id, arg_10_1)
		local var_11_1 = getShopCfg(arg_11_1.id, arg_10_1)
		local var_11_2 = arg_10_0:GetGoodStatus(arg_11_0.id, arg_10_1)
		local var_11_3 = arg_10_0:GetGoodStatus(arg_11_1.id, arg_10_1)

		if var_11_2 ~= var_11_3 then
			return var_11_2 < var_11_3
		end

		if var_11_0.shop_sort ~= var_11_1.shop_sort then
			return var_11_0.shop_sort > var_11_1.shop_sort
		end

		return var_11_0.goods_id > var_11_1.goods_id
	end)

	return var_10_0
end

function var_0_1.GetGoodStatus(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = false
	local var_12_1 = getShopCfg(arg_12_1, arg_12_2)
	local var_12_2 = ShopData.GetShop(var_12_1.shop_id)[arg_12_1]
	local var_12_3 = RechargeShopDescriptionCfg[var_12_1.description]

	if ShopData.IsGoodOutOfDate(arg_12_1, arg_12_2) then
		return 3
	end

	if var_12_2 ~= nil and var_12_1.limit_num ~= nil and var_12_1.limit_num ~= -1 and var_12_1.limit_num - var_12_2.buy_times <= 0 then
		var_12_0 = true
	end

	if var_12_0 then
		return 3
	end

	if var_12_3 and var_12_3.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_PACKS then
		for iter_12_0, iter_12_1 in ipairs(var_12_3.param) do
			if iter_12_1[1] then
				local var_12_4 = ItemCfg[iter_12_1[1]]

				if ItemTools.getItemNum(iter_12_1[1]) == 1 and var_12_4.type == ItemConst.ITEM_TYPE.HERO_SKIN then
					return 2
				end
			end
		end
	end

	if ShopData.IsGoodUnlock(arg_12_1, arg_12_2) == 0 then
		return 1
	end

	return 0
end

function var_0_1.IsInChain(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = getShopCfg(arg_13_1, arg_13_2)
	local var_13_1 = getShopIDListByShopID(var_13_0.shop_id)

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_2 = getShopCfg(iter_13_1)

		if #var_13_2.pre_goods_id > 0 and var_13_2.pre_goods_id[1] == arg_13_1 then
			return true
		end
	end

	if #var_13_0.pre_goods_id > 0 then
		return true
	end

	return false
end

function var_0_1.AddEventListeners(arg_14_0)
	arg_14_0:RegistEventListener(SHOP_LIST_UPDATE, function(arg_15_0)
		if arg_15_0 > 0 and arg_15_0 == arg_14_0.curShopId_ then
			arg_14_0:RefreshList()
		end
	end)
	arg_14_0:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_16_0, arg_16_1)
		arg_14_0:RefreshShopGoodInfo(arg_16_0, arg_16_1)
	end)
	arg_14_0:RegistEventListener(RECHARGE_SUCCESS, function(arg_17_0)
		arg_14_0:RefreshList(true)
	end)
end

function var_0_1.UpdateShopList(arg_18_0, arg_18_1)
	if arg_18_1 == arg_18_0.curShopId_ then
		arg_18_0.giftList_:Refresh()
	end
end

function var_0_1.RefreshShopGoodInfo(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_0.curShopId_ ~= arg_19_1 then
		return
	end

	for iter_19_0, iter_19_1 in pairs(arg_19_0.giftList_:GetItemList()) do
		if arg_19_2 == iter_19_1.goodId_ then
			iter_19_1:SetData(iter_19_1.index_, iter_19_1.shopId_, iter_19_1.goodId_)
		end
	end
end

function var_0_1.OnShopBuyResult(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	if arg_20_1 == 0 then
		arg_20_0:RefreshList(true)
	end
end

function var_0_1.OnTop(arg_21_0)
	return
end

function var_0_1.OnEnter(arg_22_0)
	arg_22_0:AddEventListeners()

	if arg_22_0.timer_ == nil then
		arg_22_0.timer_ = FrameTimer.New(function()
			if arg_22_0.giftList_ ~= nil then
				for iter_23_0, iter_23_1 in ipairs(arg_22_0.giftList_:GetItemList()) do
					iter_23_1:UpdateTimerView()
				end
			end

			arg_22_0:UpdateTimer()
		end, 1, -1)

		arg_22_0.timer_:Start()
	end

	SetActive(arg_22_0.refundGo_, not SDKTools.GetIsInputServer("kr"))
	SetActive(arg_22_0.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(arg_22_0.refundbtn_.gameObject, arg_22_0.curPageIndex_ ~= 4 and arg_22_0.curPageIndex_ ~= 6)
	end
end

function var_0_1.UpdateTimer(arg_24_0)
	return
end

function var_0_1.OnExit(arg_25_0)
	if arg_25_0.timer_ ~= nil then
		arg_25_0.timer_:Stop()

		arg_25_0.timer_ = nil
	end
end

function var_0_1.Hide(arg_26_0)
	var_0_1.super.Hide(arg_26_0)
end

function var_0_1.SetTreeRefreshHandler(arg_27_0, arg_27_1)
	arg_27_0.treeRefreshHandler_ = arg_27_1
end

function var_0_1.HaveActivityGift(arg_28_0)
	local var_28_0 = getShopIDListByShopID(15)

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		if not ShopData.IsGoodOutOfDate(iter_28_1, 15) then
			return true
		end
	end

	return false
end

function var_0_1.Dispose(arg_29_0)
	if arg_29_0.giftList_ then
		arg_29_0.giftList_:Dispose()

		arg_29_0.giftList_ = nil
	end

	arg_29_0.treeRefreshHandler_ = nil

	var_0_1.super.Dispose(arg_29_0)
end

return var_0_1
