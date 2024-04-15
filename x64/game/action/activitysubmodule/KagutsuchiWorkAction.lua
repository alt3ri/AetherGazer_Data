manager.net:Bind(76001, function (slot0)
	KagutsuchiWorkData:InitData(slot0)
	Timer.New(function ()
		KagutsuchiTalentAction:InitRedPoint(uv0)
		KagutsuchiWorkAction:InitRedPoint(uv0)
	end, 1, 0):Start()
end)

return {
	StartEntrust = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(76002, {
			activity_id = KagutsuchiWorkData:GetServerActivityID(),
			grid_id = slot1,
			hero_list = slot2
		}, 76003, function (slot0, slot1)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)

				return
			end

			uv0:UpdateEntrustedHeros(slot1.hero_list)
			uv0:UpdateEntrustGridClearState(slot1.grid_id)
			uv1(slot0)
		end)
	end,
	UpdateEntrustedHeros = function (slot0, slot1)
		KagutsuchiWorkData:UpdateEntrustedHeros(slot1)
	end,
	UpdateEntrustGridClearState = function (slot0, slot1)
		KagutsuchiWorkData:SetGridClear(slot1)
	end,
	InitRedPoint = function (slot0, slot1)
		slot0.BannedRedPoint_ = slot0.BannedRedPoint_ or {}

		slot0:UpdateRedPoint(slot1.activity_id)
	end,
	UpdateRedPoint = function (slot0, slot1)
		slot2 = ActivityTools.GetParentActivityID(slot1)
		slot3 = ActivityTools.GetRedPointKey(slot1) .. slot1
		slot8 = string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA_REWARDED, HanafudaData:GetActivityID())
		slot13 = {}

		table.insert(slot13, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_REWARD, slot3))
		table.insert(slot13, slot8)
		manager.redPoint:addGroup(slot3, slot13)

		slot14 = {}

		table.insert(slot14, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_HANAFUDA, slot3))
		table.insert(slot14, slot8)
		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA, slot3), slot14)

		slot15 = {}

		table.insert(slot15, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_ONE, slot3))
		table.insert(slot15, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_MULTI, slot3))
		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA, slot3), slot15)

		if not ActivityData:GetActivityIsOpen(slot1) then
			manager.redPoint:setTip(slot5, 0)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_FISH, slot3), 0)
			manager.redPoint:setTip(slot7, 0)

			return
		end

		slot16 = KagutsuchiWorkData:IsAllClear()
		slot18 = KagutsuchiGachaData:GetPoolRemains(KagutsuchiGachaData:GetPoolIds(ActivityConst.KAGUTSUCHI_ACTIVITY_REWARD)[1]) > 0

		if slot0.BannedRedPoint_[slot5] then
			manager.redPoint:setTip(slot5, 0)
		else
			manager.redPoint:setTip(slot5, not slot16 and slot18 and 1 or 0)
		end

		slot19 = GameSetting.activity_kagutsuchi_battle_fatigue_max.value[1] <= KagutsuchiWorkData:GetStamina()

		if slot0.BannedRedPoint_[slot6] then
			manager.redPoint:setTip(slot6, 0)
		else
			manager.redPoint:setTip(slot6, KagutsuchiFishingEventData:GetRestGameCount() > 0 and not slot19 and not slot16 and slot18 and 1 or 0)
		end

		if slot0.BannedRedPoint_[slot7] then
			manager.redPoint:setTip(slot7, 0)
		else
			manager.redPoint:setTip(slot7, not slot19 and not slot16 and slot18 and 1 or 0)
		end

		manager.redPoint:setTip(slot9, KagutsuchiGachaData:GetMaxDrawTimes(slot17) == 1 and 1 or 0)
		manager.redPoint:setTip(slot10, slot20 > 1 and 1 or 0)
	end,
	BanRedPoint = function (slot0, slot1)
		slot0.BannedRedPoint_[slot1] = true
	end
}
