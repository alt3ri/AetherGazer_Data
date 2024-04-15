slot0 = singletonClass("DrawData")
slot1 = {}
slot2 = false
slot3 = 0
slot4 = {}
slot5 = {}
slot6 = false
slot7 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = false
	uv2 = 0
	uv3 = {}
	uv4 = {}
	slot0.newHeroFlag_ = false
end

function slot0.InitPool(slot0, slot1)
	uv0 = {}
	slot3 = false

	for slot7, slot8 in ipairs(slot1.draw_info_list) do
		slot9 = slot8.id
		uv0[slot9] = {
			ssr_draw_times = slot8.ssr_draw_times,
			up = slot0:ConvertUpId(slot9, slot8.up, 1),
			up_times = slot8.up_times,
			is_new = slot8.is_new
		}

		if slot8.is_new == 1 then
			uv1[slot9] = true
			slot3 = true
		end
	end

	uv2 = slot1.newbie_choose_draw_flag
	uv3 = slot1.today_draw_times
	uv4 = slot1.first_ssr_draw_flag

	slot0:RefreshNewDraw()
end

function slot0.RefreshNewDraw(slot0)
	slot1 = false

	for slot5, slot6 in pairs(uv0) do
		if slot6.is_new and slot6.is_new == 1 then
			slot1 = true

			break
		end
	end

	if slot1 and not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DRAW) then
		manager.redPoint:setTip(RedPointConst.DRAW, 1, RedPointStyle.SHOW_NEW_TAG)
	end
end

function slot0.UpdatePool(slot0, slot1, slot2, slot3, slot4)
	if DrawPoolCfg[slot1].pool_type == 1 or slot5.pool_type == 5 then
		for slot9, slot10 in pairs(uv0) do
			if DrawPoolCfg[slot9].pool_type == 1 or slot11.pool_type == 5 then
				slot10.ssr_draw_times = math.max(slot2, slot10.ssr_draw_times)
			end
		end
	end

	if uv0[slot1] then
		uv0[slot1].ssr_draw_times = slot2
	else
		uv0[slot1] = {
			ssr_draw_times = slot2
		}
	end

	uv1 = slot4
	uv2 = slot3
end

function slot0.TodayDrawTimesChange(slot0, slot1)
	uv0 = uv0 + slot1
end

function slot0.GetTodayDrawTimes(slot0)
	return uv0
end

function slot0.GetIsFirstSSR(slot0)
	return uv0
end

function slot0.GetPoolDrawTimes(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].ssr_draw_times or 0
	end

	return 0
end

function slot0.SetPollUpID(slot0, slot1, slot2)
	if uv0[slot1] then
		if slot2 ~= uv0[slot1].up then
			uv0[slot1].up = slot2
			uv0[slot1].up_times = (uv0[slot1].up_times or 0) + 1
		end
	else
		uv0[slot1] = {
			up_times = 1,
			up = slot2
		}
	end
end

function slot0.GetPollUpID(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].up or 0
	end

	return 0
end

function slot0.GetPoolUpTimes(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].up_times or 0
	end

	return 0
end

function slot0.GetPoolList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		table.insert(slot1, slot5)
	end

	return slot1
end

function slot0.GetPoolIsNew(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].is_new
	end

	return false
end

function slot0.SetPoolIsNew(slot0, slot1, slot2)
	if uv0[slot1] then
		uv0[slot1].is_new = 0
	end
end

function slot0.SetDrawRecord(slot0, slot1, slot2)
	if not slot2 then
		uv0 = {}
	else
		uv0[slot1] = {
			ssr_draw_times = slot2.ssr_draw_times,
			draw_record_list = {}
		}

		for slot6 = 1, #slot2.draw_record_list do
			slot7 = slot2.draw_record_list[#slot2.draw_record_list - slot6 + 1]
			slot8 = slot7.item

			table.insert(uv0[slot1].draw_record_list, {
				item = {
					id = slot8.id,
					num = slot8.num
				},
				draw_timestamp = slot7.draw_timestamp
			})
		end
	end
end

function slot0.GetDrawRecord(slot0, slot1)
	return uv0[slot1]
end

slot8 = {}

function slot0.SetServantRedPoint(slot0, slot1, slot2)
	slot3 = string.format("%s_%d_%d", RedPointConst.WEAPON_SERVANT_POOL, slot1, slot0:GetPollUpID(slot1))

	manager.redPoint:setTip(slot3, slot2)

	uv0[slot3] = true
end

function slot0.ResetServantRedPoint(slot0)
	for slot4, slot5 in pairs(uv0) do
		manager.redPoint:setTip(slot4, 0)
	end
end

function slot0.SetNewHeroFlag(slot0, slot1)
	slot0.newHeroFlag_ = slot1
end

function slot0.GetNewHeroFlag(slot0)
	return slot0.newHeroFlag_
end

function slot0.GetNewbieChooseDrawFlag(slot0)
	return uv0
end

function slot0.IsOnePrefabPool(slot0, slot1)
	if not DrawPoolCfg[slot1] then
		CustomLog.Log(debug.traceback(string.format("null")))
	end

	return (slot2.pool_type == 3 or slot2.pool_type == 8) and #slot2.optional_lists_poolId > 2
end

function slot0.GetUpRemainTime(slot0, slot1)
	return DrawPoolCfg[slot1].pool_change - slot0:GetPoolUpTimes(slot1)
end

function slot0.ConvertUpId(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		return slot2
	end

	slot4 = DrawPoolCfg[slot1]

	if slot3 == 0 then
		return slot4.optional_lists[table.indexof(slot4.optional_lists_poolId, slot2)]
	else
		return slot4.optional_lists_poolId[table.indexof(slot4.optional_lists, slot2)]
	end
end

function slot0.GetPoolData(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1]
	end
end

function slot0.SetPoolData(slot0, slot1, slot2)
	if not uv0[slot1] then
		uv0[slot1] = {}
	end

	uv0[slot1] = {
		s_up_probability = slot2.s_up_probability,
		s_up_item = slot2.s_up_item,
		s_other_item = slot2.s_other_item,
		a_up_probability = slot2.a_up_probability,
		a_up_item = slot2.a_up_item,
		a_other_item = slot2.a_other_item,
		b_item = slot2.b_item
	}
end

return slot0
