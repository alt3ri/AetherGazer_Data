local var_0_0 = import("game.views.heroTeamInfo.HeroTeamInfoBaseView")
local var_0_1 = class("NewWarChessHeroTeamInfoView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	arg_1_0.roomProxy_ = arg_1_0.params_.roomProxy

	manager.ui:SetMainCamera("hero")

	if arg_1_0.params_.isEnter then
		if arg_1_0.filterView_ then
			arg_1_0.filterView_:Reset(true)
		end

		arg_1_0.params_.isEnter = false
	end

	manager.windowBar:SwitchBar({
		BACK_BAR
	})

	if arg_1_0.heroAvatarView_ then
		arg_1_0.heroAvatarView_:OnEnter()
	end

	arg_1_0.teamInfo_ = arg_1_0:GetHeroTeam()
	arg_1_0.trialHeroList_ = NewWarChessData:GetHeroIDList()

	local var_1_0 = HideInfoData.GetHeroHideList()
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_0.trialHeroList_) do
		local var_1_2 = HeroStandardSystemCfg[iter_1_1]

		if not table.keyof(customIDList, iter_1_1) then
			table.insert(var_1_1, {
				id = var_1_2.hero_id,
				trialID = iter_1_1,
				type = HeroConst.HERO_DATA_TYPE.TRIAL
			})
		end
	end

	arg_1_0.filterView_:ShowDropDown(true)

	local var_1_3 = {}
	local var_1_4 = BattleStageTools.GetRestrictHeroList(arg_1_0.params_.stageType, arg_1_0.params_.stageID)

	if type(var_1_4) == "table" then
		if var_1_4[arg_1_0.params_.selectHeroPos][1] then
			var_1_1 = {}

			arg_1_0.filterView_:ShowDropDown(false)
		end

		for iter_1_2, iter_1_3 in pairs(var_1_4) do
			if iter_1_3[1] ~= 0 and HeroCfg[iter_1_3[1]] and table.keyof(HeroCfg.get_id_list_by_private[0], iter_1_3[1]) then
				table.insert(var_1_1, {
					id = iter_1_3[1],
					trialID = iter_1_3[2],
					type = HeroConst.HERO_DATA_TYPE.CUSTOM
				})
				table.insert(var_1_3, iter_1_3[2])
			end
		end
	end

	arg_1_0.filterView_:SetHeroDataList(var_1_1)

	arg_1_0.selectID_, arg_1_0.selectTrialID_ = arg_1_0:GetDefaultHeroData()

	arg_1_0:SelectHero(arg_1_0.selectID_, arg_1_0.selectTrialID_)
	arg_1_0.heroHeadList_:StartScroll(#arg_1_0.heroDataList_, table.keyof(arg_1_0.heroDataList_, arg_1_0.selectID_))
	SetActive(arg_1_0.favoriteBtn_.gameObject, false)
end

function var_0_1.GetDefaultHeroData(arg_2_0)
	local var_2_0, var_2_1 = BattleFieldData:GetCurrentSelectHeroID()

	if var_2_0 ~= 0 then
		return var_2_0, var_2_1
	end

	local var_2_2 = arg_2_0.heroTeam_[arg_2_0.params_.selectHeroPos] or 0

	if var_2_2 == 0 then
		for iter_2_0, iter_2_1 in pairs(arg_2_0.heroDataList_) do
			local var_2_3 = iter_2_1.id
			local var_2_4 = NewWarChessData:GetHeroHp(var_2_3)

			if not arg_2_0:IsInTeam(var_2_3, iter_2_1.trialID) and var_2_4 > 0 then
				return var_2_3, iter_2_1.trialID
			end
		end
	end

	if var_2_2 == 0 then
		for iter_2_2, iter_2_3 in pairs(arg_2_0.heroDataList_) do
			if NewWarChessData:GetHeroHp(iter_2_3.id) > 0 then
				return iter_2_3.id, iter_2_3.trialID
			end
		end
	end

	return var_2_2, 0
end

function var_0_1.HeadRenderer(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.heroDataList_[arg_3_1].id
	local var_3_1 = arg_3_0.heroDataList_[arg_3_1].trialID
	local var_3_2 = arg_3_0.heroDataList_[arg_3_1].type

	arg_3_2:SetRedPointEnable(false)

	arg_3_2.gameObject_.name = tostring(var_3_0)

	if var_3_2 == HeroConst.HERO_DATA_TYPE.DEFAULT then
		arg_3_2:SetHeroData(var_3_0, HeroConst.HERO_DATA_TYPE.DEFAULT, {
			tempHeroList = arg_3_0.trialHeroList_
		})
		arg_3_2:SetTrial(false)
	elseif var_3_2 == HeroConst.HERO_DATA_TYPE.TRIAL then
		arg_3_2:SetHeroData(var_3_1, HeroConst.HERO_DATA_TYPE.TRIAL, {
			tempHeroList = arg_3_0.trialHeroList_
		})
		arg_3_2:SetTrial(false)
	elseif var_3_2 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		arg_3_2:SetHeroData(var_3_1, HeroConst.HERO_DATA_TYPE.CUSTOM, {
			tempHeroList = arg_3_0:GetCustomHeroList()
		})
		arg_3_2:SetTrial(false)
	elseif var_3_2 == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		arg_3_2:SetHeroData(var_3_0, HeroConst.HERO_DATA_TYPE.ADVANCETEST, {
			tempHeroList = arg_3_0.trialHeroList_
		})
		arg_3_2:SetTrial(false)
	end

	arg_3_2:SetSelected(arg_3_2.heroId_ == arg_3_0.selectID_ and arg_3_2.trialID_ == arg_3_0.selectTrialID_)
	arg_3_2:SetInTeamFlag(arg_3_0:IsInTeam(var_3_0, var_3_1))
	arg_3_2:SetLove(var_3_2 ~= HeroConst.HERO_DATA_TYPE.DEFAULT or HeroData:IsFavorite(var_3_0) == false)

	local var_3_3 = NewWarChessData:GetHeroHp(arg_3_2.heroId_)

	arg_3_2:RefreshHpValue(math.ceil(var_3_3 / NewChessConst.HERO_HP_RATE * 100))
	arg_3_2:SetHp(true)

	if var_3_3 <= 0 then
		arg_3_2:SetLocking(true)
	else
		arg_3_2:SetLocking(false)
	end

	arg_3_2:RegisterClickListener(function()
		if arg_3_0.backFlag_ then
			return
		end

		if NewWarChessData:GetHeroHp(arg_3_2.heroId_) <= 0 then
			ShowTips("ACTIVITY_NEW_WARCHESS_HERO_DIE")

			return
		end

		arg_3_0:SelectHero(arg_3_2.heroId_, arg_3_2.trialID_)
	end)
end

return var_0_1
