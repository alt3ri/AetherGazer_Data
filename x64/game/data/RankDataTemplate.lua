RankConst = {
	RANK_ID = {
		ABYSS = 3,
		SOLOHEARTDEMON = 5,
		MATRIX = 2,
		POLYHERON = 4,
		MYTHIC = 1
	}
}
RankTemplate = class("CommonRankTemplate")

function RankTemplate.Ctor(slot0)
	slot0.rankList = {}
	slot0.curRank = nil
	slot0.total_people = 1
	slot0.rank_version = 0
end

function RankTemplate.InitData(slot0, slot1)
	slot0.rankList = {}

	for slot5, slot6 in ipairs(slot1.rank_list or {}) do
		table.insert(slot0.rankList, RankInfoTemplate.New(slot6))
	end

	table.sort(slot0.rankList, function (slot0, slot1)
		return slot0.rank < slot1.rank
	end)

	if slot1.my_rank then
		slot0.curRank = RankInfoTemplate.New(slot1.my_rank, true)
	end

	slot0.total_people = slot1.total or 1
	slot0.rank_version = slot1.version or 0
end

function RankTemplate.UpdateOwnData(slot0, slot1)
	slot0.curRank = RankInfoTemplate.New(slot1.my_rank, true)
	slot0.total_people = slot1.total or 1
end

function RankTemplate.GetRankVersion(slot0)
	return slot0.rank_version
end

function RankTemplate.GetCurRankDes(slot0)
	if not slot0.curRank then
		return GetTips("MATRIX_RANK_NO_RANK"), GetTips("MATRIX_RANK_NO_INFO")
	end

	slot1 = ""
	slot2 = ""

	if slot0.curRank.rank == 0 then
		slot1 = GetTips("MATRIX_RANK_NO_RANK")
		slot2 = GetTips("MATRIX_RANK_NO_INFO")
	elseif slot3 >= 1 and slot3 <= 100 then
		slot1 = tostring(slot0.curRank.rank)
		slot2 = tostring(slot0.curRank.score)
	else
		slot1 = string.format("%.2f", slot0.curRank.rank / slot0.total_people * 100) .. "%"
		slot2 = tostring(slot0.curRank.score)
	end

	return slot1, slot2
end

GuildRankTemplate = class("ActivityRankTemplate")

function GuildRankTemplate.Ctor(slot0, slot1)
	slot2 = PlayerData:GetPlayerInfo()
	slot0.rankList = {}

	for slot6, slot7 in ipairs(slot1.rank_list or {}) do
		table.insert(slot0.rankList, RankInfoTemplate.New(slot7))

		if slot2 and slot8.user_id == slot2.userID then
			slot0.curRank = slot8
		end
	end
end

function GuildRankTemplate.GetCurRankDes(slot0)
	if not slot0.curRank then
		return GetTips("MATRIX_RANK_NO_RANK"), GetTips("MATRIX_RANK_NO_INFO")
	end

	slot1 = ""
	slot2 = ""

	if slot0.curRank.rank == 0 then
		slot1 = GetTips("MATRIX_RANK_NO_RANK")
		slot2 = GetTips("MATRIX_RANK_NO_INFO")
	elseif slot3 >= 1 and slot3 <= 100 then
		slot1 = tostring(slot0.curRank.rank)
		slot2 = tostring(slot0.curRank.score)
	else
		slot1 = not GuildData:GetGuildInfo() and "0%" or string.format("%.2f", slot0.curRank.rank / slot4.memberCnt * 100) .. "%"
		slot2 = tostring(slot0.curRank.score)
	end

	return slot1, slot2
end

RankInfoTemplate = class("RankInfoTemplate")

function RankInfoTemplate.Ctor(slot0, slot1)
	slot0.user_id = slot1.user_id
	slot0.score = slot1.score
	slot0.difficulty = slot1.difficulty
	slot0.rank = slot1.rank
	slot0.timestamp = slot1.timestamp

	if PlayerData:GetPlayerInfo() and slot0.user_id == slot2.userID then
		slot0.nick = slot2.nick
		slot0.portrait = slot2.portrait
		slot0.frame = slot2.icon_frame
	else
		slot0.nick = slot1.nick
		slot0.portrait = slot1.portrait
		slot0.frame = slot1.frame
	end

	slot0.stage_team_list = {}

	for slot6, slot7 in ipairs(slot1.stage_team_list) do
		slot8 = slot7.stage_id or 0
		slot9 = {}

		for slot13, slot14 in ipairs(slot7.team_info_list) do
			slot15 = slot14.index
			slot16 = {}

			for slot20, slot21 in ipairs(slot14.hero_info_list) do
				table.insert(slot16, {
					hero_id = slot21.hero_id,
					skin_id = slot21.skin_id
				})
			end

			slot9[slot15] = slot16
		end

		slot0.stage_team_list[slot8] = slot9
	end

	slot0.staticInfo = {
		clearTime = slot1.static_info.clear_time,
		hitNumber = slot1.static_info.hit_num
	}
	slot0.extraInfo = {}
	slot7 = slot1.extra_info

	for slot6, slot7 in ipairs(cleanProtoTable(slot7)) do
		slot0.extraInfo[slot7.key] = slot7.value
	end
end

function RankInfoTemplate.GetSingleSelectHeroList(slot0)
	if not slot0.stage_team_list[0] then
		return {}
	end

	return slot1[1] or {}
end
