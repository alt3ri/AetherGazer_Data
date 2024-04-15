slot0 = class("SynthesiseView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Bag/BagScenepopUI"
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

	slot0.commonItem1_ = CommonItemView.New(slot0.commonItemGo1_)
	slot0.commonItem2_ = CommonItemView.New(slot0.commonItemGo2_)
	slot0.useNumTriggerListener_ = slot0.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	slot0.controller_ = slot0.controllerEx_:GetController("state")

	slot0.controller_:SetSelectedState("2")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		slot0 = ItemTools.getItemNum(uv0.sourceId_)

		if uv0.haveNum_ < ItemExchangeCfg[uv0.exchangeID_].cost[1][2] * uv0.selectNum_ then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		CurrencyAction.ExchangeItem(uv0.exchangeID_, uv0.selectNum_, function (slot0)
			manager.notify:Invoke(ON_SYNTHESISE_USE_ITEM_SUCCESS)
			uv0:Back()
			getReward(slot0.reward_list)
		end)
	end)
	slot0.useNumSlider_.onValueChanged:AddListener(function ()
		uv0.selectNum_ = uv0.useNumSlider_.value

		if uv0.selectNum_ < 1 then
			uv0.selectNum_ = 1

			uv0:UpdateSliderPositionBySelectNum()
		end

		uv0:UpdateDelAddBtn()
		uv0:UpdateNum()
	end)
	slot0.useNumTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:UpdateDelAddBtn()
		uv0:UpdateNum()
		OperationRecorder.Record("bag", "mergeDrag")
	end))
	slot0:AddPressingByTimeListener(slot0.delBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum_ > 1 then
			uv0.selectNum_ = uv0.selectNum_ - 1

			uv0:UpdateSliderPositionBySelectNum()
			uv0:UpdateDelAddBtn()
			uv0:UpdateNum()

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.addBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum_ < uv0.canUseMaxNum_ then
			uv0.selectNum_ = uv0.selectNum_ + 1

			uv0:UpdateSliderPositionBySelectNum()
			uv0:UpdateDelAddBtn()

			return true
		end

		return false
	end)
end

function slot0.UpdateSliderPositionBySelectNum(slot0)
	slot0.useNumSlider_.value = slot0.selectNum_
end

function slot0.UpdateDelAddBtn(slot0)
	slot0.okBtn_.enabled = slot0.selectNum_ >= 1
	slot0.delBtn_.interactable = slot0.selectNum_ > 1
	slot0.addBtn_.interactable = slot0.selectNum_ < slot0.canUseMaxNum_
end

function slot0.InitData(slot0)
	slot0.exchangeID_ = slot0.params_.id
	slot1 = ItemExchangeCfg[slot0.exchangeID_]
	slot0.sourceId_ = slot1.cost[1][1]
	slot0.targetId_ = slot1.item_id
	slot0.costNum_ = slot1.cost[1][2]
	slot0.sourceCfg_ = ItemCfg[slot0.sourceId_]
	slot0.targetCfg_ = ItemCfg[slot0.targetId_]
	slot0.exchangeRate_ = slot0.costNum_
	slot2 = ItemTools.getItemNum(slot0.sourceId_)
	slot0.haveNum_ = slot2

	if math.floor(slot2 / slot0.costNum_) < 1 then
		slot3 = 1
	end

	slot0.canUseMaxNum_ = slot3
	slot0.selectNum_ = 1
	slot0.useNumSlider_.maxValue = slot3
	slot0.useNumSlider_.value = 1
end

function slot0.UpdateView(slot0)
	slot1 = clone(ItemTemplateData)
	slot1.id = slot0.sourceId_
	slot1.number = nil

	function slot1.clickFun(slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot0.commonItem1_:SetData(slot1)

	slot0.nameText1_.text = ItemTools.getItemName(slot0.sourceCfg_.id)
	slot2 = clone(ItemTemplateData)
	slot2.id = slot0.targetId_
	slot2.number = nil

	function slot2.clickFun(slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot3 = ItemExchangeCfg[slot0.exchangeID_]

	slot0.commonItem2_:SetData(slot2)

	slot0.nameText2_.text = ItemTools.getItemName(slot0.targetCfg_.id)

	slot0:UpdateNum()
	slot0:UpdateSliderPositionBySelectNum()
	slot0:UpdateDelAddBtn()
end

function slot0.UpdateNum(slot0)
	slot0.useNumText_.text = tostring(slot0.selectNum_) * slot0.exchangeRate_

	slot0.commonItem1_:RefreshBottomText({
		ItemTools.getItemNum(slot0.sourceId_),
		slot0.costNum_ * slot0.selectNum_
	})
	slot0.commonItem2_:RefreshBottomText(ItemExchangeCfg[slot0.exchangeID_].num * slot0.selectNum_)
end

function slot0.OnEnter(slot0)
	slot0:InitData()
	slot0:UpdateView()

	if ItemExchangeCfg[slot0.exchangeID_].type == 1 then
		slot0.titleText_.text = GetTips("ITEM_EXCHANGE")
	elseif slot1.type == 2 then
		slot0.titleText_.text = GetTips("ITEM_COMPOSE")
	elseif slot1.type == 3 then
		slot0.titleText_.text = GetTips("ITEM_DECOMPOSE")
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0.useNumSlider_.onValueChanged:RemoveAllListeners()
	slot0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)

	if slot0.commonItem1_ then
		slot0.commonItem1_:Dispose()

		slot0.commonItem1_ = nil
	end

	if slot0.commonItem2_ then
		slot0.commonItem2_:Dispose()

		slot0.commonItem2_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
