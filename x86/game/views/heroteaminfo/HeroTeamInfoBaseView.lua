local var_0_0 = class("HeroTeamInfoBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/StagePrepare/HeroTeamInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.indexof(arg_3_0, arg_3_1, arg_3_2)
	for iter_3_0 = 1, #arg_3_1 do
		if arg_3_1[iter_3_0].id == arg_3_2.id and arg_3_1[iter_3_0].trialID == arg_3_2.trialID then
			return iter_3_0
		end
	end

	return 9999
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListeners()

	arg_4_0.emptyController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "empty")
	arg_4_0.contorller_ = ControllerUtil.GetController(arg_4_0.joinBtn_.transform, "upgradeBtn")
	arg_4_0.heroAvatarView_ = HeroAvatarView.New(arg_4_0, arg_4_0.displayGo_)
	arg_4_0.heroHeadList_ = LuaList.New(handler(arg_4_0, arg_4_0.HeadRenderer), arg_4_0.uiListGo_, HeroTeamHeadItem)
	arg_4_0.filterView_ = arg_4_0:GetFilterClass().New(arg_4_0.filterGo_)

	arg_4_0.filterView_:SetExtraSorter(handler(arg_4_0, arg_4_0.ExtraSorter))
	arg_4_0.filterView_:SetListChangeHandler(handler(arg_4_0, arg_4_0.OnListChange))
end

function var_0_0.GetFilterClass(arg_5_0)
	return HeroListFilterWithTrialView
end

function var_0_0.ExtraSorter(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = arg_6_0.heroTeam_
	local var_6_1 = arg_6_0.heroTrialList_
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		var_6_2[iter_6_0] = {
			id = iter_6_1,
			trialID = var_6_1[iter_6_0]
		}
	end

	local var_6_3 = arg_6_0:indexof(var_6_2, arg_6_1)
	local var_6_4 = arg_6_0:indexof(var_6_2, arg_6_2)

	if var_6_3 ~= var_6_4 then
		return true, var_6_3 < var_6_4
	end

	if arg_6_1.trialID ~= 0 or arg_6_2.trialID ~= 0 then
		if arg_6_1.trialID ~= 0 and arg_6_2.trialID ~= 0 then
			if arg_6_3 == 0 and arg_6_1.star ~= arg_6_2.star then
				if arg_6_0.curOrder_ == "desc" then
					return true, arg_6_1.star > arg_6_2.star
				else
					return true, arg_6_1.star < arg_6_2.star
				end
			end

			local var_6_5 = getHeroPower(arg_6_1.trialID, true)
			local var_6_6 = getHeroPower(arg_6_2.trialID, true)

			if var_6_5 ~= var_6_6 then
				if arg_6_4 == "desc" then
					return true, var_6_6 < var_6_5
				else
					return true, var_6_5 < var_6_6
				end
			else
				return true, arg_6_1.trialID > arg_6_2.trialID
			end
		else
			return true, arg_6_1.trialID > arg_6_2.trialID
		end
	end

	return false, false
end

function var_0_0.OnListChange(arg_7_0, arg_7_1)
	arg_7_0.heroDataList_ = arg_7_1

	arg_7_0.heroHeadList_:StartScroll(#arg_7_0.heroDataList_)

	if #arg_7_0.heroDataList_ > 0 then
		arg_7_0.emptyController_:SetSelectedState("false")
		arg_7_0:SelectHero(arg_7_0.heroDataList_[1].id, arg_7_0.heroDataList_[1].trialID)
	else
		arg_7_0.emptyController_:SetSelectedState("true")
	end
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.roomProxy_ = arg_8_0.params_.roomProxy
	arg_8_0.type_ = arg_8_0.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_8_0.heroViewProxy_ = HeroViewDataProxy.New(arg_8_0.type_)

	manager.ui:SetMainCamera("hero")

	if arg_8_0.params_.isEnter then
		if arg_8_0.filterView_ then
			arg_8_0.filterView_:Reset(true)
		end

		arg_8_0.params_.isEnter = false
	end

	if arg_8_0.params_.stageType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	if arg_8_0.heroAvatarView_ then
		arg_8_0.heroAvatarView_:OnEnter()
	end

	arg_8_0.teamInfo_ = arg_8_0:GetHeroTeam()
	arg_8_0.trialHeroList_ = GetTrialHeroList(arg_8_0.params_.stageType, arg_8_0.params_.stageID, arg_8_0.params_.activityID)

	local var_8_0 = HideInfoData.GetHeroHideList()
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_0:GetHeroList()) do
		table.insert(var_8_1, {
			trialID = 0,
			id = iter_8_1,
			type = arg_8_0.type_
		})
	end

	arg_8_0.filterView_:ShowDropDown(true)

	local var_8_2 = {}
	local var_8_3, var_8_4 = BattleStageTools.GetRestrictHeroList(arg_8_0.params_.stageType, arg_8_0.params_.stageID)
	local var_8_5 = false

	if type(var_8_4) == "table" and var_8_4[arg_8_0.params_.selectHeroPos] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
		var_8_5 = true
	end

	if type(var_8_3) == "table" then
		if var_8_3[arg_8_0.params_.selectHeroPos][1] then
			var_8_1 = {}

			arg_8_0.filterView_:ShowDropDown(false)
		end

		if var_8_5 == true then
			local var_8_6 = var_8_3[arg_8_0.params_.selectHeroPos][1]
			local var_8_7 = var_8_3[arg_8_0.params_.selectHeroPos][2]

			if var_8_6 ~= 0 and HeroCfg[var_8_6] and table.keyof(HeroCfg.get_id_list_by_private[0], var_8_6) then
				table.insert(var_8_1, {
					id = var_8_6,
					trialID = var_8_7,
					type = HeroConst.HERO_DATA_TYPE.CUSTOM
				})

				if HeroTools.GetHeroIsUnlock(var_8_6) then
					table.insert(var_8_1, {
						trialID = 0,
						id = var_8_6,
						type = HeroConst.HERO_DATA_TYPE.DEFAULT
					})
				end
			end
		else
			for iter_8_2, iter_8_3 in pairs(var_8_3) do
				if iter_8_3[1] ~= 0 and HeroCfg[iter_8_3[1]] and table.keyof(HeroCfg.get_id_list_by_private[0], iter_8_3[1]) then
					table.insert(var_8_1, {
						id = iter_8_3[1],
						trialID = iter_8_3[2],
						type = HeroConst.HERO_DATA_TYPE.CUSTOM
					})
					table.insert(var_8_2, iter_8_3[2])
				end
			end
		end
	end

	for iter_8_4, iter_8_5 in pairs(arg_8_0.trialHeroList_) do
		local var_8_8 = HeroStandardSystemCfg[iter_8_5]

		if not table.keyof(var_8_2, iter_8_5) then
			table.insert(var_8_1, {
				id = var_8_8.hero_id,
				trialID = iter_8_5,
				type = HeroConst.HERO_DATA_TYPE.TRIAL
			})
		end
	end

	arg_8_0.filterView_:SetHeroDataList(var_8_1)

	arg_8_0.selectID_, arg_8_0.selectTrialID_ = arg_8_0:GetDefaultHeroData()

	arg_8_0:SelectHero(arg_8_0.selectID_, arg_8_0.selectTrialID_)
	arg_8_0.heroHeadList_:StartScroll(#arg_8_0.heroDataList_, table.keyof(arg_8_0.heroDataList_, arg_8_0.selectID_))
	SetActive(arg_8_0.favoriteBtn_.gameObject, false)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:RegistBackCallBack(function()
		arg_9_0:Back(1, {
			isSorted = true
		})
	end)
end

function var_0_0.OnExit(arg_11_0)
	manager.ui:ResetMainCamera()

	if arg_11_0.heroAvatarView_ then
		arg_11_0.heroAvatarView_:OnExit()
	end

	if #arg_11_0.heroDataList_ <= 0 then
		HeroData:ResetSortValue()
		arg_11_0.filterView_:Reset()
	end

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.filterView_ then
		arg_12_0.filterView_:Dispose()

		arg_12_0.filterView_ = nil
	end

	if arg_12_0.heroHeadList_ then
		arg_12_0.heroHeadList_:Dispose()

		arg_12_0.heroHeadList_ = nil
	end

	if arg_12_0.heroAvatarView_ then
		arg_12_0.heroAvatarView_:Dispose()

		arg_12_0.heroAvatarView_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)

	arg_12_0.selectID_ = nil
	arg_12_0.heroTeam_ = nil
	arg_12_0.lockStateList_ = nil
	arg_12_0.lockHeroList_ = nil
	arg_12_0.displayGo_ = nil
	arg_12_0.nameText_ = nil
	arg_12_0.subNameText_ = nil
	arg_12_0.fightPowerText_ = nil
	arg_12_0.joinBtn_ = nil
	arg_12_0.joinImg_ = nil
	arg_12_0.joinText_ = nil
	arg_12_0.infoBtn_ = nil
	arg_12_0.uiListGo_ = nil
end

function var_0_0.InitUI(arg_13_0)
	arg_13_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_14_0)
	arg_14_0:AddBtnListener(arg_14_0.infoBtn_, nil, function()
		BattleFieldData:SetCurrentSelectHeroData(arg_14_0.selectID_, arg_14_0.selectTrialID_)

		local var_15_0

		if arg_14_0.selectTrialID_ ~= 0 then
			local var_15_1 = arg_14_0:GetCustomHeroList()

			if not table.keyof(var_15_1, arg_14_0.selectTrialID_) then
				var_15_1 = arg_14_0.trialHeroList_
			end

			local var_15_2 = {}

			for iter_15_0, iter_15_1 in pairs(var_15_1) do
				local var_15_3 = HeroStandardSystemCfg[iter_15_1]

				if HeroCfg[var_15_3.hero_id].hide_info == 0 then
					table.insert(var_15_2, iter_15_1)
				end
			end

			var_15_0 = var_15_2
		end

		arg_14_0:Go("/newHero", {
			isEnter = true,
			hid = arg_14_0.selectTrialID_ ~= 0 and arg_14_0.selectTrialID_ or arg_14_0.selectID_,
			type = arg_14_0.selectTrialID_ ~= 0 and HeroConst.HERO_DATA_TYPE.TRIAL or HeroConst.HERO_DATA_TYPE.DEFAULT,
			tempHeroList = var_15_0
		})
	end)
	arg_14_0:AddBtnListener(arg_14_0.joinBtn_, nil, handler(arg_14_0, arg_14_0.OnJoinClick))
end

function var_0_0.OnJoinClick(arg_16_0)
	arg_16_0.backFlag_ = true

	local var_16_0 = arg_16_0.heroTeam_
	local var_16_1 = arg_16_0.heroTrialList_
	local var_16_2 = arg_16_0:IsSameIDInTeam(arg_16_0.selectID_, arg_16_0.selectTrialID_)

	if arg_16_0.selectID_ == var_16_0[arg_16_0.params_.selectHeroPos] and arg_16_0.selectTrialID_ == var_16_1[arg_16_0.params_.selectHeroPos] and var_16_2 then
		var_16_0[arg_16_0.params_.selectHeroPos] = 0
		var_16_1[arg_16_0.params_.selectHeroPos] = 0
	elseif var_16_2 then
		local var_16_3 = 1

		for iter_16_0, iter_16_1 in pairs(var_16_0) do
			if iter_16_1 == arg_16_0.selectID_ then
				var_16_3 = iter_16_0

				break
			end
		end

		if var_16_0[var_16_3] == arg_16_0.selectID_ and var_16_1[var_16_3] ~= arg_16_0.selectTrialID_ then
			var_16_0[var_16_3] = arg_16_0.selectID_
			var_16_1[var_16_3] = arg_16_0.selectTrialID_
		end

		local var_16_4 = var_16_0[var_16_3]

		var_16_0[var_16_3] = var_16_0[arg_16_0.params_.selectHeroPos]
		var_16_0[arg_16_0.params_.selectHeroPos] = var_16_4

		local var_16_5 = var_16_1[var_16_3]

		var_16_1[var_16_3] = var_16_1[arg_16_0.params_.selectHeroPos]
		var_16_1[arg_16_0.params_.selectHeroPos] = var_16_5

		HeroTools.PlayTalk(arg_16_0.selectID_, "team")
	else
		var_16_0[arg_16_0.params_.selectHeroPos] = arg_16_0.selectID_
		var_16_1[arg_16_0.params_.selectHeroPos] = arg_16_0.selectTrialID_

		HeroTools.PlayTalk(arg_16_0.selectID_, "team")
	end

	if arg_16_0.params_.reorder == nil or arg_16_0.params_.reorder == true then
		for iter_16_2 = 3, 1, -1 do
			if var_16_0[iter_16_2] == 0 then
				table.remove(var_16_0, iter_16_2)
				table.remove(var_16_1, iter_16_2)
			end
		end

		for iter_16_3 = 1, 3 do
			if not var_16_0[iter_16_3] then
				var_16_0[iter_16_3] = 0
				var_16_1[iter_16_3] = 0
			end
		end
	end

	arg_16_0:TryToChangeTeam(var_16_0, var_16_1)
end

function var_0_0.TryToChangeTeam(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:ChangeTeam(arg_17_1, arg_17_2)
	arg_17_0:OnChangeTeamSuccess()
end

function var_0_0.OnChangeTeamSuccess(arg_18_0)
	if arg_18_0.heroAvatarView_ then
		arg_18_0.heroAvatarView_:RemoveTween()
	end

	arg_18_0:Back(1, {
		isSorted = true
	})

	arg_18_0.backFlag_ = false
end

function var_0_0.UpdateHeroView(arg_19_0)
	local var_19_0
	local var_19_1
	local var_19_2 = arg_19_0.selectID_

	if arg_19_0.selectTrialID_ and arg_19_0.selectTrialID_ ~= 0 then
		var_19_0 = HeroStandardSystemCfg[arg_19_0.selectTrialID_].skin_id
	else
		var_19_0 = HeroTools.HeroUsingSkinInfo(arg_19_0.selectID_).id
	end

	if arg_19_0.selectTrialID_ and arg_19_0.selectTrialID_ ~= 0 then
		arg_19_0.fightPowerText_.text = getHeroPower(arg_19_0.selectTrialID_, true)
	else
		arg_19_0.fightPowerText_.text = arg_19_0.heroViewProxy_:GetBattlePower(var_19_2)
	end

	arg_19_0.heroAvatarView_:SetSkinId(var_19_0)

	local var_19_3 = HeroCfg[var_19_2]

	arg_19_0.nameText_.text = GetI18NText(var_19_3.name)
	arg_19_0.subNameText_.text = GetI18NText(var_19_3.suffix)
end

function var_0_0.HeadRenderer(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.heroDataList_[arg_20_1].id
	local var_20_1 = arg_20_0.heroDataList_[arg_20_1].trialID
	local var_20_2 = arg_20_0.heroDataList_[arg_20_1].type

	arg_20_2:SetRedPointEnable(false)

	arg_20_2.gameObject_.name = tostring(var_20_0)

	if var_20_2 == HeroConst.HERO_DATA_TYPE.DEFAULT then
		arg_20_2:SetHeroData(var_20_0, HeroConst.HERO_DATA_TYPE.DEFAULT, {
			tempHeroList = arg_20_0.trialHeroList_
		})
		arg_20_2:SetTrial(false)
	elseif var_20_2 == HeroConst.HERO_DATA_TYPE.TRIAL then
		arg_20_2:SetHeroData(var_20_1, HeroConst.HERO_DATA_TYPE.TRIAL, {
			tempHeroList = arg_20_0.trialHeroList_
		})
		arg_20_2:SetTrial(true)
	elseif var_20_2 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		arg_20_2:SetHeroData(var_20_1, HeroConst.HERO_DATA_TYPE.CUSTOM, {
			tempHeroList = arg_20_0:GetCustomHeroList()
		})
		arg_20_2:SetTrial(true)
	elseif var_20_2 == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		arg_20_2:SetHeroData(var_20_0, HeroConst.HERO_DATA_TYPE.ADVANCETEST, {
			tempHeroList = arg_20_0.trialHeroList_
		})
		arg_20_2:SetTrial(false)
	end

	arg_20_2:SetSelected(arg_20_2.heroId_ == arg_20_0.selectID_ and arg_20_2.trialID_ == arg_20_0.selectTrialID_)
	arg_20_2:SetInTeamFlag(arg_20_0:IsInTeam(var_20_0, var_20_1))
	arg_20_2:SetLove(var_20_2 ~= HeroConst.HERO_DATA_TYPE.DEFAULT or HeroData:IsFavorite(var_20_0) == false)

	if arg_20_0.params_.stageType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		arg_20_2:SetHp(false)
	else
		arg_20_2:SetHp(false)
	end

	arg_20_2:SetShowAttackType(false)
	arg_20_2:RegisterClickListener(function()
		if arg_20_0.backFlag_ then
			return
		end

		arg_20_0:SelectHero(arg_20_2.heroId_, arg_20_2.trialID_)
	end)
end

function var_0_0.SelectHero(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.selectID_ = arg_22_1
	arg_22_0.selectTrialID_ = arg_22_2

	for iter_22_0, iter_22_1 in pairs(arg_22_0.heroHeadList_:GetItemList()) do
		iter_22_1:SetSelected(iter_22_1.heroId_ == arg_22_1 and iter_22_1.trialID_ == arg_22_2)
	end

	arg_22_0:RefreshInfoBtn()
	arg_22_0:UpdateHeroView()
	arg_22_0:RefreshJoinBtn()
end

function var_0_0.RefreshInfoBtn(arg_23_0)
	if arg_23_0.infoBtn_ then
		if arg_23_0.params_.stageType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
			SetActive(arg_23_0.infoBtn_.gameObject, false)
		else
			SetActive(arg_23_0.infoBtn_.gameObject, HeroCfg[arg_23_0.selectID_].hide_info == 0)
		end
	end
end

function var_0_0.RefreshJoinBtn(arg_24_0)
	arg_24_0.joinBtn_.interactable = true

	local var_24_0, var_24_1, var_24_2 = arg_24_0:GetTextAndImage()

	arg_24_0.joinText_.text = GetI18NText(var_24_0)

	arg_24_0.contorller_:SetSelectedState(var_24_1)
end

function var_0_0.GetTextAndImage(arg_25_0)
	if arg_25_0.lockStateList_[arg_25_0.params_.selectHeroPos] == true then
		arg_25_0.joinBtn_.interactable = false

		return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
	end

	if table.keyof(arg_25_0.lockHeroList_, arg_25_0.selectID_) or table.keyof(arg_25_0.lockHeroList_, arg_25_0.selectTrialID_) then
		arg_25_0.joinBtn_.interactable = false

		return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
	end

	if arg_25_0:IsSameHeroInTeam(arg_25_0.selectID_) and not arg_25_0:IsInTeam(arg_25_0.selectID_, arg_25_0.selectTrialID_) then
		if arg_25_0.heroTeam_[arg_25_0.params_.selectHeroPos] ~= arg_25_0.selectID_ then
			arg_25_0.joinBtn_.interactable = false

			return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
		else
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		end
	end

	if arg_25_0.heroTeam_[arg_25_0.params_.selectHeroPos] == 0 then
		if arg_25_0:IsInTeam(arg_25_0.selectID_, arg_25_0.selectTrialID_) then
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		else
			return string.format("<color=#222222>%s</color>", GetTips("JOIN_TEAM")), "0"
		end
	end

	if arg_25_0.selectID_ == arg_25_0.heroTeam_[arg_25_0.params_.selectHeroPos] then
		local var_25_0 = 0

		for iter_25_0, iter_25_1 in pairs(arg_25_0.heroTeam_) do
			if iter_25_1 ~= 0 then
				var_25_0 = var_25_0 + 1
			end
		end

		if var_25_0 == 1 then
			arg_25_0.joinBtn_.interactable = false

			return string.format("<color=#222222>%s</color>", GetTips("CAN_NOT_REMOVE")), "1"
		else
			return string.format("<color=#EBEBEB>%s</color>", GetTips("REMOVE_FROM_TEAM")), "2"
		end
	end

	return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
end

function var_0_0.GetHeroTeam(arg_26_0)
	if arg_26_0.roomProxy_ then
		local var_26_0 = arg_26_0.roomProxy_:GetHeroTeam()

		arg_26_0.heroTeam_ = var_26_0.HeroList
		arg_26_0.lockStateList_ = var_26_0.LockStateList
		arg_26_0.lockHeroList_ = var_26_0.LockHeroList
		arg_26_0.heroTrialList_ = var_26_0.TrialHeroList

		return var_26_0
	end

	arg_26_0.heroTeam_, arg_26_0.lockStateList_, arg_26_0.lockHeroList_, arg_26_0.heroTrialList_ = ReserveTools.GetHeroList(arg_26_0.params_.reserveParams)

	return nil
end

function var_0_0.GetDefaultHeroData(arg_27_0)
	local var_27_0, var_27_1 = BattleFieldData:GetCurrentSelectHeroID()

	if var_27_0 and var_27_0 ~= 0 then
		return var_27_0, var_27_1
	end

	local var_27_2 = arg_27_0.heroTeam_[arg_27_0.params_.selectHeroPos] or 0

	if var_27_2 == 0 then
		for iter_27_0, iter_27_1 in pairs(arg_27_0.heroDataList_) do
			local var_27_3 = iter_27_1.id

			if not arg_27_0:IsInTeam(var_27_3, iter_27_1.trialID) then
				return var_27_3, iter_27_1.trialID
			end
		end
	end

	if var_27_2 == 0 then
		for iter_27_2, iter_27_3 in pairs(arg_27_0.heroDataList_) do
			return iter_27_3.id, iter_27_3.trialID
		end
	end

	return var_27_2, 0
end

function var_0_0.IsInTeam(arg_28_0, arg_28_1, arg_28_2)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.heroTeam_) do
		if arg_28_1 == iter_28_1 and arg_28_2 == arg_28_0.heroTrialList_[iter_28_0] then
			return true, iter_28_0 == 1, iter_28_0
		end
	end

	return false, false, -1
end

function var_0_0.IsSameIDInTeam(arg_29_0, arg_29_1, arg_29_2)
	for iter_29_0, iter_29_1 in pairs(arg_29_0.heroTeam_) do
		if arg_29_1 == iter_29_1 then
			return true
		end
	end

	return false
end

function var_0_0.IsSameHeroInTeam(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.heroTeam_) do
		if arg_30_1 == iter_30_1 then
			return true
		end
	end

	return false
end

function var_0_0.ChangeTeam(arg_31_0, arg_31_1, arg_31_2)
	ReserveTools.SetHeroList(arg_31_0.params_.reserveParams, arg_31_1, arg_31_2)
end

function var_0_0.GetHeroList(arg_32_0)
	if arg_32_0.params_.stageType == BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME then
		return {}
	end

	return (HeroTools.Sort(HeroData:GetHeroList()))
end

function var_0_0.IsCustomTeamStage(arg_33_0)
	local var_33_0 = BattleStageTools.GetRestrictHeroList(arg_33_0.params_.stageType, arg_33_0.params_.stageID)

	return type(var_33_0) == "table"
end

function var_0_0.GetCustomHeroList(arg_34_0)
	local var_34_0 = {}
	local var_34_1 = BattleStageTools.GetRestrictHeroList(arg_34_0.params_.stageType, arg_34_0.params_.stageID)

	if type(var_34_1) == "table" then
		for iter_34_0, iter_34_1 in pairs(var_34_1) do
			if iter_34_1[1] ~= 0 and HeroCfg[iter_34_1[1]] and table.keyof(HeroCfg.get_id_list_by_private[0], iter_34_1[1]) then
				table.insert(var_34_0, iter_34_1[2])
			end
		end
	end

	return var_34_0
end

function var_0_0.OnHeroSort(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5)
	arg_35_0.filterView_:RefreshSort(arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5)
	HeroData:SaveSortValue(arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5)
end

return var_0_0
