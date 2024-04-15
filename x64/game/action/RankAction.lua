return {
	QueryCommonRank = function (slot0, slot1, slot2)
		slot1 = slot1 or 0

		manager.net:SendWithLoadingNew(69000, {
			rank_id = slot0,
			children_id = slot1,
			start = 1,
			stop = 100,
			version = RankData:GetRankVersion(slot0, slot1)
		}, 69001, function (slot0, slot1)
			uv0.OnQueryCommonRankBack(slot0, slot1, uv1)
		end)
	end,
	OnQueryCommonRankBack = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			if slot0.version ~= slot1.version or slot1.version == 0 then
				RankData:SetCommonRankData(slot1.rank_id, slot1.children_id, slot0)
			end

			if slot2 then
				slot2(slot1.rank_id, slot1.children_id)
			end

			manager.notify:CallUpdateFunc(RANK_UPDATE, slot1.rank_id)
		elseif slot0.result == 5 then
			if slot2 then
				slot2(slot1.rank_id, slot1.children_id)
			end

			manager.notify:CallUpdateFunc(RANK_UPDATE, slot1.rank_id)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryGuildCommonRank = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(33300, {
			rank_id = slot0,
			children_id = slot1 or 0
		}, 33301, function (slot0, slot1)
			uv0.OnQueryGuildCommonRankBack(slot0, slot1, uv1)
		end)
	end,
	OnQueryGuildCommonRankBack = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			RankData:SetGuildCommonRankData(slot1.rank_id, slot1.children_id, slot0)

			if slot2 then
				slot2(slot1.rank_id, slot1.children_id)
			end

			manager.notify:CallUpdateFunc(RANK_UPDATE, slot1.rank_id)
		elseif slot0.result == 5 then
			if slot2 then
				slot2(slot1.rank_id, slot1.children_id)
			end

			manager.notify:CallUpdateFunc(RANK_UPDATE, slot1.rank_id)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryActivityRank = function (slot0, slot1, slot2, slot3)
		slot1 = slot1 or 0
		slot4 = 1

		if slot3 == nil or slot3 > 1 then
			slot3 = 100
		end

		manager.net:SendWithLoadingNew(69004, {
			activity_id = slot0,
			children_id = slot1,
			start = slot4,
			stop = slot3,
			version = RankData:GetActivityRankVersion(slot0, slot1)
		}, 69005, function (slot0, slot1)
			uv0.OnQueryActivityRankBack(slot0, slot1, uv1)
		end)
	end,
	OnQueryActivityRankBack = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			if slot0.version ~= slot1.version or slot1.version == 0 then
				RankData:SetActivityRankData(slot1.activity_id, slot1.children_id, slot0)
			end

			if slot2 then
				slot2(slot1.rank_id, slot1.children_id)
			end

			manager.notify:CallUpdateFunc(RANK_UPDATE, slot1.activity_id)
		elseif slot0.result == 5 then
			if slot2 then
				slot2(slot1.rank_id, slot1.children_id)
			end

			manager.notify:CallUpdateFunc(RANK_UPDATE, slot1.rank_id)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryActivityRankWitchCallBack = function (slot0, slot1, slot2)
		slot1 = slot1 or 0

		manager.net:SendWithLoadingNew(69004, {
			activity_id = slot0,
			children_id = slot1,
			start = 1,
			stop = 100,
			version = RankData:GetActivityRankVersion(slot0, slot1)
		}, 69005, function (slot0)
			if isSuccess(slot0.result) then
				RankData:SetActivityRankData(uv0, uv1, slot0)
				uv2()
			elseif slot0.result == 5 then
				uv2()
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	QueryGuildActivityRank = function (slot0, slot1)
		manager.net:SendWithLoadingNew(33302, {
			activity_id = slot0,
			children_id = slot1 or 0
		}, 33303, uv0.OnQueryGuildActivityRankBack)
	end,
	OnQueryGuildActivityRankBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			RankData:SetGuildActivityRankData(slot1.activity_id, slot1.children_id, slot0)
			manager.notify:CallUpdateFunc(RANK_UPDATE, slot1.activity_id)
		elseif slot0.result == 5 then
			manager.notify:CallUpdateFunc(RANK_UPDATE, slot1.rank_id)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryGuildActivityRankWitchCallBack = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(33302, {
			activity_id = slot0,
			children_id = slot1 or 0
		}, 33303, function (slot0)
			if isSuccess(slot0.result) then
				RankData:SetGuildActivityRankData(uv0, uv1, slot0)
				uv2()
			elseif slot0.result ~= 5 then
				ShowTips(slot0.result)
			end
		end)
	end,
	QueryOwnCommonRank = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(69002, {
			rank_id = slot0,
			children_id_list = slot1 or {
				0
			}
		}, 69003, function (slot0, slot1)
			uv0.OnQueryOwnCommonRankBack(slot0, slot1, uv1)
		end)
	end,
	OnQueryOwnCommonRankBack = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			for slot6, slot7 in ipairs(slot0.children_rank_list) do
				RankData:SetOwnCommonRankData(slot1.rank_id, slot7.children_id, slot7)
			end

			if slot2 then
				slot2()
			end

			manager.notify:CallUpdateFunc(RANK_UPDATE, slot1.rank_id)
		elseif slot0.result == 5 then
			if slot2 then
				slot2()
			end

			manager.notify:CallUpdateFunc(RANK_UPDATE, slot1.rank_id)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryActivityAllRank = function (slot0, slot1)
		manager.net:SendWithLoadingNew(69006, {
			activity_id = slot0
		}, 69007, function (slot0)
			if isSuccess(slot0.result) then
				for slot4, slot5 in ipairs(slot0.children_rank_list) do
					RankData:SetActivityRankData(uv0, slot5.children_id, slot5)
				end

				uv1()
			elseif slot0.result == 5 then
				if callBack then
					callBack()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end
}
