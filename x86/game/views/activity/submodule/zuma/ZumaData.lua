slot0 = singletonClass("ZumaData")
slot1 = 0
slot2 = 0
slot3 = {}
slot4 = 0
slot5 = 0
slot6 = {}
slot7 = {}
slot8 = {}
slot9 = {}
slot10 = {}
slot11 = {}

function slot0.GetZumaRead(slot0, slot1)
	return table.indexof(uv0, slot1)
end

function slot0.SetZumaRead(slot0, slot1)
	if not ActivityData:GetActivityData(slot1) or not slot2:IsActivitying() then
		return
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ZUMA_OPEN, slot1), 0)

	if not table.indexof(uv0, slot1) then
		table.insert(uv0, slot1)
	end
end

function slot0.GetZumaIdByActId(slot0, slot1)
	if not uv0[slot1] then
		for slot5, slot6 in ipairs(ActivityZumaLevelCfg.all) do
			if ActivityZumaLevelCfg[slot6] then
				uv0[slot7.activity_id] = slot6
			end
		end
	end

	return uv0[slot1]
end

slot0.ZUMA_DIFFICULT = {
	NIGHT = 3,
	ESAY = 1,
	HARD = 2
}

function slot0.Init(slot0)
	uv0 = 0
	uv1 = 0
	uv2 = 0
	uv3 = 0
	uv4 = {}
	uv5 = {}
	uv6 = {}
	uv7 = {}
	uv8 = {}
end

function slot0.InitZumaData(slot0, slot1)
	slot0:SetZumaCoin(slot1.value)

	for slot5, slot6 in ipairs(slot1.talent_list) do
		uv0[slot6] = true
	end

	for slot5, slot6 in ipairs(slot1.finish_mission or {}) do
		uv1[slot6.id] = {
			id = slot6.id,
			score = slot6.score
		}
	end
end

function slot0.GetZumaCoin(slot0)
	return uv0
end

function slot0.UpdateZumaCoin(slot0, slot1)
	uv0 = uv0 + slot1
end

function slot0.SetZumaCoin(slot0, slot1)
	uv0 = slot1
end

function slot0.GetZumaTaskData(slot0)
	return TaskData2:GetActivityTaskSortList(slot0:GetZumaActivityID())
end

function slot0.GetZumaStageData(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetZumaStageScore(slot0, slot1)
	return slot0:GetZumaStageData(slot1) and slot2.score or nil
end

function slot0.GetZumaFinishPointList(slot0, slot1, slot2)
	slot3 = {}

	for slot8, slot9 in pairs(slot2) do
		if ActivityPointRewardCfg[slot9].need <= slot1 then
			table.insert(slot3, slot10)

			slot4 = 0 + slot10.reward_item_list[1][2]
		end
	end

	return slot3, slot4
end

function slot0.UpdateZumaStageData(slot0, slot1)
	slot2 = slot1.id
	slot3 = ActivityZumaLevelCfg[slot2]

	if not uv0[slot2] then
		uv0[slot2] = {
			id = slot2,
			score = 0
		}
	end

	if uv0[slot2].score < slot1.score then
		uv0[slot2].score = slot1.score
	end
end

function slot0.GetZumaStageOpenTime(slot0, slot1)
	if manager.time:GetServerTime() <= (ActivityData:GetActivityData(ActivityZumaLevelCfg[slot1].activity_id) and slot3.startTime or 0) then
		return string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot3.startTime, false, true))
	end

	return nil
end

function slot0.GetZumaBeforeIsFinish(slot0, slot1)
	if ActivityZumaLevelCfg[slot1].pre_id == 0 or slot0:GetZumaStageScore(slot3) then
		return true
	end

	return false
end

function slot0.InitZumaCfgData(slot0)
	for slot4, slot5 in pairs(ActivityZumaLevelCfg.all) do
		if ActivityZumaLevelCfg[slot5] then
			if not uv0[slot6.difficult] then
				uv0[slot6.difficult] = {}
			end

			table.insert(uv0[slot6.difficult], slot6)
		end
	end
end

function slot0.GetZumaCfgData(slot0)
	if #uv0 == 0 then
		slot0:InitZumaCfgData()
	end

	return uv0
end

function slot0.GetZumaTalentIsOpen(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetUseZumaTalent(slot0, slot1)
	uv0[slot1] = true
end

function slot0.ResetTalentList(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
end

function slot0.GetTalentList(slot0)
	return uv0
end

function slot0.GetZumaTalentIsCanOpen(slot0, slot1)
	if ActivityZumaTalentCfg[slot1].pre_id == 0 or slot0:GetZumaTalentIsOpen(slot3) then
		return true
	end

	return false
end

function slot0.GetTalentTreeCfg(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(ActivityZumaTalentCfg.all) do
		if ActivityZumaTalentCfg[slot6] then
			if not slot1[slot7.pre_id] then
				slot1[slot7.pre_id] = {}
			end

			table.insert(slot1[slot7.pre_id], slot7.id)
		end
	end

	return slot1
end

function slot0.SetTalentRedList(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.GetTalentRedList(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetTalentReadList(slot0)
	for slot4, slot5 in pairs(uv0) do
		if slot5 then
			slot0:SetZumaTalentRead(slot4)
		end
	end

	for slot5 = #uv1, 1, -1 do
		if ActivityZumaTalentCfg[uv1[slot5]] and ZumaData:GetZumaCoin() < slot7.need then
			table.remove(uv1, slot5)
		end
	end

	manager.redPoint:setTip(RedPointConst.ZUMA_TALENT, 0)
end

function slot0.GetZumaTalentRead(slot0, slot1)
	return table.indexof(uv0, slot1)
end

function slot0.SetZumaTalentRead(slot0, slot1)
	if not table.indexof(uv0, slot1) then
		table.insert(uv0, slot1)
	end
end

function slot0.SetZumaActivityID(slot0, slot1)
	slot0.useActivityID = slot1
end

function slot0.GetZumaActivityID(slot0)
	return slot0.useActivityID
end

function slot0.SetZumaGameId(slot0, slot1)
	uv0 = slot1
end

function slot0.GetZumaGameId(slot0)
	return uv0
end

function slot0.ResetZumaGameData(slot0)
	uv0 = 0
end

function slot0.SetZumaScore(slot0, slot1)
	uv0 = slot1
end

function slot0.GetZumaScore(slot0)
	return uv0
end

function slot0.SetZumaBallCount(slot0, slot1)
	uv0 = slot1
end

function slot0.GetZumaBallCount(slot0)
	return uv0
end

return slot0
