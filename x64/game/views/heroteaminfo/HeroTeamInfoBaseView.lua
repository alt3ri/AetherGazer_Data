slot0 = class("HeroTeamInfoBaseView", ReduxView)

function slot0.UIName(slot0)
	return "UI/StagePrepare/HeroTeamInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.indexof(slot0, slot1, slot2)
	for slot6 = 1, #slot1 do
		if slot1[slot6].id == slot2.id and slot1[slot6].trialID == slot2.trialID then
			return slot6
		end
	end

	return 9999
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.emptyController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "empty")
	slot0.contorller_ = ControllerUtil.GetController(slot0.joinBtn_.transform, "upgradeBtn")
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot0.heroHeadList_ = LuaList.New(handler(slot0, slot0.HeadRenderer), slot0.uiListGo_, HeroTeamHeadItem)
	slot0.filterView_ = slot0:GetFilterClass().New(slot0.filterGo_)

	slot0.filterView_:SetExtraSorter(handler(slot0, slot0.ExtraSorter))
	slot0.filterView_:SetListChangeHandler(handler(slot0, slot0.OnListChange))
end

function slot0.GetFilterClass(slot0)
	return HeroListFilterWithTrialView
end

function slot0.ExtraSorter(slot0, slot1, slot2, slot3, slot4)
	slot7 = {
		[slot11] = {
			id = slot12,
			trialID = slot0.heroTrialList_[slot11]
		}
	}

	for slot11, slot12 in pairs(slot0.heroTeam_) do
		-- Nothing
	end

	if slot0:indexof(slot7, slot1) ~= slot0:indexof(slot7, slot2) then
		return true, slot8 < slot9
	end

	if slot1.trialID ~= 0 or slot2.trialID ~= 0 then
		if slot1.trialID ~= 0 and slot2.trialID ~= 0 then
			if slot3 == 0 and slot1.star ~= slot2.star then
				if slot0.curOrder_ == "desc" then
					return true, slot2.star < slot1.star
				else
					return true, slot1.star < slot2.star
				end
			end

			if getHeroPower(slot1.trialID, true) ~= getHeroPower(slot2.trialID, true) then
				if slot4 == "desc" then
					return true, slot11 < slot10
				else
					return true, slot10 < slot11
				end
			else
				return true, slot2.trialID < slot1.trialID
			end
		else
			return true, slot2.trialID < slot1.trialID
		end
	end

	return false, false
end

function slot0.OnListChange(slot0, slot1)
	slot0.heroDataList_ = slot1

	slot0.heroHeadList_:StartScroll(#slot0.heroDataList_)

	if #slot0.heroDataList_ > 0 then
		slot0.emptyController_:SetSelectedState("false")
		slot0:SelectHero(slot0.heroDataList_[1].id, slot0.heroDataList_[1].trialID)
	else
		slot0.emptyController_:SetSelectedState("true")
	end
end

function slot0.OnEnter(slot0)
	slot0.roomProxy_ = slot0.params_.roomProxy
	slot0.type_ = slot0.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	slot0.heroViewProxy_ = HeroViewDataProxy.New(slot0.type_)

	manager.ui:SetMainCamera("hero")

	if slot0.params_.isEnter then
		if slot0.filterView_ then
			slot0.filterView_:Reset(true)
		end

		slot0.params_.isEnter = false
	end

	if slot0.params_.stageType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnEnter()
	end

	slot0.teamInfo_ = slot0:GetHeroTeam()
	slot0.trialHeroList_ = GetTrialHeroList(slot0.params_.stageType, slot0.params_.stageID, slot0.params_.activityID)
	slot1 = HideInfoData.GetHeroHideList()
	slot7 = slot0

	for slot6, slot7 in pairs(slot0.GetHeroList(slot7)) do
		table.insert({}, {
			trialID = 0,
			id = slot7,
			type = slot0.type_
		})
	end

	slot0.filterView_:ShowDropDown(true)

	slot3 = {}
	slot4, slot5 = BattleStageTools.GetRestrictHeroList(slot0.params_.stageType, slot0.params_.stageID)
	slot6 = false

	if type(slot5) == "table" and slot5[slot0.params_.selectHeroPos] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
		slot6 = true
	end

	if type(slot4) == "table" then
		if slot4[slot0.params_.selectHeroPos][1] then
			slot2 = {}

			slot0.filterView_:ShowDropDown(false)
		end

		if slot6 == true then
			if slot4[slot0.params_.selectHeroPos][1] ~= 0 and HeroCfg[slot7] and table.keyof(HeroCfg.get_id_list_by_private[0], slot7) then
				table.insert(slot2, {
					id = slot7,
					trialID = slot4[slot0.params_.selectHeroPos][2],
					type = HeroConst.HERO_DATA_TYPE.CUSTOM
				})

				if HeroTools.GetHeroIsUnlock(slot7) then
					table.insert(slot2, {
						trialID = 0,
						id = slot7,
						type = HeroConst.HERO_DATA_TYPE.DEFAULT
					})
				end
			end
		else
			for slot10, slot11 in pairs(slot4) do
				if slot11[1] ~= 0 and HeroCfg[slot11[1]] and table.keyof(HeroCfg.get_id_list_by_private[0], slot11[1]) then
					table.insert(slot2, {
						id = slot11[1],
						trialID = slot11[2],
						type = HeroConst.HERO_DATA_TYPE.CUSTOM
					})
					table.insert(slot3, slot11[2])
				end
			end
		end
	end

	for slot10, slot11 in pairs(slot0.trialHeroList_) do
		if not table.keyof(slot3, slot11) then
			table.insert(slot2, {
				id = HeroStandardSystemCfg[slot11].hero_id,
				trialID = slot11,
				type = HeroConst.HERO_DATA_TYPE.TRIAL
			})
		end
	end

	slot0.filterView_:SetHeroDataList(slot2)

	slot0.selectID_, slot0.selectTrialID_ = slot0:GetDefaultHeroData()

	slot0:SelectHero(slot0.selectID_, slot0.selectTrialID_)
	slot0.heroHeadList_:StartScroll(#slot0.heroDataList_, table.keyof(slot0.heroDataList_, slot0.selectID_))
	SetActive(slot0.favoriteBtn_.gameObject, false)
end

function slot0.OnTop(slot0)
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back(1, {
			isSorted = true
		})
	end)
end

function slot0.OnExit(slot0)
	manager.ui:ResetMainCamera()

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnExit()
	end

	if #slot0.heroDataList_ <= 0 then
		HeroData:ResetSortValue()
		slot0.filterView_:Reset()
	end

	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	if slot0.filterView_ then
		slot0.filterView_:Dispose()

		slot0.filterView_ = nil
	end

	if slot0.heroHeadList_ then
		slot0.heroHeadList_:Dispose()

		slot0.heroHeadList_ = nil
	end

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:Dispose()

		slot0.heroAvatarView_ = nil
	end

	uv0.super.Dispose(slot0)

	slot0.selectID_ = nil
	slot0.heroTeam_ = nil
	slot0.lockStateList_ = nil
	slot0.lockHeroList_ = nil
	slot0.displayGo_ = nil
	slot0.nameText_ = nil
	slot0.subNameText_ = nil
	slot0.fightPowerText_ = nil
	slot0.joinBtn_ = nil
	slot0.joinImg_ = nil
	slot0.joinText_ = nil
	slot0.infoBtn_ = nil
	slot0.uiListGo_ = nil
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		BattleFieldData:SetCurrentSelectHeroData(uv0.selectID_, uv0.selectTrialID_)

		slot0 = nil

		if uv0.selectTrialID_ ~= 0 then
			if not table.keyof(uv0:GetCustomHeroList(), uv0.selectTrialID_) then
				slot1 = uv0.trialHeroList_
			end

			slot2 = {}

			for slot6, slot7 in pairs(slot1) do
				if HeroCfg[HeroStandardSystemCfg[slot7].hero_id].hide_info == 0 then
					table.insert(slot2, slot7)
				end
			end

			slot0 = slot2
		end

		uv0:Go("/newHero", {
			isEnter = true,
			hid = uv0.selectTrialID_ ~= 0 and uv0.selectTrialID_ or uv0.selectID_,
			type = uv0.selectTrialID_ ~= 0 and HeroConst.HERO_DATA_TYPE.TRIAL or HeroConst.HERO_DATA_TYPE.DEFAULT,
			tempHeroList = slot0
		})
	end)
	slot0:AddBtnListener(slot0.joinBtn_, nil, handler(slot0, slot0.OnJoinClick))
end

function slot0.OnJoinClick(slot0)
	slot0.backFlag_ = true
	slot2 = slot0.heroTrialList_

	if slot0.selectID_ == slot0.heroTeam_[slot0.params_.selectHeroPos] and slot0.selectTrialID_ == slot2[slot0.params_.selectHeroPos] and slot0:IsSameIDInTeam(slot0.selectID_, slot0.selectTrialID_) then
		slot1[slot0.params_.selectHeroPos] = 0
		slot2[slot0.params_.selectHeroPos] = 0
	elseif slot3 then
		slot4 = 1

		for slot8, slot9 in pairs(slot1) do
			if slot9 == slot0.selectID_ then
				slot4 = slot8

				break
			end
		end

		if slot1[slot4] == slot0.selectID_ and slot2[slot4] ~= slot0.selectTrialID_ then
			slot1[slot4] = slot0.selectID_
			slot2[slot4] = slot0.selectTrialID_
		end

		slot1[slot4] = slot1[slot0.params_.selectHeroPos]
		slot1[slot0.params_.selectHeroPos] = slot1[slot4]
		slot2[slot4] = slot2[slot0.params_.selectHeroPos]
		slot2[slot0.params_.selectHeroPos] = slot2[slot4]

		HeroTools.PlayTalk(slot0.selectID_, "team")
	else
		slot1[slot0.params_.selectHeroPos] = slot0.selectID_
		slot2[slot0.params_.selectHeroPos] = slot0.selectTrialID_

		HeroTools.PlayTalk(slot0.selectID_, "team")
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

function slot0.TryToChangeTeam(slot0, slot1, slot2)
	slot0:ChangeTeam(slot1, slot2)
	slot0:OnChangeTeamSuccess()
end

function slot0.OnChangeTeamSuccess(slot0)
	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:RemoveTween()
	end

	slot0:Back(1, {
		isSorted = true
	})

	slot0.backFlag_ = false
end

function slot0.UpdateHeroView(slot0)
	slot1, slot2 = nil
	slot2 = slot0.selectID_
	slot1 = (not slot0.selectTrialID_ or slot0.selectTrialID_ == 0 or HeroStandardSystemCfg[slot0.selectTrialID_].skin_id) and HeroTools.HeroUsingSkinInfo(slot0.selectID_).id

	if slot0.selectTrialID_ and slot0.selectTrialID_ ~= 0 then
		slot0.fightPowerText_.text = getHeroPower(slot0.selectTrialID_, true)
	else
		slot0.fightPowerText_.text = slot0.heroViewProxy_:GetBattlePower(slot2)
	end

	slot0.heroAvatarView_:SetSkinId(slot1)

	slot3 = HeroCfg[slot2]
	slot0.nameText_.text = GetI18NText(slot3.name)
	slot0.subNameText_.text = GetI18NText(slot3.suffix)
end

function slot0.HeadRenderer(slot0, slot1, slot2)
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
		slot2:SetTrial(true)
	elseif slot5 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		slot2:SetHeroData(slot4, HeroConst.HERO_DATA_TYPE.CUSTOM, {
			tempHeroList = slot0:GetCustomHeroList()
		})
		slot2:SetTrial(true)
	elseif slot5 == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		slot2:SetHeroData(slot3, HeroConst.HERO_DATA_TYPE.ADVANCETEST, {
			tempHeroList = slot0.trialHeroList_
		})
		slot2:SetTrial(false)
	end

	slot2:SetSelected(slot2.heroId_ == slot0.selectID_ and slot2.trialID_ == slot0.selectTrialID_)
	slot2:SetInTeamFlag(slot0:IsInTeam(slot3, slot4))
	slot2:SetLove(slot5 ~= HeroConst.HERO_DATA_TYPE.DEFAULT or HeroData:IsFavorite(slot3) == false)

	if slot0.params_.stageType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		slot2:SetHp(false)
	else
		slot2:SetHp(false)
	end

	slot2:SetShowAttackType(false)
	slot2:RegisterClickListener(function ()
		if uv0.backFlag_ then
			return
		end

		uv0:SelectHero(uv1.heroId_, uv1.trialID_)
	end)
end

function slot0.SelectHero(slot0, slot1, slot2)
	slot0.selectID_ = slot1
	slot0.selectTrialID_ = slot2
	slot5 = slot0.heroHeadList_
	slot7 = slot5

	for slot6, slot7 in pairs(slot5.GetItemList(slot7)) do
		slot7:SetSelected(slot7.heroId_ == slot1 and slot7.trialID_ == slot2)
	end

	slot0:RefreshInfoBtn()
	slot0:UpdateHeroView()
	slot0:RefreshJoinBtn()
end

function slot0.RefreshInfoBtn(slot0)
	if slot0.infoBtn_ then
		if slot0.params_.stageType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
			SetActive(slot0.infoBtn_.gameObject, false)
		else
			SetActive(slot0.infoBtn_.gameObject, HeroCfg[slot0.selectID_].hide_info == 0)
		end
	end
end

function slot0.RefreshJoinBtn(slot0)
	slot0.joinBtn_.interactable = true
	slot1, slot2, slot3 = slot0:GetTextAndImage()
	slot0.joinText_.text = GetI18NText(slot1)

	slot0.contorller_:SetSelectedState(slot2)
end

function slot0.GetTextAndImage(slot0)
	if slot0.lockStateList_[slot0.params_.selectHeroPos] == true then
		slot0.joinBtn_.interactable = false

		return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
	end

	if table.keyof(slot0.lockHeroList_, slot0.selectID_) or table.keyof(slot0.lockHeroList_, slot0.selectTrialID_) then
		slot0.joinBtn_.interactable = false

		return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
	end

	if slot0:IsSameHeroInTeam(slot0.selectID_) and not slot0:IsInTeam(slot0.selectID_, slot0.selectTrialID_) then
		if slot0.heroTeam_[slot0.params_.selectHeroPos] ~= slot0.selectID_ then
			slot0.joinBtn_.interactable = false

			return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
		else
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		end
	end

	if slot0.heroTeam_[slot0.params_.selectHeroPos] == 0 then
		if slot0:IsInTeam(slot0.selectID_, slot0.selectTrialID_) then
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		else
			return string.format("<color=#222222>%s</color>", GetTips("JOIN_TEAM")), "0"
		end
	end

	if slot0.selectID_ == slot0.heroTeam_[slot0.params_.selectHeroPos] then
		for slot5, slot6 in pairs(slot0.heroTeam_) do
			if slot6 ~= 0 then
				slot1 = 0 + 1
			end
		end

		if slot1 == 1 then
			slot0.joinBtn_.interactable = false

			return string.format("<color=#222222>%s</color>", GetTips("CAN_NOT_REMOVE")), "1"
		else
			return string.format("<color=#EBEBEB>%s</color>", GetTips("REMOVE_FROM_TEAM")), "2"
		end
	end

	return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
end

function slot0.GetHeroTeam(slot0)
	if slot0.roomProxy_ then
		slot1 = slot0.roomProxy_:GetHeroTeam()
		slot0.heroTeam_ = slot1.HeroList
		slot0.lockStateList_ = slot1.LockStateList
		slot0.lockHeroList_ = slot1.LockHeroList
		slot0.heroTrialList_ = slot1.TrialHeroList

		return slot1
	end

	slot0.heroTeam_, slot0.lockStateList_, slot0.lockHeroList_, slot0.heroTrialList_ = ReserveTools.GetHeroList(slot0.params_.reserveParams)

	return nil
end

function slot0.GetDefaultHeroData(slot0)
	slot1, slot2 = BattleFieldData:GetCurrentSelectHeroID()

	if slot1 and slot1 ~= 0 then
		return slot1, slot2
	end

	if (slot0.heroTeam_[slot0.params_.selectHeroPos] or 0) == 0 then
		for slot7, slot8 in pairs(slot0.heroDataList_) do
			if not slot0:IsInTeam(slot8.id, slot8.trialID) then
				return slot9, slot8.trialID
			end
		end
	end

	if slot3 == 0 then
		for slot7, slot8 in pairs(slot0.heroDataList_) do
			return slot8.id, slot8.trialID
		end
	end

	return slot3, 0
end

function slot0.IsInTeam(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0.heroTeam_) do
		if slot1 == slot7 and slot2 == slot0.heroTrialList_[slot6] then
			return true, slot6 == 1, slot6
		end
	end

	return false, false, -1
end

function slot0.IsSameIDInTeam(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0.heroTeam_) do
		if slot1 == slot7 then
			return true
		end
	end

	return false
end

function slot0.IsSameHeroInTeam(slot0, slot1)
	for slot5, slot6 in pairs(slot0.heroTeam_) do
		if slot1 == slot6 then
			return true
		end
	end

	return false
end

function slot0.ChangeTeam(slot0, slot1, slot2)
	ReserveTools.SetHeroList(slot0.params_.reserveParams, slot1, slot2)
end

function slot0.GetHeroList(slot0)
	if slot0.params_.stageType == BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME then
		return {}
	end

	return HeroTools.Sort(HeroData:GetHeroList())
end

function slot0.IsCustomTeamStage(slot0)
	return type(BattleStageTools.GetRestrictHeroList(slot0.params_.stageType, slot0.params_.stageID)) == "table"
end

function slot0.GetCustomHeroList(slot0)
	slot1 = {}

	if type(BattleStageTools.GetRestrictHeroList(slot0.params_.stageType, slot0.params_.stageID)) == "table" then
		for slot6, slot7 in pairs(slot2) do
			if slot7[1] ~= 0 and HeroCfg[slot7[1]] and table.keyof(HeroCfg.get_id_list_by_private[0], slot7[1]) then
				table.insert(slot1, slot7[2])
			end
		end
	end

	return slot1
end

function slot0.OnHeroSort(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.filterView_:RefreshSort(slot1, slot2, slot3, slot4, slot5)
	HeroData:SaveSortValue(slot1, slot2, slot3, slot4, slot5)
end

return slot0
