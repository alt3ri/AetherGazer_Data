slot0 = singletonClass("DormSuitEditData")
slot1, slot2, slot3, slot4 = nil

function slot0.EnterFullSuitEditMode(slot0)
	uv0, uv1, uv2 = DormFurEditStateData:GetHadPlaceFurInfoList()
	uv3 = DormFurEditStateData:RestoreRoomAllFurniture(true)

	DormFurnitureManager.GetInstance():ClearAndGenByFurList()
	DormLuaBridge.SetIsCanEditTag(false)
end

function slot0.ExitFullSuitEditMode(slot0)
	uv0 = nil
	uv1 = nil
	uv2 = nil
	uv3 = nil

	DormLuaBridge.SetIsCanEditTag(false)
end

function slot0.RecoverSceneBeforeEdit(slot0)
	DormFurEditStateData:SetCacheFurNumInfo(uv0)

	uv0 = nil

	DormFurnitureManager.GetInstance():ClearAndGenByFurList(uv1, true, uv2)
	DormSpecialFurnitureTools:ChangeDormFloorOrWallData(uv3)
end

function slot0.GetFurNumInfoInSuit(slot0, slot1, slot2, slot3)
	slot5, slot6 = nil

	if BackHomeSuitCfg[slot1] or DormSuitData:GetSuitFurInfo(slot1) then
		for slot11, slot12 in ipairs(slot4.suit_num) do
			if slot12[1] == slot3 then
				slot5 = slot12[2]
			end
		end
	else
		print("未找到模板数据")
	end

	if BackHomeSuitCfg[slot1] and BackHomeSuitCfg[slot1].type == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
		slot6 = DormRoomTools:GetHasPlaceFurInfoByRoom(slot2, slot3) + DormFurEditStateData:GetCanUseFurNumInRoom(slot2, slot3) + DormFurEditStateData:GetCacheFurNum(slot3)
	end

	return slot5, slot6
end

function slot0.ResetSuitPosition(slot0, slot1, slot2)
	slot3 = DormLuaBridge.GetSuitFurEidList(slot1)
	slot5 = nil

	if DormSuitData:GetSuitFurInfo(slot2) then
		slot5 = slot4.furList
	end

	if slot5 then
		for slot10 = 0, slot3.Length - 1 do
			table.insert({}, {
				cfgID = DormUtils.GetEntityData(slot3[slot10]).cfgID,
				eid = slot3[slot10],
				flag = false
			})
		end

		DormLuaBridge.SetSuitFurTrsFather(slot1, false)

		slot10 = slot5[0].tileType

		DormLuaBridge.SetFurniturePosition(slot1, slot10, Vector2(0, 0), 0)

		for slot10 = 0, slot5.Length - 1 do
			for slot14, slot15 in pairs(slot6) do
				if slot5[slot10].id == slot15.cfgID and not slot15.flag then
					DormLuaBridge.SetFurniturePosition(slot15.eid, slot5[slot10].tileType, slot5[slot10].pos, slot5[slot10].rotation)

					slot15.flag = true

					break
				end
			end
		end

		DormLuaBridge.SetSuitFurTrsFather(slot1, true)
		DormLuaBridge.RefreshSuitLenAndWid(slot1)
		DormLuaBridge.AddFurnitureToWallDitherAlphaControl(slot1)
		DormLuaBridge.BeginDragFurniture(slot1)
	end
end

return slot0
