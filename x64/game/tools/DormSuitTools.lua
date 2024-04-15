slot0 = require("cjson")

function slot2(slot0, slot1)
	slot2 = DormFurnitureManager.GetInstance():Generate(slot1.id)

	DormLuaBridge.SetFurniturePosition(slot2, slot0, slot1.pos, slot1.rotation)
	DormLuaBridge.ChangeFurnitureState(slot2, DormFurnitureManager.FurnitureState.Placed)

	return slot2
end

return {
	DORM_SUIT_STATE = {
		CAN_USE = 1,
		NOT_GET = 4,
		UNABLE = 5,
		NEED_SHOP = 3,
		NEED_GIFT = 2
	},
	DORM_SUIT_TYPE = {
		FULL_SET = 1,
		CUSTOM_SET = 3,
		PART_SET = 2
	},
	SerializeDormSuitData = function (slot0, slot1, slot2)
		slot3, slot4 = uv0:FurSerializeDataFilter(slot1, slot2)

		if uv0:GetWriteHeadDormSuitSerializePath(slot2.suitType) then
			if io.open(slot7 .. slot2.name .. ".json", "w") then
				slot10:write(uv1.encode({
					furList = slot3,
					numList = slot4
				}))
				slot10:close()
				ShowTips("家具套装序列化成功")
			else
				ShowTips("家具套装序列化失败")
			end
		else
			ShowTips("未获取到对应类型的文件前缀，套装类型索引为" .. slot2.suitType)
		end
	end,
	FurSerializeDataFilter = function (slot0, slot1, slot2)
		slot3 = nil
		slot4 = {}

		if slot2.suitType == uv0.DORM_SUIT_TYPE.PART_SET then
			slot3 = {}

			for slot8, slot9 in ipairs(slot1) do
				if slot9.type == 5 then
					slot10 = {
						type = slot9.type,
						furniture_pos = {}
					}
					slot11 = {}

					for slot15, slot16 in ipairs(slot9.furniture_pos) do
						if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot16.furniture_id) and BackHomeFurniture[slot16.furniture_id].sub_type == 0 then
							table.insert(slot11, slot16)
						end
					end

					slot12 = uv0:GetFurSuitCenter(slot11)

					for slot16, slot17 in ipairs(slot11) do
						slot17.x = slot17.x - slot12.x
						slot17.y = slot17.y - slot12.y

						table.insert(slot10.furniture_pos, slot17)

						slot4[slot17.furniture_id] = slot4[slot17.furniture_id] or 0
						slot4[slot17.furniture_id] = slot4[slot17.furniture_id] + 1
					end

					table.insert(slot3, slot10)
				else
					table.insert(slot3, {
						type = slot9.type,
						furniture_pos = {}
					})
				end
			end
		else
			slot3 = slot1

			for slot8, slot9 in ipairs(slot1) do
				for slot13, slot14 in ipairs(slot9.furniture_pos) do
					slot4[slot14.furniture_id] = slot4[slot14.furniture_id] or 0
					slot4[slot14.furniture_id] = slot4[slot14.furniture_id] + 1
				end
			end
		end

		slot5 = {}

		for slot9, slot10 in pairs(slot4) do
			table.insert(slot5, {
				slot9,
				slot10
			})
		end

		return slot3, slot5
	end,
	GetFurSuitCenter = function (slot0, slot1)
		slot2, slot3, slot4, slot5 = nil

		for slot9, slot10 in ipairs(slot1) do
			slot12, slot13 = nil

			if slot10.rotation / 90 % 2 == 1 then
				slot12 = BackHomeFurniture[slot10.furniture_id].title[2] * DormConst.gridLen / 2
				slot13 = BackHomeFurniture[slot10.furniture_id].title[1] * DormConst.gridLen / 2
			else
				slot12 = BackHomeFurniture[slot10.furniture_id].title[1] * DormConst.gridLen / 2
				slot13 = BackHomeFurniture[slot10.furniture_id].title[2] * DormConst.gridLen / 2
			end

			slot2 = math.min(slot2 or slot10.x, slot10.x - slot12)
			slot3 = math.max(slot3 or slot10.x, slot10.x + slot12)
			slot4 = math.min(slot4 or slot10.y, slot10.y - slot13)
			slot5 = math.max(slot5 or slot10.y, slot10.y + slot13)
		end

		if slot2 and slot3 and slot4 and slot5 then
			slot7 = (slot4 + slot5) / 2

			if (slot3 + slot2) / 2 % 5 ~= 0 then
				slot6 = math.floor(slot6 / 5) * 5
			end

			if slot7 % 5 ~= 0 then
				slot7 = math.floor(slot7 / 5) * 5
			end

			return Vector2(slot6, slot7)
		else
			print("散件套装中心数据计算错误")
		end
	end,
	GetHeadDormSuitSerializePath = function (slot0, slot1)
		slot2 = nil

		if slot1 == uv0.DORM_SUIT_TYPE.FULL_SET then
			slot2 = "Dorm/SuitJson/FullSet/"
		elseif slot1 == uv0.DORM_SUIT_TYPE.PART_SET then
			slot2 = "Dorm/SuitJson/PartSet/"
		end

		return slot2
	end,
	GetWriteHeadDormSuitSerializePath = function (slot0, slot1)
		slot2 = nil

		if slot1 == uv0.DORM_SUIT_TYPE.FULL_SET then
			slot2 = "./Assets/ABResources/Dorm/SuitJson/FullSet/"
		elseif slot1 == uv0.DORM_SUIT_TYPE.PART_SET then
			slot2 = "./Assets/ABResources/Dorm/SuitJson/PartSet/"
		end

		return slot2
	end,
	GetDormDormSuitSerializePath = function (slot0, slot1)
		slot3 = nil

		if uv0:GetHeadDormSuitSerializePath(BackHomeSuitCfg[slot1].type) then
			slot3 = slot4 .. tostring(BackHomeSuitCfg[slot1].model)
		end

		return slot3
	end,
	GetDeSerializeDormSuitDataInScene = function (slot0, slot1)
		slot3 = {}
		slot4 = {}
		slot5 = BackHomeSuitCfg[slot1]

		if uv0:GetDeSerializeDormSuitData(slot1) and slot2.furList then
			for slot9, slot10 in ipairs(slot2.furList) do
				if slot10.type then
					DormFurnitureTools:AddFurnitureInfo(slot3, slot10.furniture_pos, DormConst.PROTOCOL_TILE_TYPE[slot10.type])
				end

				if slot10.type == 5 and BackHomeSuitCfg[slot1].type == uv0.DORM_SUIT_TYPE.FULL_SET then
					DormSpecialFurnitureTools:AddSpecialFurInfo(slot4, BackHomeSuitCfg[slot1].scene_id[1], slot10.furniture_pos, false)
				end
			end
		end

		slot6 = RoomInfo.New()
		slot6.furnitureInfoS = slot3

		return slot6.furnitureInfoS, slot4.specialFur
	end,
	GetDeSerializeDormSuitData = function (slot0, slot1)
		if BackHomeSuitCfg[slot1] then
			slot3 = nil

			if uv0:GetDormDormSuitSerializePath(slot1) .. ".json" then
				if AssetEx.LoadText(slot2) then
					slot3 = uv1.decode(slot4)
				else
					print("未获取到json数据")
				end
			end

			if slot3 and slot3.furList then
				for slot7, slot8 in ipairs(slot3.furList) do
					if slot8.type then
						for slot12, slot13 in ipairs(slot8.furniture_pos) do
							slot13.x = slot13.x
							slot13.y = slot13.y
							slot13.rotation = slot13.rotation
						end
					end
				end
			end

			return slot3
		end
	end,
	GetDeSerializeDormSuitDataInLuaData = function (slot0, slot1)
		for slot6, slot7 in ipairs(uv0:GetDeSerializeDormSuitData(slot1).furList) do
			if slot7.type then
				for slot11, slot12 in ipairs(slot7.furniture_pos) do
					slot12.x = slot12.x / DormConst.POS_PRECISION
					slot12.y = slot12.y / DormConst.POS_PRECISION
					slot12.rotation = slot12.rotation / DormConst.POS_PRECISION
				end
			end
		end

		return slot2
	end,
	GenerateSuitInfoList = function (slot0, slot1, slot2)
		if slot1 then
			for slot6, slot7 in pairs(slot1) do
				uv0:GenerateFurSuit(slot6, slot7.pos, slot2, slot7.furList)
			end
		end
	end,
	GenerateFullSetFurSuit = function (slot0, slot1)
		slot2 = DormSuitData:GetSuitFurInfo(slot1)

		DormFurnitureTools:GenFurListInCurRoom(slot2.furList)
		DormSpecialFurnitureTools:ChangeDormFloorOrWallData(slot2.specialFur)
	end,
	GenerateFurSuit = function (slot0, slot1, slot2, slot3, slot4)
		slot5, slot6 = DormSuitData:CheckIsSuit(slot1)

		if not slot4 and slot1 > 1000 then
			slot7 = DormSuitData:GetSuitFurInfo(slot1)
		end

		slot8 = {}

		if slot7 == nil then
			return
		end

		slot2 = slot2 or {
			rotation = 0,
			x = 0,
			y = 0
		}
		slot9, slot10 = nil

		if slot6 == uv0.DORM_SUIT_TYPE.PART_SET then
			slot9 = slot7.furList
			slot10 = slot7.tileType
		elseif slot6 == uv0.DORM_SUIT_TYPE.CUSTOM_SET then
			slot9 = slot7
			slot10 = DormConst.PROTOCOL_TILE_TYPE[5]
			slot1 = 0
		end

		for slot14 = 0, slot9.Length - 1 do
			table.insert(slot8, uv1(slot10, slot9[slot14]))
		end

		slot11 = DormLuaBridge.GenerateSuitPrefab(slot1, slot6 == uv0.DORM_SUIT_TYPE.PART_SET, slot10)

		for slot15, slot16 in pairs(slot8) do
			DormLuaBridge.SetFurInSuitChild(slot11, slot16)
		end

		DormLuaBridge.SetFurniturePosition(slot11, slot10, Vector2(slot2.x or 0, slot2.y or 0), 0)
		DormLuaBridge.RotateFurnitureSuit(slot11, slot2.rotation or 0)

		if slot3 then
			DormLuaBridge.SetFurnitureSuitOccupy(slot11, slot3)
		end

		DormLuaBridge.UpdateAllWallMountDitherAlphaControl()
		DormLuaBridge.UpdateAllFurnitureInteractAreaEnabled()

		return slot11
	end,
	DestoryFurSuitObject = function (slot0, slot1, slot2, slot3)
		slot5 = {}

		for slot9 = 0, DormLuaBridge.GetSuitFurEidList(slot1).Length - 1 do
			table.insert(slot5, slot4[slot9])
		end

		for slot9, slot10 in ipairs(slot5) do
			slot11 = DormUtils.GetEntityData(slot10)

			if slot2 then
				slot11.noOccupy = true
			end

			slot12 = slot11.cfgID

			if slot3 and slot12 then
				DormFurEditStateData:ReviseFurNumInEditRoom(slot12, -1)
			end

			DormFurnitureManager.GetInstance().FindAndRemove(slot10)
		end

		DormLuaBridge.RemoveFurniture(slot1, false)
	end,
	RelieveSuit = function (slot0, slot1)
		DormLuaBridge.DisassembleFurSuit(slot1)
		DormLuaBridge.ExitSuitEditMode(slot1)
		manager.notify:Invoke(DORM_EXIT_SUIT_EDIT_MODE, slot1)
		DormLuaBridge.RemoveFurniture(slot1, false)
	end,
	GetSuitHighDefinitionIcon = function (slot0, slot1)
		if BackHomeSuitCfg[slot1] and slot2.icon then
			return getSpriteViaConfig("DormSuitPreview", slot3)
		end
	end,
	GetFurSuitGoodListByShopID = function (slot0, slot1)
		slot3 = {}

		for slot7, slot8 in ipairs(getShopIDListByShopID(slot1)) do
			if DormSuitData:CheckIsConfigSuit(getShopCfg(slot8, slot1).give_id) then
				table.insert(slot3, slot8)
			end
		end

		return slot3
	end
}
