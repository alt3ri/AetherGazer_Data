manager.net:Bind(76001, function (slot0)
	KagutsuchiTalentData:InitData(slot0)
end)

return {
	UpgradeTalent = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(76004, {
			activity_id = KagutsuchiWorkData:GetServerActivityID(),
			talent_id = slot1
		}, 76005, function (slot0, slot1)
			uv0:OnUpgradeTalent(slot0, slot1, uv1)
		end)
	end,
	OnUpgradeTalent = function (slot0, slot1, slot2, slot3)
		if not isSuccess(slot1.result) then
			ShowTips(slot1.result)

			return
		end

		KagutsuchiTalentData:UpgradeTalent(slot2.talent_id)
		slot3(slot1, slot2)
	end,
	InitRedPoint = function (slot0, slot1)
		slot0.BannedRedPoint_ = slot0.BannedRedPoint_ or {}

		if slot0.lastFreshTime_ and manager.time:GetServerTime() < slot0.lastFreshTime_ then
			slot0.BannedRedPoint_ = {}
		end

		slot0.lastFreshTime_ = manager.time:GetNextFreshTime()

		slot0:UpdateRedPoint(slot1.activity_id)
	end,
	UpdateRedPoint = function (slot0, slot1)
		slot3 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_TALENT, ActivityTools.GetRedPointKey(slot1) .. slot1)
		slot4 = ActivityData:GetActivityData(slot1)

		if not ActivityData:GetActivityIsOpen(slot1) then
			manager.redPoint:setTip(slot3, 0)

			return
		end

		if slot0.BannedRedPoint_[slot3] then
			manager.redPoint:setTip(slot3, 0)

			return
		end

		slot5 = false
		slot8 = KagutsuchiTalentData
		slot10 = slot8

		for slot9, slot10 in ipairs(slot8.GetTalentIdList(slot10)) do
			if KagutsuchiTalentData:CanUpgrade(slot10) then
				slot5 = true

				break
			end
		end

		manager.redPoint:setTip(slot3, slot5 and 1 or 0)
	end,
	BanRedPoint = function (slot0, slot1)
		slot0.BannedRedPoint_[slot1] = true
	end
}
