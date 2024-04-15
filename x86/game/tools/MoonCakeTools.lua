return {
	InitConst = function ()
		uv0.materialItemIdList = {}
		uv0.fillingItemIdList = {}
		uv0.cakeItemIdList = {}
		uv0.giftItemIdList = {}
		uv0.cakeRecipeDic_ = {}
		uv0.cakeIdDicByCakeItemID_ = {}
		uv0.subActivityIdDic_ = {}
		uv0.mainActivityIdDic_ = {}
		uv0.tempVisitViewParams_ = {}
		uv0.tempDelegateViewParams_ = {}
		uv0.tempRecordViewParams_ = {}

		for slot4, slot5 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.MOON_CAKE]) do
			for slot12, slot13 in ipairs(ActivityCfg[slot5].sub_activity_list) do
				if ActivityTools.GetActivityType(slot13) == ActivityTemplateConst.MOON_CAKE_MAKE then
					-- Nothing
				elseif ActivityTools.GetActivityType(slot13) == ActivityTemplateConst.MOON_CAKE_PARTY then
					slot6.party_activity_id = slot13
				elseif ActivityTools.GetActivityType(slot13) == ActivityTemplateConst.MOONBO then
					slot6.moon_bo_activity_id = slot13
				end

				uv0.mainActivityIdDic_[slot13] = slot5
			end

			uv0.subActivityIdDic_[slot5] = {
				cake_activity_id = slot13
			}
		end

		slot2 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MOON_FILLING]
		slot3 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MOON_CAKE]
		slot4 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MOON_CAKE_GIFT]

		for slot8, slot9 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MOON_FILLING_MATERIAL]) do
			uv0.materialItemIdList[slot11] = uv0.materialItemIdList[ItemCfg[slot9].time[2][1]] or {}

			table.insert(uv0.materialItemIdList[slot11], slot9)
		end

		for slot8, slot9 in ipairs(slot2) do
			uv0.fillingItemIdList[slot11] = uv0.fillingItemIdList[ItemCfg[slot9].time[2][1]] or {}

			table.insert(uv0.fillingItemIdList[slot11], slot9)
		end

		for slot8, slot9 in ipairs(slot3) do
			uv0.cakeItemIdList[slot11] = uv0.cakeItemIdList[ItemCfg[slot9].time[2][1]] or {}

			table.insert(uv0.cakeItemIdList[slot11], slot9)
		end

		for slot8, slot9 in ipairs(slot4) do
			uv0.giftItemIdList[slot11] = uv0.giftItemIdList[ItemCfg[slot9].time[2][1]] or {}

			table.insert(uv0.giftItemIdList[slot11], slot9)
		end

		for slot8, slot9 in pairs(MoonCakeCfg.get_id_list_by_activity) do
			slot10 = {}

			for slot14, slot15 in ipairs(slot9) do
				slot10[slot16] = slot10[MoonCakeCfg[slot15].patties] or {}
				slot10[slot16][MoonCakeCfg[slot15].mold] = slot15
				uv0.cakeIdDicByCakeItemID_[MoonCakeCfg[slot15].moon_cakes] = slot15
			end

			uv0.cakeRecipeDic_[slot8] = slot10
		end
	end,
	GetMainActivityID = function (slot0)
		if not uv0.mainActivityIdDic_[slot0] then
			-- Nothing
		end

		return uv0.mainActivityIdDic_[slot0]
	end,
	GetCakeStageActivityID = function (slot0)
		if not uv0.subActivityIdDic_[slot0].cake_activity_id then
			-- Nothing
		end

		return uv0.subActivityIdDic_[slot0].cake_activity_id
	end,
	GetPartyStageActivityID = function (slot0)
		if not uv0.subActivityIdDic_[slot0].party_activity_id then
			-- Nothing
		end

		return uv0.subActivityIdDic_[slot0].party_activity_id
	end,
	GetMoonBoStageActivityID = function (slot0)
		if not uv0.subActivityIdDic_[slot0].moon_bo_activity_id then
			-- Nothing
		end

		return uv0.subActivityIdDic_[slot0].moon_bo_activity_id
	end,
	GetCakeRecipeDic = function (slot0)
		return uv0.cakeRecipeDic_[slot0]
	end,
	GetCakeIdDicByCakeItemID = function ()
		return uv0.cakeIdDicByCakeItemID_
	end,
	GetMaterialItemIdList = function (slot0)
		return uv0.materialItemIdList[slot0]
	end,
	GetFillingItemIdList = function (slot0)
		return uv0.fillingItemIdList[slot0]
	end,
	GetGiftItemIdList = function (slot0)
		return uv0.giftItemIdList[slot0]
	end,
	GetFillingMultiTimes = function (slot0)
		slot1 = 0
		slot2 = 0

		for slot8, slot9 in ipairs(MoonCakeFillingCfg[slot0].recipe) do
			-- Nothing
		end

		slot5 = #{
			[slot8] = ItemTools.getItemNum(slot9[1])
		}

		while true do
			for slot10 = 1, slot5 do
				if slot4[slot10] - slot3[slot10][2] < 0 then
					slot6 = false

					break
				else
					slot4[slot10] = slot4[slot10] - slot3[slot10][2]
				end
			end

			if slot6 then
				slot2 = slot2 + 1
			end
		end

		return slot2, slot2 > 0 and 1 or 0
	end,
	GetSortedFilling = function (slot0)
		slot1 = deepClone(MoonCakeFillingCfg.get_id_list_by_activity[slot0])
		slot2 = {}

		table.sort(slot1, function (slot0, slot1)
			if not uv0[slot0] then
				uv0[slot0] = uv1.GetFillingMultiTimes(slot0)
			end

			if not uv0[slot1] then
				uv0[slot1] = uv1.GetFillingMultiTimes(slot1)
			end

			if uv0[slot0] == uv0[slot1] then
				return slot0 < slot1
			else
				return uv0[slot1] < uv0[slot0]
			end
		end)

		return slot1
	end,
	CanVisitNext = function (slot0)
		if not MoonCakeData:GetTempVisitIndex(slot0) then
			return false
		end

		slot3 = slot1.index
		slot4 = {}

		if slot1.type == MoonCakeConst.VISIT_TYPE.ALL then
			slot4 = MoonCakeData:GetSortedRecommendPartyList(slot0)
		elseif slot2 == MoonCakeConst.VISIT_TYPE.FRIEND then
			slot4 = MoonCakeData:GetSortedFriendPartyList(slot0)
		end

		if #slot4 > 0 and slot3 + 1 > #slot4 then
			return false
		end

		return true
	end,
	GetSortedCakeGroupList = function (slot0)
		slot2 = MoonCakeData:GetUnlockCakeDic(slot0)
		slot4 = {}
		slot5 = {}
		slot6 = {}

		for slot10, slot11 in ipairs(MoonCakeGroupCfg.get_id_list_by_activity[slot0]) do
			if MoonCakeData:GetReceivedGroupDic(slot0)[slot11] then
				slot4[#slot4 + 1] = slot11
			else
				slot12 = true

				for slot18, slot19 in ipairs(MoonCakeGroupCfg[slot11].collect_condition) do
					if not slot2[slot19] then
						slot6[#slot6 + 1] = slot11
						slot12 = false

						break
					end
				end

				if slot12 then
					slot5[#slot5 + 1] = slot11
				end
			end
		end

		table.insertto(slot5, slot6)
		table.insertto(slot5, slot4)

		return slot5
	end,
	GetCakeItemIdList = function (slot0)
		return uv0.cakeItemIdList[slot0] or {}
	end,
	CheckPartyPlanValid = function (slot0, slot1)
		slot2 = 0
		slot3 = 0
		slot4 = false

		if slot1 == MoonCakeConst.PARTY_TYPE.CAKE then
			for slot10, slot11 in ipairs(uv0.cakeItemIdList[uv0.GetMainActivityID(slot0)]) do
				slot2 = slot2 + ItemTools.getItemNum(slot11)
			end

			slot4 = GameSetting.activity_mid_autumn_party_consume_1.value[1] <= slot2
		elseif slot1 == MoonCakeConst.PARTY_TYPE.VISIT then
			slot4 = GameSetting.activity_mid_autumn_party_consume_2.value[1] <= MoonCakeData:GetTodayVisitTimes(slot0)
		end

		return slot4, slot2, slot3
	end,
	SetTempVisitViewType = function (slot0, slot1)
		uv0.tempVisitViewParams_[slot0] = uv0.tempVisitViewParams_[slot0] or {}
		uv0.tempVisitViewParams_[slot0].type = slot1
	end,
	GetTempVisitViewType = function (slot0)
		return uv0.tempVisitViewParams_[slot0].type
	end,
	SetTempVisitViewScrollPos = function (slot0, slot1)
		uv0.tempVisitViewParams_[slot0] = uv0.tempVisitViewParams_[slot0] or {}
		uv0.tempVisitViewParams_[slot0].scrollPos = slot1
	end,
	GetTempVisitViewScrollPos = function (slot0)
		return uv0.tempVisitViewParams_[slot0].scrollPos
	end,
	SetTempDelegateViewPageIndex = function (slot0, slot1)
		uv0.tempDelegateViewParams_[slot0] = uv0.tempDelegateViewParams_[slot0] or {}
		uv0.tempDelegateViewParams_[slot0].pageIndex = slot1
	end,
	GetTempDelegateViewPageIndex = function (slot0)
		return uv0.tempDelegateViewParams_[slot0].pageIndex
	end,
	SetTempDelegateViewScrollPos = function (slot0, slot1)
		uv0.tempDelegateViewParams_[slot0] = uv0.tempDelegateViewParams_[slot0] or {}
		uv0.tempDelegateViewParams_[slot0].scrollPos = slot1
	end,
	GetTempDelegateViewScrollPos = function (slot0)
		return uv0.tempDelegateViewParams_[slot0].scrollPos
	end,
	SetTempRecordViewType = function (slot0, slot1)
		uv0.tempRecordViewParams_[slot0] = uv0.tempRecordViewParams_[slot0] or {}
		uv0.tempRecordViewParams_[slot0].type = slot1
	end,
	GetTempRecordViewType = function (slot0)
		return uv0.tempRecordViewParams_[slot0].type
	end,
	SetTempRecordViewScrollPos = function (slot0, slot1)
		uv0.tempRecordViewParams_[slot0] = uv0.tempRecordViewParams_[slot0] or {}
		uv0.tempRecordViewParams_[slot0].scrollPos = slot1
	end,
	GetTempRecordViewScrollPos = function (slot0)
		return uv0.tempRecordViewParams_[slot0].scrollPos
	end
}
