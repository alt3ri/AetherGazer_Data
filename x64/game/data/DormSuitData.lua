slot0 = singletonClass("DormSuitData")
slot1, slot2, slot3 = nil

function slot0.InitDormSuitList(slot0, slot1)
	uv0:RefreshUnLockSuitList(slot1.backhome_suit_id_list, true)
end

function slot0.DisposeDormSuitData(slot0)
	uv0 = nil
end

function slot0.EnterDormSystem(slot0)
	uv0 = getData("BackHome", "suitHelp")

	if not uv0 then
		uv0 = false
	end
end

function slot0.ExitDormSystem(slot0)
	saveData("BackHome", "suitHelp", uv0)

	uv0 = nil
end

function slot0.GenerateSingleSuitData(slot0, slot1)
	if not uv0 then
		uv0 = {}
	end

	uv0[slot1.suitID] = {
		furList = slot1.furList,
		specialFur = slot1.specialFur,
		tileType = slot1.tileType,
		suitType = slot1.suitType,
		suit_num = slot1.suitNum
	}
end

function slot0.RefreshUnLockSuitList(slot0, slot1, slot2)
	if not uv0 or slot2 then
		uv0 = {}
	end

	for slot6, slot7 in ipairs(slot1) do
		table.insert(uv0, slot7)
	end

	DormRedPointTools:UpdataSuitRedPoint()
end

function slot0.GetSuitFurInfo(slot0, slot1)
	if uv0 and uv0[slot1] then
		return uv0[slot1]
	end

	if BackHomeSuitCfg[slot1].type == DormSuitTools.DORM_SUIT_TYPE.FULL_SET or slot2 == DormSuitTools.DORM_SUIT_TYPE.PART_SET then
		slot3, slot4 = DormSuitTools:GetDeSerializeDormSuitDataInScene(slot1)

		uv1:GenerateSingleSuitData({
			suitID = slot1,
			furList = slot3,
			specialFur = slot4,
			suitType = slot2,
			tileType = BackHomeSuitCfg[slot1].display_type,
			suitNum = BackHomeSuitCfg[slot1].suit_num
		})
	end

	return uv0[slot1]
end

function slot0.GetSuitInfoListByType(slot0, slot1)
	slot2 = {}

	if uv0 then
		for slot6, slot7 in pairs(uv0) do
			if slot7.suitType == slot1 then
				table.insert(slot2, slot6)
			end
		end
	end

	return slot2
end

function slot0.GetSuitNeedTotalFurNumList(slot0, slot1)
	for slot7, slot8 in ipairs(uv0:GetSuitFurInfo(slot1).suit_num) do
		slot2 = 0 + uv0:GetFurNeedNumBySuitID(slot1, slot8[1])
	end

	return slot2
end

function slot0.GetTotalCanUseFurNumBySuitInRoom(slot0, slot1, slot2)
	slot3, slot4 = DormSuitData:CheckIsSuit(slot1)
	slot5 = 0

	if slot3 then
		for slot10, slot11 in ipairs(uv0:GetSuitFurInfo(slot1).suit_num) do
			slot5 = slot5 + uv0:GetFurCanUseNumBySuitIDAndRoomID(slot1, slot11[1], slot2)
		end
	end

	return slot5
end

function slot0.CheckSuitCanUseInRoom(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(BackHomeSuitCfg[slot1].suit_num) do
		if not DormSpecialFurnitureTools:JudgeIsOriSpecialFur(slot8[1]) and DormFurEditStateData:GetCanUseFurNumInRoom(slot2, slot9) < slot8[2] then
			return false
		end
	end

	return true
end

function slot0.GetFurNeedNumBySuitID(slot0, slot1, slot2)
	slot4 = 0

	for slot8, slot9 in ipairs(uv0:GetSuitFurInfo(slot1).suit_num) do
		if slot9[1] == slot2 then
			slot4 = slot9[2]

			break
		end
	end

	return slot4
end

function slot0.GetFurCanUseNumBySuitIDAndRoomID(slot0, slot1, slot2, slot3)
	slot4, slot5 = uv0:CheckIsSuit(slot1)
	slot6 = BackHomeFurniture[slot2].is_give
	slot7 = 0
	slot11 = uv0:GetFurNeedNumBySuitID(slot1, slot2)

	if slot5 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
		slot7 = DormRoomTools:GetHasPlaceFurInfoByRoom(slot3, slot2) + DormFurEditStateData:GetCacheFurNum(slot2) + DormFurEditStateData:GetCanUseFurNumInRoom(slot3, slot2)
	elseif slot5 == DormSuitTools.DORM_SUIT_TYPE.PART_SET then
		slot7 = slot8
	end

	return math.min(slot11, slot7)
end

function slot0.GetNeedUseFurNumInfoBySuitID(slot0, slot1)
	if BackHomeSuitCfg[slot1] then
		return slot2.suit_num
	end
end

function slot0.GetSuitHelpFlag(slot0)
	return uv0
end

function slot0.SetSuitHelpFlag(slot0, slot1)
	uv0 = slot1

	saveData("BackHome", "suitHelp", uv0)
end

function slot0.CheckUnlockSuit(slot0, slot1)
	if uv0 then
		for slot5, slot6 in ipairs(uv0) do
			if slot6 == slot1 then
				return true
			end
		end
	end

	return false
end

function slot0.GetUnLockSuitList(slot0)
	return uv0
end

function slot0.GetUnLockSuitListByType(slot0, slot1)
	slot2 = {}

	if uv0 then
		for slot6, slot7 in ipairs(uv0) do
			if BackHomeSuitCfg[slot7].type == slot1 then
				table.insert(slot2)
			end
		end
	end

	return slot2
end

function slot0.GetSuitIDListByType(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(BackHomeSuitCfg.all) do
		if BackHomeSuitCfg[slot8].type == slot1 then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.CheckCanUseSuitInRoom(slot0, slot1, slot2)
	slot3 = uv0:CheckUnlockSuit(slot2)
	slot4 = BackHomeCfg[slot1].type
	slot5 = false

	if BackHomeSuitCfg[slot2] then
		for slot9, slot10 in ipairs(BackHomeSuitCfg[slot2].scene_id) do
			if slot4 == slot10 then
				slot5 = true

				break
			end
		end
	else
		slot5 = true
	end

	return slot3 and slot5
end

function slot0.GetCanUseFurSuitIDList(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(BackHomeSuitCfg.all) do
		if slot2 == BackHomeSuitCfg[slot8].type and uv0:CheckCanUseSuitInRoom(slot1, slot8) and uv0:CheckUnlockSuit(slot8) then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.CheckIsSuit(slot0, slot1)
	if BackHomeSuitCfg[slot1] then
		return true, slot2.type
	elseif slot1 < 1000 then
		return true, DormSuitTools.DORM_SUIT_TYPE.CUSTOM_SET
	end
end

function slot0.CheckIsConfigSuit(slot0, slot1)
	if BackHomeSuitCfg[slot1] then
		return true, slot2.type
	end
end

function slot0.GetSuitCanUseFurInfo(slot0, slot1)
	for slot7, slot8 in ipairs(DormSuitTools:GetDeSerializeDormSuitData(slot1).numList) do
		-- Nothing
	end

	return {
		[slot8[1]] = slot8[2]
	}
end

slot4 = nil
slot5 = DormSuitTools.DORM_SUIT_TYPE.FULL_SET

function slot0.SetSuitType(slot0, slot1)
	uv0 = slot1
end

function slot0.GetSuitType(slot0)
	return uv0
end

function slot0.SetSuitSerializeData(slot0, slot1)
	uv0 = {
		name = slot1,
		suitType = uv1
	}
end

function slot0.GetSuitSerializeData(slot0)
	return uv0
end

return slot0
