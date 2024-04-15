slot0 = class("CommunitySpecialWelfareShopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/showpopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.refreshUIHandler_ = handler(slot0, slot0.RefreshUI)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.useNumTriggerListener_ = slot0.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	slot0.bgController = slot0.controller_:GetController("bg")
	slot0.timeController = slot0.controller_:GetController("time")
	slot0.viewController = slot0.controller_:GetController("view")
	slot0.starController = slot0.controller_:GetController("star")
	slot0.ndtabController = slot0.controller_:GetController("ndtab")
	slot0.consumeController = slot0.controller_:GetController("consume")
	slot0.numController = slot0.controller_:GetController("showNum")
	slot0.furnitureController = slot0.controller_:GetController("Furniture")
	slot0.groupController = slot0.controller_:GetController("group")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if CommunityData:GetWelfareExchangeCnt() < uv0.useNum_ then
			ShowTips("EXCEED_MAX_CNT")

			return
		end

		CommunityAction:BuySpecialWelfare(uv0.useNum_)
	end)
	slot0:AddPressingByTimeListener(slot0.addBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.useNumSlider_.value < uv0.canUseMaxNum_ then
			uv0.useNumSlider_.value = uv0.useNumSlider_.value + 1

			if uv0.canUseMaxNum_ <= uv0.useNumSlider_.value then
				uv0.useNumSlider_.value = uv0.canUseMaxNum_
			end

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.delBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.useNumSlider_.value >= 1 then
			uv0.useNumSlider_.value = uv0.useNumSlider_.value - 1

			return true
		end

		return false
	end)
	slot0.useNumSlider_.onValueChanged:AddListener(function ()
		if uv0.canUseMaxNum_ then
			uv0.useNum_ = math.floor(uv0.useNumSlider_.value)

			if uv0.useNum_ < 1 then
				uv0.useNum_ = 1
			elseif uv0.canUseMaxNum_ < uv0.useNum_ then
				uv0.useNum_ = uv0.canUseMaxNum_
			end

			if uv0.useNum_ <= 0 then
				uv0.useNum_ = 1
			end

			uv0:UpdateCnt()
		end
	end)
	slot0.useNumTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0.useNumSlider_.value = math.floor(uv0.useNumSlider_.value)
	end))
end

function slot0.OnEnter(slot0)
	CommunityAction:RefreshCurrencyA()
	manager.windowBar:SetAsLastSibling()
	slot0.numController:SetSelectedState("none")
	slot0.viewController:SetSelectedState("false")
	slot0.consumeController:SetSelectedState("normal")
	slot0.furnitureController:SetSelectedState("false")

	slot0.identity_ = CommunityData:GetIdentity()

	manager.notify:RegistListener(GUILD_WELFRE_CNT_REFRESH, slot0.refreshUIHandler_)

	slot0.okBtn_.interactable = GameSetting.club_special_welfare_cost.value[1] <= CommunityData:GetCurrenyA()

	slot0:RefreshUI()
end

function slot0.RefreshGood(slot0)
	slot1 = ItemCfg[GameSetting.club_special_welfare.value[1]]

	slot0.ndtabController:SetSelectedState("off")

	slot0.itemIcon_.sprite = ItemTools.getItemSprite(slot1.id)

	slot0.bgController:SetSelectedState(tostring(slot1.rare))

	slot0.nameText_.text = GetI18NText(slot1.name)
	slot0.descText_.text = GetI18NText(slot1.desc) .. "\n\n" .. GetTips("CLUB_SPECIAL_WELFARE")
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A)
end

function slot0.RefreshSlider(slot0)
	slot1 = CommunityData:GetCurrenyA()
	slot2 = GameSetting.club_special_welfare_cost.value[1]
	slot3 = CommunityData:GetWelfareExchangeCnt()
	slot0.canUseMaxNum_ = slot3
	slot0.useNumSlider_.minValue = 1
	slot0.useNumSlider_.maxValue = math.max(slot3, 1)
	slot0.useNumSlider_.value = math.min(slot0.useNumSlider_.maxValue, 1)

	slot0:UpdateDelAddBtn()
	slot0:UpdatePreview()
end

function slot0.UpdateDelAddBtn(slot0)
end

function slot0.UpdatePreview(slot0)
	slot0.useNum_ = slot0.useNumSlider_.value
	slot0.useNumText_.text = slot0.useNum_

	if CommunityData:GetCurrenyA() < slot0.useNum_ * GameSetting.club_special_welfare_cost.value[1] then
		slot0.totalCostText_.text = "<color=#FF0000>" .. slot1 .. "</color>"
	else
		slot0.totalCostText_.text = slot1
	end
end

function slot0.UpdateCnt(slot0)
	slot0:UpdateDelAddBtn()
	slot0:UpdatePreview()
end

function slot0.OnBuyCommunitySpecialWelfare(slot0)
	slot0:Back()
	ShowTips("TIP_CLUB_SPECIAL_WELFARE_BUY")
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(GUILD_WELFRE_CNT_REFRESH, slot0.refreshUIHandler_)
end

function slot0.OnExitInput(slot0)
	JumpTools.Back()

	return true
end

function slot0.Dispose(slot0)
	slot0.refreshUIHandler_ = nil

	slot0:RemoveAllListeners()
	slot0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshGood()
	slot0:RefreshSlider()
	slot0.groupController:SetSelectedState("false")
	SetActive(slot0.limitGo_, true)

	slot1 = GameSetting.club_special_reward_buy_limit_weekly.value[1]
	slot0.limitText_.text = GetTips("LIMIT_WEEK") .. string.format("%s/%s", slot1 - CommunityData:GetWelfareExchangeCnt(), slot1)
end

return slot0
