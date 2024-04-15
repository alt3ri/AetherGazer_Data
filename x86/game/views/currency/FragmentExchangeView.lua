slot0 = class("FragmentExchangeView", ReduxView)
slot1 = import("game.tools.HeroTools")

function slot0.UIName(slot0)
	return "Widget/System/Shop/ShopExchangePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, CommonItemView)
	slot0.resultList = LuaList.New(handler(slot0, slot0.indexItem2), slot0.list2Go_, FragmentExchangeItem)
	slot0.controller = slot0.controller_:GetController("state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.btnOK_, nil, function ()
		if #uv0.itemList_ == 0 then
			uv0:Back()
		else
			ShopAction.ResolveFragment()
		end
	end)
	slot0:AddBtnListener(slot0.btnCancel_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnResolveFragment(slot0, slot1)
	if #slot0.itemList_ == 0 then
		return
	end

	if slot1.result == 0 then
		ShowTips("EXCHANGE_SUCCESS")
		slot0:Back()
	else
		ShowTips(slot1.result)

		return
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = slot0.pieceList_[slot1]

	function slot3.clickFun(slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot3.selectStyle = true

	CommonTools.SetCommonData(slot2, slot3)
end

function slot0.indexItem2(slot0, slot1, slot2)
	slot3 = slot0.itemList_[slot1]

	slot2:SetData({
		number = 1,
		id = slot3.id,
		clickFun = function (slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
		end
	}, slot3.num)
end

function slot0.RefreshPiece(slot0)
	slot0.pieceList_ = uv0.GetCanExchangeHero()

	slot0.scrollHelper:StartScroll(#slot0.pieceList_)
end

function slot0.RefreshGetItemNum(slot0)
	if not slot0.pieceList_ then
		return
	end

	slot0.itemList_ = ShopTools.GetFragmentList()

	slot0.resultList:StartScroll(#slot0.itemList_)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.UpdateView(slot0)
	slot0.controller:SetSelectedState(#ShopTools.GetFragmentList() == 0 and "none" or "have")

	slot0.noneTxt_.text = GetTips("NO_EXCHANGE_HERO_PIECE")
	slot0.titleTxt_.text = GetTips("DEBRIS_EXCHANGE")
	slot0.bottleTxt_.text = GetTips("SHOP_EXCHANGE_CONFIRM_2")
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
	slot0:RefreshPiece()
	slot0:RefreshGetItemNum()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper:Dispose()
	slot0.resultList:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
