slot0 = singletonClass("ActivityPtScrollData")
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = {}
end

function slot0.SetData(slot0, slot1)
	uv0[slot2] = {
		activityID = slot1.activity_id,
		clearList = slot1.clear_stage_list or {},
		buff_id = slot1.buff_id,
		up_select = slot1.up_select,
		filter_up = slot1.up_select,
		poolID = slot1.index,
		clear_times = slot1.clear_times
	}

	if slot1.up_select == 0 then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. slot2, 0)

		if not ActivityPtRouletteRandomCfg[slot1.index] then
			return
		end

		uv0[slot2].filter_up = slot3.equip_suit_list[1] or 0

		if #slot3.equip_suit_list > 1 and manager.time:GetTodayFreshTime() > (getData("activityPtScroll", "last_check_up") or 0) then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. slot2, 1)
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_INFINITY_TASK .. "_" .. slot2, GameSetting.activity_pt_roulette_task_times.value[1] <= slot1.clear_times and 1 or 0)
	slot0:RefreshAffix(slot2)
end

function slot0.RefreshAffix(slot0, slot1)
	slot0:RefreshAffixMap(slot1)
	slot0:RefreshAffixList(slot1)
end

function slot0.RefreshAffixMap(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[slot1]) do
		if ActivityPtRouletteStageCfg[slot8].mode == 2 then
			slot2 = ActivityPtRouletteStageCfg[slot8].roulette_id

			break
		end
	end

	uv0[slot1] = {
		all = {}
	}

	for slot8, slot9 in ipairs(ActivityPtRouletteRandomCfg[uv1[slot1].poolID].affix_list) do
		slot11 = ActivityPtRouletteAffixCfg[slot9].affix_list
		uv0[slot1][slot11[1]] = {
			type = 0,
			useless = false,
			affix = slot11[1],
			level = slot11[2],
			target = slot11[3]
		}

		table.insert(uv0[slot1].all, slot11[1])
	end

	for slot8, slot9 in ipairs(slot4.random_affix_list) do
		for slot15, slot16 in ipairs(slot9[2]) do
			slot18 = ActivityPtRouletteAffixCfg[slot16].affix_list
			uv0[slot1][slot18[1]] = {
				useless = false,
				type = slot9[1],
				affix = slot18[1],
				level = slot18[2],
				target = slot18[3]
			}

			table.insert(uv0[slot1].all, slot18[1])
		end
	end

	for slot8, slot9 in ipairs(slot4.roulette_desc) do
		uv0[slot1][slot9] = {
			target = 0,
			useless = true,
			level = 1,
			type = ActivityPtRouletteTipsCfg[slot9].icon,
			affix = slot9
		}

		table.insert(uv0[slot1].all, slot9)
	end
end

function slot0.RefreshAffixList(slot0, slot1)
	uv0[slot1] = deepClone(uv1[slot1].all)

	table.remove(uv0[slot1], table.indexof(uv0[slot1], slot0:GetChooseAffixID(slot1)))

	for slot7 = #uv0[slot1], 1, -1 do
		uv0[slot1][slot3] = table.remove(uv0[slot1], math.random(slot7))
	end

	table.insert(uv0[slot1], slot3 / 2 + 1, slot2)
end

function slot0.GetChooseAffixID(slot0, slot1)
	return ActivityPtRouletteAffixCfg[uv0[slot1].buff_id].affix_list[1]
end

function slot0.GetAffixList(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetAffixInfo(slot0, slot1, slot2)
	return uv0[slot1][slot2]
end

function slot0.SetLastStage(slot0, slot1, slot2, slot3)
	uv0[slot1] = {
		type = slot2,
		index = slot3
	}
end

function slot0.GetLastStage(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetClearList(slot0, slot1, slot2)
	if not table.indexof(uv0[slot1].clearList, slot2) then
		table.insert(uv0[slot1].clearList, slot2)
	end
end

function slot0.GetClearList(slot0, slot1)
	return uv0[slot1].clearList
end

function slot0.SetUpSelect(slot0, slot1, slot2)
	uv0[slot1].up_select = slot2

	if slot2 ~= 0 then
		uv0[slot1].filter_up = slot2
	end
end

function slot0.GetUpSelect(slot0, slot1)
	return uv0[slot1].up_select, uv0[slot1].filter_up
end

function slot0.GetPoolID(slot0, slot1)
	return uv0[slot1].poolID
end

function slot0.GetClearTime(slot0, slot1)
	return uv0[slot1].clear_times
end

function slot0.AddClearTime(slot0, slot1, slot2)
	uv0[slot1].clear_times = uv0[slot1].clear_times + slot2

	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_INFINITY_TASK .. "_" .. slot1, GameSetting.activity_pt_roulette_task_times.value[1] <= uv0[slot1].clear_times and 1 or 0)
end

function slot0.ModifyClearTime(slot0, slot1, slot2)
	uv0[slot1].clear_times = slot2

	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_INFINITY_TASK .. "_" .. slot1, GameSetting.activity_pt_roulette_task_times.value[1] <= uv0[slot1].clear_times and 1 or 0)
end

return slot0
