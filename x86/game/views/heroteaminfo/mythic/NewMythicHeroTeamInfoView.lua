local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("NewMythicHeroTeamInfoView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	arg_1_0.teamLength_ = arg_1_0.params_.teamLength

	var_0_1.super.OnEnter(arg_1_0)
end

function var_0_1.GetHeroHeadClass(arg_2_0)
	return NewMythicHeroTeamHeadItem
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
	arg_4_2:RefreshTeamTag(arg_4_0.params_.reserveParams.teamIndex, arg_4_0.teamLength_)
end

function var_0_1.IsInTeam(arg_5_0, arg_5_1)
	for iter_5_0 = 1, #arg_5_0.heroTeam_ do
		if arg_5_0.heroTeam_[iter_5_0] == arg_5_1 then
			return true
		end
	end

	return false
end

function var_0_1.OnJoinClick(arg_6_0)
	local var_6_0 = clone(arg_6_0.heroTeam_)
	local var_6_1 = clone(arg_6_0.heroTrialList_)
	local var_6_2 = arg_6_0:IsSameHeroInTeam(arg_6_0.selectHeroData_.id)

	if arg_6_0.selectHeroData_.id == var_6_0[arg_6_0.params_.selectHeroPos] and arg_6_0.selectHeroData_.trialID == var_6_1[arg_6_0.params_.selectHeroPos] and var_6_2 then
		var_6_0[arg_6_0.params_.selectHeroPos] = 0
		var_6_1[arg_6_0.params_.selectHeroPos] = 0
	elseif var_6_2 then
		local var_6_3 = 1

		for iter_6_0, iter_6_1 in pairs(var_6_0) do
			if iter_6_1 == arg_6_0.selectHeroData_.id then
				var_6_3 = iter_6_0

				break
			end
		end

		if var_6_0[var_6_3] == arg_6_0.selectHeroData_.id and var_6_1[var_6_3] ~= arg_6_0.selectHeroData_.trialID then
			var_6_0[var_6_3] = arg_6_0.selectHeroData_.id
			var_6_1[var_6_3] = arg_6_0.selectHeroData_.trialID
		end

		local var_6_4 = var_6_0[var_6_3]

		var_6_0[var_6_3] = var_6_0[arg_6_0.params_.selectHeroPos]
		var_6_0[arg_6_0.params_.selectHeroPos] = var_6_4

		local var_6_5 = var_6_1[var_6_3]

		var_6_1[var_6_3] = var_6_1[arg_6_0.params_.selectHeroPos]
		var_6_1[arg_6_0.params_.selectHeroPos] = var_6_5

		HeroTools.PlayTalk(arg_6_0.selectHeroData_.id, "team")
	else
		var_6_0[arg_6_0.params_.selectHeroPos] = arg_6_0.selectHeroData_.id
		var_6_1[arg_6_0.params_.selectHeroPos] = arg_6_0.selectHeroData_.trialID

		HeroTools.PlayTalk(arg_6_0.selectHeroData_.id, "team")
	end

	if arg_6_0.params_.reorder == nil or arg_6_0.params_.reorder == true then
		if arg_6_0:IsCustomTeamStage() then
			local var_6_6 = BattleStageTools.GetRestrictHeroList(arg_6_0.params_.stageType, arg_6_0.params_.stageID)
			local var_6_7 = 1
			local var_6_8 = {}
			local var_6_9 = {}

			for iter_6_2, iter_6_3 in pairs(var_6_6) do
				if iter_6_3[1] then
					var_6_8[iter_6_2] = iter_6_3[1]
					var_6_9[iter_6_2] = iter_6_3[2]
				else
					var_6_8[iter_6_2] = var_6_0[iter_6_2]
					var_6_9[iter_6_2] = var_6_1[iter_6_2]
				end
			end

			for iter_6_4 = 1, 3 do
				if not var_6_8[iter_6_4] then
					for iter_6_5, iter_6_6 in pairs(var_6_0) do
						local var_6_10 = table.keyof(var_6_8, iter_6_6)

						if iter_6_6 ~= 0 and not var_6_10 then
							var_6_8[iter_6_4] = iter_6_6
							var_6_9[iter_6_4] = var_6_9[var_6_10]

							break
						end
					end

					var_6_8[iter_6_4] = var_6_8[iter_6_4] or 0
					var_6_9[iter_6_4] = var_6_9[iter_6_4] or 0
				end
			end

			var_6_0 = var_6_8
			var_6_1 = var_6_9
		else
			for iter_6_7 = 3, 1, -1 do
				if var_6_0[iter_6_7] == 0 then
					table.remove(var_6_0, iter_6_7)
					table.remove(var_6_1, iter_6_7)
				end
			end

			for iter_6_8 = 1, 3 do
				if not var_6_0[iter_6_8] then
					var_6_0[iter_6_8] = 0
					var_6_1[iter_6_8] = 0
				end
			end
		end
	end

	local var_6_11
	local var_6_12
	local var_6_13

	for iter_6_9 = 1, 2 do
		if arg_6_0.params_.reserveParams.teamIndex ~= iter_6_9 then
			local var_6_14 = ReserveParams.New(nil, arg_6_0.params_.reserveParams.contID, iter_6_9, {
				stageType = arg_6_0.params_.stageType,
				stageID = arg_6_0.params_.stageID
			})
			local var_6_15 = ReserveTools.GetHeroList(var_6_14)

			for iter_6_10, iter_6_11 in ipairs(var_6_15) do
				if iter_6_11 ~= 0 then
					for iter_6_12 = 1, 3 do
						if iter_6_11 == var_6_0[iter_6_12] then
							var_6_11 = iter_6_9
							var_6_12 = var_6_15
							var_6_13 = iter_6_10
						end
					end
				end
			end
		end
	end

	if var_6_11 then
		local var_6_16 = GetTips("NUM_" .. var_6_11)

		ShowMessageBox({
			content = string.format(GetTips("CURHERO_USED"), var_6_16),
			OkCallback = function()
				var_6_12[var_6_13] = 0

				for iter_7_0 = 1, 2 do
					for iter_7_1 = iter_7_0 + 1, 3 do
						if var_6_12[iter_7_0] == 0 then
							var_6_12[iter_7_0] = var_6_12[iter_7_1]
							var_6_12[iter_7_1] = 0
						end
					end
				end

				local var_7_0 = ReserveParams.New(nil, arg_6_0.params_.reserveParams.contID, var_6_11, {
					stageType = arg_6_0.params_.stageType,
					stageID = arg_6_0.params_.stageID
				})

				ReserveTools.SetHeroList(var_7_0, var_6_12, {
					0,
					0,
					0
				})
				arg_6_0:ExitFunc(var_6_0, var_6_1)
			end
		})
	else
		arg_6_0:ExitFunc(var_6_0, var_6_1)
	end
end

function var_0_1.ExitFunc(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:ChangeTeam(arg_8_1, arg_8_2)

	if arg_8_0.heroAvatarView_ then
		arg_8_0.heroAvatarView_:RemoveTween()
	end

	arg_8_0:Back()
end

function var_0_1.ChangeTeam(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}

	for iter_9_0 = 1, 3 do
		if arg_9_1[iter_9_0] ~= 0 then
			var_9_0[#var_9_0 + 1] = arg_9_1[iter_9_0]
		end
	end

	for iter_9_1 = #var_9_0 + 1, 3 do
		var_9_0[iter_9_1] = 0
	end

	local var_9_1 = ComboSkillTools.GetRecommendSkillID(var_9_0, true)
	local var_9_2, var_9_3 = ReserveTools.GetMimirData(arg_9_0.params_.reserveParams)

	ReserveTools.SetTeam(arg_9_0.params_.reserveParams, var_9_0, arg_9_2 or {}, var_9_1, var_9_2, var_9_3)
end

return var_0_1
