local var_0_0 = import("game.views.heroTeamInfo.HeroTeamInfoBaseView")
local var_0_1 = class("HeroTeamInfoChessView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	arg_1_0.teamLength_ = arg_1_0.params_.teamLength

	var_0_1.super.OnEnter(arg_1_0)
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.emptyController_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "empty")
	arg_2_0.contorller_ = ControllerUtil.GetController(arg_2_0.joinBtn_.transform, "upgradeBtn")
	arg_2_0.heroAvatarView_ = HeroAvatarView.New(arg_2_0, arg_2_0.displayGo_)
	arg_2_0.heroHeadList_ = LuaList.New(handler(arg_2_0, arg_2_0.HeadRenderer), arg_2_0.uiListGo_, ChessHeroTeamHeadItem)
	arg_2_0.filterView_ = arg_2_0:GetFilterClass().New(arg_2_0.filterGo_)

	arg_2_0.filterView_:SetExtraSorter(handler(arg_2_0, arg_2_0.ExtraSorter))
	arg_2_0.filterView_:SetListChangeHandler(handler(arg_2_0, arg_2_0.OnListChange))
end

function var_0_1.ExtraSorter(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = arg_3_0.heroTeam_
	local var_3_1 = arg_3_0.heroTrialList_
	local var_3_2 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		var_3_2[iter_3_0] = {
			id = iter_3_1,
			trialID = var_3_1[iter_3_0]
		}
	end

	local var_3_3 = arg_3_0:indexof(var_3_2, arg_3_1)
	local var_3_4 = arg_3_0:indexof(var_3_2, arg_3_2)

	if var_3_3 ~= var_3_4 then
		return true, var_3_3 < var_3_4
	end

	if arg_3_1.trialID ~= 0 or arg_3_2.trialID ~= 0 then
		if arg_3_1.trialID ~= 0 and arg_3_2.trialID ~= 0 then
			if arg_3_3 == 0 and arg_3_1.star ~= arg_3_2.star then
				if arg_3_0.curOrder_ == "desc" then
					return true, arg_3_1.star > arg_3_2.star
				else
					return true, arg_3_1.star < arg_3_2.star
				end
			end

			local var_3_5 = getHeroPower(arg_3_1.trialID, true)
			local var_3_6 = getHeroPower(arg_3_2.trialID, true)

			if var_3_5 ~= var_3_6 then
				if arg_3_4 == "desc" then
					return true, var_3_6 < var_3_5
				else
					return true, var_3_5 < var_3_6
				end
			else
				return true, arg_3_1.trialID > arg_3_2.trialID
			end
		else
			return true, arg_3_1.trialID > arg_3_2.trialID
		end
	end

	return false, false
end

function var_0_1.HeadRenderer(arg_4_0, arg_4_1, arg_4_2)
	var_0_1.super.HeadRenderer(arg_4_0, arg_4_1, arg_4_2)

	local var_4_0 = arg_4_0.heroDataList_[arg_4_1].id

	arg_4_2:RefreshTeamTag(arg_4_0.params_.reserveParams.contID, arg_4_0.params_.reserveParams.teamIndex, arg_4_0.teamLength_)
	arg_4_2:SetHeroLock(table.keyof(arg_4_0.lockHeroList_, var_4_0) ~= nil)
end

function var_0_1.SelectHero(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.selectID_ = arg_5_1
	arg_5_0.selectTrialID_ = arg_5_2

	for iter_5_0, iter_5_1 in pairs(arg_5_0.heroHeadList_:GetItemList()) do
		iter_5_1:SetSelected(iter_5_1.heroId_ == arg_5_1)
	end

	arg_5_0:UpdateHeroView()
	arg_5_0:RefreshJoinBtn()
end

function var_0_1.GetDefaultHeroData(arg_6_0)
	local var_6_0 = arg_6_0.heroTeam_[arg_6_0.params_.selectHeroPos] or 0

	if var_6_0 == 0 then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.heroDataList_) do
			local var_6_1 = iter_6_1.id

			if not arg_6_0:IsInTeam(var_6_1) and not table.keyof(arg_6_0.lockHeroList_, var_6_1) then
				return var_6_1, 0
			end
		end
	end

	if var_6_0 == 0 then
		for iter_6_2, iter_6_3 in pairs(arg_6_0.heroDataList_) do
			return iter_6_3.id, 0
		end
	end

	return var_6_0, 0
end

function var_0_1.IsInTeam(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.heroTeam_

	for iter_7_0 = 1, #var_7_0 do
		if var_7_0[iter_7_0] == arg_7_1 then
			return true
		end
	end

	return false
end

function var_0_1.GetTextAndImage(arg_8_0)
	if arg_8_0.lockStateList_[arg_8_0.params_.selectHeroPos] == true then
		arg_8_0.joinBtn_.interactable = false

		return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
	end

	if table.keyof(arg_8_0.lockHeroList_, arg_8_0.selectID_) or table.keyof(arg_8_0.lockHeroList_, arg_8_0.selectTrialID_) then
		arg_8_0.joinBtn_.interactable = false

		return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
	end

	if arg_8_0:IsSameHeroInTeam(arg_8_0.selectID_) and not arg_8_0:IsInTeam(arg_8_0.selectID_, arg_8_0.selectTrialID_) then
		if arg_8_0.heroTeam_[arg_8_0.params_.selectHeroPos] ~= arg_8_0.selectID_ then
			arg_8_0.joinBtn_.interactable = false

			return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
		else
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		end
	end

	if arg_8_0.heroTeam_[arg_8_0.params_.selectHeroPos] == 0 then
		if arg_8_0:IsInTeam(arg_8_0.selectID_, arg_8_0.selectTrialID_) then
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		else
			return string.format("<color=#222222>%s</color>", GetTips("JOIN_TEAM")), "0"
		end
	end

	if arg_8_0.selectID_ == arg_8_0.heroTeam_[arg_8_0.params_.selectHeroPos] then
		local var_8_0 = 0

		for iter_8_0, iter_8_1 in pairs(arg_8_0.heroTeam_) do
			if iter_8_1 ~= 0 then
				var_8_0 = var_8_0 + 1
			end
		end

		return string.format("<color=#EBEBEB>%s</color>", GetTips("REMOVE_FROM_TEAM")), "2"
	end

	return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
end

function var_0_1.OnJoinClick(arg_9_0)
	local var_9_0 = clone(arg_9_0.heroTeam_)
	local var_9_1 = clone(arg_9_0.heroTrialList_)
	local var_9_2 = arg_9_0:IsInTeam(arg_9_0.selectID_, arg_9_0.selectTrialID_)

	if arg_9_0.selectID_ == arg_9_0.heroTeam_[arg_9_0.params_.selectHeroPos] and var_9_2 then
		var_9_0[arg_9_0.params_.selectHeroPos] = 0
		var_9_1[arg_9_0.params_.selectHeroPos] = 0
	elseif var_9_2 then
		local var_9_3 = 1

		for iter_9_0, iter_9_1 in pairs(arg_9_0.heroTeam_) do
			if iter_9_1 == arg_9_0.selectID_ then
				var_9_3 = iter_9_0

				break
			end
		end

		local var_9_4 = var_9_0[var_9_3]

		var_9_0[var_9_3] = arg_9_0.heroTeam_[arg_9_0.params_.selectHeroPos]
		var_9_0[arg_9_0.params_.selectHeroPos] = var_9_4

		local var_9_5 = var_9_1[var_9_3]

		var_9_1[var_9_3] = arg_9_0.heroTrialList_[arg_9_0.params_.selectHeroPos]
		var_9_1[arg_9_0.params_.selectHeroPos] = var_9_5

		HeroTools.PlayTalk(arg_9_0.selectID_, "team")
	else
		var_9_0[arg_9_0.params_.selectHeroPos] = arg_9_0.selectID_
		var_9_1[arg_9_0.params_.selectHeroPos] = arg_9_0.selectTrialID_

		HeroTools.PlayTalk(arg_9_0.selectID_, "team")
	end

	if arg_9_0.params_.reorder == nil or arg_9_0.params_.reorder == true then
		if arg_9_0:IsCustomTeamStage() then
			local var_9_6 = BattleStageTools.GetRestrictHeroList(arg_9_0.params_.stageType, arg_9_0.params_.stageID)
			local var_9_7 = 1
			local var_9_8 = {}
			local var_9_9 = {}

			for iter_9_2, iter_9_3 in pairs(var_9_6) do
				if iter_9_3[1] then
					var_9_8[iter_9_2] = iter_9_3[1]
					var_9_9[iter_9_2] = iter_9_3[2]
				else
					var_9_8[iter_9_2] = var_9_0[iter_9_2]
					var_9_9[iter_9_2] = var_9_1[iter_9_2]
				end
			end

			for iter_9_4 = 1, 3 do
				if not var_9_8[iter_9_4] then
					for iter_9_5, iter_9_6 in pairs(var_9_0) do
						local var_9_10 = table.keyof(var_9_8, iter_9_6)

						if iter_9_6 ~= 0 and not var_9_10 then
							var_9_8[iter_9_4] = iter_9_6
							var_9_9[iter_9_4] = var_9_9[var_9_10]

							break
						end
					end

					var_9_8[iter_9_4] = var_9_8[iter_9_4] or 0
					var_9_9[iter_9_4] = var_9_9[iter_9_4] or 0
				end
			end

			var_9_0 = var_9_8
			var_9_1 = var_9_9
		else
			for iter_9_7 = 3, 1, -1 do
				if var_9_0[iter_9_7] == 0 then
					table.remove(var_9_0, iter_9_7)
					table.remove(var_9_1, iter_9_7)
				end
			end

			for iter_9_8 = 1, 3 do
				if not var_9_0[iter_9_8] then
					var_9_0[iter_9_8] = 0
					var_9_1[iter_9_8] = 0
				end
			end
		end
	end

	local var_9_11
	local var_9_12
	local var_9_13

	for iter_9_9 = 1, 3 do
		if arg_9_0.params_.reserveParams.teamIndex ~= iter_9_9 then
			local var_9_14 = ReserveParams.New(arg_9_0.params_.reserveParams.reserveType, arg_9_0.params_.reserveParams.contID, iter_9_9, {
				stageType = arg_9_0.params_.stageType,
				stageID = arg_9_0.params_.stageID
			})
			local var_9_15 = ReserveTools.GetHeroList(var_9_14)

			for iter_9_10, iter_9_11 in ipairs(var_9_15) do
				if iter_9_11 ~= 0 then
					for iter_9_12 = 1, 3 do
						if iter_9_11 == var_9_0[iter_9_12] then
							var_9_11 = iter_9_9
							var_9_12 = var_9_15
							var_9_13 = iter_9_10
						end
					end
				end
			end
		end
	end

	if var_9_11 then
		local var_9_16 = GetTips("NUM_" .. var_9_11)

		ShowMessageBox({
			content = string.format(GetTips("CURHERO_USED"), var_9_16),
			OkCallback = function()
				var_9_12[var_9_13] = 0

				for iter_10_0 = 1, 2 do
					for iter_10_1 = iter_10_0 + 1, 3 do
						if var_9_12[iter_10_0] == 0 then
							var_9_12[iter_10_0] = var_9_12[iter_10_1]
							var_9_12[iter_10_1] = 0
						end
					end
				end

				local var_10_0 = ReserveParams.New(arg_9_0.params_.reserveParams.reserveType, arg_9_0.params_.reserveParams.contID, var_9_11, {
					stageType = arg_9_0.params_.stageType,
					stageID = arg_9_0.params_.stageID
				})

				ReserveTools.SetHeroList(var_10_0, var_9_12, {
					0,
					0,
					0
				})
				arg_9_0:ExitFunc(var_9_0, var_9_1)
			end
		})
	else
		arg_9_0:ExitFunc(var_9_0, var_9_1)
	end
end

function var_0_1.ExitFunc(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:ChangeTeam(arg_11_1, arg_11_2)

	if arg_11_0.heroAvatarView_ then
		arg_11_0.heroAvatarView_:RemoveTween()
	end

	arg_11_0:Back()
end

function var_0_1.ChangeTeam(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}

	for iter_12_0 = 1, 3 do
		if arg_12_1[iter_12_0] ~= 0 then
			var_12_0[#var_12_0 + 1] = arg_12_1[iter_12_0]
		end
	end

	for iter_12_1 = #var_12_0 + 1, 3 do
		var_12_0[iter_12_1] = 0
	end

	local var_12_1 = ComboSkillTools.GetRecommendSkillID(var_12_0, true)
	local var_12_2, var_12_3 = ReserveTools.GetMimirData(arg_12_0.params_.reserveParams)

	ReserveTools.SetTeam(arg_12_0.params_.reserveParams, var_12_0, arg_12_2 or {}, var_12_1, var_12_2, var_12_3)
end

return var_0_1
