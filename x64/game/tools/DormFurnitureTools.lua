slot1 = nil
slot2 = nil

return {
	GenerateFurnitureWhenEnterScene = function (slot0)
		slot1 = DormData:GetCurrectSceneID()
		slot2 = DormitoryData:GetDormSceneData(slot1)

		DormSpecialFurnitureTools:ChangeDormFloorOrWallData(slot2.specialFur)
		DormFurnitureManager.GetInstance():ClearAndGenByFurList(DormitoryData:GetDormFurListByRoomID(slot1), false, slot2.suitInfo)
	end,
	DestoryRandomPruralFurByID = function (slot0, slot1, slot2, slot3)
		for slot8, slot9 in ipairs(DormFurnitureManager.GetInstance():GetAllFurniture()) do
			if DormUtils.GetEntityData(slot9).cfgID == slot1 then
				if slot3 then
					if DormLuaBridge.CheckFurnitureBelongSuit(slot1) then
						DormFurnitureManager.GetInstance().FindAndRemove(slot9)
						DormFurEditStateData:ReviseFurNumInEditRoom(slot0.itemID, -1)

						slot2 = slot2 - 1
					end
				else
					DormFurnitureManager.GetInstance().FindAndRemove(slot9)
					DormFurEditStateData:ReviseFurNumInEditRoom(slot0.itemID, -1)

					slot2 = slot2 - 1
				end

				if slot2 <= 0 then
					break
				end
			end
		end

		if slot2 <= 0 then
			return true
		end
	end,
	GenFurListInCurRoom = function (slot0, slot1, slot2)
		if slot1 then
			DormFurnitureManager.GetInstance():ClearAndGenByFurList(slot1, false, slot2)
		else
			print("家具信息不存在")
		end
	end,
	AddFurnitureInfo = function (slot0, slot1, slot2, slot3)
		if slot2 then
			for slot7, slot8 in ipairs(slot2) do
				while true do
					if DormSuitData:CheckIsSuit(slot8.furniture_id) then
						break
					end

					if not BackHomeFurniture[slot8.furniture_id] then
						print("未在家具表中配置，家具id为" .. slot8.furniture_id)

						return
					end

					if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot8.furniture_id) then
						slot9 = FurnitureInfo.New()
						slot9.id = slot8.furniture_id
						slot9.tileType = slot3
						slot9.pos = Vector2.New(slot8.x / DormConst.POS_PRECISION, slot8.y / DormConst.POS_PRECISION)
						slot9.rotation = slot8.rotation / DormConst.POS_PRECISION

						table.insert(slot1, slot9)
					end

					break
				end
			end
		end
	end,
	ResolverFurnitureInfo = function (slot0, slot1, slot2)
		slot3 = DormRoomTools:GetRoomSceneType(slot2)
		slot5 = {}

		for slot9, slot10 in ipairs(slot1) do
			if slot10.type < 100 then
				slot0:AddFurnitureInfo({}, slot10.furniture_pos, DormConst.PROTOCOL_TILE_TYPE[slot10.type])
			end

			if slot10.type == DormConst.PROTOCOL_TILE_TYPE_INDEX.FLOOR then
				slot5 = slot10.furniture_pos
			end
		end

		slot11 = slot3
		slot12 = slot5

		DormSpecialFurnitureTools:AddSpecialFurInfo({}, slot11, slot12, false)

		slot7 = {}

		for slot11, slot12 in ipairs(slot1) do
			if slot12.type < 100 then
				for slot16, slot17 in ipairs(slot12.furniture_pos) do
					if DormSuitData:CheckIsSuit(slot17.furniture_id) then
						slot7[slot17.furniture_id] = {
							pos = {
								x = slot17.x / DormConst.POS_PRECISION,
								y = slot17.y / DormConst.POS_PRECISION,
								rotation = slot17.rotation / DormConst.POS_PRECISION
							}
						}
					end
				end
			else
				slot7[slot12.type] = {}
				slot13 = {}

				DormFurnitureTools:AddFurnitureInfo(slot13, slot12.furniture_pos, DormConst.PROTOCOL_TILE_TYPE[5])

				slot14 = RoomInfo.New()
				slot14.furnitureInfoS = slot13
				slot7[slot12.type].furList = slot14.furnitureInfoS
				slot7[slot12.type].tileType = DormConst.PROTOCOL_TILE_TYPE_INDEX.FLOOR
			end
		end

		return slot4, slot6.specialFur, slot7
	end,
	CheckFurShowExtendLable = function (slot0, slot1)
		if BackHomeFurniture[slot1] and BackHomeFurniture[slot1].extend_info == 1 then
			return true
		end

		return false
	end,
	CheckFurCanUseRoom = function (slot0, slot1, slot2)
		slot4 = false

		for slot8, slot9 in ipairs(BackHomeFurniture[slot2].scene_id) do
			if slot9 == BackHomeCfg[slot1].type then
				slot4 = true

				break
			end
		end

		return slot4
	end,
	JudgeFurIsOri = function (slot0, slot1, slot2)
		for slot7, slot8 in ipairs(BackHomeCfg[slot1].default_item) do
			if slot2 == slot8[1] then
				return true
			end
		end

		return false
	end,
	GetCanUseFurListByRoomID = function (slot0, slot1)
		slot2 = {}
		slot3 = BackHomeCfg[slot1].type

		for slot8, slot9 in pairs(DormData:GetFurnitureInfoList()) do
			for slot14, slot15 in ipairs(BackHomeFurniture[slot8].scene_id) do
				if slot15 == slot3 then
					if slot15 == DormConst.BACKHOME_TYPE.PrivateDorm and BackHomeFurniture[slot8].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.SPECIFY then
						if DormitoryData:GetArchiveIDViaRoomID(slot1)[1] == BackHomeFurniture[slot8].hero_id then
							table.insert(slot2, slot8)
						end

						break
					end

					table.insert(slot2, slot8)

					break
				end
			end
		end

		return slot2
	end,
	GetRoomCanPlaceFurList = function (slot0, slot1)
		slot2 = {}

		if uv0:GetCanUseFurListByRoomID(slot1) then
			for slot7, slot8 in ipairs(slot3) do
				if DormFurEditStateData:GetCanUseFurNumInRoom(slot1, slot8) > 0 then
					table.insert(slot2, slot8)
				end
			end
		end

		return slot2
	end,
	GetRoomCanPlaceFurMaxNum = function (slot0, slot1, slot2)
		if not uv0:CheckFurCanUseRoom(slot1, slot2) then
			return 0
		end

		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
			if DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot2) then
				if BackHomeFurniture[slot2].is_give == 0 or BackHomeFurniture[slot2].is_give == 3 then
					if DormData:GetFurnitureInfoList()[slot2].num > 0 then
						slot3 = 1
					end
				elseif BackHomeFurniture[slot2].is_give == 1 and slot4[slot2].give_num > 0 then
					slot3 = 1
				end
			elseif BackHomeFurniture[slot2].is_give == 0 or BackHomeFurniture[slot2].is_give == 3 then
				slot3 = slot4[slot2].num
			elseif BackHomeFurniture[slot2].is_give == 1 then
				slot3 = slot4[slot2].give_num
			end
		elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			slot6 = DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(slot1)[1])

			if DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot2) then
				if BackHomeFurniture[slot2].is_give == 0 or BackHomeFurniture[slot2].is_give == 3 then
					if slot4[slot2].num > 0 then
						slot3 = 1
					end
				elseif BackHomeFurniture[slot2].is_give == 1 and slot6:GetGiftNum(slot2) > 0 then
					slot3 = 1
				end
			elseif BackHomeFurniture[slot2].is_give == 0 or BackHomeFurniture[slot2].is_give == 3 then
				slot3 = slot4[slot2].num
			elseif BackHomeFurniture[slot2].is_give == 1 then
				slot3 = slot6:GetGiftNum(slot2)
			end
		end

		return slot3
	end,
	GetHasPlaceFurNumInfoInMap = function (slot0, slot1)
		slot2 = 0
		slot3 = {}

		if DormData:GetDormSceneData(slot1).roomInfo then
			for slot9 = 0, slot4.roomInfo.furnitureInfoS.Length - 1 do
				slot2 = slot2 + 1

				if not slot3[slot5[slot9].id] then
					slot3[slot5[slot9].id] = 0
				end

				slot3[slot5[slot9].id] = slot3[slot5[slot9].id] + 1
			end
		end

		if slot4.suitInfo then
			for slot8, slot9 in pairs(slot4.suitInfo) do
				slot2 = slot8 < DormConst.DORM_VISIT_ROOM_MIN and slot2 + slot9.furList.Length or slot2 + DormSuitData:GetSuitNeedTotalFurNumList(slot8)
			end
		end

		return slot2, slot3
	end,
	CheckFurCanGiftInRoom = function (slot0, slot1, slot2)
		for slot7, slot8 in ipairs(DormitoryData:GetArchiveIDViaRoomID(slot1)) do
			if DormData:GetHeroInfo(slot8):GetCanGiftNum(slot2) > 0 then
				return true
			end
		end

		return false
	end,
	GetHadPlaceFlagFurInRoom = function (slot0, slot1)
		slot2 = {}

		if DormFurnitureTools:GetCanUseFurListByRoomID(slot1) then
			for slot7, slot8 in ipairs(slot3) do
				if DormFurnitureTools:GetRoomCanPlaceFurMaxNum(slot1, slot8) - DormFurEditStateData:GetCanUseFurNumInRoom(slot1, slot8) - DormRoomTools:GetHasPlaceFurInfoByRoom(slot1, slot8) - DormFurEditStateData:GetCacheFurNum(slot8) > 0 then
					table.insert(slot2, slot8)
				elseif slot9 - slot10 - slot11 - slot12 < 0 then
					print("被占用数量计算错误")
				end
			end
		end

		return slot2
	end,
	GetNotPresentedFurInRoom = function (slot0, slot1)
		slot2 = {}

		if DormFurnitureTools:GetCanUseFurListByRoomID(slot1) then
			for slot7, slot8 in ipairs(slot3) do
				if BackHomeFurniture[slot8].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
					slot9 = DormData:GetFurNumInfo(slot8)

					if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
						if slot9.give_num < slot9.num then
							table.insert(slot2, slot8)
						end
					elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
						if slot9.num - slot9.give_num > 0 and DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(slot1)[1]):GetGiftNum(slot8) < BackHomeFurniture[slot8].give_max then
							table.insert(slot2, slot8)
						end
					end
				end
			end
		end

		return slot2
	end,
	GetIsOverLoad = function (slot0, slot1)
		slot2 = DormitoryData:GetDormLevel(slot1)
		slot3 = nil

		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
			slot3 = GameSetting.dorm_lobby_furniture_limited.value[1]
		elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			slot3 = BackHomeDormLevel[slot2].furniture_max
		end

		if slot3 - DormRoomTools:GetFurHasPlaceTotalNum(slot1) - DormFurEditStateData:GetCacheFurTotalNum() - DormConst.DORM_SPECIAL_FURNITURE_NUM > 0 then
			return true
		end

		return false
	end,
	InitFurEditFlag = function (slot0)
		uv0 = getData("Dorm", "furEditFlag")

		if not uv0 or tostring(uv0) == "userdata: NULL" then
			uv0 = {
				otherHadPlaceFlag = true,
				hadPlaceFlag = true,
				canPlaceFlag = true,
				notPresentedFlag = true
			}
		end
	end,
	SaveFurEditFlag = function (slot0)
		if uv0 then
			saveData("Dorm", "furEditFlag", uv0)
		end
	end,
	GetFurEditFlag = function (slot0)
		return uv0
	end,
	SetEditFurFlag = function (slot0, slot1)
		uv0 = slot1
	end,
	GetEditFurFlag = function (slot0)
		return uv0
	end,
	CheckFurTileType = function (slot0, slot1, slot2)
		if BackHomeFurniture[slot1] then
			if slot3.display_type == 0 and slot2 == DormConst.TILE_TYPE.FLOOR then
				return true
			end

			if slot3.display_type == 2 and (slot2 == DormConst.TILE_TYPE.WALL_LEFT or slot2 == DormConst.TILE_TYPE.WALL_RIGHT or slot2 == DormConst.TILE_TYPE.WALL_BEHIND or slot2 == DormConst.TILE_TYPE.WALL_FRONT) then
				return true
			end

			return false
		end

		print("不存在编号为" .. slot1 .. "的家具")
	end
}
