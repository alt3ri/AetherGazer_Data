local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("NewHeroTeamInfoChessView", var_0_0)

function var_0_1.UpdateBar(arg_1_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_1.OnEnter(arg_2_0)
	arg_2_0.teamLength_ = arg_2_0.params_.teamLength

	var_0_1.super.OnEnter(arg_2_0)
end

function var_0_1.GetHeroHeadClass(arg_3_0)
	return NewChessHeroTeamHeadItem
end

function var_0_1.ExtraSorter(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = arg_4_0.heroTeam_
	local var_4_1 = arg_4_0.heroTrialList_
	local var_4_2 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		var_4_2[iter_4_0] = {
			id = iter_4_1,
			trialID = var_4_1[iter_4_0]
		}
	end

	local var_4_3 = arg_4_0:indexof(var_4_2, arg_4_1)
	local var_4_4 = arg_4_0:indexof(var_4_2, arg_4_2)

	if var_4_3 ~= var_4_4 then
		return true, var_4_3 < var_4_4
	end

	if arg_4_1.trialID ~= 0 or arg_4_2.trialID ~= 0 then
		if arg_4_1.trialID ~= 0 and arg_4_2.trialID ~= 0 then
			if arg_4_3 == 0 and arg_4_1.star ~= arg_4_2.star then
				if arg_4_0.curOrder_ == "desc" then
					return true, arg_4_1.star > arg_4_2.star
				else
					return true, arg_4_1.star < arg_4_2.star
				end
			end

			local var_4_5 = getHeroPower(arg_4_1.trialID, true)
			local var_4_6 = getHeroPower(arg_4_2.trialID, true)

			if var_4_5 ~= var_4_6 then
				if arg_4_4 == "desc" then
					return true, var_4_6 < var_4_5
				else
					return true, var_4_5 < var_4_6
				end
			else
				return true, arg_4_1.trialID > arg_4_2.trialID
			end
		else
			return true, arg_4_1.trialID > arg_4_2.trialID
		end
	end

	return false, false
end

function var_0_1.HeadRenderer(arg_5_0, arg_5_1, arg_5_2)
	var_0_1.super.HeadRenderer(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshTeamTag(arg_5_0.params_.reserveParams.contID, arg_5_0.params_.reserveParams.teamIndex, arg_5_0.teamLength_)
end

function var_0_1.IsInTeam(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.heroTeam_

	for iter_6_0 = 1, #var_6_0 do
		if var_6_0[iter_6_0] == arg_6_1 then
			return true
		end
	end

	return false
end

function var_0_1.OnJoinClick(arg_7_0)
	local var_7_0 = clone(arg_7_0.heroTeam_)
	local var_7_1 = clone(arg_7_0.heroTrialList_)
	local var_7_2 = arg_7_0:IsSameHeroInTeam(arg_7_0.selectHeroData_.id)

	if arg_7_0.selectHeroData_.id == var_7_0[arg_7_0.params_.selectHeroPos] and arg_7_0.selectHeroData_.trialID == var_7_1[arg_7_0.params_.selectHeroPos] and var_7_2 then
		var_7_0[arg_7_0.params_.selectHeroPos] = 0
		var_7_1[arg_7_0.params_.selectHeroPos] = 0
	elseif var_7_2 then
		local var_7_3 = 1

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			if iter_7_1 == arg_7_0.selectHeroData_.id then
				var_7_3 = iter_7_0

				break
			end
		end

		if var_7_0[var_7_3] == arg_7_0.selectHeroData_.id and var_7_1[var_7_3] ~= arg_7_0.selectHeroData_.trialID then
			var_7_0[var_7_3] = arg_7_0.selectHeroData_.id
			var_7_1[var_7_3] = arg_7_0.selectHeroData_.trialID
		end

		local var_7_4 = var_7_0[var_7_3]

		var_7_0[var_7_3] = var_7_0[arg_7_0.params_.selectHeroPos]
		var_7_0[arg_7_0.params_.selectHeroPos] = var_7_4

		local var_7_5 = var_7_1[var_7_3]

		var_7_1[var_7_3] = var_7_1[arg_7_0.params_.selectHeroPos]
		var_7_1[arg_7_0.params_.selectHeroPos] = var_7_5

		HeroTools.PlayTalk(arg_7_0.selectHeroData_.id, "team")
	else
		var_7_0[arg_7_0.params_.selectHeroPos] = arg_7_0.selectHeroData_.id
		var_7_1[arg_7_0.params_.selectHeroPos] = arg_7_0.selectHeroData_.trialID

		HeroTools.PlayTalk(arg_7_0.selectHeroData_.id, "team")
	end

	if arg_7_0.params_.reorder == nil or arg_7_0.params_.reorder == true then
		if arg_7_0:IsCustomTeamStage() then
			local var_7_6 = BattleStageTools.GetRestrictHeroList(arg_7_0.params_.stageType, arg_7_0.params_.stageID)
			local var_7_7 = 1
			local var_7_8 = {}
			local var_7_9 = {}

			for iter_7_2, iter_7_3 in pairs(var_7_6) do
				if iter_7_3[1] then
					var_7_8[iter_7_2] = iter_7_3[1]
					var_7_9[iter_7_2] = iter_7_3[2]
				else
					var_7_8[iter_7_2] = var_7_0[iter_7_2]
					var_7_9[iter_7_2] = var_7_1[iter_7_2]
				end
			end

			for iter_7_4 = 1, 3 do
				if not var_7_8[iter_7_4] then
					for iter_7_5, iter_7_6 in pairs(var_7_0) do
						local var_7_10 = table.keyof(var_7_8, iter_7_6)

						if iter_7_6 ~= 0 and not var_7_10 then
							var_7_8[iter_7_4] = iter_7_6
							var_7_9[iter_7_4] = var_7_9[var_7_10]

							break
						end
					end

					var_7_8[iter_7_4] = var_7_8[iter_7_4] or 0
					var_7_9[iter_7_4] = var_7_9[iter_7_4] or 0
				end
			end

			var_7_0 = var_7_8
			var_7_1 = var_7_9
		else
			for iter_7_7 = 3, 1, -1 do
				if var_7_0[iter_7_7] == 0 then
					table.remove(var_7_0, iter_7_7)
					table.remove(var_7_1, iter_7_7)
				end
			end

			for iter_7_8 = 1, 3 do
				if not var_7_0[iter_7_8] then
					var_7_0[iter_7_8] = 0
					var_7_1[iter_7_8] = 0
				end
			end
		end
	end

	local var_7_11
	local var_7_12
	local var_7_13

	for iter_7_9 = 1, 3 do
		if arg_7_0.params_.reserveParams.teamIndex ~= iter_7_9 then
			local var_7_14 = ReserveParams.New(arg_7_0.params_.reserveParams.reserveType, arg_7_0.params_.reserveParams.contID, iter_7_9, {
				stageType = arg_7_0.params_.stageType,
				stageID = arg_7_0.params_.stageID
			})
			local var_7_15 = ReserveTools.GetHeroList(var_7_14)

			for iter_7_10, iter_7_11 in ipairs(var_7_15) do
				if iter_7_11 ~= 0 then
					for iter_7_12 = 1, 3 do
						if iter_7_11 == var_7_0[iter_7_12] then
							var_7_11 = iter_7_9
							var_7_12 = var_7_15
							var_7_13 = iter_7_10
						end
					end
				end
			end
		end
	end

	if var_7_11 then
		local var_7_16 = GetTips("NUM_" .. var_7_11)

		ShowMessageBox({
			content = string.format(GetTips("CURHERO_USED"), var_7_16),
			OkCallback = function()
				var_7_12[var_7_13] = 0

				for iter_8_0 = 1, 2 do
					for iter_8_1 = iter_8_0 + 1, 3 do
						if var_7_12[iter_8_0] == 0 then
							var_7_12[iter_8_0] = var_7_12[iter_8_1]
							var_7_12[iter_8_1] = 0
						end
					end
				end

				local var_8_0 = ReserveParams.New(arg_7_0.params_.reserveParams.reserveType, arg_7_0.params_.reserveParams.contID, var_7_11, {
					stageType = arg_7_0.params_.stageType,
					stageID = arg_7_0.params_.stageID
				})

				ReserveTools.SetHeroList(var_8_0, var_7_12, {
					0,
					0,
					0
				})
				arg_7_0:ExitFunc(var_7_0, var_7_1)
			end
		})
	else
		arg_7_0:ExitFunc(var_7_0, var_7_1)
	end
end

function var_0_1.ExitFunc(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:ChangeTeam(arg_9_1, arg_9_2)

	if arg_9_0.heroAvatarView_ then
		arg_9_0.heroAvatarView_:RemoveTween()
	end

	arg_9_0:Back()
end

function var_0_1.ChangeTeam(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}

	for iter_10_0 = 1, 3 do
		if arg_10_1[iter_10_0] ~= 0 then
			var_10_0[#var_10_0 + 1] = arg_10_1[iter_10_0]
		end
	end

	for iter_10_1 = #var_10_0 + 1, 3 do
		var_10_0[iter_10_1] = 0
	end

	local var_10_1 = ComboSkillTools.GetRecommendSkillID(var_10_0, true)
	local var_10_2, var_10_3 = ReserveTools.GetMimirData(arg_10_0.params_.reserveParams)

	ReserveTools.SetTeam(arg_10_0.params_.reserveParams, var_10_0, arg_10_2 or {}, var_10_1, var_10_2, var_10_3)
end

return var_0_1
