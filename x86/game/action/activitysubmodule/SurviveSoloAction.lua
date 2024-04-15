slot1 = false

return {
	Init = function ()
		if uv0 then
			return
		end

		uv0 = true

		SurviveSoloData:Init()
		manager.net:Bind(61053, function (slot0)
			slot1 = slot0.activity_info

			SurviveSoloData:InitData(slot1)
			SurviveSoloAction:RefreshRedPoint(slot1.activity_id)
		end)
	end,
	InitRedPointKey = function (slot0)
		slot1 = {}
		slot2 = {}

		for slot8, slot9 in ipairs(ActivityData:GetActivityData(slot0).subActivityIdList) do
			table.insert(slot1, RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot9)
			table.insert(slot2, RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. slot9)
		end

		manager.redPoint:addGroup(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot0, slot1)
		manager.redPoint:addGroup(RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. slot0, slot2)
		manager.redPoint:addGroup(RedPointConst.SOLO_SURVIVE .. "_" .. slot0, {
			RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot0,
			RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. slot0
		})
	end,
	GetReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(61054, {
			id = slot1,
			time = slot2
		}, 61055, handler(uv0, uv0.OnGetReward))
	end,
	OnGetReward = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			SurviveSoloData:SetReward(slot2.id, slot2.time)
			getReward2(slot1.reward_list)
			slot0:RefreshRewardRedPoint(slot2.id)
			manager.notify:CallUpdateFunc(SURVIVE_SOLO_REWARD)
		else
			ShowTips(slot1.result)
		end
	end,
	RefreshRedPoint = function (slot0, slot1)
		if not ActivityData:GetActivityData(slot1) or not slot2:IsActivitying() then
			slot0:ClearRed(slot1)

			return
		end

		slot0:RefreshOpenRedPoint(slot1)
		slot0:RefreshRewardRedPoint(slot1)
	end,
	RefreshOpenRedPoint = function (slot0, slot1)
		if not SurviveSoloData:GetData(slot1) or slot2.time >= 0 then
			manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot1, 0)
		else
			manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot1, 1)
		end
	end,
	RefreshRewardRedPoint = function (slot0, slot1)
		slot3 = false

		if SurviveSoloData:GetData(slot1) then
			for slot10, slot11 in ipairs(ActivitySoloSlayerCfg[slot1].reward_item_list) do
				if slot11[1] <= slot2.time and not table.indexof(slot2.rewards, slot11[1]) then
					slot3 = true

					break
				end
			end
		else
			slot3 = false
		end

		manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. slot1, slot3 and 1 or 0)
	end,
	ClearRed = function (slot0, slot1)
		for slot7, slot8 in ipairs(ActivityData:GetActivityData(slot1).subActivityIdList) do
			manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot8, 0)
			manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. slot8, 0)
		end

		manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot1, 0)
		manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. slot1, 0)
		manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE .. "_" .. slot1, 0)
	end
}
