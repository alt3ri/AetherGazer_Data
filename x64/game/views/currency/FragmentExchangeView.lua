local var_0_0 = class("FragmentExchangeView", ReduxView)
local var_0_1 = import("game.tools.HeroTools")

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Shop/ShopExchangePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.scrollHelper = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.listGo_, CommonItemView)
	arg_3_0.resultList = LuaList.New(handler(arg_3_0, arg_3_0.indexItem2), arg_3_0.list2Go_, FragmentExchangeItem)
	arg_3_0.controller = arg_3_0.controller_:GetController("state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnOK_, nil, function()
		if #arg_4_0.itemList_ == 0 then
			arg_4_0:Back()
		else
			ShopAction.ResolveFragment()
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnCancel_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.OnResolveFragment(arg_8_0, arg_8_1)
	if #arg_8_0.itemList_ == 0 then
		return
	end

	if arg_8_1.result == 0 then
		ShowTips("EXCHANGE_SUCCESS")
		arg_8_0:Back()
	else
		ShowTips(arg_8_1.result)

		return
	end
end

function var_0_0.indexItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.pieceList_[arg_9_1]

	function var_9_0.clickFun(arg_10_0)
		ShowPopItem(POP_ITEM, {
			arg_10_0.id,
			arg_10_0.number
		})
	end

	var_9_0.selectStyle = true

	CommonTools.SetCommonData(arg_9_2, var_9_0)
end

function var_0_0.indexItem2(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.itemList_[arg_11_1]

	arg_11_2:SetData({
		number = 1,
		id = var_11_0.id,
		clickFun = function(arg_12_0)
			ShowPopItem(POP_ITEM, {
				arg_12_0.id,
				arg_12_0.number
			})
		end
	}, var_11_0.num)
end

function var_0_0.RefreshPiece(arg_13_0)
	arg_13_0.pieceList_ = var_0_1.GetCanExchangeHero()

	arg_13_0.scrollHelper:StartScroll(#arg_13_0.pieceList_)
end

function var_0_0.RefreshGetItemNum(arg_14_0)
	if not arg_14_0.pieceList_ then
		return
	end

	arg_14_0.itemList_ = ShopTools.GetFragmentList()

	arg_14_0.resultList:StartScroll(#arg_14_0.itemList_)
end

function var_0_0.Init(arg_15_0)
	arg_15_0:InitUI()
	arg_15_0:AddUIListener()
end

function var_0_0.UpdateView(arg_16_0)
	arg_16_0.controller:SetSelectedState(#ShopTools.GetFragmentList() == 0 and "none" or "have")

	arg_16_0.noneTxt_.text = GetTips("NO_EXCHANGE_HERO_PIECE")
	arg_16_0.titleTxt_.text = GetTips("DEBRIS_EXCHANGE")
	arg_16_0.bottleTxt_.text = GetTips("SHOP_EXCHANGE_CONFIRM_2")
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0:UpdateView()
	arg_17_0:RefreshPiece()
	arg_17_0:RefreshGetItemNum()
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:RemoveAllListeners()
	arg_18_0.scrollHelper:Dispose()
	arg_18_0.resultList:Dispose()
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
