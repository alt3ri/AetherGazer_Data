slot1 = class("HeroTeamInfoBossView", import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView"))

function slot1.OnEnter(slot0)
	slot0.bossIndex_ = slot0.params_.bossIndex

	uv0.super.OnEnter(slot0)
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)
	slot2:SetHeroLock(table.keyof(slot0.lockHeroList_, slot0.heroDataList_[slot1].id) ~= nil)
	slot2:SetChallengeFlag(slot0:IsCurrentBossLock(slot3))
end

function slot1.GetDefaultHeroData(slot0)
	if SectionSelectHeroTools.GetCurSelectHeroData() and slot1.id ~= 0 then
		return slot1
	end

	if (slot0.heroTeam_[slot0.params_.selectHeroPos] or 0) == 0 then
		for slot6, slot7 in ipairs(slot0.heroDataList_) do
			if not slot0:IsInTeam(slot7.id, slot7.trialID) and not table.keyof(slot0.lockHeroList_, slot8) then
				return slot7
			end
		end
	end

	if slot2 == 0 and #slot0.heroDataList_ > 0 then
		return slot0.heroDataList_[1]
	end

	return {
		trialID = 0,
		id = slot2,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		heroViewProxy = slot0:GetHeroViewProxy(HeroConst.HERO_DATA_TYPE.DEFAULT)
	}
end

function slot1.GetHeroList(slot0)
	slot2 = {}
	slot3 = {}
	slot4 = {}

	for slot9, slot10 in ipairs(HeroTools.Sort(HeroData:GetHeroList())) do
		if table.keyof(BossTools.GetLockHero()[slot0.bossIndex_], slot10) then
			table.insert(slot2, slot10)
		elseif table.keyof(slot0.lockHeroList_, slot10) then
			table.insert(slot3, slot10)
		else
			table.insert(slot4, slot10)
		end
	end

	table.insertto(slot2, slot4)

	slot9 = slot3

	table.insertto(slot2, slot9)

	for slot9 = 3, 1, -1 do
		if slot0.heroTeam_[slot9] ~= 0 then
			table.removebyvalue(slot2, slot0.heroTeam_[slot9])
			table.insert(slot2, 1, slot0.heroTeam_[slot9])
		end
	end

	return slot2
end

function slot1.IsCurrentBossLock(slot0, slot1)
	return table.keyof(BossTools.GetLockHero()[slot0.bossIndex_], slot1) ~= nil
end

return slot1
