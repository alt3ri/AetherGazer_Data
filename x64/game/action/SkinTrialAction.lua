manager.net:Bind(11055, function (slot0)
	SkinTrialData:InitData(slot0)
	manager.notify:Invoke(SKIN_TRIAL_UPDATE)
end)

return {
	UpdateRedPoint = function (slot0)
		if not ActivityData:GetActivityIsOpen(slot0) then
			if ActivitySkinTrialCfg.get_id_list_by_activity_id[slot0] ~= nil then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_TRIAL, slot0), 0)
			elseif ActivityData:GetActivityData(slot0).subActivityIdList ~= nil then
				for slot5, slot6 in ipairs(slot1) do
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_TRIAL, slot6), 0)
				end
			end
		end
	end,
	RequestSkinTrialReward = function (slot0)
		manager.net:SendWithLoadingNew(11066, {
			cfg_id = slot0
		}, 11067, uv0.OnRewardSuccess)
	end,
	OnRewardSuccess = function (slot0, slot1)
		SkinTrialData:OnRewardSuccess(slot1.cfg_id)

		slot2 = {}

		for slot6, slot7 in ipairs(slot0.item_list) do
			table.insert(slot2, {
				id = slot7.id,
				num = slot7.num
			})
		end

		getReward(slot2)
		manager.notify:Invoke(SKIN_TRIAL_UPDATE)
	end
}
