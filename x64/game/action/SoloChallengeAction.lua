manager.net:Bind(60031, function (slot0)
	if not uv0.initedConst[slot0.info.challenge_id] then
		SoloChallengeTools.InitConst(slot1)

		uv0.initedConst[slot1] = true
	end

	SoloChallengeData:SetData(slot0)
end)

return {
	initedConst = {},
	RequireReceive = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(60034, {
			activity_id = slot0,
			difficult = ActivitySoloChallengeCfg[slot0].stage_id[slot1][1]
		}, 60035, function (slot0)
			uv0(slot0)
		end)
	end,
	SaveDifficulty = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(60038, {
			activity_id = slot0,
			difficult = ActivitySoloChallengeCfg[slot0].stage_id[slot1][1]
		}, 60039, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 ~= nil then
					uv0(slot0, uv1)
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ResetData = function (slot0, slot1)
		manager.net:SendWithLoadingNew(60036, {
			activity_id = slot0
		}, 60037, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 ~= nil then
					uv0(slot0, uv1)
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	InitRedPoint = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(ActivityCfg[slot0].sub_activity_list) do
			table.insert(slot1, string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, slot0, slot6))
		end

		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.SOLO_CHALLENGE, slot0), slot1)
	end,
	CloseRedPoint = function (slot0)
		if ActivityData:GetActivityIsOpen(slot0) then
			return
		end

		for slot4, slot5 in ipairs(ActivityCfg[slot0].sub_activity_list) do
			manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, slot0, slot5), 0)
		end
	end
}
