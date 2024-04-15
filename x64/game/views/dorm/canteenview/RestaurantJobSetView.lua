local var_0_0 = class("RestaurantJobSetView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dining/RoleConfigurationUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.sceneID = DormConst.CANTEEN_ID
	arg_4_0.showHeroInfo = CanteenHeroItem.New(arg_4_0.showHeroItem)

	arg_4_0.showHeroInfo:ResetCharacterCallBack(function(arg_5_0)
		arg_4_0:ClickHeroItem(arg_5_0)
	end)

	arg_4_0.heroScroll = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.heroUiList_, CanteenHeroItem)
	arg_4_0.heroSkillScroll = LuaList.New(handler(arg_4_0, arg_4_0.heroSkillItem), arg_4_0.uiSkillListGo_, CanteenSkillItem)
	arg_4_0.switchBtnController = ControllerUtil.GetController(arg_4_0.transform_, "btnState")
	arg_4_0.fatigueBtnController = ControllerUtil.GetController(arg_4_0.transform_, "fatigue")
	arg_4_0.pageStateController = ControllerUtil.GetController(arg_4_0.transform_, "empty")
	arg_4_0.curWorkController = ControllerUtil.GetController(arg_4_0.roleTrs_, "state")
	arg_4_0.staffController = ControllerUtil.GetController(arg_4_0.transform_, "staff")
	arg_4_0.jobStateController = {}

	for iter_4_0, iter_4_1 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
		arg_4_0.jobStateController[iter_4_0] = ControllerUtil.GetController(arg_4_0["job" .. iter_4_0 .. "Tgl_"].gameObject.transform, "state")
	end
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.jobType = arg_7_0.params_.jobType or arg_7_0.jobType or 1

	arg_7_0:RegisterEvent()
	arg_7_0:SelJob(arg_7_0.jobType)
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0.params_.jobType = arg_8_0.jobType
	arg_8_0.selHero = nil

	arg_8_0:RemoveAllEventListener()
end

function var_0_0.RegisterEvent(arg_9_0)
	arg_9_0:RegistEventListener(CANTEEN_SET_JOG_SUCCESS, function()
		ShowTips(GetTips("DORM_CANTEEN_HERO_CHANGE_SUCCESS"))
		arg_9_0:RefreshView()
	end)
end

function var_0_0.AddUIListener(arg_11_0)
	arg_11_0:AddBtnListenerScale(arg_11_0.confirmBtn_, nil, function()
		CanteenAction:SetCharacterJob(arg_11_0.jobType, {
			arg_11_0.selHero
		})
	end)
	arg_11_0:AddBtnListener(arg_11_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_11_0:AddBtnListenerScale(arg_11_0.removeBtn_, nil, function()
		local var_14_0 = DormData:GetCharacterInfo(arg_11_0.selHero).jobType

		CanteenAction:SetCharacterJob(var_14_0, {
			0
		})
	end)

	for iter_11_0, iter_11_1 in ipairs(DormEnum.RestaurantJobToClientMap) do
		arg_11_0:AddToggleListener(arg_11_0["job" .. iter_11_0 .. "Tgl_"], function(arg_15_0)
			if arg_15_0 then
				arg_11_0:SelJob(iter_11_0)
			end
		end)
	end
end

function var_0_0.SelJob(arg_16_0, arg_16_1)
	arg_16_0.jobType = arg_16_1
	arg_16_0.selHero = nil

	arg_16_0:RefreshView()
end

function var_0_0.indexItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2:RefreshUI(arg_17_0.heroList[arg_17_1], arg_17_0.selHero, arg_17_0.jobType)
	arg_17_2:ResetCharacterCallBack(function(arg_18_0)
		arg_17_0:ClickHeroItem(arg_18_0)
	end)
end

function var_0_0.ClickHeroItem(arg_19_0, arg_19_1)
	if not DormNpcTools:CheckIDIsNpc(arg_19_1) and CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_19_1) == true then
		ShowTips("CANTEEN_TASK_CANT_CHOOSE")

		return
	end

	arg_19_0.selHero = arg_19_1

	arg_19_0.heroScroll:Refresh()
	arg_19_0:RefreshCurWorkInfo()
	arg_19_0:RefreshHeroInfo()
end

function var_0_0.heroSkillItem(arg_20_0, arg_20_1, arg_20_2)
	arg_20_2:RefreshUI(arg_20_0.skillItemList[arg_20_1], arg_20_0.heroLevel, arg_20_1)
end

function var_0_0.RefreshView(arg_21_0)
	arg_21_0.jobText_.text = string.format(GetTips("CANTEEN_JOB_SET"), GetI18NText(CanteenTools:GetJobName(arg_21_0.jobType)))

	arg_21_0:RefreshJobButtonState()
	arg_21_0:RefreshCanUseHeroList()
	arg_21_0:RefreshHeroInfo()
end

function var_0_0.RefreshJobButtonState(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
		if CanteenHeroTools:HasJobAssignedToHero(iter_22_1) then
			arg_22_0.jobStateController[iter_22_0]:SetSelectedState("on")
		else
			arg_22_0.jobStateController[iter_22_0]:SetSelectedState("off")
		end
	end
end

function var_0_0.RefreshCurWorkInfo(arg_23_0)
	local var_23_0 = CanteenHeroTools:GetCurWorkIDListByJobType(arg_23_0.jobType)[1]
	local var_23_1

	if DormNpcTools:CheckIDIsNpc(var_23_0) then
		var_23_1 = var_23_0
	elseif var_23_0 then
		var_23_1 = DormData:GetHeroInfo(var_23_0):GetHeroId()
	end

	if not arg_23_0.selHero then
		arg_23_0.selHero = var_23_1
	end

	if var_23_1 then
		arg_23_0.showHeroInfo:RefreshUI(var_23_1, arg_23_0.selHero, arg_23_0.jobType)
	end

	return var_23_1
end

function var_0_0.RefreshCanUseHeroList(arg_24_0)
	local var_24_0 = DormHeroTools:GetUnLockBackHomeHeroIDList()
	local var_24_1 = DormNpcTools:GetNpcInfoListByConstJobType(arg_24_0.jobType)

	arg_24_0.heroList = {}

	local var_24_2 = arg_24_0:RefreshCurWorkInfo()

	if var_24_2 then
		for iter_24_0, iter_24_1 in ipairs(var_24_0) do
			if iter_24_1 ~= var_24_2 then
				table.insert(arg_24_0.heroList, iter_24_1)
			end
		end

		for iter_24_2, iter_24_3 in ipairs(var_24_1) do
			if iter_24_3 ~= var_24_2 then
				table.insert(arg_24_0.heroList, iter_24_3)
			end
		end

		arg_24_0.curWorkController:SetSelectedState("full")
	else
		arg_24_0.heroList = var_24_0

		for iter_24_4, iter_24_5 in ipairs(var_24_1) do
			table.insert(arg_24_0.heroList, iter_24_5)
		end

		arg_24_0.curWorkController:SetSelectedState("null")
	end

	CommonTools.UniversalSortEx(arg_24_0.heroList, {
		ascend = true,
		map = function(arg_25_0)
			if not DormNpcTools:CheckIDIsNpc(arg_25_0) then
				local var_25_0 = DormData:GetCharacterInfo(arg_25_0).jobType
				local var_25_1 = CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_25_0)

				if not var_25_0 and not var_25_1 then
					return 1
				end

				if var_25_0 then
					return 3
				else
					return 4
				end
			else
				return 2
			end
		end
	}, {
		map = function(arg_26_0)
			if not DormNpcTools:CheckIDIsNpc(arg_26_0) then
				local var_26_0 = DormData:GetHeroArchiveID(arg_26_0)
				local var_26_1 = DormHeroTools:GetAllCanUseHeroIDInDorm(var_26_0)
				local var_26_2 = false

				for iter_26_0, iter_26_1 in ipairs(var_26_1) do
					if #DormSkillData:CheckSkillCanOpen(arg_24_0.jobType, iter_26_1) > 0 then
						var_26_2 = true

						break
					end
				end

				if var_26_2 then
					return 2
				else
					return 1
				end
			end
		end
	}, {
		map = function(arg_27_0)
			if not DormNpcTools:CheckIDIsNpc(arg_27_0) then
				return DormData:GetHeroFatigue(arg_27_0)
			end
		end
	}, {
		map = function(arg_28_0)
			return (DormData:GetHeroArchiveID(arg_28_0))
		end
	}, {
		map = function(arg_29_0)
			return arg_29_0
		end
	})
	arg_24_0.heroScroll:StartScroll(#arg_24_0.heroList)
end

function var_0_0.RefreshHeroInfo(arg_30_0)
	if not arg_30_0.selHero then
		arg_30_0.pageStateController:SetSelectedState("true")

		local var_30_0 = CanteenTools:GetJobName(arg_30_0.jobType)

		arg_30_0.lackJobText.text = string.format(GetTips("DORM_SELECT"), var_30_0)

		return
	end

	if DormNpcTools:CheckIDIsNpc(arg_30_0.selHero) then
		arg_30_0:RefreshNpcInfoPage()
	else
		arg_30_0:RefreshHeroInfoPage()
	end
end

function var_0_0.RefreshNpcInfoPage(arg_31_0)
	arg_31_0.pageStateController:SetSelectedState("false")
	arg_31_0.staffController:SetSelectedState("noviciate_1")

	arg_31_0.heroLevel = nil

	local var_31_0 = BackHomeNpcData:GetNpcInfoById(arg_31_0.selHero)

	arg_31_0.nameText_.text = BackHomeNpcCfg[arg_31_0.selHero].npc_name
	arg_31_0.npcDescTex.text = BackHomeNpcCfg[arg_31_0.selHero].npc_desc

	if DormNpcTools:GetNpcFatigue(arg_31_0.selHero) < 0 then
		arg_31_0.fatigueBtnController:SetSelectedState("infinite")
	end

	arg_31_0.switchBtnController:SetSelectedState("true")

	if var_31_0.jobType then
		arg_31_0.switchBtnController:SetSelectedState("remove")
	end

	if arg_31_0.jobType == 1 then
		arg_31_0.btnText_.text = GetTips("DORM_CANTEEN_COOK_DO")
	elseif arg_31_0.jobType == 2 then
		arg_31_0.btnText_.text = GetTips("DORM_CANTEEN_WAITER_DO")
	elseif arg_31_0.jobType == 3 then
		arg_31_0.btnText_.text = GetTips("DORM_CANTEEN_CASHIER_DO")
	end

	arg_31_0:RefreshHeroSkillInfo(arg_31_0.selHero)
end

function var_0_0.RefreshHeroInfoPage(arg_32_0)
	arg_32_0.pageStateController:SetSelectedState("false")
	arg_32_0.staffController:SetSelectedState("xzz")

	local var_32_0 = DormData:GetHeroTemplateInfo(arg_32_0.selHero)
	local var_32_1 = HeroData:GetHeroData(arg_32_0.selHero)

	arg_32_0.heroLevel = var_32_1.level
	arg_32_0.nameText_.text = GetI18NText(HeroCfg[arg_32_0.selHero].suffix)
	arg_32_0.selHeroLevel = string.format(GetTips("DORM_LEVEL_TIPS"), arg_32_0.heroLevel)

	local var_32_2 = DormData:GetHeroFatigue(arg_32_0.selHero)

	if var_32_1 then
		arg_32_0.lvText_.text = string.format(GetTips("DORM_LEVEL_TIPS"), var_32_1.level)
		arg_32_0.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
		arg_32_0.curText_.text = var_32_2
		arg_32_0.progressImg_.fillAmount = 1 - math.min(var_32_2 / GameSetting.canteen_hero_fatigue_max.value[1], 1)
	end

	local var_32_3 = arg_32_0:CalFatigurReduce()

	arg_32_0.fatigueRe_.text = string.format(GetTips("DORM_CANTEEN_FATIGUE_COST"), var_32_3)

	local var_32_4 = GameDisplayCfg.dorm_hero_fatigue_level.value

	if var_32_2 <= var_32_4[1] then
		arg_32_0.fatigueBtnController:SetSelectedState("false")
	elseif var_32_2 > var_32_4[1] and var_32_2 <= var_32_4[2] then
		arg_32_0.fatigueBtnController:SetSelectedState("middle")
	else
		arg_32_0.fatigueBtnController:SetSelectedState("true")
	end

	if var_32_2 < GameSetting.dorm_canteen_work_fatigue.value[1] / 100 then
		arg_32_0.switchBtnController:SetSelectedState("false")
	else
		arg_32_0.switchBtnController:SetSelectedState("true")
	end

	if arg_32_0.jobType == 1 then
		arg_32_0.btnText_.text = GetTips("DORM_CANTEEN_COOK_DO")
	elseif arg_32_0.jobType == 2 then
		arg_32_0.btnText_.text = GetTips("DORM_CANTEEN_WAITER_DO")
	elseif arg_32_0.jobType == 3 then
		arg_32_0.btnText_.text = GetTips("DORM_CANTEEN_CASHIER_DO")
	end

	if var_32_0.jobType then
		arg_32_0.switchBtnController:SetSelectedState("remove")
	end

	arg_32_0:RefreshHeroSkillInfo(arg_32_0.selHero)
end

function var_0_0.CalFatigurReduce(arg_33_0)
	local var_33_0 = CanteenData:GetPopularityNum()
	local var_33_1 = GameSetting.canteen_popular_cost_time.value
	local var_33_2 = var_33_1[#var_33_1][2]

	for iter_33_0, iter_33_1 in ipairs(var_33_1) do
		if var_33_0 < iter_33_1[1] then
			var_33_2 = iter_33_1[2]
		end
	end

	local var_33_3 = math.ceil(3600 / var_33_2)
	local var_33_4 = GameSetting.dorm_canteen_fatigue_cost.value[1] / 100
	local var_33_5 = DormSkillData:CheckSkillCanOpen(arg_33_0.jobType, arg_33_0.selHero)
	local var_33_6 = 0

	for iter_33_2, iter_33_3 in ipairs(var_33_5) do
		if BackHomeHeroSkillCfg[iter_33_3].type == CanteenConst.HeroSkillType.FatigueRecuse then
			var_33_6 = var_33_6 + BackHomeHeroSkillCfg[iter_33_3].param[1]
		end
	end

	return var_33_3 * var_33_4 * (100 - var_33_6) / 100
end

function var_0_0.RefreshHeroSkillInfo(arg_34_0, arg_34_1)
	if DormNpcTools:CheckIDIsNpc(arg_34_1) then
		arg_34_0.skillItemList = BackHomeNpcCfg[arg_34_1].skill_list
	else
		arg_34_0.skillItemList = BackHomeHeroCfg[arg_34_1].skill_list
	end

	arg_34_0.heroSkillScroll:StartScroll(#arg_34_0.skillItemList)
end

function var_0_0.Dispose(arg_35_0)
	if arg_35_0.heroScroll then
		arg_35_0.heroScroll:Dispose()

		arg_35_0.heroScroll = nil
	end

	if arg_35_0.heroSkillScroll then
		arg_35_0.heroSkillScroll:Dispose()
	end

	arg_35_0.showHeroInfo:Dispose()
	var_0_0.super.Dispose(arg_35_0)
end

return var_0_0
