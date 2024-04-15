return {
	ChangeDormSpeicalFur = function (slot0, slot1)
		slot3 = DormRoomTools:GetRoomSceneType(DormData:GetCurrectSceneID())
		slot4 = BackHomeFurniture[slot1]

		if BackHomeFurniture[slot1].type == DormConst.FLOOR_TYPE_NUM then
			slot5 = nil

			if slot4.replace and #slot4.replace > 0 then
				for slot9 = 1, #slot4.scene_id do
					if slot3 == slot4.scene_id[slot9] then
						slot5 = slot4.replace[slot9]

						break
					end
				end
			else
				slot5 = BackHomeFurniture[slot1].model
			end

			if slot5 then
				DormLuaBridge.SetRoomThemeFloor(slot5, BackHomeFurniture[slot1].extend)
			end
		elseif BackHomeFurniture[slot1].type == DormConst.WALL_TYPE_NUM then
			DormLuaBridge.SetRoomThemeWall(BackHomeFurniture[slot1].material, BackHomeFurniture[slot1].mesh)
		elseif BackHomeFurniture[slot1].type == DormConst.BACK_GROUND_TYPE then
			DormLuaBridge.SetRoomThemeBG(BackHomeFurniture[slot1].extend, BackHomeFurniture[slot1].material)
		end
	end,
	ChangeDormFloorOrWallData = function (slot0, slot1)
		if slot1.wallID then
			slot0:ChangeDormSpeicalFur(slot1.wallID)
		end

		if slot1.floorID then
			slot0:ChangeDormSpeicalFur(slot1.floorID)
		end

		if slot1.backGroundID then
			slot0:ChangeDormSpeicalFur(slot1.backGroundID)
		end
	end,
	AddSpecialFurInfo = function (slot0, slot1, slot2, slot3, slot4)
		slot1.specialFur = {}

		if slot4 then
			slot1.specialFur.floorID = uv0:GetOriFloorOrWall(slot2, DormConst.FLOOR_TYPE_NUM)
			slot1.specialFur.wallID = uv0:GetOriFloorOrWall(slot2, DormConst.WALL_TYPE_NUM)
			slot1.specialFur.backGroundID = uv0:GetOriFloorOrWall(slot2, DormConst.BACK_GROUND_TYPE)
		else
			if slot3 then
				for slot8, slot9 in ipairs(slot3) do
					if BackHomeFurniture[slot9.furniture_id] then
						if BackHomeFurniture[slot9.furniture_id].type == DormConst.FLOOR_TYPE_NUM then
							slot1.specialFur.floorID = slot9.furniture_id
						elseif BackHomeFurniture[slot9.furniture_id].type == DormConst.WALL_TYPE_NUM then
							slot1.specialFur.wallID = slot9.furniture_id
						elseif BackHomeFurniture[slot9.furniture_id].type == DormConst.BACK_GROUND_TYPE then
							slot1.specialFur.backGroundID = slot9.furniture_id
						end
					end
				end
			end

			if not slot1.specialFur.floorID then
				slot1.specialFur.floorID = uv0:GetOriFloorOrWall(slot2, DormConst.FLOOR_TYPE_NUM)
			end

			if not slot1.specialFur.wallID then
				slot1.specialFur.wallID = uv0:GetOriFloorOrWall(slot2, DormConst.WALL_TYPE_NUM)
			end

			if not slot1.specialFur.backGroundID then
				slot1.specialFur.backGroundID = uv0:GetOriFloorOrWall(slot2, DormConst.BACK_GROUND_TYPE)
			end
		end
	end,
	JudgeFurIsSpecialType = function (slot0, slot1)
		if BackHomeFurniture[slot1] then
			if BackHomeFurniture[slot1].type == DormConst.FLOOR_TYPE_NUM or BackHomeFurniture[slot1].type == DormConst.WALL_TYPE_NUM or BackHomeFurniture[slot1].type == DormConst.BACK_GROUND_TYPE then
				return true
			else
				return false
			end
		end
	end,
	JudgeIsOriSpecialFur = function (slot0, slot1)
		if DormConst.LOBBY_ORI_FLOOR_ID == slot1 or DormConst.LOBBY_ORI_WALL_ID == slot1 or DormConst.LOBBY_ORI_BACKHGROUND_ID == slot1 or DormConst.FLOOR_ORI_ID == slot1 or DormConst.WALL_ORI_ID == slot1 or DormConst.BACK_GROUND_ORI_ID == slot1 then
			return true
		end

		return false
	end,
	GetOriFloorOrWall = function (slot0, slot1, slot2)
		if slot1 == DormConst.BACKHOME_TYPE.PublicDorm then
			if slot2 == DormConst.FLOOR_TYPE_NUM then
				return DormConst.LOBBY_ORI_FLOOR_ID
			elseif slot2 == DormConst.WALL_TYPE_NUM then
				return DormConst.LOBBY_ORI_WALL_ID
			elseif slot2 == DormConst.BACK_GROUND_TYPE then
				return DormConst.LOBBY_ORI_BACKHGROUND_ID
			end
		elseif slot1 == DormConst.BACKHOME_TYPE.PrivateDorm then
			if slot2 == DormConst.FLOOR_TYPE_NUM then
				return DormConst.FLOOR_ORI_ID
			elseif slot2 == DormConst.WALL_TYPE_NUM then
				return DormConst.WALL_ORI_ID
			elseif slot2 == DormConst.BACK_GROUND_TYPE then
				return DormConst.BACK_GROUND_ORI_ID
			end
		end
	end,
	GetSpecialFurIDByRoom = function (slot0, slot1, slot2)
		if DormitoryData:GetDormMapList()[slot1] then
			if slot2 == DormConst.FLOOR_TYPE_NUM then
				return slot3[slot1].specialFur.floorID
			elseif slot2 == DormConst.WALL_TYPE_NUM then
				return slot3[slot1].specialFur.wallID
			elseif slot2 == DormConst.BACK_GROUND_TYPE then
				return slot3[slot1].specialFur.backGroundID
			end
		end
	end
}
