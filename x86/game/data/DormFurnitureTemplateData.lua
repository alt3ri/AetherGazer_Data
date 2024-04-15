slot0 = singletonClass("DormFurnitureTemplateData")
slot1, slot2 = nil

function slot0.InitTemplateSimpleDorm(slot0, slot1)
	uv0:SetOtherCanSave(slot1.share_is_open or true)
end

function slot0.InitDormFurnitureTemplate(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.template) do
		slot7 = {
			id = slot6.id,
			type = slot6.type,
			name = slot6.name,
			pos = slot6.pos
		}
		slot8 = {}

		if slot6.furniture_pos_list then
			for slot12, slot13 in ipairs(slot6.furniture_pos_list) do
				if slot13.type and slot13.type < 100 then
					DormFurnitureTools:AddFurnitureInfo(slot8, slot13.furniture_pos, DormConst.PROTOCOL_TILE_TYPE[slot13.type])
				else
					print("模板数据内存在套装家具，模板id为" .. slot6.id)
				end
			end
		end

		slot9 = slot6.type
		slot10 = RoomInfo.New()
		slot10.furnitureInfoS = slot8
		slot7.furnitureInfoS = slot10.furnitureInfoS
		uv0[slot6.id] = DormRoomTemplate.New(slot7)
		slot11 = {}

		for slot15, slot16 in ipairs(slot6.furniture_pos_list) do
			if slot16.type == DormConst.PROTOCOL_TILE_TYPE_INDEX.FLOOR then
				slot11 = slot16.furniture_pos
			end
		end

		DormSpecialFurnitureTools:AddSpecialFurInfo(uv0[slot6.id], slot9, slot11, false)
	end
end

function slot0.DeleteDormTemplateInfo(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1]:Dispose()

		uv0[slot1] = nil
	else
		print("不存在家具模板信息")
	end
end

function slot0.Dispose(slot0)
	if uv0 then
		for slot4, slot5 in pairs(uv0) do
			slot5:Dispose()
		end
	end
end

function slot0.SetOtherCanSave(slot0, slot1)
	uv0 = slot1
end

function slot0.GetOtherCanSave(slot0)
	return uv0
end

function slot0.PreviewDormSceneTemplate(slot0, slot1)
	DormHeroTools.HideAllCharacter()

	if DormFurnitureTemplateData:GetDormTemplateInfo(slot1) then
		DormFurEditStateData:RestoreRoomAllFurniture(true)
		DormFurnitureTools:GenFurListInCurRoom(slot2.furnitureInfoS, slot2.suitInfo)
		DormSpecialFurnitureTools:ChangeDormFloorOrWallData(slot2.specialFur)
	end
end

function slot0.CancelPreviewDormSceneTemplate(slot0, slot1)
	slot2 = DormitoryData:GetDormSceneData(slot1)

	DormFurnitureTools:GenFurListInCurRoom(slot2.roomInfo.furnitureInfoS)
	DormSpecialFurnitureTools:ChangeDormFloorOrWallData(slot2.specialFur)
	DormSuitTools:GenerateSuitInfoList(slot2.suitInfo, true)
	DormHeroTools:GenerateHeroWhenEnterScene()
end

function slot0.SaveDormSceneTemplate(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot2 == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		slot2 = DormConst.BACKHOME_TYPE.PublicDorm
	end

	if slot2 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		slot2 = DormConst.BACKHOME_TYPE.PrivateDorm
	end

	if not slot4 or slot4 > 1000 then
		DormAction:SaveFurTemplate(slot1, slot2, slot3, 0, DormLuaBridge.GetPlacedFurnitureInfo(true), slot5, DormitoryData:GetDormSceneData(DormData:GetCurrectSceneID()).specialFur, slot6)
	elseif DormitoryData:GetDormSceneData(slot4).suitInfo and next(slot7.suitInfo) ~= nil then
		DormAction:SaveFurTemplate(slot1, slot2, slot3, 0, DormLuaBridge.GetPlacedFurnitureInfo(true), slot5, slot7.specialFur, slot6)
	else
		DormAction:SaveFurTemplate(slot1, slot2, slot3, slot4, nil, slot5, nil, slot6)
	end
end

function slot0.SaveFurTemplateInfo(slot0, slot1)
	slot2 = DormitoryData:GetDormMapList()
	slot3 = nil

	if uv0[DormFurnitureTemplateData:GetDormTemplateInfoByPosID(slot1.pos, slot1.type)] then
		slot8 = uv0[slot7]
		slot8.id = slot1.id
		slot8.type = slot1.type
		slot8.name = slot1.name
		slot8.posID = slot1.pos
		slot8.furnitureInfoS = DormLuaBridge.GetPlacedFurnitureInfo(true)
		slot8.specialFur = deepClone(((slot1.architecture_id == 0 or slot4 >= 1000 or slot2[slot4]) and slot2[DormData:GetCurrectSceneID()]).specialFur)
	else
		uv0[slot1.id] = DormRoomTemplate.New({
			id = slot1.id,
			type = slot1.type,
			name = slot1.name,
			pos = slot1.pos,
			furnitureInfoS = DormLuaBridge.GetPlacedFurnitureInfo(true),
			specialFur = deepClone(slot3.specialFur)
		})
	end
end

function slot0.ConfirmUseTemplateInRoom(slot0, slot1, slot2, slot3, slot4)
	if slot3 then
		DormAction:SetFurListInMap(slot2, slot1, nil)
	else
		DormAction:SetFurListInMap(slot2, nil, slot4)
	end
end

function slot0.GetCanUseTemplateID(slot0)
	for slot5 = 1, DormConst.DORM_TEMPLATE_NUM_MAX + DormConst.DORM_TEMPLATE_PRIVATE_NUM_MAX do
		slot6 = false

		for slot10, slot11 in pairs(uv0) do
			if slot10 == slot5 then
				slot6 = true

				break
			end
		end

		if not slot6 then
			return slot5
		end
	end
end

function slot0.GetDormTemplateInfo(slot0, slot1)
	if uv0 and uv0[slot1] then
		return uv0[slot1]
	end
end

function slot0.GetDormTemplateInfoByPosID(slot0, slot1, slot2)
	if uv0 then
		for slot6, slot7 in pairs(uv0) do
			if slot7.posID == slot1 and slot2 == slot7.type then
				return slot6
			end
		end
	end
end

function slot0.CheckFurNumSuitTemplate(slot0, slot1, slot2)
	slot3 = {}
	slot4 = true

	if not DormFurnitureTemplateData:GetDormTemplateInfo(slot1) then
		print("模板数据为空")

		return
	end

	slot6, slot7 = slot5:GetDormTemplateFurNumInfo()

	for slot11, slot12 in pairs(slot7) do
		if slot12 > DormFurEditStateData:GetCanUseFurNumInRoom(slot2, slot11) + DormRoomTools:GetHasPlaceFurInfoByRoom(slot2, slot11) then
			slot4 = false
			slot3[slot11] = slot12 - slot13
		end
	end

	if not slot4 then
		return slot4, slot3
	else
		return slot4, nil
	end
end

function slot0.ReduceTemplateLackFurInfoS(slot0, slot1, slot2)
	slot5 = {}
	slot6 = DormFurnitureTemplateData:GetDormTemplateInfo(slot1).specialFur

	for slot10 = 0, DormFurnitureTemplateData:GetDormTemplateInfo(slot1).furnitureInfoS.Length - 1 do
		slot11 = FurnitureInfo.New()
		slot11.id = slot3[slot10].id
		slot11.tileType = slot3[slot10].tileType
		slot11.pos = slot3[slot10].pos
		slot11.rotation = slot3[slot10].rotation

		table.insert(slot5, slot11)
	end

	for slot10 = #slot5, 1, -1 do
		if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot5[slot10].id) and slot2[slot11] and slot2[slot11] > 0 then
			table.remove(slot5, slot10)

			slot2[slot11] = slot2[slot11] - 1
		end
	end

	slot8 = slot6.wallID
	slot9 = slot6.floorID
	slot10 = slot6.backGroundID

	if slot2[slot6.wallID] and slot2[slot6.wallID] > 0 then
		slot8 = DormSpecialFurnitureTools:GetOriFloorOrWall(slot4.type, DormConst.WALL_TYPE_NUM)
	end

	if slot2[slot6.floorID] and slot2[slot6.floorID] > 0 then
		slot9 = DormSpecialFurnitureTools:GetOriFloorOrWall(slot7, DormConst.FLOOR_TYPE_NUM)
	end

	if slot2[slot6.backGroundID] and slot2[slot6.backGroundID] > 0 then
		slot10 = DormSpecialFurnitureTools:GetOriFloorOrWall(slot7, DormConst.BACK_GROUND_TYPE)
	end

	slot11 = RoomInfo.New()
	slot11.furnitureInfoS = slot5

	return slot11.furnitureInfoS, {
		wallID = slot8,
		floorID = slot9,
		backGroundID = slot10
	}
end

return slot0
