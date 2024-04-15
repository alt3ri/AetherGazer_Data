manager.net:Bind(11065, function (slot0)
	ParkourAction.UpdateCollect(slot0)
	ParkourData:InitParkourCollectData(slot0)
	ParkourAction.UpdateRedPoint(slot0.activity_id)
end)
manager.net:Bind(11061, function (slot0)
	ParkourData:InitParkourData(slot0)
	ParkourAction.CheckEntrustRewardRedPoint(slot0.activity_id)

	for slot5, slot6 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.PARKOUR] or {}) do
		if not ParkourData:GetRead(slot6) and table.indexof(ActivityCfg[slot6].sub_activity_list, slot0.activity_id) then
			ParkourAction.CheckPardourEntrustRedPoint(slot6)
		end
	end
end)

return {
	QueryParkourStarReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(11062, {
			activity_id = slot0,
			treasure_id = slot1
		}, 11063, uv0.OnParkourStarRewardCallBack)
	end,
	OnParkourStarRewardCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			getReward2(slot0.item_list)
			ParkourData:SetParkourEntrustReward(slot1.activity_id, slot1.treasure_id)
			ParkourAction.CheckEntrustRewardRedPoint(slot1.activity_id)
			manager.notify:CallUpdateFunc(PARKOUR_REWARD)
		else
			ShowTips(slot0.result)
		end
	end,
	UpdateRedPoint = function (slot0)
		ParkourAction.CheckPardourCollectRedPoint(slot0)

		if not ParkourData:GetRead(slot0) then
			ParkourAction.CheckPardourEntrustRedPoint(slot0)
		end
	end,
	UpdateCollect = function (slot0)
		if ParkourData:GetParkourCollectList()[slot0.activity_id] then
			for slot7, slot8 in ipairs(slot0.item_list) do
				slot9 = {}

				if not table.indexof(slot3, slot8) then
					table.insert(slot9, slot8)
				end

				if #slot9 > 0 then
					slot10 = ParkourData:GetCollectRedList(slot1)

					table.insertto(slot10, slot9)
					saveData("Parkour", tostring(slot1), slot10)
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_COLLECT, slot1), 1)
				end
			end
		end
	end,
	CheckPardourCollectRedPoint = function (slot0)
		if ActivityCfg[slot0] then
			for slot7, slot8 in pairs(slot1.sub_activity_list) do
				if table.indexof(ParkourData:GetCollectRedList(slot0), ActivityParkourCfg[slot8].specail_item) then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_COLLECT, slot0), 1)

					return
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_COLLECT, slot0), 0)
	end,
	UpdateParkourRedPoint = function (slot0, slot1)
		for slot6, slot7 in pairs(ActivityCfg[slot1].sub_activity_list) do
			ParkourAction.CheckEntrustRewardRedPoint(slot7)
		end
	end,
	CheckEntrustRewardRedPoint = function (slot0)
		if not ActivityData:GetActivityIsOpen(slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, slot0), 0)

			return
		end

		if ParkourData:GetParkourEntrustData(slot0) then
			if table.indexof(slot1.stars, 4) then
				slot3 = #slot1.stars - 1

				if not table.indexof(slot1.rewards, slot2) then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, slot0), 1)

					return
				end
			end

			for slot7 = 1, slot3 do
				if not table.indexof(slot1.rewards, slot7) then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, slot0), 1)

					return
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, slot0), 0)
	end,
	CheckPardourEntrustRedPoint = function (slot0)
		for slot5, slot6 in pairs(ActivityCfg[slot0].sub_activity_list) do
			if ActivityData:GetActivityIsOpen(slot6) and ParkourData:GetAllStarCount(slot6) == 0 then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST, slot0), 1)

				return
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST, slot0), 0)
	end,
	SetParkourRead = function (slot0)
		if manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST, slot0)) == 1 then
			ParkourData:SetRead(slot0)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST, slot0), 0)
		end
	end
}
