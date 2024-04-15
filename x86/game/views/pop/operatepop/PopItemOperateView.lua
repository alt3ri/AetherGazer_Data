slot0 = class("PopItemOperateView", import("game.views.pop.sourcePop.PopItemSourceView"))
slot1 = GameSetting.vitality_exchange_id_list.value

function slot0.CustomInitUI(slot0)
	uv0.super.CustomInitUI(slot0)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:RefreshUI()

	slot0[ON_TRY_TO_USE_ITEM] = slot0.UseItemFun
end

function slot0.OnExit(slot0)
	slot0[ON_TRY_TO_USE_ITEM] = nil

	uv0.super.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.addBtn_ = nil
	slot0.delBtn_ = nil
	slot0.materialCntText_ = nil
	slot0.useNumSlider_ = nil
end

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)
end

function slot0.RemoveListeners(slot0)
	uv0.super.RemoveListeners(slot0)
end

function slot0.AddVitalityCnt(slot0, slot1)
	if ItemCfg[slot1].sub_type == 401 or slot2.sub_type == 403 then
		return slot2.param[1][2]
	end

	return false
end

function slot0.UseItemFun(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		if ItemTools.getItemNum(slot0:GetItemID(), slot0:GetItemTimeValid()) <= 0 then
			slot0:Back()
		else
			slot0:RefreshUI()
			slot0:RefreshCount()
			slot0:SetCommonItem(slot5)
		end

		slot6 = slot1.drop_list

		if ItemCfg[slot2.use_item_list[1].item_info.id].type == ItemConst.ITEM_TYPE.SKIN_CHANGE then
			slot8 = ItemCfg[slot7].param[1]
			slot9 = SkinCfg[slot8].hero

			getReward(formatRewardCfgList({
				{
					slot8,
					1
				}
			}), {
				ItemConst.ITEM_TYPE.HERO_SKIN
			})
		elseif ItemCfg[slot7].sub_type == ItemConst.ITEM_SUB_TYPE.BIRTHDAY_ITEM then
			manager.story:StartStory(BirthdayCfg[BirthdayCfg.get_id_list_by_commemorative_props_id[slot7][1]].story_id)
		elseif ItemCfg[slot7].sub_type == ItemConst.ITEM_SUB_TYPE.BITRHDAY_LETTER then
			slot8 = BirthdayCfg[BirthdayCfg.get_id_list_by_appendix_id[slot7][1]].story_id

			manager.story:StartStory(slot8)
			IllustratedData:ModifyPlot(slot8)
			getReward(slot6)
			SDKTools.SendMessageToSDK("birthday_received", {
				story_unlock = 1
			})
		elseif ItemCfg[slot7].type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
			ShowTips("EXCHANGE_SUCCESS")
		elseif ItemCfg[slot7].sub_type == ItemConst.ITEM_SUB_TYPE.MOON_CAKE_GIFT then
			getReward(slot6)
			MoonCakeAction.OnOpenGift(ItemCfg[slot7].time[2][1], slot1.drop_list)
		else
			getReward(slot6)
		end

		manager.notify:CallUpdateFunc(NOTIFY_FOR_BAG_REFRESH_BUG)
	else
		ShowTips(slot1.result)
	end
end

function slot0.RefreshUI(slot0)
	slot0.useNumSlider_.minValue = 0
	slot0.useNumSlider_.maxValue = slot0:GetMaxNum()
	slot0.useNumSlider_.value = 1

	if ItemCfg[slot0:GetItemID()].sub_type == ItemConst.ITEM_SUB_TYPE.NEWWARCHESS_MOVEPOINT_PACKAGE then
		SetActive(slot0.operatePanel_, false)
	else
		SetActive(slot0.operatePanel_, slot2 and (slot2.use == 1 or slot2.use == 2) and MaterialConst.MATERIAL_TYPE.MYTHIC_REFRESH ~= slot2.sub_type)
	end

	if slot2.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or slot2.type == ItemConst.ITEM_TYPE.GIFT and slot2.sub_type == ItemConst.ITEM_SUB_TYPE.FUKUBUKURO then
		SetActive(slot0.operateInfoGo_, false)
	else
		SetActive(slot0.operateInfoGo_, true)
	end
end

function slot0.GetMaxNum(slot0)
	slot2 = slot0.itemInfo_.timeValid

	if ItemCfg[slot0:GetItemID()].sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM then
		return 1
	end

	slot4 = ItemTools.getItemNum(slot1, slot2)

	if slot3.type == ItemConst.ITEM_TYPE.PROPS and (ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY == slot3.sub_type or ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID == slot3.sub_type) then
		return math.max(math.min(math.floor((999 - ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)) / slot3.param[1][2]), slot4), 1)
	end

	return slot4
end

function slot0.UpdateCount(slot0)
	if slot0.useNumSlider_.value < 1 then
		slot0.useNumSlider_.value = 1
	end

	slot1 = slot0.useNumSlider_.value
	slot0.materialCntText_.text = slot1
	slot0.delBtn_.interactable = slot1 > 1
	slot2 = slot0:GetItemID()
	slot0.addBtn_.interactable = slot0.useNumSlider_.value < slot0:GetMaxNum()
end

return slot0
