slot1 = class("HeroTeamInfoNewWarChessView", import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView"))

function slot1.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function slot1.RefreshHeroDataList(slot0)
	slot0.trialHeroList_ = NewWarChessData:GetHeroIDList()

	for slot6, slot7 in pairs(slot0.trialHeroList_) do
		table.insert({}, {
			id = HeroStandardSystemCfg[slot7].hero_id,
			trialID = slot7,
			type = HeroConst.HERO_DATA_TYPE.TRIAL,
			heroViewProxy = slot0:GetHeroViewProxy(HeroConst.HERO_DATA_TYPE.TRIAL)
		})
		table.insert({}, slot7)
	end

	for slot6, slot7 in pairs(slot0.heroViewProxyDic_) do
		slot7:SetTempHeroList(slot2)
	end

	slot0.filterView_:SetHeroIdList(slot1)
end

function slot1.GetDefaultHeroData(slot0)
	if SectionSelectHeroTools.GetCurSelectHeroData() and slot1.id ~= 0 then
		return slot1
	end

	if (slot0.heroTeam_[slot0.params_.selectHeroPos] or 0) == 0 then
		for slot6, slot7 in ipairs(slot0.heroDataList_) do
			slot8 = slot7.id

			if not slot0:IsInTeam(slot8, slot7.trialID) and NewWarChessData:GetHeroHp(slot8) > 0 then
				return slot7
			end
		end
	end

	if slot2 == 0 then
		for slot6, slot7 in pairs(slot0.heroDataList_) do
			if NewWarChessData:GetHeroHp(slot7.id) > 0 then
				return slot7
			end
		end
	end

	return {
		trialID = 0,
		id = slot2,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		heroViewProxy = slot0:GetHeroViewProxy(HeroConst.HERO_DATA_TYPE.DEFAULT)
	}
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	slot2:SetSectionHeroData(slot0.heroDataList_[slot1], slot0.trialHeroList_)
	slot2:SetSelected(slot2.heroId_ == slot0.selectHeroData_.id and slot2.trialID_ == slot0.selectHeroData_.trialID)
	slot2:RegisterClickListener(function ()
		if uv0.backFlag_ then
			return
		end

		if NewWarChessData:GetHeroHp(uv1.heroId_) <= 0 then
			ShowTips("ACTIVITY_NEW_WARCHESS_HERO_DIE")

			return
		end

		uv0:SelectHero(uv0.heroDataList_[uv2])
	end)
	slot2:SetInTeamFlag(slot0:IsInTeam(slot0.heroDataList_[slot1].id, slot0.heroDataList_[slot1].trialID))

	slot5, slot6 = slot0.sectionProxy_:CustomGetHeroHP(nil, slot2.heroId_)

	slot2:RefreshHpValue(slot6)
	slot2:SetHp(true)

	if slot5 <= 0 then
		slot2:SetLocking(true)
	else
		slot2:SetLocking(false)
	end
end

return slot1
