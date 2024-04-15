local var_0_0 = class("ReservesView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Formation/FormationReserveView"
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

	arg_4_0.selectHeroView_ = arg_4_0:GetSelectHeroViewClass().New(arg_4_0.selectHeroGo_)
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ReservesItem)
	arg_4_0.clickItemHandler_ = handler(arg_4_0, arg_4_0.OnClickItem)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.saveBtn_, nil, function()
		return
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:ProcessCamera()
	arg_7_0:UpdateBar()

	arg_7_0.reserveParams_ = arg_7_0.params_.reserveParams
	arg_7_0.curList_, _, arg_7_0.lockList_, arg_7_0.trailList_ = ReserveTools.GetHeroList(arg_7_0.reserveParams_)
	arg_7_0.comboSkill_ = ReserveTools.GetComboSkillID(arg_7_0.reserveParams_)

	local var_7_0 = ReserveTools.GetMimirID(arg_7_0.reserveParams_)
	local var_7_1 = ReserveTools.GetMimirChipList(arg_7_0.reserveParams_)

	arg_7_0.chipInfo_ = {
		enabledID = var_7_0,
		chipList = var_7_1
	}
	arg_7_0.handler_ = handler(arg_7_0, arg_7_0.OnComboSkillSelect)

	manager.notify:RegistListener(COMBO_SKILL_SELECT, arg_7_0.handler_)
	arg_7_0:RefreshUI()
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_8_0:Back(1, {
			isSorted = true
		})
	end)
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0.lastPos_ = arg_10_0.scrollHelper_:GetScrolledPosition()

	if arg_10_0.scrollHelper_ then
		arg_10_0.scrollHelper_:StopRender()
	end

	manager.windowBar:HideBar()
	manager.notify:RemoveListener(COMBO_SKILL_SELECT, arg_10_0.handler_)

	arg_10_0.params_.isInit = false
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	arg_11_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.ProcessCamera(arg_12_0)
	manager.ui:SetMainCamera("battleHeroSelect")
	manager.ui:AdaptUIByFOV()
end

function var_0_0.UpdateBar(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
end

function var_0_0.RefreshUI(arg_14_0)
	arg_14_0:RefreshList()
	arg_14_0:RefreshText()
end

function var_0_0.RefreshList(arg_15_0)
	arg_15_0.reservesTeams_ = BattleTeamData:GetReservesTeamList()
	arg_15_0.setCurTeamIndex_ = arg_15_0.setCurTeamIndex_ or 0

	if arg_15_0.params_.isInit then
		arg_15_0.reservesTempTeams_ = BattleTeamData:InitTempList()

		local var_15_0 = arg_15_0:IsTrial()

		if not arg_15_0:IsExist() and not var_15_0 and arg_15_0:IsNotEmpty() then
			arg_15_0.setCurTeamIndex_ = BattleTeamData:SetCurTeam(arg_15_0.curList_, arg_15_0.comboSkill_, arg_15_0.chipInfo_)
		end

		if var_15_0 then
			ShowTips("CHARACTOR_ON_TRIAL")
		end

		arg_15_0.scrollHelper_:StartScroll(#arg_15_0.reservesTempTeams_)
	else
		arg_15_0.reservesTempTeams_ = BattleTeamData:GetReservesTempTeamList()

		if arg_15_0.setCurTeamIndex_ ~= 0 and not arg_15_0:IsCurTeam(arg_15_0.reservesTempTeams_[arg_15_0.setCurTeamIndex_]) then
			arg_15_0.setCurTeamIndex_ = 0
		end

		arg_15_0.scrollHelper_:StartScrollByPosition(#arg_15_0.reservesTempTeams_, arg_15_0.lastPos_)
	end
end

function var_0_0.IndexItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.reservesTempTeams_[arg_16_1].hero_list

	arg_16_2:RefreshUI(arg_16_0.reservesTempTeams_[arg_16_1], arg_16_0:IsCurTeam(arg_16_0.reservesTempTeams_[arg_16_1]), arg_16_0:IsInList(arg_16_1, arg_16_0.reservesTempTeams_[arg_16_1]), arg_16_1 == arg_16_0.setCurTeamIndex_, arg_16_0.isAdvanceTest_)
	arg_16_2:RegistClickCallback()
	arg_16_2:RegistChangeBtn(function(arg_17_0)
		local var_17_0 = BattleTeamData:GetReservesTeam(arg_17_0)

		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			if iter_17_1 ~= 0 and table.indexof(arg_16_0.lockList_, iter_17_1) then
				ShowTips("FORMATION_PLAN_CHANGE_FAILED")

				return
			end
		end

		local var_17_1 = BattleTeamData:GetReservesTeamList()[arg_17_0]

		ReserveTools.SetTeam(arg_16_0.reserveParams_, var_17_0, {
			0,
			0,
			0
		}, var_17_1.comboSkill, var_17_1.chipInfo.id, var_17_1.chipInfo.list)
		arg_16_0:Back(1, {
			isReserves = true,
			index = arg_17_0
		})
		ShowTips("FORMATION_PLAN_CHANGED")
	end)
end

function var_0_0.RefreshText(arg_18_0)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.reservesTeams_) do
		if iter_18_1.name ~= "" then
			var_18_0 = var_18_0 + 1
		end
	end

	arg_18_0.text_.text = var_18_0 .. "/10"
end

function var_0_0.IsCurTeam(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.hero_list

	if var_19_0[1] == arg_19_0.curList_[1] and var_19_0[2] == arg_19_0.curList_[2] and var_19_0[3] == arg_19_0.curList_[3] and arg_19_1.comboSkill == arg_19_0.comboSkill_ and arg_19_1.chipInfo.id == arg_19_0.chipInfo_.enabledID and #arg_19_1.chipInfo.list == #arg_19_0.chipInfo_.chipList then
		for iter_19_0, iter_19_1 in ipairs(arg_19_1.chipInfo.list) do
			if not table.indexof(arg_19_0.chipInfo_.chipList, iter_19_1) then
				return false
			end
		end

		return true
	end

	return false
end

function var_0_0.IsInList(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2.hero_list
	local var_20_1 = arg_20_0.reservesTeams_[arg_20_1]
	local var_20_2 = var_20_1.hero_list

	if var_20_0[1] == var_20_2[1] and var_20_0[2] == var_20_2[2] and var_20_0[3] == var_20_2[3] and arg_20_2.comboSkill == var_20_1.comboSkill and arg_20_2.chipInfo.id == var_20_1.chipInfo.id and #arg_20_2.chipInfo.list == #var_20_1.chipInfo.list then
		for iter_20_0, iter_20_1 in ipairs(arg_20_2.chipInfo.list) do
			if not table.indexof(var_20_1.chipInfo.list, iter_20_1) then
				return false
			end
		end

		return true
	end

	return false
end

function var_0_0.GetSelectHeroViewClass(arg_21_0)
	return ReservesSelectHeroView
end

function var_0_0.OnReservesSaveTeam(arg_22_0)
	arg_22_0:RefreshText()
	arg_22_0.scrollHelper_:Refresh()
end

function var_0_0.OnReservesDelectTeam(arg_23_0)
	arg_23_0:RefreshText()
	arg_23_0.scrollHelper_:Refresh()
	ShowTips("FORMATION_PLAN_DELETED")
end

function var_0_0.OnComboSkillSelect(arg_24_0)
	arg_24_0.setCurTeamIndex_ = 0

	arg_24_0.scrollHelper_:Refresh()
end

function var_0_0.OnClickItem(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0.scrollHelper_:GetItemList()) do
		iter_25_1:SetSelect(arg_25_1)
	end
end

function var_0_0.IsExist(arg_26_0)
	local var_26_0 = false

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.reservesTempTeams_) do
		if arg_26_0:IsCurTeam(iter_26_1) then
			var_26_0 = true

			break
		end
	end

	return var_26_0
end

function var_0_0.IsTrial(arg_27_0)
	local var_27_0 = false

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.trailList_) do
		if iter_27_1 ~= 0 then
			arg_27_0.curList_ = {
				0,
				0,
				0
			}
			arg_27_0.comboSkill_ = 0
			arg_27_0.chipInfo_ = {
				enabledID = 0,
				chipList = {}
			}
			var_27_0 = true

			break
		end
	end

	return var_27_0
end

function var_0_0.IsNotEmpty(arg_28_0)
	local var_28_0 = false

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.curList_) do
		if iter_28_1 ~= 0 then
			var_28_0 = true

			break
		end
	end

	return var_28_0
end

return var_0_0
