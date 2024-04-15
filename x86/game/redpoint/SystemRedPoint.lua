return {
	Init = function (slot0)
		slot0.NewSystemTagList = {}

		slot0:AddToggleList()
		slot0:AppendSystemUnlock()
	end,
	AddToggleList = function (slot0)
		for slot5, slot6 in ipairs({
			BattleConst.TOGGLE.RESOURCE,
			BattleConst.TOGGLE.EQUIP,
			BattleConst.TOGGLE.CHALLENGE
		}) do
			for slot11 = 1, #ChapterClientCfg.get_id_list_by_toggle[slot6] do
				if not ChapterTools.IsChapterSystemLock(slot7[slot11]) and GetSystemIdByClientChapterId(slot12) and slot13 > 0 then
					slot0.NewSystemTagList[slot13] = true
				end
			end
		end
	end,
	AppendSystemUnlock = function (slot0)
		for slot5, slot6 in ipairs({
			BattleConst.TOGGLE.RESOURCE,
			BattleConst.TOGGLE.EQUIP,
			BattleConst.TOGGLE.CHALLENGE
		}) do
			for slot11 = 1, #ChapterClientCfg.get_id_list_by_toggle[slot6] do
				if not ChapterTools.IsChapterSystemLock(slot7[slot11]) and GetSystemIdByClientChapterId(slot12) and slot13 > 0 and ChapterTools.GetRedPoint(slot12) ~= RedPointConst.COMBAT_UNLL then
					manager.redPoint:appendGroup(slot14, GetSystemNewRedKey(slot13))
				end
			end
		end
	end,
	InitSystemUnlockDispatch = function (slot0)
		slot2 = false
		slot3 = {}

		for slot7, slot8 in ipairs(getData("systemUnlockNewTag", "newSystem") or {}) do
			if not SystemData:GetSystemIsOpen(slot8) then
				slot2 = true
			else
				slot0:DispatchNewTag(slot8)
				table.insert(slot3, slot8)
			end
		end

		if slot2 then
			saveData("systemUnlockNewTag", "newSystem", slot3)
		end
	end,
	CheckIsSystemUnlock = function (slot0, slot1)
		slot3 = {
			[slot8] = true
		}

		for slot7, slot8 in ipairs(getData("systemUnlockNewTag", "newSystem") or {}) do
			-- Nothing
		end

		for slot7, slot8 in ipairs(slot1) do
			if slot0:CheckNeedNewTag(slot8) and not slot3[slot8] then
				table.insert(slot2, slot8)
				slot0:DispatchNewTag(slot8)
			end
		end

		saveData("systemUnlockNewTag", "newSystem", slot2)
	end,
	DispatchNewTag = function (slot0, slot1)
		manager.redPoint:setTip(GetSystemNewRedKey(slot1), 1, RedPointStyle.SHOW_NEW_TAG)
	end,
	CancelNewTagByChapterId = function (slot0, slot1)
		if GetSystemIdByClientChapterId(slot1) then
			slot0:CancelNewTag(slot2)
		end
	end,
	CancelNewTag = function (slot0, slot1)
		slot2 = GetSystemNewRedKey(slot1)

		for slot8, slot9 in ipairs(getData("systemUnlockNewTag", "newSystem") or {}) do
			-- Nothing
		end

		if slot0:CheckNeedNewTag(slot1) and ({
			[slot9] = slot8
		})[slot1] then
			table.remove(slot3, slot4[slot1])
		end

		manager.redPoint:setTip(GetSystemNewRedKey(slot1), 0, RedPointStyle.SHOW_NEW_TAG)
		saveData("systemUnlockNewTag", "newSystem", slot3)
	end,
	CheckNeedNewTag = function (slot0, slot1)
		return slot0.NewSystemTagList[slot1] or false
	end
}
