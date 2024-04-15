require("game.data.RankDataTemplate")

slot0 = singletonClass("RankData")
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

function slot0.SetCommonRankData(slot0, slot1, slot2, slot3)
	if not uv0[slot1] then
		uv0[slot1] = {}
	end

	slot4 = RankTemplate.New()

	slot4:InitData(slot3)

	uv0[slot1][slot2] = slot4
end

function slot0.SetGuildCommonRankData(slot0, slot1, slot2, slot3)
	if not uv0[slot1] then
		uv0[slot1] = {}
	end

	uv0[slot1][slot2] = GuildRankTemplate.New(slot3)
end

function slot0.SetActivityRankData(slot0, slot1, slot2, slot3)
	if not uv0[slot1] then
		uv0[slot1] = {}
	end

	slot4 = RankTemplate.New()

	slot4:InitData(slot3)

	uv0[slot1][slot2] = slot4
end

function slot0.SetGuildActivityRankData(slot0, slot1, slot2, slot3)
	if not uv0[slot1] then
		uv0[slot1] = {}
	end

	uv0[slot1][slot2] = GuildRankTemplate.New(slot3)
end

function slot0.SetOwnCommonRankData(slot0, slot1, slot2, slot3)
	if not uv0[slot1] then
		uv0[slot1] = {}
	end

	uv0[slot1][slot2] = uv0[slot1][slot2] or RankTemplate.New()

	uv0[slot1][slot2]:UpdateOwnData(slot3)
end

function slot0.GetRankVersion(slot0, slot1, slot2)
	if not slot0:GetCommonRank(slot1, slot2) then
		return 0
	end

	return slot3:GetRankVersion()
end

function slot0.GetActivityRankVersion(slot0, slot1, slot2)
	if not slot0:GetActivityRank(slot1, slot2) then
		return 0
	end

	return slot3:GetRankVersion()
end

function slot0.GetCommonRank(slot0, slot1, slot2)
	if slot2 == nil then
		slot2 = 0
	end

	return uv0[slot1] and uv0[slot1][slot2] or nil
end

function slot0.GetGuildCommonRank(slot0, slot1, slot2)
	if slot2 == nil then
		slot2 = 0
	end

	return uv0[slot1] and uv0[slot1][slot2] or nil
end

function slot0.GetActivityRank(slot0, slot1, slot2)
	if slot2 == nil then
		slot2 = 0
	end

	return uv0[slot1] and uv0[slot1][slot2] or nil
end

function slot0.GetGuildActivityRank(slot0, slot1, slot2)
	if slot2 == nil then
		slot2 = 0
	end

	return uv0[slot1] and uv0[slot1][slot2] or nil
end

function slot0.GetCommonRankList(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1]
	end

	return {}
end

return slot0
