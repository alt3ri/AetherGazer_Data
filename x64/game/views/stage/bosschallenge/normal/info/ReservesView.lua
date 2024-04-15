local var_0_0 = class("ReservesView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/StagePrepare/HeroProjectPUIop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ReservesItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.reservesTempTeams_[arg_5_1].hero_list

	arg_5_2:RefreshUI(arg_5_0.reservesTempTeams_[arg_5_1], arg_5_0:IsCurTeam(arg_5_0.reservesTempTeams_[arg_5_1]), arg_5_0:IsInList(arg_5_1, arg_5_0.reservesTempTeams_[arg_5_1]), arg_5_1 == arg_5_0.setCurTeamIndex_, arg_5_0.isAdvanceTest_)
	arg_5_2:RegistChangeBtn(function(arg_6_0)
		local var_6_0 = BattleTeamData:GetReservesTeam(arg_6_0)

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			if iter_6_1 ~= 0 and table.indexof(arg_5_0.lockList_, iter_6_1) then
				ShowTips("FORMATION_PLAN_CHANGE_FAILED")

				return
			end
		end

		local var_6_1 = BattleTeamData:GetReservesTeamList()[arg_6_0]

		ReserveTools.SetTeam(arg_5_0.reserveParams_, var_6_0, {
			0,
			0,
			0
		}, var_6_1.comboSkill, var_6_1.chipInfo.id, var_6_1.chipInfo.list)
		arg_5_0:Back(1, {
			isReserves = true,
			index = arg_6_0
		})
		ShowTips("FORMATION_PLAN_CHANGED")
	end)
end

function var_0_0.AddUIListeners(arg_7_0)
	return
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.reserveParams_ = arg_8_0.params_.reserveParams
	arg_8_0.curList_, _, arg_8_0.lockList_, arg_8_0.trailList_ = ReserveTools.GetHeroList(arg_8_0.reserveParams_)
	arg_8_0.comboSkill_ = ReserveTools.GetComboSkillID(arg_8_0.reserveParams_)

	local var_8_0 = ReserveTools.GetMimirID(arg_8_0.reserveParams_)
	local var_8_1 = ReserveTools.GetMimirChipList(arg_8_0.reserveParams_)

	arg_8_0.chipInfo_ = {
		enabledID = var_8_0,
		chipList = var_8_1
	}
	arg_8_0.handler_ = handler(arg_8_0, arg_8_0.OnComboSkillSelect)

	manager.notify:RegistListener(COMBO_SKILL_SELECT, arg_8_0.handler_)
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshList()
	arg_9_0:RefreshText()
end

function var_0_0.RefreshList(arg_10_0)
	arg_10_0.reservesTeams_ = BattleTeamData:GetReservesTeamList()
	arg_10_0.setCurTeamIndex_ = arg_10_0.setCurTeamIndex_ or 0

	if arg_10_0.params_.isInit then
		arg_10_0.reservesTempTeams_ = BattleTeamData:InitTempList()

		local var_10_0 = arg_10_0:IsTrial()

		if not arg_10_0:IsExist() and not var_10_0 and arg_10_0:IsNotEmpty() then
			arg_10_0.setCurTeamIndex_ = BattleTeamData:SetCurTeam(arg_10_0.curList_, arg_10_0.comboSkill_, arg_10_0.chipInfo_)
		end

		if var_10_0 then
			ShowTips("CHARACTOR_ON_TRIAL")
		end

		arg_10_0.scrollHelper_:StartScroll(#arg_10_0.reservesTempTeams_)
	else
		arg_10_0.reservesTempTeams_ = BattleTeamData:GetReservesTempTeamList()

		if arg_10_0.setCurTeamIndex_ ~= 0 and not arg_10_0:IsCurTeam(arg_10_0.reservesTempTeams_[arg_10_0.setCurTeamIndex_]) then
			arg_10_0.setCurTeamIndex_ = 0
		end

		arg_10_0.scrollHelper_:StartScrollByPosition(#arg_10_0.reservesTempTeams_, arg_10_0.lastPos_)
	end
end

function var_0_0.IsExist(arg_11_0)
	local var_11_0 = false

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.reservesTempTeams_) do
		if arg_11_0:IsCurTeam(iter_11_1) then
			var_11_0 = true

			break
		end
	end

	return var_11_0
end

function var_0_0.IsTrial(arg_12_0)
	local var_12_0 = false

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.trailList_) do
		if iter_12_1 ~= 0 then
			arg_12_0.curList_ = {
				0,
				0,
				0
			}
			arg_12_0.comboSkill_ = 0
			arg_12_0.chipInfo_ = {
				enabledID = 0,
				chipList = {}
			}
			var_12_0 = true

			break
		end
	end

	return var_12_0
end

function var_0_0.IsNotEmpty(arg_13_0)
	local var_13_0 = false

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.curList_) do
		if iter_13_1 ~= 0 then
			var_13_0 = true

			break
		end
	end

	return var_13_0
end

function var_0_0.RefreshText(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.reservesTeams_) do
		if iter_14_1.name ~= "" then
			var_14_0 = var_14_0 + 1
		end
	end

	arg_14_0.text_.text = var_14_0 .. "/10"
end

function var_0_0.IsCurTeam(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.hero_list

	if var_15_0[1] == arg_15_0.curList_[1] and var_15_0[2] == arg_15_0.curList_[2] and var_15_0[3] == arg_15_0.curList_[3] and arg_15_1.comboSkill == arg_15_0.comboSkill_ and arg_15_1.chipInfo.id == arg_15_0.chipInfo_.enabledID and #arg_15_1.chipInfo.list == #arg_15_0.chipInfo_.chipList then
		for iter_15_0, iter_15_1 in ipairs(arg_15_1.chipInfo.list) do
			if not table.indexof(arg_15_0.chipInfo_.chipList, iter_15_1) then
				return false
			end
		end

		return true
	end

	return false
end

function var_0_0.IsInList(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2.hero_list
	local var_16_1 = arg_16_0.reservesTeams_[arg_16_1]
	local var_16_2 = var_16_1.hero_list

	if var_16_0[1] == var_16_2[1] and var_16_0[2] == var_16_2[2] and var_16_0[3] == var_16_2[3] and arg_16_2.comboSkill == var_16_1.comboSkill and arg_16_2.chipInfo.id == var_16_1.chipInfo.id and #arg_16_2.chipInfo.list == #var_16_1.chipInfo.list then
		for iter_16_0, iter_16_1 in ipairs(arg_16_2.chipInfo.list) do
			if not table.indexof(var_16_1.chipInfo.list, iter_16_1) then
				return false
			end
		end

		return true
	end

	return false
end

function var_0_0.OnReservesSaveTeam(arg_17_0)
	arg_17_0:RefreshText()
	arg_17_0.scrollHelper_:Refresh()
end

function var_0_0.OnReservesDelectTeam(arg_18_0)
	arg_18_0:RefreshText()
	arg_18_0.scrollHelper_:Refresh()
	ShowTips("FORMATION_PLAN_DELETED")
end

function var_0_0.OnComboSkillSelect(arg_19_0)
	arg_19_0.setCurTeamIndex_ = 0

	arg_19_0.scrollHelper_:Refresh()
end

function var_0_0.OnTop(arg_20_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_20_0:Back(1, {
			isSorted = true
		})
	end)
end

function var_0_0.OnExit(arg_22_0)
	arg_22_0.lastPos_ = arg_22_0.scrollHelper_:GetScrolledPosition()

	if arg_22_0.scrollHelper_ then
		arg_22_0.scrollHelper_:StopRender()
	end

	manager.windowBar:HideBar()
	manager.notify:RemoveListener(COMBO_SKILL_SELECT, arg_22_0.handler_)

	arg_22_0.params_.isInit = false
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAllListeners()
	arg_23_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
