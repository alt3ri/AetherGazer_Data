slot0 = singletonClass("BattleEquipData")
slot1 = {
	upSuitId = 0,
	baseStageId = 0,
	EquipNewTagKey = "BattleEquipNewTag_",
	guaranteeNum = {}
}

function slot0.InitBattleEquipData(slot0, slot1)
	uv0.baseStageId = slot1.stage_base_id
	uv0.upSuitId = slot1.equip_suit_id
	uv0.next_refresh_time = slot1.next_refresh_time

	for slot5, slot6 in ipairs(slot1.insure_list) do
		uv0.guaranteeNum[slot6.difficulty] = slot6.insure_times
	end

	slot0:InitNewTagData()
end

function slot0.ChangeUpSuitId(slot0, slot1)
	uv0.upSuitId = slot1
end

function slot0.SetGuaranteeNum(slot0, slot1, slot2)
	uv0.guaranteeNum[slot1] = slot2
end

function slot0.AddGuaranteeNum(slot0, slot1, slot2)
	uv0.guaranteeNum[slot1] = (uv0.guaranteeNum[slot1] or 0) + slot2
end

function slot0.GetBattleEquipData(slot0)
	return uv0
end

function slot0.GetGuaranteeNum(slot0)
	return uv0.guaranteeNum
end

function slot0.AlreadyPlayOnce(slot0, slot1)
	if uv0.guaranteeNum[slot1] ~= nil then
		return true
	end

	return false
end

function slot0.InitNewTagData(slot0)
	if SystemData:ServerSystemIsLocked(ViewConst.SYSTEM_ID.BATTLE_EQUIP) then
		return
	end

	if not uv0.baseStageId or slot1 == 0 then
		return
	end

	slot6 = 1

	for slot10, slot11 in ipairs(StageGroupCfg[slot1].stage_list) do
		if BattleStageData:GetStageIsOpen(slot11) then
			if (getData("battleEquipNewTag", "newTag") or {})[slot10] ~= nil then
				if slot0:AlreadyPlayOnce(slot10) then
					-- Nothing
				else
					slot5[slot10] = slot4[slot10]
				end
			elseif slot0:AlreadyPlayOnce(slot10) then
				slot5[slot10] = false
			else
				slot5[slot10] = true
			end

			slot6 = slot10
		end
	end

	slot0:AppendRedKey(slot6)
	slot0:ClearNewTag(slot6)
	saveData("battleEquipNewTag", "newTag", {
		[slot10] = false
	})
	slot0:DispatchNewTag()
end

function slot0.OnSystemUnlock(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot6 == ViewConst.SYSTEM_ID.BATTLE_EQUIP then
			slot0:InitNewTagData()

			break
		end
	end
end

function slot0.DispatchNewTag(slot0)
	for slot5, slot6 in ipairs(getData("battleEquipNewTag", "newTag") or {}) do
		if slot6 then
			manager.redPoint:setTip(uv0.EquipNewTagKey .. slot5, 1, RedPointStyle.SHOW_NEW_TAG)
		end
	end
end

function slot0.AppendRedKey(slot0, slot1)
	for slot5 = 1, slot1 do
		manager.redPoint:appendGroup(RedPointConst.BATTLE_EQUIP, uv0.EquipNewTagKey .. slot5)
	end
end

function slot0.ClearNewTag(slot0, slot1)
	for slot5 = 1, slot1 do
		manager.redPoint:setTip(uv0.EquipNewTagKey .. slot5, 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

function slot0.CancelNewTag(slot0, slot1)
	slot2 = getData("battleEquipNewTag", "newTag")

	if slot1 and slot2 and slot2[slot1] == true then
		slot2[slot1] = false

		manager.redPoint:setTip(uv0.EquipNewTagKey .. slot1, 0, RedPointStyle.SHOW_NEW_TAG)
		saveData("battleEquipNewTag", "newTag", slot2)
	end
end

function slot0.GetNewRedPrefix(slot0)
	return uv0.EquipNewTagKey
end

return slot0
