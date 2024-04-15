slot0 = class("ItemUseView", ReduxView)

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
	slot0.useNumTriggerListener_ = slot0.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	slot0.controller_ = slot0.controllerEx_:GetController("state")

	slot0.controller_:SetSelectedState("1")

	slot0.titleText_.text = GetTips("ITEM_USE")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		OperationRecorder.Record(uv0.lastRecord_, "operateUseBtn")

		slot0 = uv0.itemData_.id
		slot1 = ItemTools.getItemNum(slot0, uv0.itemData_.timeValid)
		slot2 = uv0.itemData_.timeValid
		slot3 = ItemCfg[slot0]

		if uv0:AddVitalityCnt() and not (uv0.useNumSlider_.value * slot5 + ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) <= ItemCfg[CurrencyConst.CURRENCY_TYPE_VITALITY].max) then
			ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

			return
		end

		if not canAddVitalityByProp(slot0) then
			ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

			return
		end

		CommonAction.TryToUseItemWitchCallback({
			{
				item_info = {
					id = slot0,
					num = slot4,
					time_valid = slot2
				},
				use_list = {}
			}
		}, function (slot0)
			uv0:UseItemSuccess(slot0)
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
			if uv0:AddVitalityCnt() and not ((uv0.useNumSlider_.value + 1) * slot1 + ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) <= ItemCfg[CurrencyConst.CURRENCY_TYPE_VITALITY].max) then
				ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

				return false
			end

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
	slot0.itemData_ = slot0.params_.itemData

	if slot0:GetMaxNum() < 1 then
		slot1 = 1
	end

	slot0.canUseMaxNum_ = slot1
	slot0.selectNum_ = 1
	slot0.useNumSlider_.maxValue = slot1
	slot0.useNumSlider_.value = 1
end

function slot0.UpdateView(slot0)
	slot1 = slot0.itemData_.id
	slot2 = clone(ItemTemplateData)
	slot2.id = slot1
	slot2.number = nil

	function slot2.clickFun(slot0)
		slot1 = clone(slot0)
		slot1.timeValid = uv0.itemData_.timeValid

		ShowPopItem(POP_ITEM, slot1)
	end

	slot0.commonItem1_:SetData(slot2)

	slot0.nameText1_.text = ItemTools.getItemName(slot1)

	slot0:UpdateNum()
	slot0:UpdateSliderPositionBySelectNum()
	slot0:UpdateDelAddBtn()
end

function slot0.UpdateNum(slot0)
	slot0.useNumText_.text = tostring(slot0.selectNum_)

	slot0.commonItem1_:RefreshBottomText({
		ItemTools.getItemNum(slot0.itemData_.id, slot0.itemData_.timeValid),
		slot0.selectNum_
	})
end

function slot0.OnEnter(slot0)
	slot0:InitData()
	slot0:UpdateView()
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

	uv0.super.Dispose(slot0)
end

function slot0.AddVitalityCnt(slot0)
	if ItemCfg[slot0.itemData_.id].sub_type == ItemConst.ITEM_SUB_TYPE.TIME_LIMIT_ITEM or slot1.sub_type == ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID then
		return slot1.param[1][2]
	end

	return false
end

function slot0.GetMaxNum(slot0)
	slot2 = slot0.itemData_.timeValid

	if ItemCfg[slot0.itemData_.id].sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM then
		return 1
	end

	slot4 = ItemTools.getItemNum(slot1, slot2)

	if slot3.type == ItemConst.ITEM_TYPE.PROPS and (ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY == slot3.sub_type or ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID == slot3.sub_type) then
		return math.max(math.min(math.floor((999 - ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)) / slot3.param[1][2]), slot4), 1)
	end

	return slot4
end

function slot0.UseItemSuccess(slot0, slot1)
	if ItemTools.getItemNum(slot0.itemData_.id, slot0.itemData_.timeValid) <= 0 then
		slot0:Back()
	else
		slot0:InitData()
		slot0:UpdateView()
	end

	slot5 = slot1.drop_list

	if ItemCfg[slot2].type == ItemConst.ITEM_TYPE.SKIN_CHANGE then
		slot6 = ItemCfg[slot2].param[1]
		slot7 = SkinCfg[slot6].hero

		getReward(formatRewardCfgList({
			{
				slot6,
				1
			}
		}), {
			ItemConst.ITEM_TYPE.HERO_SKIN
		})
	elseif ItemCfg[slot2].sub_type == ItemConst.ITEM_SUB_TYPE.BIRTHDAY_ITEM then
		manager.story:StartStory(BirthdayCfg[BirthdayCfg.get_id_list_by_commemorative_props_id[slot2][1]].story_id)
	elseif ItemCfg[slot2].sub_type == ItemConst.ITEM_SUB_TYPE.BITRHDAY_LETTER then
		slot6 = BirthdayCfg[BirthdayCfg.get_id_list_by_appendix_id[slot2][1]].story_id

		manager.story:StartStory(slot6)
		IllustratedData:ModifyPlot(slot6)
		getReward(slot5)
		SDKTools.SendMessageToSDK("birthday_received", {
			story_unlock = 1
		})
	elseif ItemCfg[slot2].type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
		ShowTips("EXCHANGE_SUCCESS")
	elseif ItemCfg[slot2].sub_type == ItemConst.ITEM_SUB_TYPE.MOON_CAKE_GIFT then
		getReward(slot5)
		MoonCakeAction.OnOpenGift(ItemCfg[slot2].time[2][1], slot1.drop_list)
	else
		getReward(mergeReward(slot5))
	end
end

return slot0
