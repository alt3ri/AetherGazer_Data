return {
	getItemName = function (slot0)
		if ItemCfg[slot0].type == ItemConst.ITEM_TYPE.HERO then
			return HeroTools.GetHeroFullName(slot0)
		elseif slot1.type == ItemConst.ITEM_TYPE.HERO_SKIN and slot1.sub_type ~= ItemConst.ITEM_SUB_TYPE.LIMIT_SKIN then
			return SkinCfg[slot0].name
		end

		return GetI18NText(slot1.name)
	end,
	getItemDesc = function (slot0)
		if ItemCfg[slot0].type == ItemConst.ITEM_TYPE.HERO then
			return string.format(GetTips("HERO_DESC"), GetI18NText(HeroCfg[slot0].hero_desc))
		elseif slot1.type == ItemConst.ITEM_TYPE.HERO_SKIN then
			slot2 = slot0

			if slot1.param[1] then
				slot2 = slot1.param[1]
			end

			return string.format("%s%s", GetI18NText(slot1.desc), GetI18NText(SkinCfg[slot2].desc))
		elseif slot1.type == ItemConst.ITEM_TYPE.SKIN_CHANGE then
			return string.format(GetTips("EXCHANGE"), uv0.getItemDesc(slot1.param[1]))
		elseif slot1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			return string.format(GetTips("SERVANT_DESC"), GetI18NText(WeaponServantCfg[slot0].desc))
		else
			return GetI18NText(slot1.desc)
		end
	end,
	getItemNum = function (slot0, slot1)
		if slot0 == nil or slot0 == 0 then
			return 0
		end

		slot2 = ItemCfg[slot0]
		slot4 = slot2.sub_type

		if slot2.type == ItemConst.ITEM_TYPE.CURRENCY then
			return CurrencyData:GetCurrencyNum(slot0) or 0
		elseif slot3 == ItemConst.ITEM_TYPE.HERO_PIECE then
			if HeroData:GetHeroData(slot2.hero_id) then
				return slot5.piece
			end
		elseif slot3 == ItemConst.ITEM_TYPE.PROPS or slot3 == ItemConst.ITEM_TYPE.MATERIAL or slot3 == ItemConst.ITEM_TYPE.ARCHIVE_GIFT or slot3 == ItemConst.ITEM_TYPE.SKIN_CHANGE or slot3 == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
			return MaterialData:GetMaterialNum(slot0, slot1)
		elseif slot3 == ItemConst.ITEM_TYPE.GIFT then
			if slot4 == ItemConst.ITEM_SUB_TYPE.FUKUBUKURO then
				return FukubukuroData:CheckHaveItemId(slot0) and 1 or 0
			else
				return MaterialData:GetMaterialNum(slot0, slot1)
			end
		elseif slot3 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			return WeaponServantData:GetServantSByID(slot0) and table.length(slot5) or 0
		elseif slot3 == ItemConst.ITEM_TYPE.EQUIP then
			return #EquipTools.GetEquipListByEquipid(slot0)
		elseif slot3 == ItemConst.ITEM_TYPE.HERO_SKIN then
			if slot2.param[1] then
				slot0 = slot2.param[1]
			end

			return HeroTools.IsSkinUnlock(slot0) and 1 or 0
		elseif slot3 == ItemConst.ITEM_TYPE.PORTRAIT then
			return PlayerData:GetPortrait(slot0).unlock == 1 and 1 or 0
		elseif slot3 == ItemConst.ITEM_TYPE.FRAME then
			return PlayerData:GetFrame(slot0).unlock == 1 and 1 or 0
		elseif slot3 == ItemConst.ITEM_TYPE.STICKER then
			return PlayerData:GetSticker(slot0).unlock == 1 and 1 or 0
		elseif slot3 == ItemConst.ITEM_TYPE.CANTEEN_INGREDIENTS then
			return CanteenFoodData:GetHadIngredientNum(slot0) or 0
		elseif slot3 == ItemConst.ITEM_TYPE.CLUB_COMMON then
			-- Nothing
		elseif slot3 == ItemConst.ITEM_TYPE.DORM_FURNITURE then
			return DormData:GetFurNumInfo(slot0).num or 0
		elseif slot3 == ItemConst.ITEM_TYPE.SCENE then
			return HomeSceneSettingData:IsHaveScene(slot0) and 1 or 0
		elseif slot3 == ItemConst.ITEM_TYPE.FURNITURE_SUIT then
			return DormSuitData:CheckUnlockSuit(slot0) and 1 or 0
		elseif slot3 == ItemConst.ITEM_TYPE.STICKER_BG then
			return PlayerData:GetStickerBg(slot0).unlock == 1 and 1 or 0
		elseif slot3 == ItemConst.ITEM_TYPE.CARD_BG then
			return PlayerData:GetCardBg(slot0).unlock == 1 and 1 or 0
		elseif slot3 == ItemConst.ITEM_TYPE.CHAT_BUBBLE then
			return table.keyof(PlayerData:GetUnlockChatBubbleIDList(), slot0) and 1 or 0
		else
			print("未知的Item类型", slot3)
		end

		return 0
	end,
	getItemTexturePath = function (slot0, slot1)
		if ItemCfg[slot0] == nil then
			return
		end

		if slot2.type == ItemConst.ITEM_TYPE.EQUIP then
			return slot1 and SpritePathCfg.EquipIcon_s.path or SpritePathCfg.EquipIcon_l.path
		elseif slot2.type == ItemConst.ITEM_TYPE.HERO_SKIN or slot2.type == ItemConst.ITEM_TYPE.HERO then
			return SpritePathCfg.HeroLittleIcon.path
		elseif slot2.type == ItemConst.ITEM_TYPE.HERO_PIECE then
			return SpritePathCfg.HeroPiece.path
		elseif slot2.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			return SpritePathCfg.ServantIcon.path
		elseif slot2.type == ItemConst.ITEM_TYPE.PORTRAIT then
			if slot2.sub_type == 1 then
				return SpritePathCfg.HeroLittleIcon.path
			elseif slot2.sub_type == 2 then
				return "TextureConfig/Item_l"
			else
				print("暂未定义的头像来源")
			end
		elseif slot2.type == ItemConst.ITEM_TYPE.STICKER then
			return "TextureConfig/Sticker/"
		elseif slot1 then
			return SpritePathCfg.ItemLittleIcon.path
		else
			return SpritePathCfg.ItemIcon.path
		end
	end,
	getItemSprite = function (slot0, slot1, slot2)
		if ItemCfg[slot0] == nil then
			return
		end

		if slot3.type == ItemConst.ITEM_TYPE.STICKER then
			if getSpriteWithoutAtlas(uv0.getItemTexturePath(slot0, slot2) .. slot3.icon) then
				return slot5
			else
				return getSpriteWithoutAtlas(slot4 .. slot3.icon .. SettingData:GetCurrentLanguageKey())
			end
		else
			return getSpriteWithoutAtlas(slot4 .. slot3.icon)
		end
	end,
	GetItemSpriteAsync = function (slot0, slot1, slot2, slot3)
		if not (ItemCfg[slot0] or RechargeShopDescriptionCfg[slot0] or {
			sub_type = 3,
			icon = "30042"
		}).icon then
			slot4.icon = "30042"
		end

		slot5 = true

		if not slot2 then
			slot6 = uv0.getItemTexturePath(slot0, slot3)

			if slot4.type == ItemConst.ITEM_TYPE.STICKER then
				slot5 = false
			end

			slot2 = slot6 .. slot4.icon
		end

		if not slot5 then
			slot1(slot0, uv0.getItemSprite(slot0, nil, slot3))
		else
			getSpriteWithoutAtlasAsync(slot2, function (slot0)
				uv0(uv1, slot0)
			end)
		end
	end,
	getItemLittleSprite = function (slot0)
		return uv0.getItemSprite(slot0, nil, true)
	end,
	GetItemExpiredTimeByInfo = function (slot0)
		if slot0.timeValid ~= nil and slot0.timeValid > 0 then
			return slot0.timeValid
		end

		return uv0.GetItemExpiredTimeByID(slot0.id)
	end,
	GetItemExpiredTimeByID = function (slot0)
		if ItemCfg[slot0].time ~= nil and slot1.time ~= "" then
			if slot1.time[1] == 1 or slot2 == 5 then
				for slot6, slot7 in ipairs(slot1.time[2]) do
					slot8, slot9 = ActivityData:GetActivityTime(slot7)

					return slot9
				end
			elseif slot2 == 2 then
				return slot1.time[2][1]
			elseif slot2 == 3 then
				return _G.gameTimer:GetNextWeekFreshTime() + slot1.time[2][1] * 604800 + (slot1.time[2][2][1] - 1) * 24 * 3600 + (slot1.time[2][2][2] - 5) * 3600 + slot1.time[2][2][3] * 60
			elseif slot2 == 4 then
				return _G.gameTimer:GetNextDayFreshTime() + slot1.time[2][1] * 24 * 3600 + (slot1.time[2][2][1] - 5) * 3600 + slot1.time[2][2][2] * 60 + slot1.time[2][2][3]
			end
		end

		return 0
	end,
	IsItemExpired = function (slot0)
		if uv0.IsItemExpiredByItemId(slot0.id) then
			return true
		end

		if slot0.timeValid ~= nil and slot0.timeValid > 0 and slot0.timeValid < manager.time:GetServerTime() then
			return true
		end

		return false
	end,
	IsItemExpiredByItemId = function (slot0)
		if ItemCfg[slot0].type ~= ItemConst.ITEM_TYPE.MATERIAL then
			return false
		end

		if ItemCfg[slot0].time ~= nil and slot2.time ~= "" then
			if slot2.time[1] == 1 then
				return not ActivityData:GetActivityIsOpen(slot2.time[2][1])
			elseif slot3 == 2 then
				return slot2.time[2][1] < manager.time:GetServerTime()
			end
		end

		return false
	end,
	GetItemCountdownText = function (slot0)
		if slot0 <= manager.time:GetServerTime() then
			return GetTips("TIP_EXPIRED")
		else
			return manager.time:GetLostTimeStr2(slot0, nil, false)
		end
	end,
	RefreshLimitRed = function ()
		PlayerData:RefreshTagRed()
		PlayerData:RefreshCardBgRed()
	end,
	StopRefreshLimitRed = function ()
		PlayerData:StopTagRed()
		PlayerData:StopCardRed()
	end,
	GetItemIsOwned = function (slot0)
		if ItemCfg[slot0].type == ItemConst.ITEM_TYPE.SKIN_CHANGE then
			return uv0.getItemNum(slot0) > 0 or HeroTools.GetSkinIsUnlock(slot1.param[1])
		elseif slot2 == ItemConst.ITEM_TYPE.HERO_SKIN then
			if slot1.param[1] then
				return HeroTools.GetSkinIsUnlock(slot1.param[1])
			else
				return HeroTools.GetSkinIsUnlock(slot1.id)
			end
		elseif slot2 == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
			return uv0.getItemNum(slot0) > 0 or not ChatStickerData:IsLockSticker(slot1.param[1])
		elseif slot2 == ItemConst.ITEM_TYPE.STICKER_BG then
			return uv0.getItemNum(slot0) > 0 or PlayerData:GetStickerBg(slot0).unlock == 1
		elseif slot2 == ItemConst.ITEM_TYPE.TAG then
			return uv0.getItemNum(slot0) > 0 or PlayerData:GetTagInfo(slot0).unlock == 1
		elseif slot2 == ItemConst.ITEM_TYPE.CARD_BG then
			return uv0.getItemNum(slot0) > 0 or PlayerData:GetCardBg(slot0).unlock == 1
		elseif slot2 == ItemConst.ITEM_TYPE.CHAT_BUBBLE then
			return uv0.getItemNum(slot0) > 0 or table.keyof(PlayerData:GetUnlockChatBubbleIDList(), slot0)
		elseif slot2 == ItemConst.ITEM_TYPE.SCENE then
			return HomeSceneSettingData:GetUsedState(ItemCfg[slot0].param[1]) == SceneConst.HOME_SCENE_TYPE.UNLOCK
		end

		return false
	end,
	isCanUseItem = function (slot0)
		return (ItemCfg[slot0].use == 1 or slot1.use == 2) and MaterialConst.MATERIAL_TYPE.MYTHIC_REFRESH ~= slot1.sub_type
	end,
	GetItemSourceList = function (slot0)
		slot1 = {}
		slot2 = ItemCfg[slot0]
		slot3 = clone(slot2.source)

		if slot2.type == ItemConst.ITEM_TYPE.HERO_PIECE then
			for slot7, slot8 in ipairs(slot3) do
				if slot8[1] == ViewConst.SYSTEM_ID.DRAW then
					table.insert(slot1, slot8)
				elseif slot8[1] == ViewConst.SYSTEM_ID.LIMIT_DRAW or slot8[1] == ViewConst.SYSTEM_ID.LIMIT_MUST_DRAW then
					if HeroTools:CanBeDraw(slot8[2]) then
						table.insert(slot1, slot8)
					end
				elseif slot8[1] == ViewConst.SYSTEM_ID.NEWS_SHOP or slot8[1] == ViewConst.SYSTEM_ID.DREAM_SHOP then
					if HeroTools.GetHeroIsUnlock(slot2.id - 10000) then
						table.insert(slot1, slot8)
					end
				else
					table.insert(slot1, slot8)
				end
			end
		else
			for slot7, slot8 in ipairs(slot3) do
				if not slot8[2] then
					slot3[slot7][2] = slot0
				end
			end

			slot1 = slot3
		end

		slot4 = {}
		slot5 = {}

		for slot9 = #slot1, 1, -1 do
			if JumpTools.NeedHide(slot1[slot9], slot0) then
				table.remove(slot1, slot9)
			end

			if slot1[slot9] and slot1[slot9][1] == ViewConst.JUMP_SPECIAL_ID.HEROITEM_SPECIAL_SOURCE then
				table.remove(slot1, slot9)

				_, slot5 = SourceTool.GetJumpDataByHeroSpecialType(slot0)
			elseif slot1[slot9] and slot1[slot9][1] == ViewConst.JUMP_SPECIAL_ID.SERVANT_SPECIAL_SOURCE then
				table.remove(slot1, slot9)

				_, slot4 = SourceTool.GetJumpDataByServantSpecialType(slot0)
			elseif slot1[slot9] and slot1[slot9][1] == ViewConst.JUMP_SPECIAL_ID.EQUIP_SPECIAL_SOURCE then
				table.remove(slot1, slot9)

				if SourceTool.GetJumpDataByEquipSpecialType(slot1, slot0) and slot10[1] and not JumpTools.NeedHide(slot10, slot0) then
					table.insert(slot1, slot10)
				end
			end
		end

		for slot9, slot10 in pairs(slot4) do
			slot11 = true

			for slot15, slot16 in pairs(slot1) do
				if slot16[1] == slot10[1] then
					slot11 = false
				end
			end

			if slot11 then
				table.insert(slot1, slot10)
			end
		end

		for slot9, slot10 in pairs(slot5) do
			slot11 = true

			for slot15, slot16 in pairs(slot1) do
				if slot16[1] == slot10[1] then
					slot11 = false
				end
			end

			if slot11 then
				table.insert(slot1, slot10)
			end
		end

		return slot1
	end
}
