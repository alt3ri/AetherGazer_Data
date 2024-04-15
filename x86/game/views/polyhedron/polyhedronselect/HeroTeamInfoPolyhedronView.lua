local var_0_0 = import("game.views.heroTeamInfo.HeroTeamInfoBaseView")
local var_0_1 = class("HeroTeamInfoPolyhedronView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Polyhedron/HeroPolyhedronTeamInfoUI"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.emptyController_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "empty")
	arg_2_0.contorller_ = ControllerUtil.GetController(arg_2_0.joinBtn_.transform, "upgradeBtn")
	arg_2_0.heroAvatarView_ = HeroAvatarView.New(arg_2_0, arg_2_0.displayGo_)
	arg_2_0.heroHeadList_ = LuaList.New(handler(arg_2_0, arg_2_0.HeadRenderer), arg_2_0.uiListGo_, PolyhedronTeamHeadItem)
	arg_2_0.filterView_ = arg_2_0:GetFilterClass().New(arg_2_0.filterGo_)

	arg_2_0.filterView_:SetExtraSorter(handler(arg_2_0, arg_2_0.ExtraSorter))
	arg_2_0.filterView_:SetListChangeHandler(handler(arg_2_0, arg_2_0.OnListChange))
end

function var_0_1.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_infoBtn, nil, function()
		PolyhedronData:SetCacheSelectHero(arg_3_0.selectID_)

		local var_4_0 = arg_3_0:GetCustomHeroList()

		if not table.keyof(var_4_0, arg_3_0.selectTrialID_) then
			var_4_0 = arg_3_0.trialHeroList_
		end

		arg_3_0:Go("/polyhedronHero", {
			isEnter = true,
			hid = arg_3_0.selectTrialID_ ~= 0 and arg_3_0.selectTrialID_ or arg_3_0.selectID_,
			isTemp = arg_3_0.selectTrialID_ ~= 0 and true or false,
			tempHeroList = var_4_0
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.m_okBtn, nil, function()
		PolyhedronData:SetCacheSelectHero(arg_3_0.selectID_)
		JumpTools.OpenPageByJump("/polyhedronBeacon", {})
	end)
	arg_3_0:AddBtnListener(arg_3_0.m_backBtn, nil, function()
		arg_3_0:Back()
	end)
end

function var_0_1.HeadRenderer(arg_7_0, arg_7_1, arg_7_2)
	var_0_1.super.HeadRenderer(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2.lockedController_:SetSelectedState("false")

	local var_7_0 = arg_7_0.heroDataList_[arg_7_1].id
	local var_7_1 = PolyhedronHeroCfg[var_7_0].standard_id
	local var_7_2 = HeroStandardSystemCfg[var_7_1]

	arg_7_2.levelText_.text = var_7_2.hero_lv
end

function var_0_1.UpdateHeroView(arg_8_0)
	local var_8_0 = arg_8_0.selectID_
	local var_8_1 = HeroCfg[var_8_0]

	arg_8_0.m_heroName.text = GetI18NText(var_8_1.name)
	arg_8_0.m_heroSuffix.text = GetI18NText(var_8_1.suffix)

	local var_8_2 = PolyhedronHeroCfg[var_8_0].standard_id
	local var_8_3 = PolyhedronData:GetHeroUsingSkinInfo(var_8_0).id

	arg_8_0.heroAvatarView_:SetSkinId(var_8_3)

	arg_8_0.fightPowerText_.text = arg_8_0.heroViewProxy_:GetBattlePower(var_8_0)
end

function var_0_1.IsInTeam(arg_9_0, arg_9_1, arg_9_2)
	return false, false, -1
end

function var_0_1.GetHeroTeam(arg_10_0)
	arg_10_0.heroTeam_ = arg_10_0.params_.heroTeam
	arg_10_0.lockStateList_ = {}
	arg_10_0.lockHeroList_ = {}
	arg_10_0.heroTrialList_ = {
		0
	}
end

function var_0_1.GetDefaultHeroData(arg_11_0)
	local var_11_0 = PolyhedronData:GetCacheSelectHero()

	if var_11_0 ~= 0 then
		return var_11_0, 0
	end

	local var_11_1 = arg_11_0.heroTeam_[arg_11_0.params_.selectHeroPos] or 0

	if var_11_1 == 0 then
		for iter_11_0, iter_11_1 in pairs(arg_11_0.heroDataList_) do
			local var_11_2 = iter_11_1.id

			if not arg_11_0:IsInTeam(var_11_2) and not table.keyof(arg_11_0.lockHeroList_, var_11_2) then
				return var_11_2, 0
			end
		end
	end

	if var_11_1 == 0 then
		for iter_11_2, iter_11_3 in pairs(arg_11_0.heroDataList_) do
			return iter_11_3.id, 0
		end
	end

	return var_11_1, 0
end

function var_0_1.GetHeroList(arg_12_0)
	return PolyhedronData:GetUnlockHeroList()
end

return var_0_1
