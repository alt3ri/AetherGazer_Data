local var_0_0 = class("NewHeroTeamInfoBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Formation/FormationHeroUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.autoClearFilter_ = true
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.heroHeadList_ = LuaList.New(handler(arg_4_0, arg_4_0.HeadRenderer), arg_4_0.uiListGo_, arg_4_0:GetHeroHeadClass())
	arg_4_0.filterView_ = arg_4_0:GetFilterClass().New(arg_4_0.filterGo_)

	arg_4_0.filterView_:SetExtraSorter(handler(arg_4_0, arg_4_0.ExtraSorter))
	arg_4_0.filterView_:SetListChangeHandler(handler(arg_4_0, arg_4_0.OnListChange))

	arg_4_0.heroAvatarView_ = HeroAvatarView.New(arg_4_0, arg_4_0.displayGo_)
	arg_4_0.heroInfoView_ = SectionHeroInfoView.New(arg_4_0, arg_4_0.heroInfoGo_)
	arg_4_0.emptyController_ = arg_4_0.controller_:GetController("empty")
	arg_4_0.joinBtnController_ = arg_4_0.btnPanelController_:GetController("join")
	arg_4_0.infoBtnController_ = arg_4_0.btnPanelController_:GetController("info")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.infoBtn_, nil, function()
		local var_6_0 = {}

		if arg_5_0.selectHeroData_.trialID ~= 0 then
			for iter_6_0, iter_6_1 in pairs(arg_5_0.allTrialIDList_) do
				local var_6_1 = HeroStandardSystemCfg[iter_6_1]

				if HeroCfg[var_6_1.hero_id].hide_info == 0 then
					table.insert(var_6_0, iter_6_1)
				end
			end
		end

		arg_5_0:Go("/newHero", {
			isEnter = true,
			hid = arg_5_0.selectHeroData_.trialID ~= 0 and arg_5_0.selectHeroData_.trialID or arg_5_0.selectHeroData_.id,
			type = arg_5_0.selectHeroData_.trialID ~= 0 and HeroConst.HERO_DATA_TYPE.TRIAL or arg_5_0.heroDataType_,
			tempHeroList = var_6_0
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.joinBtn_, nil, handler(arg_5_0, arg_5_0.OnJoinClick))
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:ProcessCamera()
	arg_7_0:UpdateBar()
	arg_7_0:ParseParams()
	arg_7_0:SubViewOnEnter()
	arg_7_0:GetHeroTeam()
	arg_7_0:RefreshHeroDataList()
	arg_7_0:RefreshHeroList()
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:RegistBackCallBack(function()
		arg_8_0:Back(1, {
			isSorted = true
		})
	end)
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0.params_.curSelectHeroData = arg_10_0.selectHeroData_

	manager.ui:ResetMainCamera()
	manager.windowBar:HideBar()
	arg_10_0:SubViewOnExit()
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.filterView_ then
		arg_11_0.filterView_:Dispose()

		arg_11_0.filterView_ = nil
	end

	if arg_11_0.heroHeadList_ then
		arg_11_0.heroHeadList_:Dispose()

		arg_11_0.heroHeadList_ = nil
	end

	if arg_11_0.heroAvatarView_ then
		arg_11_0.heroAvatarView_:Dispose()

		arg_11_0.heroAvatarView_ = nil
	end

	if arg_11_0.heroInfoView_ then
		arg_11_0.heroInfoView_:Dispose()

		arg_11_0.heroInfoView_ = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.ProcessCamera(arg_12_0)
	manager.ui:SetMainCamera("hero")
end

function var_0_0.UpdateBar(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.ParseParams(arg_14_0)
	arg_14_0.stageID_ = arg_14_0.params_.stageID
	arg_14_0.stageType_ = arg_14_0.params_.stageType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	arg_14_0.activityID_ = arg_14_0.params_.activityID

	if not arg_14_0.params_.reserveParams then
		arg_14_0.params_.reserveParams = ReserveTools.GetReserveParams(arg_14_0.stageType_, arg_14_0.stageID_, arg_14_0.activityID_)
	elseif not arg_14_0.params_.reserveParams.customData.activityID then
		arg_14_0.params_.reserveParams.customData.activityID = arg_14_0.activityID_
	end

	arg_14_0.reserveParams_ = arg_14_0.params_.reserveParams
	arg_14_0.params_.heroDataType = arg_14_0.params_.heroDataType or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_14_0.heroDataType_ = arg_14_0.params_.heroDataType

	if not arg_14_0.params_.sectionProxy then
		arg_14_0.params_.sectionProxy = SectionSelectHeroTools.GetProxy(arg_14_0.params_, arg_14_0.reserveParams_, arg_14_0.heroDataType_)
	end

	arg_14_0.sectionProxy_ = arg_14_0.params_.sectionProxy
	arg_14_0.heroViewProxy_ = arg_14_0.sectionProxy_:GetHeroViewProxy()
	arg_14_0.heroViewProxyDic_ = {}
	arg_14_0.heroViewProxyDic_[arg_14_0.heroDataType_] = arg_14_0.heroViewProxy_
end

function var_0_0.SubViewOnEnter(arg_15_0)
	arg_15_0.heroAvatarView_:OnEnter()

	if not arg_15_0.params_.isBack and arg_15_0.filterView_ and arg_15_0.autoClearFilter_ then
		arg_15_0.filterView_:Reset(true)
		CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
	end

	arg_15_0.filterView_:OnEnter(arg_15_0.heroViewProxy_)

	if arg_15_0.heroInfoView_ then
		arg_15_0.heroInfoView_:OnEnter(arg_15_0.heroViewProxy_)
	end
end

function var_0_0.SubViewOnExit(arg_16_0)
	arg_16_0.heroAvatarView_:OnExit()

	if arg_16_0.filterView_ and arg_16_0.filterView_.OnExit then
		arg_16_0.filterView_:OnExit()
	end

	if #arg_16_0.heroDataList_ <= 0 then
		HeroData:ResetSortValue()
		arg_16_0.filterView_:Reset()
	end

	arg_16_0.heroInfoView_:OnExit()
end

function var_0_0.RefreshHeroDataList(arg_17_0)
	local var_17_0 = {}

	arg_17_0.allTrialIDList_ = {}

	local var_17_1 = {}
	local var_17_2
	local var_17_3

	if arg_17_0.params_.stageType and arg_17_0.params_.stageID and arg_17_0.params_.stageID ~= 0 then
		var_17_2, var_17_3 = BattleStageTools.GetRestrictHeroList(arg_17_0.params_.stageType, arg_17_0.params_.stageID)
	end

	local var_17_4 = false

	if type(var_17_3) == "table" then
		arg_17_0.canSwitchResctrictHeroList_ = var_17_3

		if arg_17_0.canSwitchResctrictHeroList_[arg_17_0.params_.selectHeroPos] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
			var_17_4 = true
		end
	else
		arg_17_0.canSwitchResctrictHeroList_ = {
			0,
			0,
			0
		}
	end

	if type(var_17_2) == "table" then
		for iter_17_0, iter_17_1 in ipairs(var_17_2) do
			if iter_17_1[1] then
				local var_17_5 = iter_17_1[1]

				if var_17_5 ~= 0 and HeroCfg[var_17_5] and HeroCfg[var_17_5].private == 0 then
					var_17_1[var_17_5] = iter_17_1[2]
				end
			end
		end

		if var_17_4 == true then
			local var_17_6 = var_17_2[arg_17_0.params_.selectHeroPos][1]
			local var_17_7 = var_17_2[arg_17_0.params_.selectHeroPos][2]

			if var_17_1[var_17_6] then
				table.insert(var_17_0, {
					id = var_17_6,
					trialID = var_17_7,
					type = HeroConst.HERO_DATA_TYPE.TRIAL,
					heroViewProxy = arg_17_0:GetHeroViewProxy(HeroConst.HERO_DATA_TYPE.TRIAL)
				})
				table.insert(arg_17_0.allTrialIDList_, var_17_7)

				if HeroTools.GetHeroIsUnlock(var_17_6) then
					table.insert(var_17_0, {
						trialID = 0,
						id = var_17_6,
						type = HeroConst.HERO_DATA_TYPE.DEFAULT,
						heroViewProxy = arg_17_0:GetHeroViewProxy(HeroConst.HERO_DATA_TYPE.DEFAULT)
					})
				end
			end
		elseif arg_17_0.lockStateList_[arg_17_0.params_.selectHeroPos] then
			for iter_17_2, iter_17_3 in pairs(var_17_2) do
				local var_17_8 = iter_17_3[1]
				local var_17_9 = iter_17_3[2]

				if var_17_1[var_17_8] then
					table.insert(var_17_0, {
						id = var_17_8,
						trialID = var_17_9,
						type = HeroConst.HERO_DATA_TYPE.TRIAL,
						heroViewProxy = arg_17_0:GetHeroViewProxy(HeroConst.HERO_DATA_TYPE.TRIAL)
					})

					var_17_1[var_17_8] = var_17_9

					table.insert(arg_17_0.allTrialIDList_, var_17_9)
				end
			end
		end
	end

	arg_17_0.trialHeroList_ = arg_17_0:GetTrialHeroList()

	if not arg_17_0.lockStateList_[arg_17_0.params_.selectHeroPos] and not var_17_4 then
		for iter_17_4, iter_17_5 in pairs(arg_17_0:GetHeroList()) do
			if not var_17_1[iter_17_5] then
				table.insert(var_17_0, {
					trialID = 0,
					id = iter_17_5,
					type = arg_17_0.heroDataType_,
					heroViewProxy = arg_17_0:GetHeroViewProxy(arg_17_0.heroDataType_)
				})
			end
		end

		for iter_17_6, iter_17_7 in pairs(arg_17_0.trialHeroList_) do
			local var_17_10 = HeroStandardSystemCfg[iter_17_7]

			if not table.keyof(var_17_1, iter_17_7) then
				table.insert(var_17_0, {
					id = var_17_10.hero_id,
					trialID = iter_17_7,
					type = HeroConst.HERO_DATA_TYPE.TRIAL,
					heroViewProxy = arg_17_0:GetHeroViewProxy(HeroConst.HERO_DATA_TYPE.TRIAL)
				})
				table.insert(arg_17_0.allTrialIDList_, iter_17_7)
			end
		end
	end

	for iter_17_8, iter_17_9 in pairs(arg_17_0.heroViewProxyDic_) do
		iter_17_9:SetTempHeroList(arg_17_0.allTrialIDList_)
	end

	arg_17_0.filterView_:SetHeroIdList(var_17_0)
end

function var_0_0.RefreshHeroList(arg_18_0)
	if #arg_18_0.heroDataList_ <= 0 then
		return
	end

	arg_18_0.selectHeroData_ = arg_18_0:GetDefaultHeroData()

	local var_18_0 = 1

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.heroDataList_) do
		if iter_18_1.id == arg_18_0.selectHeroData_.id and iter_18_1.trialID == arg_18_0.selectHeroData_.trialID then
			var_18_0 = iter_18_0

			break
		end
	end

	arg_18_0.heroHeadList_:StartScroll(#arg_18_0.heroDataList_, var_18_0)
	arg_18_0:SelectHero(arg_18_0.selectHeroData_)
end

function var_0_0.SelectHero(arg_19_0, arg_19_1)
	arg_19_0.selectHeroData_ = arg_19_1

	for iter_19_0, iter_19_1 in pairs(arg_19_0.heroHeadList_:GetItemList()) do
		iter_19_1:SetSelected(iter_19_1.heroId_ == arg_19_0.selectHeroData_.id and iter_19_1.trialID_ == arg_19_0.selectHeroData_.trialID)
	end

	arg_19_0:RefreshInfoBtn()
	arg_19_0:UpdateHeroView()
	arg_19_0:RefreshJoinBtn()
end

function var_0_0.RefreshInfoBtn(arg_20_0)
	if arg_20_0.params_.hideInfoBtn or HeroCfg[arg_20_0.selectHeroData_.id].private ~= 0 then
		arg_20_0.infoBtnController_:SetSelectedState("off")
	else
		arg_20_0.infoBtnController_:SetSelectedState(HeroCfg[arg_20_0.selectHeroData_.id].hide_info == 0 and "on" or "off")
	end
end

function var_0_0.UpdateHeroView(arg_21_0)
	local var_21_0
	local var_21_1
	local var_21_2
	local var_21_3 = arg_21_0.selectHeroData_.id
	local var_21_4 = arg_21_0.selectHeroData_.heroViewProxy:GetHeroData(var_21_3, {
		arg_21_0.selectHeroData_.trialID
	})
	local var_21_5 = arg_21_0.selectHeroData_.heroViewProxy:GetHeroUsingSkinInfo(var_21_3, {
		arg_21_0.selectHeroData_.trialID
	}).id

	arg_21_0.heroAvatarView_:SetSkinId(var_21_5)
	arg_21_0.heroInfoView_:SetProxy(arg_21_0.selectHeroData_.heroViewProxy)
	arg_21_0.heroInfoView_:SetHeroInfo(var_21_4)
	arg_21_0.heroInfoView_:UpdateView()
end

function var_0_0.RefreshJoinBtn(arg_22_0)
	arg_22_0.joinBtn_.interactable = true

	if arg_22_0.lockStateList_[arg_22_0.params_.selectHeroPos] == true then
		arg_22_0.joinBtnController_:SetSelectedState("lock")

		arg_22_0.joinBtn_.interactable = false
	elseif table.keyof(arg_22_0.lockHeroList_, arg_22_0.selectHeroData_.id) or table.keyof(arg_22_0.lockHeroList_, arg_22_0.selectHeroData_.trialID) then
		arg_22_0.joinBtnController_:SetSelectedState("lock")

		arg_22_0.joinBtn_.interactable = false
	elseif arg_22_0:IsSameHeroInTeam(arg_22_0.selectHeroData_.id) and not arg_22_0:IsInTeam(arg_22_0.selectHeroData_.id, arg_22_0.selectHeroData_.trialID) then
		if arg_22_0.heroTeam_[arg_22_0.params_.selectHeroPos] ~= arg_22_0.selectHeroData_.id then
			arg_22_0.joinBtnController_:SetSelectedState("lock")

			arg_22_0.joinBtn_.interactable = false
		else
			arg_22_0.joinBtnController_:SetSelectedState("change")
		end
	elseif arg_22_0.heroTeam_[arg_22_0.params_.selectHeroPos] == 0 then
		if arg_22_0:IsInTeam(arg_22_0.selectHeroData_.id, arg_22_0.selectHeroData_.trialID) then
			arg_22_0.joinBtnController_:SetSelectedState("change")
		else
			arg_22_0.joinBtnController_:SetSelectedState("add")
		end
	elseif arg_22_0.selectHeroData_.id == arg_22_0.heroTeam_[arg_22_0.params_.selectHeroPos] then
		local var_22_0 = 0

		for iter_22_0, iter_22_1 in pairs(arg_22_0.heroTeam_) do
			if iter_22_1 ~= 0 then
				var_22_0 = var_22_0 + 1
			end
		end

		if var_22_0 == 1 and not arg_22_0.params_.canCleanTeam then
			arg_22_0.joinBtn_.interactable = false

			arg_22_0.joinBtnController_:SetSelectedState("cantRemove")
		else
			arg_22_0.joinBtnController_:SetSelectedState("out")
		end
	else
		arg_22_0.joinBtnController_:SetSelectedState("change")
	end
end

function var_0_0.GetHeroTeam(arg_23_0)
	arg_23_0.heroTeam_, arg_23_0.lockStateList_, arg_23_0.lockHeroList_, arg_23_0.heroTrialList_ = arg_23_0.sectionProxy_:CustomGetTeamData()
end

function var_0_0.GetHeroList(arg_24_0)
	if arg_24_0.params_.stageType == BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME then
		return {}
	end

	return (HeroTools.Sort(HeroData:GetHeroList()))
end

function var_0_0.GetCustomHeroList(arg_25_0)
	local var_25_0 = {}
	local var_25_1 = BattleStageTools.GetRestrictHeroList(arg_25_0.params_.stageType, arg_25_0.params_.stageID)

	if type(var_25_1) == "table" then
		for iter_25_0, iter_25_1 in pairs(var_25_1) do
			if iter_25_1[1] ~= 0 and HeroCfg[iter_25_1[1]] and HeroCfg[iter_25_1[1]].private == 0 then
				table.insert(var_25_0, iter_25_1[2])
			end
		end
	end

	return var_25_0
end

function var_0_0.GetDefaultHeroData(arg_26_0)
	if arg_26_0.params_.curSelectHeroData and arg_26_0.params_.curSelectHeroData.id ~= 0 then
		for iter_26_0, iter_26_1 in ipairs(arg_26_0.heroDataList_) do
			if iter_26_1.id == arg_26_0.params_.curSelectHeroData.id and iter_26_1.trialID == arg_26_0.params_.curSelectHeroData.trialID then
				return arg_26_0.params_.curSelectHeroData
			end
		end
	end

	if not arg_26_0.params_.isBack then
		local var_26_0 = arg_26_0.heroTeam_[arg_26_0.params_.selectHeroPos] or 0
		local var_26_1 = arg_26_0.heroTrialList_[arg_26_0.params_.selectHeroPos] or 0

		if var_26_0 ~= 0 then
			for iter_26_2, iter_26_3 in ipairs(arg_26_0.heroDataList_) do
				if iter_26_3.id == var_26_0 and iter_26_3.trialID == var_26_1 then
					return iter_26_3
				end
			end

			return {
				id = var_26_0,
				trialID = var_26_1,
				type = arg_26_0.heroDataType_,
				heroViewProxy = arg_26_0:GetHeroViewProxy(arg_26_0.heroDataType_)
			}
		end
	end

	for iter_26_4, iter_26_5 in ipairs(arg_26_0.heroDataList_) do
		local var_26_2 = iter_26_5.id
		local var_26_3 = iter_26_5.trialID

		if not arg_26_0:IsInTeam(var_26_2, iter_26_5.trialID) and not table.keyof(arg_26_0.lockHeroList_, var_26_2) and not table.keyof(arg_26_0.lockHeroList_, var_26_3) then
			return iter_26_5
		end
	end

	if #arg_26_0.heroDataList_ > 0 then
		return arg_26_0.heroDataList_[1]
	end

	return nil
end

function var_0_0.OnJoinClick(arg_27_0)
	local var_27_0 = arg_27_0.heroTeam_
	local var_27_1 = arg_27_0.heroTrialList_
	local var_27_2 = arg_27_0:IsSameHeroInTeam(arg_27_0.selectHeroData_.id)

	if arg_27_0.selectHeroData_.id == var_27_0[arg_27_0.params_.selectHeroPos] and arg_27_0.selectHeroData_.trialID == var_27_1[arg_27_0.params_.selectHeroPos] and var_27_2 then
		var_27_0[arg_27_0.params_.selectHeroPos] = 0
		var_27_1[arg_27_0.params_.selectHeroPos] = 0
	elseif var_27_2 then
		local var_27_3 = 1

		for iter_27_0, iter_27_1 in pairs(var_27_0) do
			if iter_27_1 == arg_27_0.selectHeroData_.id then
				var_27_3 = iter_27_0

				break
			end
		end

		if var_27_0[var_27_3] == arg_27_0.selectHeroData_.id and var_27_1[var_27_3] ~= arg_27_0.selectHeroData_.trialID then
			var_27_0[var_27_3] = arg_27_0.selectHeroData_.id
			var_27_1[var_27_3] = arg_27_0.selectHeroData_.trialID
		end

		local var_27_4 = var_27_0[var_27_3]

		var_27_0[var_27_3] = var_27_0[arg_27_0.params_.selectHeroPos]
		var_27_0[arg_27_0.params_.selectHeroPos] = var_27_4

		local var_27_5 = var_27_1[var_27_3]

		var_27_1[var_27_3] = var_27_1[arg_27_0.params_.selectHeroPos]
		var_27_1[arg_27_0.params_.selectHeroPos] = var_27_5

		HeroTools.PlayTalk(arg_27_0.selectHeroData_.id, "team")
	else
		var_27_0[arg_27_0.params_.selectHeroPos] = arg_27_0.selectHeroData_.id
		var_27_1[arg_27_0.params_.selectHeroPos] = arg_27_0.selectHeroData_.trialID

		HeroTools.PlayTalk(arg_27_0.selectHeroData_.id, "team")
	end

	if arg_27_0.canSwitchResctrictHeroList_[arg_27_0.params_.selectHeroPos] == ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID and (arg_27_0.params_.reorder == nil or arg_27_0.params_.reorder == true) then
		local var_27_6 = 1
		local var_27_7 = 2

		while var_27_6 <= 3 and var_27_7 <= 3 do
			if var_27_0[var_27_6] == 0 then
				if arg_27_0.canSwitchResctrictHeroList_[var_27_7] == ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID and var_27_0[var_27_7] ~= 0 then
					var_27_0[var_27_6] = var_27_0[var_27_7]
					var_27_1[var_27_6] = var_27_1[var_27_7]
					var_27_0[var_27_7] = 0
					var_27_1[var_27_7] = 0
					var_27_6 = var_27_7
				end
			else
				var_27_6 = var_27_6 + 1
			end

			var_27_7 = var_27_7 + 1
		end
	end

	arg_27_0:TryToChangeTeam(var_27_0, var_27_1)
end

function var_0_0.TryToChangeTeam(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0:ChangeTeam(arg_28_1, arg_28_2)
	arg_28_0:OnChangeTeamSuccess()
end

function var_0_0.ChangeTeam(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0.sectionProxy_:ChangeHeroTeam(arg_29_1, arg_29_2)
end

function var_0_0.OnChangeTeamSuccess(arg_30_0)
	arg_30_0.heroAvatarView_:RemoveTween()
	arg_30_0:Back(1, {
		isSorted = true
	})
end

function var_0_0.IsInTeam(arg_31_0, arg_31_1, arg_31_2)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.heroTeam_) do
		if arg_31_1 == iter_31_1 and arg_31_2 == arg_31_0.heroTrialList_[iter_31_0] then
			return true, iter_31_0 == 1, iter_31_0
		end
	end

	return false, false, -1
end

function var_0_0.IsSameHeroInTeam(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in pairs(arg_32_0.heroTeam_) do
		if arg_32_1 == iter_32_1 then
			return true
		end
	end

	return false
end

function var_0_0.IsCustomTeamStage(arg_33_0)
	local var_33_0 = BattleStageTools.GetRestrictHeroList(arg_33_0.params_.stageType, arg_33_0.params_.stageID)

	return type(var_33_0) == "table"
end

function var_0_0.GetHeroHeadClass(arg_34_0)
	return SectionHeroTeamHeadItem
end

function var_0_0.HeadRenderer(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0.heroDataList_[arg_35_1].id
	local var_35_1 = arg_35_0.heroDataList_[arg_35_1].trialID

	arg_35_2:SetSectionHeroData(arg_35_0.heroDataList_[arg_35_1])
	arg_35_2:SetSelected(arg_35_2.heroId_ == arg_35_0.selectHeroData_.id and arg_35_2.trialID_ == arg_35_0.selectHeroData_.trialID)
	arg_35_2:RegisterClickListener(function()
		arg_35_0:SelectHero(arg_35_0.heroDataList_[arg_35_1])
	end)
	arg_35_2:SetInTeamFlag(arg_35_0:IsInTeam(var_35_0, var_35_1))
	arg_35_2:SetHeroLock(table.keyof(arg_35_0.lockHeroList_, var_35_0) ~= nil or table.keyof(arg_35_0.lockHeroList_, var_35_1) ~= nil)
end

function var_0_0.GetHeroViewProxy(arg_37_0, arg_37_1)
	if not arg_37_0.heroViewProxyDic_[arg_37_1] then
		arg_37_0.heroViewProxyDic_[arg_37_1] = HeroViewDataProxy.New(arg_37_1)
	end

	return arg_37_0.heroViewProxyDic_[arg_37_1]
end

function var_0_0.GetFilterClass(arg_38_0)
	return NewHeroListFilterView
end

function var_0_0.ExtraSorter(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	local var_39_0 = arg_39_0.heroTeam_
	local var_39_1 = arg_39_0.heroTrialList_
	local var_39_2 = {}

	for iter_39_0, iter_39_1 in pairs(var_39_0) do
		var_39_2[iter_39_0] = {
			id = iter_39_1,
			trialID = var_39_1[iter_39_0]
		}
	end

	local var_39_3 = arg_39_0:indexof(var_39_2, arg_39_1)
	local var_39_4 = arg_39_0:indexof(var_39_2, arg_39_2)

	if var_39_3 ~= var_39_4 then
		return true, var_39_3 < var_39_4
	end

	if arg_39_1.trialID ~= 0 or arg_39_2.trialID ~= 0 then
		if arg_39_1.trialID ~= 0 and arg_39_2.trialID ~= 0 then
			if arg_39_3 == 0 and arg_39_1.star ~= arg_39_2.star then
				if arg_39_0.curOrder_ == "desc" then
					return true, arg_39_1.star > arg_39_2.star
				else
					return true, arg_39_1.star < arg_39_2.star
				end
			end

			local var_39_5 = getHeroPower(arg_39_1.trialID, true)
			local var_39_6 = getHeroPower(arg_39_2.trialID, true)

			if var_39_5 ~= var_39_6 then
				if arg_39_4 == "desc" then
					return true, var_39_6 < var_39_5
				else
					return true, var_39_5 < var_39_6
				end
			else
				return true, arg_39_1.trialID > arg_39_2.trialID
			end
		else
			return true, arg_39_1.trialID > arg_39_2.trialID
		end
	end

	return false, false
end

function var_0_0.OnListChange(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0.heroDataList_ = arg_40_2
	arg_40_0.selectHeroData_ = arg_40_0.heroDataList_[1]

	arg_40_0.heroHeadList_:StartScroll(#arg_40_0.heroDataList_)

	if #arg_40_0.heroDataList_ == 0 then
		arg_40_0.emptyController_:SetSelectedState("true")
		arg_40_0.heroAvatarView_:ShowHeroModel(false)
	else
		arg_40_0.emptyController_:SetSelectedState("false")
		arg_40_0.heroAvatarView_:ShowHeroModel(true)

		if not arg_40_0.params_.isEnter then
			arg_40_0:SelectHero(arg_40_0.heroDataList_[1])
		else
			arg_40_0.params_.isEnter = false
		end
	end
end

function var_0_0.indexof(arg_41_0, arg_41_1, arg_41_2)
	for iter_41_0 = 1, #arg_41_1 do
		if arg_41_1[iter_41_0].id == arg_41_2.id and arg_41_1[iter_41_0].trialID == arg_41_2.trialID then
			return iter_41_0
		end
	end

	return 9999
end

function var_0_0.OnHeroSort(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5)
	arg_42_0.filterView_:RefreshSort(arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5)
	HeroData:SaveSortValue(arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5)
end

function var_0_0.GetTrialHeroList(arg_43_0)
	return GetTrialHeroList(arg_43_0.params_.stageType, arg_43_0.params_.stageID, arg_43_0.params_.activityID)
end

return var_0_0
