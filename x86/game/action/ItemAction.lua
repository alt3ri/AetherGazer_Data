manager.net:Bind(17023, function (slot0)
	uv0.ModifyItemList(slot0.normal_items)
	EquipAction.ModifyEquipList(slot0.equip_list)
	uv0.AddBackHomeItem(slot0.back_home_list)
	ServantAction.ModifyServantList(slot0.weapon_list)
	FukubukuroAction.UpdateItem(slot0.rand_item)
end)
manager.net:Bind(17025, function (slot0)
	if slot0.last_fatigue_recover_time then
		CurrencyData:SetLastFatigueRecoverTime(slot1)
	end
end)

return {
	ModifyItemList = function (slot0)
		for slot4, slot5 in ipairs(slot0) do
			uv0.AddItemData(slot5)
		end
	end,
	AddItemData = function (slot0)
		if ItemCfg[slot0.id].type == ItemConst.ITEM_TYPE.CURRENCY then
			CurrencyAction.SetCurrencyValue(slot1, slot0.num, slot0.time_valid)
		elseif slot5 == ItemConst.ITEM_TYPE.MATERIAL or slot5 == ItemConst.ITEM_TYPE.GIFT or slot5 == ItemConst.ITEM_TYPE.PROPS or slot5 == ItemConst.ITEM_TYPE.DYNAMIC_STICKER or slot5 == ItemConst.ITEM_TYPE.ARCHIVE_GIFT then
			MaterialAction.SetMaterialValue(slot1, slot2, slot3)
		elseif slot5 == ItemConst.ITEM_TYPE.SKIN_CHANGE then
			MaterialAction.SetMaterialValue(slot1, slot2, slot3)
			HeroAction.UpdateSkinCouponRedPoint(SkinCfg[ItemCfg[slot1].param[1]].hero)
		elseif slot5 == ItemConst.ITEM_TYPE.HERO then
			HeroAction.UnlockHeroSuccess(slot1)
		elseif slot5 == ItemConst.ITEM_TYPE.HERO_PIECE then
			HeroAction.HeroPieceModify(slot4.hero_id, slot2)
		elseif slot5 == ItemConst.ITEM_TYPE.HERO_SKIN then
			HeroAction.SkinAdd(slot1, slot0.time_valid ~= 0, slot0.time_valid)
		elseif slot5 == ItemConst.ITEM_TYPE.PORTRAIT then
			PlayerAction.UnlockPortrait(slot1)
		elseif slot5 == ItemConst.ITEM_TYPE.FRAME then
			PlayerAction.UnlockFrame(slot1)
		elseif slot5 == ItemConst.ITEM_TYPE.STICKER then
			PlayerAction.UnlockSticker(slot1)
		elseif slot5 == ItemConst.ITEM_TYPE.STICKER_BG then
			PlayerAction.UnlockStickerBg(slot1)
		elseif slot5 == ItemConst.ITEM_TYPE.TAG then
			PlayerData:UnlockTag(slot1)
		elseif slot5 == ItemConst.ITEM_TYPE.CARD_BG then
			PlayerData:UnlockCardBg(slot1)
		elseif slot5 == ItemConst.ITEM_TYPE.CLUB_COMMON then
			if slot1 == 52002 then
				GuildData:ModifyEXP(slot2)
			elseif slot1 == CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A then
				GuildData:ModifyCoin(slot2)
			end
		elseif slot5 == ItemConst.ITEM_TYPE.SCENE then
			HomeSceneSettingData:UnlockScene(slot1, slot0.time_valid)
			HomeSceneSettingAction.CheckMatchScene(slot1, slot0.time_valid)
		else
			error("未添加对应的奖励", slot5)
		end
	end,
	AddBackHomeItem = function (slot0)
		for slot4, slot5 in ipairs(slot0) do
			if ItemCfg[slot5.id].type == ItemConst.ITEM_TYPE.DORM_FURNITURE then
				DormAction.ModifyFurniture(slot5.id, slot5.num, slot5.give_num)
			elseif slot6.type == ItemConst.ITEM_TYPE.CANTEEN_INGREDIENTS then
				CanteenFoodData:AddFoodIngredients(slot5.id, slot5.num)
			elseif slot6.type == ItemConst.ITEM_TYPE.FURNITURE_SUIT then
				DormSuitData:RefreshUnLockSuitList({
					slot5.id
				}, false)
			end
		end
	end
}
