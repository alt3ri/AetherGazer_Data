slot0 = singletonClass("DormFurEditStateData")
slot1, slot2, slot3, slot4 = nil

function slot0.EnterEditState(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
end

function slot0.ExitEditState(slot0)
	uv0 = nil
	uv1 = nil
	uv2 = nil
	uv3 = nil

	DormFurnitureManager.GetInstance():RefreshAllFurnitureConnection()
end

function slot0.GetHadPlaceFurInfoList(slot0)
	slot1 = DormLuaBridge.GetPlacedFurnitureInfo()
	slot2 = DormFurEditStateData:GetCurPlaceSpecialFurInfo()

	for slot8 = 0, DormLuaBridge.GetAllPlaceFurSuitInfo().Length - 1 do
		if slot3[slot8].id > 1000 then
			-- Nothing
		else
			slot4[slot3[slot8].id] = {
				oriSuitID = slot3[slot8].oriSuitID,
				furList = DormLuaBridge.GetCustomSuitFurInfo(slot3[slot8].id)
			}
			slot10 = DormConst.TILE_TYPE.FLOOR

			if slot4[slot3[slot8].id].furList[0] then
				slot10 = slot4[slot3[slot8].id].furList[1].tileType
			end

			slot4[slot3[slot8].id].tileType = slot10
		end
	end

	return slot1, slot2, {
		[slot3[slot8].id] = {
			pos = {
				x = slot3[slot8].pos.x,
				y = slot3[slot8].pos.y,
				rotation = slot3[slot8].rotation
			}
		}
	}
end

function slot0.GetHadPlaceFurNumInRoom(slot0, slot1)
	slot2 = {}

	if DormFurnitureTools:GetCanUseFurListByRoomID(slot1) then
		for slot7, slot8 in ipairs(slot3) do
			if DormRoomTools:GetHasPlaceFurInfoByRoom(slot1, slot8) + slot0:GetCacheFurNum(slot8) > 0 then
				table.insert(slot2, slot8)
			end
		end
	end

	return slot2
end

function slot0.GetCanUseFurNumInRoom(slot0, slot1, slot2)
	if not DormFurnitureTools:CheckFurCanUseRoom(slot1, slot2) then
		return 0
	else
		slot5 = DormData:GetFurNumInfo(slot2)

		if BackHomeFurniture[slot2].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT then
			if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot2) then
				return slot5.num - slot5.hasPlaceNum - slot0:GetCacheFurNum(slot2)
			else
				if DormRoomTools:GetHasPlaceFurInfoByRoom(slot1, slot2) + slot4 >= 1 then
					return 0
				end

				if slot5.num - slot5.hasPlaceNum - slot4 > 0 then
					return 1
				else
					return 0
				end
			end
		elseif slot6 == DormConst.BACKHOME_FUR_GIVE_TYPE.SPECIFY then
			if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
				return slot5.num - slot5.hasPlaceNum - slot4
			elseif slot7 == DormConst.BACKHOME_TYPE.PrivateDorm and DormitoryData:GetArchiveIDViaRoomID(slot1)[1] == BackHomeFurniture[slot2].hero_id then
				return slot5.num - slot5.hasPlaceNum - slot4
			end

			return 0
		elseif slot6 == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
			if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
				if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot2) then
					return slot5.give_num - slot5.hasPlaceNum - slot4
				else
					if DormRoomTools:GetHasPlaceFurInfoByRoom(slot1, slot2) + slot4 >= 1 then
						return 0
					end

					if slot5.give_num - slot5.hasPlaceNum - slot4 > 0 then
						return 1
					else
						return 0
					end
				end
			elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm and DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(slot1)[1]) then
				slot12 = slot5.give_num - slot5.hasPlaceNum - slot4

				if slot8:GetGiftNum(slot2) - DormRoomTools:GetHasPlaceFurInfoByRoom(slot1, slot2) - slot4 < 0 then
					print("可摆放家具计算错误")

					return 0
				end

				return math.min(slot12, slot11)
			end
		end

		print("未找到的类型")

		return 0
	end
end

function slot0.GetCacheFurTotalNum(slot0)
	slot1 = 0

	if uv0 then
		for slot5, slot6 in pairs(uv0) do
			if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot5) then
				slot1 = slot1 + slot6
			end
		end
	end

	return slot1
end

function slot0.GetCacheFurNumInfo(slot0)
	if uv0 then
		return uv0
	end
end

function slot0.SetCacheFurNumInfo(slot0, slot1)
	uv0 = slot1
end

function slot0.GetCacheFurNum(slot0, slot1)
	if uv0 then
		return uv0[slot1] or 0
	end

	return 0
end

function slot0.GetCacheWallAndFloorInfo(slot0, slot1)
	if uv0 then
		if slot1 == DormConst.FLOOR_TYPE_NUM then
			return uv0.floorID
		elseif slot1 == DormConst.WALL_TYPE_NUM then
			return uv0.wallID
		elseif slot1 == DormConst.BACK_GROUND_TYPE then
			return uv0.backGroundID
		end
	end
end

function slot0.SyncRoomFurniture(slot0, slot1, slot2, slot3, slot4)
	if not DormitoryData:GetDormMapList()[slot1.architecture_id] then
		print("没有场景数据,场景id为" .. slot6)

		return
	end

	if not slot5[slot6].roomInfo then
		return
	end

	slot5[slot6].roomInfo.furnitureInfoS = slot2

	if not slot3 then
		for slot10, slot11 in ipairs(slot1.furniture_layout.furniture_pos_list) do
			if DormConst.PROTOCOL_TILE_TYPE[slot11.type] == DormConst.TILE_TYPE.FLOOR then
				slot0:SyncRoomSpecialFur(slot11.furniture_pos)

				break
			end
		end
	else
		slot0:SyncRoomSpecialFur(slot3)
	end

	slot5[slot6].suitInfo = slot4 or {}

	DormRoomTools:RefreshSingleRoomPlaceFurNum(slot6)
	DormData:UpdateAllPlaceFurNumList()
end

function slot0.GetCurPlaceSpecialFurInfo(slot0)
	slot1 = DormData:GetCurrectSceneID()
	slot3 = DormitoryData:GetDormMapList()

	if uv0 and uv0.floorID then
		-- Nothing
	else
		slot2.floorID = slot3[slot1].specialFur.floorID
	end

	if uv0 and uv0.wallID then
		slot2.wallID = uv0.wallID
	else
		slot2.wallID = slot3[slot1].specialFur.wallID
	end

	if uv0 and uv0.backGroundID then
		slot2.backGroundID = uv0.backGroundID
	else
		slot2.backGroundID = slot3[slot1].specialFur.backGroundID
	end

	return {
		floorID = uv0.floorID
	}
end

function slot0.SyncRoomSpecialFur(slot0, slot1)
	if DormitoryData:GetDormMapList()[DormData:GetCurrectSceneID()] then
		for slot7, slot8 in ipairs(slot1) do
			if DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot8.furniture_id) then
				if BackHomeFurniture[slot9].type == DormConst.FLOOR_TYPE_NUM then
					slot3[slot2].specialFur.floorID = slot9
				elseif BackHomeFurniture[slot9].type == DormConst.WALL_TYPE_NUM then
					slot3[slot2].specialFur.wallID = slot9
				elseif BackHomeFurniture[slot9].type == DormConst.BACK_GROUND_TYPE then
					slot3[slot2].specialFur.backGroundID = slot9
				end
			end
		end
	end
end

function slot0.ReviseFurNumInEditRoom(slot0, slot1, slot2)
	if not uv0 then
		uv0 = {}
	end

	if not uv0[slot1] then
		uv0[slot1] = 0
	end

	uv0[slot1] = uv0[slot1] + slot2

	if DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot1) and slot2 > 0 then
		if BackHomeFurniture[slot1].type == DormConst.FLOOR_TYPE_NUM then
			-- Nothing
		elseif BackHomeFurniture[slot1].type == DormConst.WALL_TYPE_NUM then
			slot3.wallID = slot1
		elseif BackHomeFurniture[slot1].type == DormConst.BACK_GROUND_TYPE then
			slot3.backGroundID = slot1
		end

		slot0:CacheWallAndFloorInfo({
			floorID = slot1
		})
	end
end

function slot0.ClearFurNumInEditRoom(slot0)
	uv0 = nil
end

function slot0.RestoreRoomAllFurniture(slot0, slot1)
	slot2 = uv0
	uv0 = {}

	for slot9 = 0, DormitoryData:GetDormMapList()[DormData:GetCurrectSceneID()].roomInfo.furnitureInfoS.Length - 1 do
		if not uv0[slot5[slot9].id] then
			uv0[slot10.id] = 0
		end

		uv0[slot10.id] = uv0[slot10.id] - 1
	end

	slot0:RestoreSpecialFur(slot1)
	slot0:RestoreFurSuitCacheInfo()

	return slot2
end

function slot0.RestoreSpecialFur(slot0, slot1)
	uv0 = nil
	slot2 = DormData:GetCurrectSceneID()
	slot3 = BackHomeCfg[slot2].type
	slot8 = DormitoryData:GetDormSceneData(slot2).specialFur

	if not slot1 then
		DormSpecialFurnitureTools:ChangeDormFloorOrWallData({
			wallID = DormSpecialFurnitureTools:GetOriFloorOrWall(slot3, DormConst.WALL_TYPE_NUM),
			floorID = DormSpecialFurnitureTools:GetOriFloorOrWall(slot3, DormConst.FLOOR_TYPE_NUM),
			backGroundID = DormSpecialFurnitureTools:GetOriFloorOrWall(slot3, DormConst.BACK_GROUND_TYPE)
		})
	end

	if slot4 ~= slot8.wallID then
		slot0:ReviseFurNumInEditRoom(slot8.wallID, -1)
		slot0:ReviseFurNumInEditRoom(slot4, 1)
	end

	if slot5 ~= slot8.floorID then
		slot0:ReviseFurNumInEditRoom(slot8.floorID, -1)
		slot0:ReviseFurNumInEditRoom(slot5, 1)
	end

	if slot6 ~= slot8.backGroundID then
		slot0:ReviseFurNumInEditRoom(slot8.backGroundID, -1)
		slot0:ReviseFurNumInEditRoom(slot6, 1)
	end
end

function slot0.CacheWallAndFloorInfo(slot0, slot1)
	if not uv0 then
		uv0 = {}
	end

	if slot1.floorID then
		uv0.floorID = slot1.floorID
	end

	if slot1.wallID then
		uv0.wallID = slot1.wallID
	end

	if slot1.backGroundID then
		uv0.backGroundID = slot1.backGroundID
	end
end

function slot0.ReveseFurSuitNumInEidtRoom(slot0, slot1, slot2)
	if slot1 > 1000 then
		if not uv0 then
			uv0 = {}
		end

		uv0[slot1] = uv0[slot1] or 0
		uv0[slot1] = uv0[slot1] + slot2

		if BackHomeSuitCfg[slot1] then
			for slot8, slot9 in ipairs(slot3.suit_num) do
				uv1:ReviseFurNumInEditRoom(slot9[1], slot9[2] * slot2)
			end
		end
	end
end

function slot0.RestoreFurSuitCacheInfo(slot0)
	uv0 = {}

	if DormitoryData:GetDormMapList()[DormData:GetCurrectSceneID()].suitInfo then
		for slot7, slot8 in pairs(slot3) do
			slot9, slot10 = DormSuitData:CheckIsSuit(slot7)

			if slot10 == DormSuitTools.DORM_SUIT_TYPE.CUSTOM_SET then
				for slot14 = 0, slot8.furList.Length - 1 do
					uv1[slot15] = uv1[slot8.furList[slot14].id] or 0
					uv1[slot15] = uv1[slot15] - 1
				end
			else
				for slot15, slot16 in ipairs(BackHomeSuitCfg[slot7].suit_num) do
					uv1[slot16[1]] = uv1[slot16[1]] or 0
					uv1[slot16[1]] = uv1[slot16[1]] - slot16[2]
				end
			end
		end
	end
end

function slot0.GetRealSpecialFurInfo(slot0)
	slot3 = DormitoryData:GetDormSceneData(DormData:GetCurrectSceneID()).specialFur

	return {
		floorID = uv0.floorID or slot3.floorID,
		wallID = uv0.wallID or slot3.wallID,
		backGroundID = uv0.backGroundID or slot3.backGroundID
	}
end

return slot0
