slot1 = class("ActivityRaceHeroTeamInfoView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.OnEnter(slot0)
	manager.ui:SetMainCamera("hero")

	if slot0.params_.isEnter then
		if slot0.filterView_ then
			slot0.filterView_:Reset()
		end

		slot0.params_.isEnter = false
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	SetActive(slot0.infoBtn_.gameObject, true)

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnEnter()
	end

	slot0:GetHeroTeam()

	slot0.trialHeroList_ = GetTrialHeroList(slot0.params_.stageType, slot0.params_.stageID, slot0.params_.activityID)
	slot7 = slot0

	for slot6, slot7 in pairs(slot0.GetHeroList(slot7)) do
		if HeroCfg[slot7].race == ActivityRaceCfg[slot0.params_.activityID].race_id then
			table.insert({}, {
				trialID = 0,
				id = slot7,
				type = HeroConst.HERO_DATA_TYPE.DEFAULT
			})
		end
	end

	slot3 = {}

	if type(BattleStageTools.GetRestrictHeroList(slot0.params_.stageType, slot0.params_.stageID)) == "table" then
		if slot4[slot0.params_.selectHeroPos][1] then
			slot1 = {}
		end

		for slot8, slot9 in pairs(slot4) do
			if slot9[1] ~= 0 and HeroCfg[slot9[1]] and table.keyof(HeroCfg.get_id_list_by_private[0], slot9[1]) then
				table.insert(slot1, {
					id = slot9[1],
					trialID = slot9[2],
					type = HeroConst.HERO_DATA_TYPE.CUSTOM
				})
				table.insert(slot3, slot9[2])
			end
		end
	end

	slot0.filterView_:SetHeroDataList(slot1)

	slot0.selectID_, slot0.selectTrialID_ = slot0:GetDefaultHeroData()

	slot0:SelectHero(slot0.selectID_, slot0.selectTrialID_)
	slot0.heroHeadList_:StartScroll(#slot0.heroDataList_, table.keyof(slot0.heroDataList_, slot0.selectID_))
end

return slot1
