slot1 = class("HeroTeamInfoCoreVerificationView", import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView"))

function slot1.GetHeroList(slot0)
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in ipairs(HeroTools.Sort(HeroData:GetHeroList())) do
		if table.keyof(slot0.lockHeroList_, slot8) then
			table.insert(slot2, slot8)
		else
			table.insert(slot3, slot8)
		end
	end

	table.insertto(slot2, slot3)

	for slot7 = 3, 1, -1 do
		if slot0.heroTeam_[slot7] ~= 0 then
			table.removebyvalue(slot2, slot0.heroTeam_[slot7])
			table.insert(slot2, 1, slot0.heroTeam_[slot7])
		end
	end

	return slot2
end

function slot1.OnJoinClick(slot0)
	slot2 = slot0.heroTrialList_

	if slot0.selectHeroData_.id == slot0.heroTeam_[slot0.params_.selectHeroPos] and slot0.selectHeroData_.trialID == slot2[slot0.params_.selectHeroPos] and slot0:IsSameHeroInTeam(slot0.selectHeroData_.id) then
		slot1[slot0.params_.selectHeroPos] = 0
		slot2[slot0.params_.selectHeroPos] = 0
	elseif slot3 then
		slot4 = 1

		for slot8, slot9 in pairs(slot1) do
			if slot9 == slot0.selectHeroData_.id then
				slot4 = slot8

				break
			end
		end

		if slot1[slot4] == slot0.selectHeroData_.id and slot2[slot4] ~= slot0.selectHeroData_.trialID then
			slot1[slot4] = slot0.selectHeroData_.id
			slot2[slot4] = slot0.selectHeroData_.trialID
		end

		slot1[slot4] = slot1[slot0.params_.selectHeroPos]
		slot1[slot0.params_.selectHeroPos] = slot1[slot4]
		slot2[slot4] = slot2[slot0.params_.selectHeroPos]
		slot2[slot0.params_.selectHeroPos] = slot2[slot4]

		HeroTools.PlayTalk(slot0.selectHeroData_.id, "team")
	else
		for slot9, slot10 in pairs(slot0.heroTeam_) do
			if not table.keyof(slot4, slot10) and slot10 ~= 0 and slot9 ~= slot0.params_.selectHeroPos then
				slot5 = #CoreVerificationData:GetLockHeroByInfoID(slot0.params_.activityID, true) + 1
			end
		end

		if not table.keyof(slot4, slot0.selectHeroData_.id) then
			slot5 = slot5 + 1
		end

		if slot5 > 6 then
			ShowTips(GetTips("ACTIVITY_CORE_VERIFICATION_HERO_LOCKED"))

			return
		end

		slot1[slot0.params_.selectHeroPos] = slot0.selectHeroData_.id
		slot2[slot0.params_.selectHeroPos] = slot0.selectHeroData_.trialID

		HeroTools.PlayTalk(slot0.selectHeroData_.id, "team")
	end

	if slot0.params_.reorder == nil or slot0.params_.reorder == true then
		for slot7 = 3, 1, -1 do
			if slot1[slot7] == 0 then
				table.remove(slot1, slot7)
				table.remove(slot2, slot7)
			end
		end

		for slot7 = 1, 3 do
			if not slot1[slot7] then
				slot1[slot7] = 0
				slot2[slot7] = 0
			end
		end
	end

	slot0:TryToChangeTeam(slot1, slot2)
end

return slot1
