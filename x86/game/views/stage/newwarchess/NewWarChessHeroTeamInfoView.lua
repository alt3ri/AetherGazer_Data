slot1 = class("NewWarChessHeroTeamInfoView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.OnEnter(slot0)
	slot0.roomProxy_ = slot0.params_.roomProxy

	manager.ui:SetMainCamera("hero")

	if slot0.params_.isEnter then
		if slot0.filterView_ then
			slot0.filterView_:Reset(true)
		end

		slot0.params_.isEnter = false
	end

	manager.windowBar:SwitchBar({
		BACK_BAR
	})

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnEnter()
	end

	slot0.teamInfo_ = slot0:GetHeroTeam()
	slot0.trialHeroList_ = NewWarChessData:GetHeroIDList()
	slot1 = HideInfoData.GetHeroHideList()

	for slot6, slot7 in pairs(slot0.trialHeroList_) do
		if not table.keyof(customIDList, slot7) then
			table.insert({}, {
				id = HeroStandardSystemCfg[slot7].hero_id,
				trialID = slot7,
				type = HeroConst.HERO_DATA_TYPE.TRIAL
			})
		end
	end

	slot0.filterView_:ShowDropDown(true)

	slot3 = {}

	if type(BattleStageTools.GetRestrictHeroList(slot0.params_.stageType, slot0.params_.stageID)) == "table" then
		if slot4[slot0.params_.selectHeroPos][1] then
			slot2 = {}

			slot0.filterView_:ShowDropDown(false)
		end

		for slot8, slot9 in pairs(slot4) do
			if slot9[1] ~= 0 and HeroCfg[slot9[1]] and table.keyof(HeroCfg.get_id_list_by_private[0], slot9[1]) then
				table.insert(slot2, {
					id = slot9[1],
					trialID = slot9[2],
					type = HeroConst.HERO_DATA_TYPE.CUSTOM
				})
				table.insert(slot3, slot9[2])
			end
		end
	end

	slot0.filterView_:SetHeroDataList(slot2)

	slot0.selectID_, slot0.selectTrialID_ = slot0:GetDefaultHeroData()

	slot0:SelectHero(slot0.selectID_, slot0.selectTrialID_)
	slot0.heroHeadList_:StartScroll(#slot0.heroDataList_, table.keyof(slot0.heroDataList_, slot0.selectID_))
	SetActive(slot0.favoriteBtn_.gameObject, false)
end

function slot1.GetDefaultHeroData(slot0)
	slot1, slot2 = BattleFieldData:GetCurrentSelectHeroID()

	if slot1 ~= 0 then
		return slot1, slot2
	end

	if (slot0.heroTeam_[slot0.params_.selectHeroPos] or 0) == 0 then
		for slot7, slot8 in pairs(slot0.heroDataList_) do
			slot9 = slot8.id

			if not slot0:IsInTeam(slot9, slot8.trialID) and NewWarChessData:GetHeroHp(slot9) > 0 then
				return slot9, slot8.trialID
			end
		end
	end

	if slot3 == 0 then
		for slot7, slot8 in pairs(slot0.heroDataList_) do
			if NewWarChessData:GetHeroHp(slot8.id) > 0 then
				return slot8.id, slot8.trialID
			end
		end
	end

	return slot3, 0
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	slot4 = slot0.heroDataList_[slot1].trialID

	slot2:SetRedPointEnable(false)

	slot2.gameObject_.name = tostring(slot0.heroDataList_[slot1].id)

	if slot0.heroDataList_[slot1].type == HeroConst.HERO_DATA_TYPE.DEFAULT then
		slot2:SetHeroData(slot3, HeroConst.HERO_DATA_TYPE.DEFAULT, {
			tempHeroList = slot0.trialHeroList_
		})
		slot2:SetTrial(false)
	elseif slot5 == HeroConst.HERO_DATA_TYPE.TRIAL then
		slot2:SetHeroData(slot4, HeroConst.HERO_DATA_TYPE.TRIAL, {
			tempHeroList = slot0.trialHeroList_
		})
		slot2:SetTrial(false)
	elseif slot5 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		slot2:SetHeroData(slot4, HeroConst.HERO_DATA_TYPE.CUSTOM, {
			tempHeroList = slot0:GetCustomHeroList()
		})
		slot2:SetTrial(false)
	elseif slot5 == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		slot2:SetHeroData(slot3, HeroConst.HERO_DATA_TYPE.ADVANCETEST, {
			tempHeroList = slot0.trialHeroList_
		})
		slot2:SetTrial(false)
	end

	slot2:SetSelected(slot2.heroId_ == slot0.selectID_ and slot2.trialID_ == slot0.selectTrialID_)
	slot2:SetInTeamFlag(slot0:IsInTeam(slot3, slot4))
	slot2:SetLove(slot5 ~= HeroConst.HERO_DATA_TYPE.DEFAULT or HeroData:IsFavorite(slot3) == false)

	slot6 = NewWarChessData:GetHeroHp(slot2.heroId_)

	slot2:RefreshHpValue(math.ceil(slot6 / NewChessConst.HERO_HP_RATE * 100))
	slot2:SetHp(true)

	if slot6 <= 0 then
		slot2:SetLocking(true)
	else
		slot2:SetLocking(false)
	end

	slot2:RegisterClickListener(function ()
		if uv0.backFlag_ then
			return
		end

		if NewWarChessData:GetHeroHp(uv1.heroId_) <= 0 then
			ShowTips("ACTIVITY_NEW_WARCHESS_HERO_DIE")

			return
		end

		uv0:SelectHero(uv1.heroId_, uv1.trialID_)
	end)
end

return slot1
