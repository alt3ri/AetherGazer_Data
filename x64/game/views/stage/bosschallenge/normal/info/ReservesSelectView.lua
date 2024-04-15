local var_0_0 = class("ReservesSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/StagePrepare/HeroTeamInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.emptyController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "empty")
	arg_4_0.contorller_ = ControllerUtil.GetController(arg_4_0.joinBtn_.transform, "upgradeBtn")
	arg_4_0.heroAvatarView_ = HeroAvatarView.New(arg_4_0, arg_4_0.displayGo_)
	arg_4_0.heroHeadList_ = LuaList.New(handler(arg_4_0, arg_4_0.HeadRenderer), arg_4_0.uiListGo_, HeroTeamHeadItem)
	arg_4_0.filterView_ = NewHeroListFilterView.New(arg_4_0.filterGo_)

	arg_4_0.filterView_:SetExtraSorter(handler(arg_4_0, arg_4_0.ExtraSorter))
	arg_4_0.filterView_:SetListChangeHandler(handler(arg_4_0, arg_4_0.OnListChange))

	arg_4_0.favoriteCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "favorite")
end

function var_0_0.HeadRenderer(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.heroIDList_[arg_5_1]

	arg_5_2:SetHeroId(var_5_0)
	arg_5_2:SetRedPointEnable(false)

	arg_5_2.gameObject_.name = tostring(var_5_0)

	arg_5_2:SetSelected(arg_5_2.heroId_ == arg_5_0.selectID_)
	arg_5_2:SetInTeamFlag(arg_5_0:IsInTeam(var_5_0))
	arg_5_2:SetHp(false)
	arg_5_2:SetLove(HeroData:IsFavorite(var_5_0) == false)
	arg_5_2:RegisterClickListener(function()
		arg_5_0:SelectHero(arg_5_2.heroId_)
	end)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.infoBtn_, nil, function()
		arg_7_0:Go("/newHero", {
			isEnter = true,
			hid = arg_7_0.selectID_,
			type = HeroConst.HERO_DATA_TYPE.ADVANCETEST
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.joinBtn_, nil, handler(arg_7_0, arg_7_0.OnJoinClick))
	arg_7_0:AddBtnListener(arg_7_0.favoriteBtn_, nil, function()
		if HeroData:IsFavorite(arg_7_0.selectID_) then
			HeroAction.SetFavoriteHeroOff(arg_7_0.selectID_)
		else
			HeroAction.SetFavoriteHeroOn(arg_7_0.selectID_)
		end
	end)
end

function var_0_0.OnEnter(arg_10_0)
	manager.ui:SetMainCamera("hero")
	arg_10_0.filterView_:Reset(true)

	if arg_10_0.heroAvatarView_ then
		arg_10_0.heroAvatarView_:OnEnter()
	end

	arg_10_0.heroTeam_ = arg_10_0.params_.hero_list
	arg_10_0.index_ = arg_10_0.params_.index
	arg_10_0.pos_ = arg_10_0.params_.pos

	arg_10_0.filterView_:SetHeroIdList(arg_10_0:GetHeroList())

	arg_10_0.selectID_ = arg_10_0:GetDefaultHeroID()

	arg_10_0:SelectHero(arg_10_0.selectID_)
	arg_10_0.heroHeadList_:StartScroll(#arg_10_0.heroIDList_, table.keyof(arg_10_0.heroIDList_, arg_10_0.selectID_))
	arg_10_0:RegistEventListener(FAVORITE_HERO, handler(arg_10_0, arg_10_0.OnHeroFavorite))
end

function var_0_0.IsInTeam(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.heroTeam_) do
		if arg_11_1 == iter_11_1 then
			return true, iter_11_0 == 1, iter_11_0
		end
	end

	return false, false, -1
end

function var_0_0.SelectHero(arg_12_0, arg_12_1)
	arg_12_0.selectID_ = arg_12_1

	for iter_12_0, iter_12_1 in pairs(arg_12_0.heroHeadList_:GetItemList()) do
		iter_12_1:SetSelected(iter_12_1.heroId_ == arg_12_1)
	end

	arg_12_0:UpdateHeroView()
	arg_12_0:RefreshJoinBtn()
	arg_12_0:RefreshFavorite()
end

function var_0_0.UpdateHeroView(arg_13_0)
	local var_13_0

	if arg_13_0.isAdvanceTest_ then
		var_13_0 = AdvanceTestData:GetAdvanceHeroData(arg_13_0.selectID_)
		arg_13_0.fightPowerText_.text = AdvanceTestData:GetBattlePower(var_13_0)
	else
		var_13_0 = HeroData:GetHeroData(arg_13_0.selectID_)
		arg_13_0.fightPowerText_.text = getBattlePower(var_13_0)
	end

	arg_13_0.heroAvatarView_:SetSkinId(var_13_0.using_skin == 0 and var_13_0.id or var_13_0.using_skin)

	local var_13_1 = HeroCfg[var_13_0.id]

	arg_13_0.nameText_.text = GetI18NText(var_13_1.name)
	arg_13_0.subNameText_.text = GetI18NText(var_13_1.suffix)
end

function var_0_0.RefreshJoinBtn(arg_14_0)
	arg_14_0.joinBtn_.interactable = true

	if arg_14_0.selectID_ == arg_14_0.heroTeam_[arg_14_0.pos_] and arg_14_0.heroTeam_[arg_14_0.pos_] ~= 0 then
		arg_14_0.contorller_:SetSelectedState("2")

		arg_14_0.joinText_.text = string.format("<color=#EBEBEB>%s</color>", GetTips("REMOVE_FROM_TEAM"))
	else
		arg_14_0.contorller_:SetSelectedState("0")

		arg_14_0.joinText_.text = string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER"))
	end
end

function var_0_0.ExtraSorter(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.heroTeam_
	local var_15_1 = arg_15_0:indexof(var_15_0, arg_15_1)
	local var_15_2 = arg_15_0:indexof(var_15_0, arg_15_2)

	if var_15_1 ~= var_15_2 then
		return true, var_15_1 < var_15_2
	end

	return false, false
end

function var_0_0.indexof(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	for iter_16_0 = arg_16_3 or 1, #arg_16_1 do
		if arg_16_1[iter_16_0] == arg_16_2 then
			return iter_16_0
		end
	end

	return 9999
end

function var_0_0.OnListChange(arg_17_0, arg_17_1)
	arg_17_0.heroIDList_ = arg_17_1

	arg_17_0.heroHeadList_:StartScroll(#arg_17_0.heroIDList_)

	if #arg_17_0.heroIDList_ > 0 then
		arg_17_0.emptyController_:SetSelectedState("false")

		if arg_17_0:indexof(arg_17_0.heroIDList_, arg_17_0.params_.heroID) > #arg_17_0.heroIDList_ then
			arg_17_0:SelectHero(arg_17_0.heroIDList_[1])
		else
			arg_17_0:SelectHero(arg_17_0.params_.heroID)
		end
	else
		arg_17_0.emptyController_:SetSelectedState("true")
	end
end

function var_0_0.OnJoinClick(arg_18_0)
	arg_18_0:RefreshCombo()

	if arg_18_0.selectID_ == arg_18_0.heroTeam_[arg_18_0.pos_] and arg_18_0.heroTeam_[arg_18_0.pos_] ~= 0 then
		BattleTeamData:SetReservesTempTeamList(arg_18_0.index_, arg_18_0.pos_, 0)
	else
		BattleTeamData:SetReservesTempTeamList(arg_18_0.index_, arg_18_0.pos_, arg_18_0.selectID_)
	end

	arg_18_0:Back(1, {
		isInit = false
	})
end

function var_0_0.GetHeroList(arg_19_0)
	local var_19_0

	if arg_19_0.isAdvanceTest_ then
		var_19_0 = HeroTools.Sort(AdvanceTestData:GetHeroList())
	else
		var_19_0 = HeroTools.Sort(HeroData:GetHeroList())
	end

	return var_19_0
end

function var_0_0.GetDefaultHeroID(arg_20_0)
	local var_20_0 = arg_20_0.heroTeam_[arg_20_0.pos_]

	if var_20_0 and var_20_0 ~= 0 then
		return var_20_0
	end

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.heroIDList_) do
		if not arg_20_0:IsInTeam(iter_20_1) then
			return iter_20_1
		end
	end

	for iter_20_2, iter_20_3 in ipairs(arg_20_0.heroIDList_) do
		return iter_20_3
	end

	return 0
end

function var_0_0.RefreshCombo(arg_21_0)
	local var_21_0 = arg_21_0.params_.combo ~= 0 and arg_21_0.params_.combo or nil
	local var_21_1 = deepClone(arg_21_0.heroTeam_)

	if arg_21_0.selectID_ == arg_21_0.heroTeam_[arg_21_0.pos_] and arg_21_0.heroTeam_[arg_21_0.pos_] ~= 0 then
		var_21_1[arg_21_0.pos_] = 0
	else
		var_21_1[arg_21_0.pos_] = arg_21_0.selectID_
	end

	local var_21_2 = ComboSkillTools.CheckError(var_21_0, var_21_1, true)

	if var_21_2 ~= var_21_0 then
		BattleTeamData:ChangeComboSkillID(arg_21_0.index_, var_21_2)
	end
end

function var_0_0.OnTop(arg_22_0)
	arg_22_0:ShowDefaultBar()
	manager.windowBar:RegistBackCallBack(function()
		arg_22_0:Back(1, {
			isInit = false
		})
	end)
end

function var_0_0.RefreshFavorite(arg_24_0)
	SetActive(arg_24_0.favoriteBtn_.gameObject, true)
	arg_24_0.favoriteCon_:SetSelectedState(HeroData:IsFavorite(arg_24_0.selectID_) == false and "false" or "true")
end

function var_0_0.OnHeroFavorite(arg_25_0)
	arg_25_0:RefreshFavorite()
	arg_25_0.heroHeadList_:Refresh()
end

function var_0_0.OnHeroSort(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5)
	arg_26_0.filterView_:RefreshSort(arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5)
	HeroData:SaveSortValue(arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5)
end

function var_0_0.OnExit(arg_27_0)
	if arg_27_0.filterView_ and arg_27_0.filterView_.OnExit then
		arg_27_0.filterView_:OnExit()
	end

	arg_27_0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if arg_27_0.heroAvatarView_ then
		arg_27_0.heroAvatarView_:OnExit()
	end

	if #arg_27_0.heroIDList_ <= 0 then
		HeroData:ResetSortValue()
		arg_27_0.filterView_:Reset()
	end
end

function var_0_0.Dispose(arg_28_0)
	arg_28_0:RemoveAllListeners()

	if arg_28_0.filterView_ then
		arg_28_0.filterView_:Dispose()

		arg_28_0.filterView_ = nil
	end

	if arg_28_0.heroHeadList_ then
		arg_28_0.heroHeadList_:Dispose()

		arg_28_0.heroHeadList_ = nil
	end

	if arg_28_0.heroAvatarView_ then
		arg_28_0.heroAvatarView_:Dispose()

		arg_28_0.heroAvatarView_ = nil
	end

	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
