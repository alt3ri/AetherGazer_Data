slot0 = singletonClass("AdvanceTestData", BaseHeroViewData)
slot1 = {}
slot2 = nil

function slot0.Init(slot0)
	slot0.mainActivityID = 182241
	slot0.lastSelectIndex = 1
	slot0.isActivityOpen = false
	slot0.battleResultScore = 0
	slot0.scoreList = {}
	uv0 = {}
end

function slot0.GetMainActivityID(slot0)
	return slot0.mainActivityID
end

function slot0.GetLastSelectIndex(slot0)
	return slot0.lastSelectIndex
end

function slot0.SetLastSelectIndex(slot0, slot1)
	slot0.lastSelectIndex = slot1
end

function slot0.InitDefalutHeroList(slot0)
	slot3 = HeroData
	slot5 = slot3
	slot0.heroList = clone(slot3.GetHeroList(slot5))

	for slot4, slot5 in pairs(slot0.heroList) do
		slot5.servantInfo = clone(slot5:GetServantInfo())

		function slot5.GetServantInfo()
			return uv0.servantInfo
		end
	end
end

function slot0.GetHeroList(slot0)
	return slot0.heroList
end

function slot0.GetSortedHeroList(slot0)
	return HeroTools.Sort(slot0:GetHeroList())
end

function slot0.GetAdvanceHeroData(slot0, slot1)
	return slot0.heroList[slot1]
end

function slot0.GetCurCfgByIndex(slot0, slot1)
	slot4 = nil

	for slot8, slot9 in pairs(AdvanceTestCfg.get_id_list_by_activity_id[AdvanceTestData.mainActivityID]) do
		if AdvanceTestCfg[slot9].stage_type == slot1 then
			slot4 = AdvanceTestCfg[slot9]

			break
		end
	end

	return slot4
end

function slot0.SetHeroTeam(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.GetHeroTeam(slot0, slot1)
	slot2 = uv0[slot1] or {}

	return {
		slot2[1] or 0,
		slot2[2] or 0,
		slot2[3] or 0
	}
end

function slot0.SetHeroListByDifficult(slot0, slot1)
	slot2 = slot0:GetCurCfgByIndex(slot1)

	for slot8, slot9 in pairs(slot0.heroList) do
		slot9.star = slot2.character

		if slot9.servant_uid ~= 0 and slot9.unlock == 1 then
			slot9.servantInfo.stage = slot2.weapon
		end
	end
end

function slot0.GetisActivityOpen(slot0)
	return slot0.isActivityOpen
end

function slot0.OnReceviedAdvanceTestData(slot0, slot1)
	if slot1 == nil then
		slot0.isActivityOpen = false
	else
		if slot0.scoreList == nil then
			slot0.scoreList = {}
		end

		slot0.isActivityOpen = true
		slot0.mainActivityID = slot1.activity_id
		slot0.subActivityList = AdvanceTestCfg.get_id_list_by_activity_id[slot0.mainActivityID]

		for slot5, slot6 in ipairs(slot1.stage_list) do
			slot0.scoreList[AdvanceTestCfg[slot0.subActivityList[slot5]].stage_type] = slot6.history_max_score
		end
	end
end

function slot0.OnReceviedBattleResult(slot0, slot1)
	slot0.battleResultScore = slot1.score
	slot0.scoreList[AdvanceTestCfg[slot1.id].stage_type] = slot1.history_max_score
end

function slot0.GetBattleResultScore(slot0)
	return slot0.battleResultScore
end

function slot0.GetHistortyMaxScoreByIndex(slot0, slot1)
	if not slot0.scoreList or not slot0.scoreList[slot1] then
		return -1
	end

	return slot0.scoreList[slot1]
end

slot4 = ({
	ALL = 1,
	GUILD = 2
}).ALL

function slot0.GetCurActivityID(slot0)
	for slot6, slot7 in pairs(ActivityCfg[slot0.mainActivityID].sub_activity_list) do
		if ActivityData:GetActivityData(slot7).startTime <= manager.time:GetServerTime() and manager.time:GetServerTime() < slot8.stopTime then
			return slot7
		end
	end

	return 0
end

function slot0.GetRankTypeConst(slot0)
	return uv0
end

function slot0.GetCurRankType(slot0)
	return uv0
end

function slot0.SetCurRankType(slot0, slot1)
	uv0 = slot1
end

return slot0
