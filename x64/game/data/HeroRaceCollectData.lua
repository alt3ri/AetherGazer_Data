slot0 = singletonClass("HeroRaceCollectData")
slot1 = {}
slot2 = {}
slot3 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}

	for slot5, slot6 in pairs(RaceEffectCfg.all) do
		uv0[slot6] = 0
	end
end

function slot0.InitData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.hero_race_collect) do
		table.insert(uv0, slot6)
	end

	uv1:RefreshHeroRaceCounts()
	uv1:RefreshTasksState()
end

function slot0.RefreshHeroRaceCounts(slot0)
	for slot5, slot6 in pairs(RaceEffectCfg.all) do
		uv0[slot6] = 0
	end

	for slot6, slot7 in pairs(HeroData:GetUnlockHeros()) do
		slot8 = HeroCfg[slot7].race
		uv0[slot8] = uv0[slot8] + 1
	end
end

function slot0.NewHeroUnlock(slot0, slot1)
	slot0:RefreshHeroRaceCounts()
	uv0:RefreshTasksState()
end

function slot0.GetHeroRaceCount(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1]
	end
end

function slot0.RefreshTasksState(slot0)
	for slot5, slot6 in pairs(CollectHeroRaceCfg.all) do
		slot7 = CollectHeroRaceCfg[slot6]

		if uv0[slot7.hero_race] < slot7.need then
			uv1:SetTaskState(slot6, 0)
		elseif table.indexof(uv2, slot6) then
			uv1:SetTaskState(slot6, 2)
		else
			uv1:SetTaskState(slot6, 1)
		end
	end

	uv1:UpdateRedPoint()
end

function slot0.GetTaskState(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetTaskState(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.GetAllCanReceiveTasks(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if slot6 == 1 then
			table.insert(slot1, slot5)
		end
	end

	return slot1
end

function slot0.SetTasksReceived(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		table.insert(uv0, slot6)
	end

	uv1:RefreshTasksState()
end

function slot0.GetTasksReceivedCount(slot0)
	for slot5, slot6 in pairs(uv0) do
		if slot6 == 2 then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.GetCanGetRewardIndex(slot0)
	for slot4, slot5 in pairs(uv0) do
		if slot5 == 1 then
			return table.indexof(RaceEffectCfg.all, CollectHeroRaceCfg[slot4].race)
		end
	end

	return 1
end

function slot0.UpdateRedPoint(slot0)
	manager.redPoint:setTip(RedPointConst.HERO_RACE_COLLECT_REWARD, uv0:HasRewardReceive() and 1 or 0)
end

function slot0.HasRewardReceive(slot0)
	slot1 = false

	for slot5, slot6 in pairs(uv0) do
		if slot6 == 1 then
			slot1 = true

			break
		end
	end

	return slot1
end

return slot0
