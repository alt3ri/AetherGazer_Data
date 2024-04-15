slot1 = false

manager.notify:RegistListener(ACTIVITY_REWARD_GET, function (slot0)
	ActivityAffixSelectData:OnScoreRewardGet(slot0.point_reward_id_list)
	uv0.UpdateScoreBonusRedPoint()
end)
manager.net:Bind(11073, function (slot0)
	ActivityAffixSelectData:OnPushMainActivityData(slot0)
end)
manager.net:Bind(11075, function (slot0)
	ActivityAffixSelectData:OnPushSubActivityData(slot0)
	uv0.UpdateFirstBonusRedPoint()
	uv0.UpdateUnPassRedPoint()
	uv0.UpdateScoreBonusRedPoint()
end)

return {
	Init = function ()
		uv0 = false
	end,
	InitRedPointKey = function (slot0)
		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.AFFIX_SELECT, slot0), {
			string.format("%s_%s", RedPointConst.AFFIX_SELECT_BONUS_UNPASS, slot0),
			string.format("%s_%s", RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET, slot0),
			string.format("%s_%s", RedPointConst.AFFIX_SELECT_SCORE_BONUS_CAN_GET, slot0)
		})
	end,
	UpdateUnPassRedPoint = function ()
		for slot4, slot5 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_AFFIX_SELECT] or {}) do
			slot6 = false

			if ActivityData:GetActivityIsOpen(slot5) then
				slot7 = ActivityAffixSelectData:GetOpenedSubActivityDatas(slot5)

				if not uv0 then
					for slot11, slot12 in pairs(slot7) do
						if ActivityData:GetActivityIsOpen(slot12.activityId) and slot12.clearState == 1 then
							slot6 = true

							break
						end
					end
				end
			end

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.AFFIX_SELECT_BONUS_UNPASS, slot5), slot6 and 1 or 0)
		end
	end,
	ReadUnPassRedPoint = function ()
		uv0 = true

		uv1.UpdateUnPassRedPoint()
	end,
	UpdateFirstBonusRedPoint = function ()
		for slot4, slot5 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_AFFIX_SELECT] or {}) do
			slot6 = false

			if ActivityData:GetActivityIsOpen(slot5) then
				for slot11, slot12 in pairs(ActivityAffixSelectData:GetOpenedSubActivityDatas(slot5)) do
					if ActivityData:GetActivityIsOpen(slot12.activityId) and slot12.clearState == 2 then
						slot6 = true

						break
					end
				end
			end

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET, slot5), slot6 and 1 or 0)
		end
	end,
	UpdateScoreBonusRedPoint = function ()
		for slot4, slot5 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_AFFIX_SELECT] or {}) do
			slot6 = false

			if ActivityData:GetActivityIsOpen(slot5) then
				for slot11, slot12 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot5]) do
					slot13 = ActivityPointRewardCfg[slot12]

					if ActivityData:GetActivityIsOpen(slot13.activity_id) and slot13.need <= ActivityAffixSelectData:GetTotalScore(slot5) and not ActivityAffixSelectData:HaveGotScoreReward(slot5, slot12) then
						slot6 = true

						break
					end
				end
			end

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.AFFIX_SELECT_SCORE_BONUS_CAN_GET, slot5), slot6 and 1 or 0)
		end
	end,
	GetFirstPassReward = function (slot0)
		manager.net:SendWithLoadingNew(11076, {
			id = slot0
		}, 11077, uv0.OnGetFirstPassRewardCallback)
	end,
	OnGetFirstPassRewardCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityAffixSelectData:OnGetFirstBonus(slot1.id)
			getReward2(slot0.item_list)
			uv0.UpdateFirstBonusRedPoint()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	SetAffixList = function (slot0, slot1)
		manager.net:SendWithLoadingNew(11078, {
			id = slot0,
			affix_id_list = slot1
		}, 11079, uv0.OnSelectAffixListCallback)
	end,
	OnSelectAffixListCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityAffixSelectData:OnSetAffix(slot1.id, slot1.affix_id_list)
		else
			ShowTips(GetTips(slot0.result))
		end
	end
}
