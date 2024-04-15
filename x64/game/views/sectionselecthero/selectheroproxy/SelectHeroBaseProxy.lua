local var_0_0 = class("SelectHeroBaseProxy")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_1 = arg_1_1 or {}
	arg_1_2 = arg_1_2 or {}

	arg_1_0:Init(arg_1_1, arg_1_2, arg_1_3)
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:InitBaseParams(arg_2_1)
	arg_2_0:InitReserveParams(arg_2_2, arg_2_3)
	arg_2_0:InitUIParams(arg_2_1)
	arg_2_0:InitCustomParams(arg_2_1)
	arg_2_0:GetHeroTeam()
end

function var_0_0.InitBaseParams(arg_3_0, arg_3_1)
	arg_3_0.stageID = arg_3_1.section or 0
	arg_3_0.stageType = arg_3_1.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	arg_3_0.activityID = arg_3_1.activityID
	arg_3_0.multiple = arg_3_1.multiple or 1
end

function var_0_0.InitReserveParams(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.reserveParams = arg_4_1 or ReserveTools.GetReserveParams(arg_4_0.stageType, arg_4_0.stageID, arg_4_0.activityID)
	arg_4_0.heroDataType = arg_4_2 or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_4_0.heroViewProxy = HeroViewDataProxy.New(arg_4_0.heroDataType)
	arg_4_0.heroViewProxyDic = {}
	arg_4_0.heroViewProxyDic[arg_4_0.heroDataType] = arg_4_0.heroViewProxy
	arg_4_0.heroPosMaxCount = 3
	arg_4_0.heroInfoList = {}
	arg_4_0.lockHeroList = {}
	arg_4_0.comboSkillID = 0
	arg_4_0.mimirID = 0
	arg_4_0.chipList = {}
end

function var_0_0.InitUIParams(arg_5_0, arg_5_1)
	arg_5_0.barList = arg_5_1.customBarList or {
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	}
	arg_5_0.canChangeTeam = true
	arg_5_0.needHeroPower = true
	arg_5_0.needRacePanel = true
	arg_5_0.forceRace = -1
	arg_5_0.needComboSkillPanel = true
	arg_5_0.canChangeComboSkill = true
	arg_5_0.needMimirPanel = true
	arg_5_0.canChangeMimir = true
	arg_5_0.needReserveProposalPanel = true
	arg_5_0.canChangeReserveProposal = true
	arg_5_0.needHeroHP = false
	arg_5_0.needHeroAssistant = false
	arg_5_0.needHeroEnergy = false

	arg_5_0:CheckComboSkill()
	arg_5_0:CheckMimirInfo()
end

function var_0_0.InitCustomParams(arg_6_0, arg_6_1)
	return
end

function var_0_0.UpdateBar(arg_7_0)
	manager.windowBar:SwitchBar(arg_7_0.barList)
end

function var_0_0.OnSectionSelectEnter(arg_8_0)
	return
end

function var_0_0.OnSectionSelectExit(arg_9_0)
	return
end

function var_0_0.CustomCheckBeforeGotoHeroInfoUI(arg_10_0, arg_10_1)
	local var_10_0 = true
	local var_10_1 = ""

	return var_10_0, var_10_1
end

function var_0_0.GetHeroTeamInfoRoute(arg_11_0)
	return "/newHeroTeamInfo"
end

function var_0_0.GetCustomeTeamInfoParams(arg_12_0, arg_12_1)
	return {}
end

function var_0_0.GetHeroReserveProposalRoute(arg_13_0)
	return "/reservesUI"
end

function var_0_0.GetCustomeReserveProposalParams(arg_14_0)
	return {}
end

function var_0_0.CustomCheckBeforeBattle(arg_15_0)
	local var_15_0 = true
	local var_15_1 = ""

	return var_15_0, var_15_1
end

function var_0_0.GetStageData(arg_16_0)
	return BattleStageFactory.Produce(arg_16_0.stageType, arg_16_0.stageID, arg_16_0.activityID)
end

function var_0_0.LaunchBattle(arg_17_0, arg_17_1)
	BattleController.GetInstance():LaunchBattle(arg_17_1)
end

function var_0_0.CustomSaveTeam(arg_18_0)
	if ReserveTools.NeedCacheTeam(arg_18_0.stageType, arg_18_0.stageID) then
		local var_18_0 = arg_18_0:GetHeroIDList()
		local var_18_1 = arg_18_0:GetTrialIDList()

		ReserveTools.SetTeam(arg_18_0.reserveParams, var_18_0, var_18_1, arg_18_0.comboSkillID, arg_18_0.mimirID, arg_18_0.chipList)
	end
end

function var_0_0.CustomResetTeam(arg_19_0)
	ReserveAction.ResetContData(arg_19_0.reserveParams.reserveType, arg_19_0.reserveParams.contID, function()
		for iter_20_0 = 1, arg_19_0.heroPosMaxCount do
			arg_19_0.heroInfoList[iter_20_0]:SetData(0, 0, false)
		end

		arg_19_0.lockHeroList = {}
		arg_19_0.comboSkillID = 0
		arg_19_0.mimirID = 0
		arg_19_0.chipList = {}
	end)
end

function var_0_0.CustomGetTeamData(arg_21_0)
	local var_21_0, var_21_1, var_21_2, var_21_3 = ReserveTools.GetHeroList(arg_21_0.reserveParams)

	return var_21_0, var_21_1, var_21_2, var_21_3
end

function var_0_0.CustomChangeHeroTeam(arg_22_0, arg_22_1, arg_22_2)
	ReserveTools.SetHeroList(arg_22_0.reserveParams, arg_22_1, arg_22_2)
end

function var_0_0.CustomApplyRroposalHeroTeam(arg_23_0, arg_23_1, arg_23_2)
	ReserveTools.SetHeroList(arg_23_0.reserveParams, arg_23_1, arg_23_2)
end

function var_0_0.CustomRefreshHeroInfoList(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	return
end

function var_0_0.CustomGetSkinCfg(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	return arg_25_0.heroInfoList[arg_25_1].heroViewProxy:GetHeroUsingSkinInfo(arg_25_2, {
		arg_25_3
	})
end

function var_0_0.CustomGetHeroPower(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	return arg_26_0.heroInfoList[arg_26_1].heroViewProxy:GetBattlePower(arg_26_2, arg_26_3)
end

function var_0_0.CustomGetHeroHP(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = 1
	local var_27_1 = 100

	return var_27_0, var_27_1
end

function var_0_0.CustomGetHeroEnergy(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	return 0
end

function var_0_0.CustomHeroBindRedPoint(arg_29_0, arg_29_1, arg_29_2)
	return
end

function var_0_0.CustomHeroUnBindRedPoint(arg_30_0, arg_30_1, arg_30_2)
	return
end

function var_0_0.CustomCheckComboSkill(arg_31_0)
	return
end

function var_0_0.CustomGetComboSkillID(arg_32_0)
	return ReserveTools.GetComboSkillID(arg_32_0.reserveParams)
end

function var_0_0.CustomSetComboSkillID(arg_33_0, arg_33_1)
	ReserveTools.SetComboSkillID(arg_33_0.reserveParams, arg_33_1)
end

function var_0_0.CustomMimirID(arg_34_0)
	return ReserveTools.GetMimirID(arg_34_0.reserveParams)
end

function var_0_0.CustomSetMimirID(arg_35_0, arg_35_1)
	ReserveTools.SetMimirID(arg_35_0.reserveParams, arg_35_1)
end

function var_0_0.CustomGetMimirChipList(arg_36_0)
	return ReserveTools.GetMimirChipList(arg_36_0.reserveParams)
end

function var_0_0.CustomInsertMimirChip(arg_37_0, arg_37_1)
	ReserveTools.InsertMimirChip(arg_37_0.reserveParams, arg_37_1)
end

function var_0_0.CustomRemoveMimirChip(arg_38_0, arg_38_1)
	ReserveTools.RemoveMimirChip(arg_38_0.reserveParams, arg_38_1)
end

function var_0_0.CustomSetMimirChipList(arg_39_0, arg_39_1)
	ReserveTools.SetMimirChipList(arg_39_0.reserveParams, arg_39_1)
end

function var_0_0.GetRaceEffect(arg_40_0)
	local var_40_0 = arg_40_0:GetHeroIDList()

	return BattleTools.GetMaxRaceData(var_40_0)
end

function var_0_0.GetStageInfoClass(arg_41_0)
	return SectionStageInfoView
end

function var_0_0.GetSelectHeroViewClass(arg_42_0)
	return SelectHeroBaseView
end

function var_0_0.GetHeroInfoItemClass(arg_43_0)
	return SectionSelectHeroInfoItem
end

function var_0_0.GetMimirInfoViewClass(arg_44_0)
	return NewSectionMimirView
end

function var_0_0.GetComboSkillViewClass(arg_45_0)
	return NewSectionComboSkillView
end

function var_0_0.GetSectionSelectHeroInfoClass(arg_46_0)
	return SectionSelectHeroInfo
end

function var_0_0.GotoHeroInfoUI(arg_47_0, arg_47_1)
	local var_47_0, var_47_1 = arg_47_0:CheckBeforeGotoHeroInfoUI(arg_47_1)

	if not var_47_0 then
		if var_47_1 then
			ShowTips(var_47_1)
		end

		return
	end

	local var_47_2 = arg_47_0:GetDefaultTeamInfoParams(arg_47_1)
	local var_47_3 = arg_47_0:GetCustomeTeamInfoParams(arg_47_1)

	for iter_47_0, iter_47_1 in pairs(var_47_3) do
		var_47_2[iter_47_0] = iter_47_1
	end

	JumpTools.OpenPageByJump(arg_47_0:GetHeroTeamInfoRoute(), var_47_2)
end

function var_0_0.CheckBeforeGotoHeroInfoUI(arg_48_0, arg_48_1)
	if not arg_48_0.canChangeTeam then
		return false, "CAN_NOT_CHANGE_HERO"
	end

	if arg_48_0.stageID and arg_48_0.stageID ~= 0 then
		local var_48_0, var_48_1 = BattleStageTools.GetRestrictHeroList(arg_48_0.stageType, arg_48_0.stageID)

		if type(var_48_0) == "table" then
			local var_48_2 = var_48_0[arg_48_1]

			if var_48_2[1] == 0 then
				return false, "CAN_NOT_CHANGE_HERO"
			end

			if HeroCfg[var_48_2[1]] and not table.keyof(HeroCfg.get_id_list_by_private[0], var_48_2[1]) and (type(var_48_1) ~= "table" or var_48_1[arg_48_1] == ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID) then
				return false, "CAN_NOT_CHANGE_HERO"
			end
		end
	end

	return arg_48_0:CustomCheckBeforeGotoHeroInfoUI(arg_48_1)
end

function var_0_0.GetDefaultTeamInfoParams(arg_49_0, arg_49_1)
	return {
		isEnter = true,
		selectHeroPos = arg_49_1,
		stageID = arg_49_0.stageID,
		activityID = arg_49_0.activityID,
		stageType = arg_49_0.stageType,
		reserveParams = arg_49_0.reserveParams,
		heroDataType = arg_49_0.heroDataType,
		sectionProxy = arg_49_0.sectionProxy
	}
end

function var_0_0.GotoReservesProposalUI(arg_50_0)
	local var_50_0 = arg_50_0:GetDefaultReserveProposalParams()
	local var_50_1 = arg_50_0:GetCustomeReserveProposalParams()

	for iter_50_0, iter_50_1 in pairs(var_50_1) do
		var_50_0[iter_50_0] = iter_50_1
	end

	JumpTools.OpenPageByJump(arg_50_0:GetHeroReserveProposalRoute(), var_50_0)
end

function var_0_0.GetDefaultReserveProposalParams(arg_51_0)
	local var_51_0 = arg_51_0:GetHeroIDList()
	local var_51_1 = arg_51_0:GetTrialIDList()

	return {
		isEnter = true,
		stageType = arg_51_0.stageType,
		stageID = arg_51_0.stageID,
		sectionProxy = arg_51_0,
		heroList = var_51_0,
		trialList = var_51_1,
		lockHeroList = arg_51_0.lockHeroList,
		comboSkillID = arg_51_0.comboSkillID,
		mimirID = arg_51_0.mimirID,
		chipList = arg_51_0.chipList
	}
end

function var_0_0.CheckBeforeBattle(arg_52_0)
	if arg_52_0.heroInfoList[1].heroID == 0 then
		return false, "TEAM_ERROR_LEADER"
	end

	local var_52_0, var_52_1 = BattleStageTools.GetRestrictHeroList(arg_52_0.stageType, arg_52_0.stageID)

	if type(var_52_1) == "table" and var_52_1[arg_52_0.heroPosMaxCount] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
		for iter_52_0 = 2, arg_52_0.heroPosMaxCount - 1 do
			if arg_52_0.heroInfoList[iter_52_0].heroID == 0 then
				return false, "TEAM_ERROR_NEED_MAX"
			end
		end
	end

	return arg_52_0:CustomCheckBeforeBattle()
end

function var_0_0.StartBattle(arg_53_0)
	local var_53_0, var_53_1 = arg_53_0:CheckBeforeBattle()

	if not var_53_0 then
		if var_53_1 then
			ShowTips(var_53_1)
		end

		return
	end

	arg_53_0:SaveTeam()

	local var_53_2 = arg_53_0:GetStageData()

	var_53_2:SetMultiple(arg_53_0.multiple)
	var_53_2:SetReserveParams(arg_53_0.reserveParams)
	var_53_2:Init()
	arg_53_0:LaunchBattle(var_53_2)
end

function var_0_0.SetReserveParams(arg_54_0, arg_54_1)
	arg_54_0.reserveParams = arg_54_1
end

function var_0_0.GetReserveParams(arg_55_0)
	return arg_55_0.reserveParams
end

function var_0_0.SaveTeam(arg_56_0)
	arg_56_0:CustomSaveTeam()
end

function var_0_0.ResetTeam(arg_57_0)
	arg_57_0:CustomResetTeam()
end

function var_0_0.GetHeroTeam(arg_58_0)
	local var_58_0, var_58_1, var_58_2, var_58_3 = arg_58_0:CustomGetTeamData()

	arg_58_0:RefreshHeroInfoList(var_58_0, var_58_3, var_58_1, var_58_2)

	local var_58_4 = {}

	for iter_58_0, iter_58_1 in ipairs(var_58_3) do
		if iter_58_1 ~= 0 then
			var_58_4[#var_58_4 + 1] = iter_58_1
		end
	end

	for iter_58_2, iter_58_3 in ipairs(arg_58_0.heroViewProxyDic) do
		iter_58_3:SetTempHeroList(var_58_4)
	end

	return var_58_0, var_58_1, var_58_2, var_58_3
end

function var_0_0.GetHeroIDList(arg_59_0)
	local var_59_0 = {}

	for iter_59_0 = 1, arg_59_0.heroPosMaxCount do
		var_59_0[iter_59_0] = arg_59_0.heroInfoList[iter_59_0].heroID
	end

	return var_59_0
end

function var_0_0.GetTrialIDList(arg_60_0)
	local var_60_0 = {}

	for iter_60_0 = 1, arg_60_0.heroPosMaxCount do
		var_60_0[iter_60_0] = arg_60_0.heroInfoList[iter_60_0].trialID
	end

	return var_60_0
end

function var_0_0.GetLockStateList(arg_61_0)
	local var_61_0 = {}

	for iter_61_0 = 1, arg_61_0.heroPosMaxCount do
		var_61_0[iter_61_0] = arg_61_0.heroInfoList[iter_61_0].isLock
	end

	return var_61_0
end

function var_0_0.GetLockHeroList(arg_62_0)
	return arg_62_0.lockHeroList
end

function var_0_0.ChangeHeroTeam(arg_63_0, arg_63_1, arg_63_2)
	arg_63_2 = arg_63_2 or {
		0,
		0,
		0
	}

	arg_63_0:CustomChangeHeroTeam(arg_63_1, arg_63_2)

	local var_63_0 = arg_63_0:GetLockStateList()

	arg_63_0:RefreshHeroInfoList(arg_63_1, arg_63_2, var_63_0, arg_63_0.lockHeroList)
end

function var_0_0.ApplyReserveProposal(arg_64_0, arg_64_1, arg_64_2, arg_64_3, arg_64_4, arg_64_5)
	arg_64_0:ApplyRroposalHeroTeam(arg_64_1, arg_64_2)
	arg_64_0:SetComboSkillID(arg_64_3)
	arg_64_0:SetMimirID(arg_64_4)
	arg_64_0:SetMimirChipList(arg_64_5)
end

function var_0_0.ApplyRroposalHeroTeam(arg_65_0, arg_65_1, arg_65_2)
	arg_65_0:CustomApplyRroposalHeroTeam(arg_65_1, arg_65_2)

	local var_65_0 = arg_65_0:GetLockStateList()

	arg_65_0:RefreshHeroInfoList(arg_65_1, arg_65_2, var_65_0, arg_65_0.lockHeroList)
end

function var_0_0.RefreshHeroInfoList(arg_66_0, arg_66_1, arg_66_2, arg_66_3, arg_66_4)
	for iter_66_0 = 1, arg_66_0.heroPosMaxCount do
		if not arg_66_0.heroInfoList[iter_66_0] then
			arg_66_0.heroInfoList[iter_66_0] = arg_66_0:GetSectionSelectHeroInfoClass().New()
		end

		local var_66_0 = arg_66_1[iter_66_0] or 0
		local var_66_1 = arg_66_2[iter_66_0] or 0
		local var_66_2
		local var_66_3

		if var_66_1 ~= 0 then
			var_66_2 = HeroConst.HERO_DATA_TYPE.TRIAL
		else
			var_66_2 = arg_66_0.heroDataType
		end

		local var_66_4 = arg_66_0:GreateHeroViewProxy(var_66_2)

		arg_66_0.heroInfoList[iter_66_0]:SetData(var_66_0, var_66_1, arg_66_3[iter_66_0])
		arg_66_0.heroInfoList[iter_66_0]:SetHeroDataType(var_66_2, var_66_4)
	end

	local var_66_5 = {}

	for iter_66_1, iter_66_2 in ipairs(arg_66_2) do
		if iter_66_2 ~= 0 then
			var_66_5[#var_66_5 + 1] = iter_66_2
		end
	end

	for iter_66_3, iter_66_4 in pairs(arg_66_0.heroViewProxyDic) do
		iter_66_4:SetTempHeroList(var_66_5)
	end

	arg_66_0.lockHeroList = arg_66_4

	arg_66_0:CustomRefreshHeroInfoList(arg_66_1, arg_66_2, arg_66_3, arg_66_4)
end

function var_0_0.SetHeroDataType(arg_67_0, arg_67_1)
	arg_67_0.heroDataType = arg_67_1

	arg_67_0:GreateHeroViewProxy(arg_67_1)
end

function var_0_0.GreateHeroViewProxy(arg_68_0, arg_68_1)
	if not arg_68_0.heroViewProxyDic[arg_68_1] then
		arg_68_0.heroViewProxyDic[arg_68_1] = HeroViewDataProxy.New(arg_68_1)
	end

	return arg_68_0.heroViewProxyDic[arg_68_1]
end

function var_0_0.GetHeroViewProxy(arg_69_0)
	return arg_69_0:GreateHeroViewProxy(arg_69_0.heroDataType)
end

function var_0_0.CheckComboSkill(arg_70_0)
	if arg_70_0.stageID and arg_70_0.stageID ~= 0 then
		local var_70_0 = BattleStageTools.GetStageCfg(arg_70_0.stageType, arg_70_0.stageID)

		if var_70_0 and var_70_0.combo_skill_id and var_70_0.combo_skill_id ~= 0 then
			arg_70_0.customComboSkill = var_70_0.combo_skill_id
			arg_70_0.needComboSkillPanel = true
			arg_70_0.canChangeComboSkill = false

			return
		end

		local var_70_1 = BattleStageTools.GetRestrictHeroList(arg_70_0.stageType, arg_70_0.stageID)

		if type(var_70_1) == "table" then
			arg_70_0.customComboSkill = 0
			arg_70_0.needComboSkillPanel = false
			arg_70_0.canChangeComboSkill = false
		end
	end

	arg_70_0:CustomCheckComboSkill()
end

function var_0_0.GetComboSkillID(arg_71_0)
	local var_71_0

	if arg_71_0.stageID and arg_71_0.stageID ~= 0 then
		local var_71_1 = BattleStageTools.GetStageCfg(arg_71_0.stageType, arg_71_0.stageID)

		if var_71_1 and var_71_1.combo_skill_id and var_71_1.combo_skill_id ~= 0 then
			var_71_0 = var_71_1.combo_skill_id
		else
			local var_71_2 = BattleStageTools.GetRestrictHeroList(arg_71_0.stageType, arg_71_0.stageID)

			if type(var_71_2) == "table" then
				var_71_0 = 0
			else
				var_71_0 = arg_71_0:CustomGetComboSkillID()
			end
		end
	else
		var_71_0 = arg_71_0:CustomGetComboSkillID()
	end

	arg_71_0.comboSkillID = var_71_0

	return arg_71_0.comboSkillID
end

function var_0_0.SetComboSkillID(arg_72_0, arg_72_1)
	arg_72_0.comboSkillID = arg_72_1

	arg_72_0:CustomSetComboSkillID(arg_72_1)
end

function var_0_0.CheckMimirInfo(arg_73_0)
	if arg_73_0.stageID and arg_73_0.stageID ~= 0 then
		local var_73_0 = BattleStageTools.GetStageCfg(arg_73_0.stageType, arg_73_0.stageID)

		if var_73_0 and type(var_73_0.chip_list) == "table" then
			arg_73_0.canChangeMimir = false
		end
	end
end

function var_0_0.GetMimirID(arg_74_0)
	local var_74_0

	if arg_74_0.stageID and arg_74_0.stageID ~= 0 then
		local var_74_1 = BattleStageTools.GetStageCfg(arg_74_0.stageType, arg_74_0.stageID)

		if var_74_1 and type(var_74_1.chip_list) == "table" then
			var_74_0 = var_74_1.chip_list[1]
			arg_74_0.chipList = {}

			for iter_74_0 = 2, 3 do
				arg_74_0.chipList[iter_74_0 - 1] = var_74_1.chip_list[iter_74_0]
			end
		else
			var_74_0 = arg_74_0:CustomMimirID()
		end
	else
		var_74_0 = arg_74_0:CustomMimirID()
	end

	arg_74_0.mimirID = var_74_0

	return arg_74_0.mimirID
end

function var_0_0.SetMimirID(arg_75_0, arg_75_1)
	arg_75_0.mimirID = arg_75_1

	arg_75_0:CustomSetMimirID(arg_75_1)
end

function var_0_0.GetMimirChipList(arg_76_0)
	local var_76_0

	if arg_76_0.stageID and arg_76_0.stageID ~= 0 then
		local var_76_1 = BattleStageTools.GetStageCfg(arg_76_0.stageType, arg_76_0.stageID)

		if var_76_1 and type(var_76_1.chip_list) == "table" then
			var_76_0 = {}

			for iter_76_0 = 2, 3 do
				var_76_0[iter_76_0 - 1] = var_76_1.chip_list[iter_76_0]
			end
		else
			var_76_0 = arg_76_0:CustomGetMimirChipList()
		end
	else
		var_76_0 = arg_76_0:CustomGetMimirChipList()
	end

	arg_76_0.chipList = var_76_0

	return arg_76_0.chipList
end

function var_0_0.InsertMimirChip(arg_77_0, arg_77_1)
	arg_77_0:CustomInsertMimirChip(arg_77_1)
	arg_77_0:GetMimirChipList()
end

function var_0_0.RemoveMimirChip(arg_78_0, arg_78_1)
	arg_78_0:CustomRemoveMimirChip(arg_78_1)
	arg_78_0:GetMimirChipList()
end

function var_0_0.SetMimirChipList(arg_79_0, arg_79_1)
	arg_79_0:CustomSetMimirChipList(arg_79_1)
	arg_79_0:GetMimirChipList()
end

return var_0_0
