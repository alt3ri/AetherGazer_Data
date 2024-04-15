slot0 = class("ModuleItemResolveView", ReduxView)
slot1 = GameSetting.weapon_module_break_return

function slot0.UIName(slot0)
	return "Widget/System/Shop/ShopExchangePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, CommonItemView)
	slot0.resultList = LuaList.New(handler(slot0, slot0.indexItem2), slot0.list2Go_, FragmentExchangeItem)
	slot0.controller = slot0.controller_:GetController("state")
end

function slot0.OnEnter(slot0)
	slot0.titleTxt_.text = GetTips("FILE_EXCHANGE")
	slot0.bottleTxt_.text = GetTips("SHOP_EXCHANGE_CONFIRM_1")
	slot0.curModulePieceList_ = {}

	slot0.controller:SetSelectedState(HeroTools.CheckModulePieceCanEnter() and "have" or "none")

	slot0.noneTxt_.text = GetTips("WEAPON_MODULE_MATERIAL_NOT_ENOUGH")

	if HeroTools.CheckModulePieceCanEnter() == false then
		return
	end

	slot2 = 1

	for slot6, slot7 in pairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MODULE_PIECE]) do
		if ItemTools.getItemNum(slot7) > 0 then
			table.insert(slot0.curModulePieceList_, {
				select = 0,
				id = slot7,
				number = slot8,
				index = slot2
			})

			slot2 = slot2 + 1
		end
	end

	slot0.list_:StartScroll(#slot0.curModulePieceList_)
	slot0.resultList:StartScroll(1)
	slot0:RefreshReward()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.btnOK_, nil, function ()
		if uv0.getNum_ == 0 then
			ShowTips(GetTips("WEAPON_MODULE_MATERIAL_SELECT"))
		else
			slot0 = {}

			for slot4, slot5 in pairs(uv0.curModulePieceList_) do
				if slot5.select > 0 then
					table.insert(slot0, {
						id = slot5.id,
						num = slot5.select
					})
				end
			end

			HeroAction.ResolveModuleItem(slot0)
		end
	end)
	slot0:AddBtnListener(slot0.btnCancel_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnItemSelect(slot0, slot1, slot2, slot3)
	if slot1.topAmountValue < slot1.number then
		slot1.topAmountValue = slot1.topAmountValue + 1
		slot0.curModulePieceList_[slot3].select = slot1.topAmountValue

		slot2:SetData(slot1)
		slot0:RefreshReward()

		return true
	end

	return false
end

function slot0.OnItemCut(slot0, slot1, slot2, slot3)
	if slot1.topAmountValue > 0 then
		slot1.topAmountValue = slot1.topAmountValue - 1

		if slot1.topAmountValue == 0 then
			slot1.grayFlag = false
		end

		slot0.curModulePieceList_[slot3].select = slot1.topAmountValue

		slot2:SetData(slot1)
		slot0:RefreshReward()

		return true
	end

	return false
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.curModulePieceList_[slot1]
	slot3.topAmountValue = slot3.select

	function slot3.clickFun(slot0)
		uv0:OnItemSelect(slot0, uv1, uv2)
	end

	function slot3.clickAmountFun(slot0)
		return uv0:OnItemCut(slot0, uv1, uv2)
	end

	function slot3.longClickFun(slot0)
		return uv0:OnItemSelect(slot0, uv1, uv2)
	end

	CommonTools.SetCommonData(slot2, slot3)
end

function slot0.indexItem2(slot0, slot1, slot2)
	slot0.item = slot2
	slot0.info = {
		number = 1,
		id = uv0.value[1],
		clickFun = function ()
			ShowPopItem(POP_SOURCE_ITEM, {
				uv0.value[1]
			})
		end
	}

	slot2:SetData(slot0.info, slot0.getNum_ or 0)
end

function slot0.RefreshReward(slot0)
	slot0.getNum_ = 0

	for slot4, slot5 in pairs(slot0.curModulePieceList_) do
		slot0.getNum_ = slot0.getNum_ + slot5.select
	end

	slot0.getNum_ = slot0.getNum_ * uv0.value[2]
	slot0.info = {
		number = 1,
		id = uv0.value[1],
		clickFun = function ()
			ShowPopItem(POP_SOURCE_ITEM, {
				uv0.value[1]
			})
		end
	}

	if slot0.item then
		slot0.item:SetData(slot0.info, slot0.getNum_)
	end
end

function slot0.OnResolveModuleItem(slot0, slot1, slot2)
	if slot0.getNum_ == 0 then
		return
	end

	if slot1.result == 0 then
		JumpTools:Back()
		getReward({
			{
				id = uv0.value[1],
				num = slot0.getNum_
			}
		})
	else
		ShowTips(slot1.result)
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	if slot0.resultList then
		slot0.resultList:Dispose()

		slot0.resultList = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
