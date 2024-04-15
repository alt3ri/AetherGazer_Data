slot1 = nil

function slot2(slot0)
	if BackHomeFurniture[slot0].is_occupy and slot1.is_occupy == 1 then
		if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot0) then
			if slot1.display_type == 0 then
				return slot1.title[1] * slot1.title[2]
			elseif slot2 == 2 then
				return slot1.title[1] * slot1.title[3]
			end
		end
	else
		return 0
	end
end

return {
	InitDormHasPlaceFurInfo = function (slot0, slot1)
		uv0 = {}
	end,
	InitNewSingleRoomData = function (slot0, slot1, slot2, slot3)
		slot4 = {
			exp = 0,
			pos_id = slot1.pos_id,
			archiveIDList = {},
			give_furnitures = {},
			likeNum = slot1.liked_num or 0
		}

		if slot1.archives_id then
			for slot8, slot9 in ipairs(slot1.archives_id) do
				table.insert(slot4.archiveIDList, slot9)
			end
		end

		if BackHomeCfg[slot1.id].type == DormConst.BACKHOME_TYPE.PrivateDorm and #slot4.archiveIDList > 0 then
			DormData:GetHeroInfo(slot4.archiveIDList[1]):InitHeroRoomID(slot1.id)
		end

		slot4.roomInfo = RoomInfo.New()
		slot4.roomInfo.id = slot1.id
		slot4.roomInfo.sceneName = BackHomeCfg[slot1.id].scene
		slot6 = {}
		slot7 = {}
		slot8 = {}

		DormSpecialFurnitureTools:AddSpecialFurInfo(slot6, DormRoomTools:GetRoomSceneType(slot1.id), {}, true)

		slot6 = slot6.specialFur

		if not slot3 and slot1.layout then
			if slot1.layout.temp_id == 0 then
				slot8, slot6, slot7 = DormFurnitureTools:ResolverFurnitureInfo(slot1.layout.furniture_pos_list, slot1.id)
			elseif DormFurnitureTemplateData:GetDormTemplateInfo(slot1.layout.temp_id) then
				slot8 = slot10.furnitureInfoS
				slot6 = slot10.specialFur
			end
		end

		slot4.roomInfo.furnitureInfoS = slot8
		slot4.suitInfo = slot7
		slot4.specialFur = slot6
		slot4.give_furnitures = {}

		if slot1.give_furnitures then
			for slot13, slot14 in ipairs(slot1.give_furnitures) do
				if BackHomeFurniture[slot14.id].is_give == 1 then
					slot4.give_furnitures[slot14.id] = slot14.num
				end
			end
		end

		slot2[slot1.id] = slot4

		DormRoomTools:RefreshSingleRoomPlaceFurNum(slot1.id)
	end,
	GetDormFurOccupy = function (slot0, slot1)
		slot2 = DormFurEditStateData:GetCacheFurNumInfo()
		slot3 = 0

		if slot1 == DormData:GetCurrectSceneID() and slot2 then
			for slot7, slot8 in pairs(slot2) do
				slot3 = slot3 + uv0(slot7) * slot8
			end
		end

		if uv1[slot1] then
			for slot7, slot8 in pairs(uv1[slot1]) do
				slot3 = slot3 + uv0(slot7) * slot8
			end
		end

		return slot3
	end,
	GetUnlockRoomNum = function (slot0)
		slot1 = 0

		if DormitoryData:GetDormMapList() then
			for slot6, slot7 in pairs(slot2) do
				if BackHomeCfg[slot6].type == DormConst.BACKHOME_TYPE.PrivateDorm then
					slot1 = slot1 + 1
				end
			end
		end

		return slot1
	end,
	GetCanGiftNumByRoomIDAndFurID = function (slot0, slot1, slot2)
		slot4 = DormData:GetFurNumInfo(slot2)
		slot5 = 0

		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			slot5 = DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(slot1)[1]):GetCanGiftNum(slot2)
		elseif slot3 == DormConst.BACKHOME_TYPE.PublicDorm then
			slot5 = math.min(slot4.num, DormRoomTools:GetUnlockRoomNum() * BackHomeFurniture[slot2].give_max) - slot4.give_num
		end

		return slot5
	end,
	RefreshDormExp = function (slot0, slot1, slot2, slot3)
		slot4 = 0

		if DormitoryData:GetDormMapList()[slot1].give_furnitures then
			slot6 = slot5[slot1].give_furnitures

			if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
				for slot10, slot11 in pairs(slot6) do
					if BackHomeFurniture[slot10] then
						slot4 = BackHomeFurniture[slot10].dorm_exp * slot11 + slot4
					end
				end
			end

			for slot12, slot13 in pairs(DormData:GetFurnitureInfoList()) do
				if BackHomeFurniture[slot12].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.SPECIFY and slot5[slot1].archiveIDList[1] == BackHomeFurniture[slot12].hero_id then
					slot4 = slot4 + slot13.num * BackHomeFurniture[slot12].dorm_exp
				end
			end
		elseif slot2 and BackHomeFurniture[slot2].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.SPECIFY then
			-- Nothing
		end

		slot5[slot1].exp = slot4
	end,
	GetHasPlaceFurInfoByRoom = function (slot0, slot1, slot2)
		if uv0[slot1] then
			return uv0[slot1][slot2] or 0
		end

		return 0
	end,
	CheckRoomPosSameLevel = function (slot0, slot1, slot2)
		slot4 = slot2 - (DormConst.DORM_POS_ID_OFFSET + 1)

		if slot1 - (DormConst.DORM_POS_ID_OFFSET + 1) < DormConst.DORM_FIRST_FLOOR_ROOM_NUM and slot4 < DormConst.DORM_FIRST_FLOOR_ROOM_NUM then
			return true
		end

		if DormConst.DORM_FIRST_FLOOR_ROOM_NUM <= slot3 and DormConst.DORM_FIRST_FLOOR_ROOM_NUM <= slot4 and math.floor((slot1 - (DormConst.DORM_POS_ID_OFFSET + 1 + DormConst.DORM_FIRST_FLOOR_ROOM_NUM)) / DormConst.DORM_FLOOR_ROOM_NUM) == math.floor((slot2 - (DormConst.DORM_POS_ID_OFFSET + 1 + DormConst.DORM_FIRST_FLOOR_ROOM_NUM)) / DormConst.DORM_FLOOR_ROOM_NUM) then
			return true
		end
	end,
	GetFurHasPlaceTotalNum = function (slot0, slot1)
		slot2 = 0

		if uv0[slot1] then
			for slot7, slot8 in pairs(slot3) do
				if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot7) then
					slot2 = slot2 + slot8
				end
			end
		else
			print("未获取到已摆放家具数量信息")
		end

		return slot2
	end,
	GetDormIDViaArchive = function (slot0, slot1)
		if slot1 and DormData:GetHeroInfo(slot1) then
			return slot2:GetRoomID()
		end
	end,
	GetGiftNumByRoomID = function (slot0, slot1)
		slot2 = 0

		if slot1 and DormitoryData:GetDormSceneData(slot1) and slot3.give_furnitures then
			for slot7, slot8 in pairs(slot3.give_furnitures) do
				slot2 = slot2 + slot8
			end
		end

		return slot2
	end,
	GetCanGiftFurMaxNum = function (slot0, slot1, slot2)
		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			return BackHomeFurniture[slot2].give_max - DormData:GetHeroInfo(DormData:GetDormSceneData(slot1).archiveIDList[1]):GetGiftNum(slot2)
		elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
			return 10000
		end
	end,
	GetDormLevelAward = function (slot0, slot1, slot2, slot3)
		slot4 = {}

		for slot8 = slot2 + 1, slot3 do
			for slot15, slot16 in ipairs(BackHomeHeroCfg[DormData:GetHeroInfo(slot1):GetCanUseHeroList()[1]].level_reward[slot8]) do
				if BackHomeDormLevelRewardCfg[slot16].type == 3 then
					table.insert(slot4, slot17.reward)
				end
			end
		end

		getReward(mergeReward(formatRewardCfgList(slot4)))
	end,
	GetPrivateDormRoomState = function (slot0, slot1)
		slot2 = DormitoryData:GetDormMapList()

		if not slot1 then
			return DormEnum.DormRoomUseState.Lock
		end

		if BackHomeCfg[slot1].type ~= DormConst.BACKHOME_TYPE.PrivateDorm then
			return
		end

		if #slot2[slot1].archiveIDList > 0 then
			return DormEnum.DormRoomUseState.HadPlace
		else
			return DormEnum.DormRoomUseState.Unlock
		end
	end,
	Dispose = function (slot0)
		uv0 = nil
	end,
	GetRoomSceneType = function (slot0, slot1)
		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
			slot2 = DormConst.BACKHOME_TYPE.PublicDorm
		end

		if slot2 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
			slot2 = DormConst.BACKHOME_TYPE.PrivateDorm
		end

		return slot2
	end,
	RefreshSingleRoomPlaceFurNum = function (slot0, slot1)
		slot2 = DormitoryData:GetDormMapList()

		if not uv0 then
			uv0 = {}
		end

		uv0[slot1] = {}
		slot3 = {}

		for slot8 = 0, slot2[slot1].roomInfo.furnitureInfoS.Length - 1 do
			if not slot3[slot4[slot8].id] then
				slot3[slot9] = 0
			end

			slot3[slot9] = slot3[slot9] + 1
		end

		for slot9, slot10 in pairs(slot2[slot1].specialFur) do
			slot3[slot10] = 1
		end

		for slot9, slot10 in pairs(slot2[slot1].suitInfo) do
			if slot9 < DormConst.DORM_VISIT_ROOM_MIN then
				for slot14 = 0, slot10.furList.Length - 1 do
					slot3[slot15] = slot3[slot10.furList[slot14].id] or 0
					slot3[slot15] = slot3[slot15] + 1
				end
			else
				for slot15, slot16 in ipairs(DormSuitData:GetNeedUseFurNumInfoBySuitID(slot9)) do
					slot3[slot16[1]] = slot3[slot16[1]] or 0
					slot3[slot16[1]] = slot3[slot16[1]] + slot16[2]
				end
			end
		end

		uv0[slot1] = slot3
	end
}
