slot0 = class("SelectHeroBaseProxy")

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0:Init(slot1 or {}, slot2 or {}, slot3)
end

function slot0.Init(slot0, slot1, slot2, slot3)
	slot0:InitBaseParams(slot1)
	slot0:InitReserveParams(slot2, slot3)
	slot0:InitUIParams(slot1)
	slot0:InitCustomParams(slot1)
	slot0:GetHeroTeam()
end

function slot0.InitBaseParams(slot0, slot1)
	slot0.stageID = slot1.section or 0
	slot0.stageType = slot1.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	slot0.activityID = slot1.activityID
	slot0.multiple = slot1.multiple or 1
end

function slot0.InitReserveParams(slot0, slot1, slot2)
	slot0.reserveParams = slot1 or ReserveTools.GetReserveParams(slot0.stageType, slot0.stageID, slot0.activityID)
	slot0.heroDataType = slot2 or HeroConst.HERO_DATA_TYPE.DEFAULT
	slot0.heroViewProxy = HeroViewDataProxy.New(slot0.heroDataType)
	slot0.heroViewProxyDic = {
		[slot0.heroDataType] = slot0.heroViewProxy
	}
	slot0.heroPosMaxCount = 3
	slot0.heroInfoList = {}
	slot0.lockHeroList = {}
	slot0.comboSkillID = 0
	slot0.mimirID = 0
	slot0.chipList = {}
end

function slot0.InitUIParams(slot0, slot1)
	slot0.barList = slot1.customBarList or {
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	}
	slot0.canChangeTeam = true
	slot0.needHeroPower = true
	slot0.needRacePanel = true
	slot0.forceRace = -1
	slot0.needComboSkillPanel = true
	slot0.canChangeComboSkill = true
	slot0.needMimirPanel = true
	slot0.canChangeMimir = true
	slot0.needReserveProposalPanel = true
	slot0.canChangeReserveProposal = true
	slot0.needHeroHP = false
	slot0.needHeroAssistant = false
	slot0.needHeroEnergy = false

	slot0:CheckComboSkill()
	slot0:CheckMimirInfo()
end

function slot0.InitCustomParams(slot0, slot1)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar(slot0.barList)
end

function slot0.OnSectionSelectEnter(slot0)
end

function slot0.OnSectionSelectExit(slot0)
end

function slot0.CustomCheckBeforeGotoHeroInfoUI(slot0, slot1)
	return true, ""
end

function slot0.GetHeroTeamInfoRoute(slot0)
	return "/newHeroTeamInfo"
end

function slot0.GetCustomeTeamInfoParams(slot0, slot1)
	return {}
end

function slot0.GetHeroReserveProposalRoute(slot0)
	return "/reservesUI"
end

function slot0.GetCustomeReserveProposalParams(slot0)
	return {}
end

function slot0.CustomCheckBeforeBattle(slot0)
	return true, ""
end

function slot0.GetStageData(slot0)
	return BattleStageFactory.Produce(slot0.stageType, slot0.stageID, slot0.activityID)
end

function slot0.LaunchBattle(slot0, slot1)
	BattleController.GetInstance():LaunchBattle(slot1)
end

function slot0.CustomSaveTeam(slot0)
	if ReserveTools.NeedCacheTeam(slot0.stageType, slot0.stageID) then
		ReserveTools.SetTeam(slot0.reserveParams, slot0:GetHeroIDList(), slot0:GetTrialIDList(), slot0.comboSkillID, slot0.mimirID, slot0.chipList)
	end
end

function slot0.CustomResetTeam(slot0)
	ReserveAction.ResetContData(slot0.reserveParams.reserveType, slot0.reserveParams.contID, function ()
		for slot3 = 1, uv0.heroPosMaxCount do
			uv0.heroInfoList[slot3]:SetData(0, 0, false)
		end

		uv0.lockHeroList = {}
		uv0.comboSkillID = 0
		uv0.mimirID = 0
		uv0.chipList = {}
	end)
end

function slot0.CustomGetTeamData(slot0)
	slot1, slot2, slot3, slot4 = ReserveTools.GetHeroList(slot0.reserveParams)

	return slot1, slot2, slot3, slot4
end

function slot0.CustomChangeHeroTeam(slot0, slot1, slot2)
	ReserveTools.SetHeroList(slot0.reserveParams, slot1, slot2)
end

function slot0.CustomApplyRroposalHeroTeam(slot0, slot1, slot2)
	ReserveTools.SetHeroList(slot0.reserveParams, slot1, slot2)
end

function slot0.CustomRefreshHeroInfoList(slot0, slot1, slot2, slot3, slot4)
end

function slot0.CustomGetSkinCfg(slot0, slot1, slot2, slot3)
	return slot0.heroInfoList[slot1].heroViewProxy:GetHeroUsingSkinInfo(slot2, {
		slot3
	})
end

function slot0.CustomGetHeroPower(slot0, slot1, slot2, slot3)
	return slot0.heroInfoList[slot1].heroViewProxy:GetBattlePower(slot2, slot3)
end

function slot0.CustomGetHeroHP(slot0, slot1, slot2, slot3)
	return 1, 100
end

function slot0.CustomGetHeroEnergy(slot0, slot1, slot2, slot3)
	return 0
end

function slot0.CustomHeroBindRedPoint(slot0, slot1, slot2)
end

function slot0.CustomHeroUnBindRedPoint(slot0, slot1, slot2)
end

function slot0.CustomCheckComboSkill(slot0)
end

function slot0.CustomGetComboSkillID(slot0)
	return ReserveTools.GetComboSkillID(slot0.reserveParams)
end

function slot0.CustomSetComboSkillID(slot0, slot1)
	ReserveTools.SetComboSkillID(slot0.reserveParams, slot1)
end

function slot0.CustomMimirID(slot0)
	return ReserveTools.GetMimirID(slot0.reserveParams)
end

function slot0.CustomSetMimirID(slot0, slot1)
	ReserveTools.SetMimirID(slot0.reserveParams, slot1)
end

function slot0.CustomGetMimirChipList(slot0)
	return ReserveTools.GetMimirChipList(slot0.reserveParams)
end

function slot0.CustomInsertMimirChip(slot0, slot1)
	ReserveTools.InsertMimirChip(slot0.reserveParams, slot1)
end

function slot0.CustomRemoveMimirChip(slot0, slot1)
	ReserveTools.RemoveMimirChip(slot0.reserveParams, slot1)
end

function slot0.CustomSetMimirChipList(slot0, slot1)
	ReserveTools.SetMimirChipList(slot0.reserveParams, slot1)
end

function slot0.GetRaceEffect(slot0)
	return BattleTools.GetMaxRaceData(slot0:GetHeroIDList())
end

function slot0.GetStageInfoClass(slot0)
	return SectionStageInfoView
end

function slot0.GetSelectHeroViewClass(slot0)
	return SelectHeroBaseView
end

function slot0.GetHeroInfoItemClass(slot0)
	return SectionSelectHeroInfoItem
end

function slot0.GetMimirInfoViewClass(slot0)
	return NewSectionMimirView
end

function slot0.GetComboSkillViewClass(slot0)
	return NewSectionComboSkillView
end

function slot0.GetSectionSelectHeroInfoClass(slot0)
	return SectionSelectHeroInfo
end

function slot0.GotoHeroInfoUI(slot0, slot1)
	slot2, slot3 = slot0:CheckBeforeGotoHeroInfoUI(slot1)

	if not slot2 then
		if slot3 then
			ShowTips(slot3)
		end

		return
	end

	slot4 = slot0:GetDefaultTeamInfoParams(slot1)

	for slot9, slot10 in pairs(slot0:GetCustomeTeamInfoParams(slot1)) do
		slot4[slot9] = slot10
	end

	JumpTools.OpenPageByJump(slot0:GetHeroTeamInfoRoute(), slot4)
end

function slot0.CheckBeforeGotoHeroInfoUI(slot0, slot1)
	if not slot0.canChangeTeam then
		return false, "CAN_NOT_CHANGE_HERO"
	end

	if slot0.stageID and slot0.stageID ~= 0 then
		slot2, slot3 = BattleStageTools.GetRestrictHeroList(slot0.stageType, slot0.stageID)

		if type(slot2) == "table" then
			if slot2[slot1][1] == 0 then
				return false, "CAN_NOT_CHANGE_HERO"
			end

			if HeroCfg[slot4[1]] and not table.keyof(HeroCfg.get_id_list_by_private[0], slot4[1]) and (type(slot3) ~= "table" or slot3[slot1] == ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID) then
				return false, "CAN_NOT_CHANGE_HERO"
			end
		end
	end

	return slot0:CustomCheckBeforeGotoHeroInfoUI(slot1)
end

function slot0.GetDefaultTeamInfoParams(slot0, slot1)
	return {
		isEnter = true,
		selectHeroPos = slot1,
		stageID = slot0.stageID,
		activityID = slot0.activityID,
		stageType = slot0.stageType,
		reserveParams = slot0.reserveParams,
		heroDataType = slot0.heroDataType,
		sectionProxy = slot0.sectionProxy
	}
end

function slot0.GotoReservesProposalUI(slot0)
	slot1 = slot0:GetDefaultReserveProposalParams()

	for slot6, slot7 in pairs(slot0:GetCustomeReserveProposalParams()) do
		slot1[slot6] = slot7
	end

	JumpTools.OpenPageByJump(slot0:GetHeroReserveProposalRoute(), slot1)
end

function slot0.GetDefaultReserveProposalParams(slot0)
	return {
		isEnter = true,
		stageType = slot0.stageType,
		stageID = slot0.stageID,
		sectionProxy = slot0,
		heroList = slot0:GetHeroIDList(),
		trialList = slot0:GetTrialIDList(),
		lockHeroList = slot0.lockHeroList,
		comboSkillID = slot0.comboSkillID,
		mimirID = slot0.mimirID,
		chipList = slot0.chipList
	}
end

function slot0.CheckBeforeBattle(slot0)
	if slot0.heroInfoList[1].heroID == 0 then
		return false, "TEAM_ERROR_LEADER"
	end

	slot1, slot2 = BattleStageTools.GetRestrictHeroList(slot0.stageType, slot0.stageID)

	if type(slot2) == "table" and slot2[slot0.heroPosMaxCount] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
		for slot6 = 2, slot0.heroPosMaxCount - 1 do
			if slot0.heroInfoList[slot6].heroID == 0 then
				return false, "TEAM_ERROR_NEED_MAX"
			end
		end
	end

	return slot0:CustomCheckBeforeBattle()
end

function slot0.StartBattle(slot0)
	slot1, slot2 = slot0:CheckBeforeBattle()

	if not slot1 then
		if slot2 then
			ShowTips(slot2)
		end

		return
	end

	slot0:SaveTeam()

	slot3 = slot0:GetStageData()

	slot3:SetMultiple(slot0.multiple)
	slot3:SetReserveParams(slot0.reserveParams)
	slot3:Init()
	slot0:LaunchBattle(slot3)
end

function slot0.SetReserveParams(slot0, slot1)
	slot0.reserveParams = slot1
end

function slot0.GetReserveParams(slot0)
	return slot0.reserveParams
end

function slot0.SaveTeam(slot0)
	slot0:CustomSaveTeam()
end

function slot0.ResetTeam(slot0)
	slot0:CustomResetTeam()
end

function slot0.GetHeroTeam(slot0)
	slot1, slot9, slot10, slot4 = slot0:CustomGetTeamData()

	slot0:RefreshHeroInfoList(slot1, slot4, slot9, slot10)

	slot5 = {}

	for slot9, slot10 in ipairs(slot4) do
		if slot10 ~= 0 then
			slot5[#slot5 + 1] = slot10
		end
	end

	for slot9, slot10 in ipairs(slot0.heroViewProxyDic) do
		slot10:SetTempHeroList(slot5)
	end

	return slot1, slot2, slot3, slot4
end

function slot0.GetHeroIDList(slot0)
	for slot5 = 1, slot0.heroPosMaxCount do
	end

	return {
		[slot5] = slot0.heroInfoList[slot5].heroID
	}
end

function slot0.GetTrialIDList(slot0)
	for slot5 = 1, slot0.heroPosMaxCount do
	end

	return {
		[slot5] = slot0.heroInfoList[slot5].trialID
	}
end

function slot0.GetLockStateList(slot0)
	for slot5 = 1, slot0.heroPosMaxCount do
	end

	return {
		[slot5] = slot0.heroInfoList[slot5].isLock
	}
end

function slot0.GetLockHeroList(slot0)
	return slot0.lockHeroList
end

function slot0.ChangeHeroTeam(slot0, slot1, slot2)
	slot2 = slot2 or {
		0,
		0,
		0
	}

	slot0:CustomChangeHeroTeam(slot1, slot2)
	slot0:RefreshHeroInfoList(slot1, slot2, slot0:GetLockStateList(), slot0.lockHeroList)
end

function slot0.ApplyReserveProposal(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:ApplyRroposalHeroTeam(slot1, slot2)
	slot0:SetComboSkillID(slot3)
	slot0:SetMimirID(slot4)
	slot0:SetMimirChipList(slot5)
end

function slot0.ApplyRroposalHeroTeam(slot0, slot1, slot2)
	slot0:CustomApplyRroposalHeroTeam(slot1, slot2)
	slot0:RefreshHeroInfoList(slot1, slot2, slot0:GetLockStateList(), slot0.lockHeroList)
end

function slot0.RefreshHeroInfoList(slot0, slot1, slot2, slot3, slot4)
	for slot8 = 1, slot0.heroPosMaxCount do
		if not slot0.heroInfoList[slot8] then
			slot0.heroInfoList[slot8] = slot0:GetSectionSelectHeroInfoClass().New()
		end

		slot10 = slot2[slot8] or 0
		slot11, slot12 = nil
		slot11 = (slot10 == 0 or HeroConst.HERO_DATA_TYPE.TRIAL) and slot0.heroDataType

		slot0.heroInfoList[slot8]:SetData(slot1[slot8] or 0, slot10, slot3[slot8])
		slot0.heroInfoList[slot8]:SetHeroDataType(slot11, slot0:GreateHeroViewProxy(slot11))
	end

	slot5 = {}

	for slot9, slot10 in ipairs(slot2) do
		if slot10 ~= 0 then
			slot5[#slot5 + 1] = slot10
		end
	end

	for slot9, slot10 in pairs(slot0.heroViewProxyDic) do
		slot10:SetTempHeroList(slot5)
	end

	slot0.lockHeroList = slot4

	slot0:CustomRefreshHeroInfoList(slot1, slot2, slot3, slot4)
end

function slot0.SetHeroDataType(slot0, slot1)
	slot0.heroDataType = slot1

	slot0:GreateHeroViewProxy(slot1)
end

function slot0.GreateHeroViewProxy(slot0, slot1)
	if not slot0.heroViewProxyDic[slot1] then
		slot0.heroViewProxyDic[slot1] = HeroViewDataProxy.New(slot1)
	end

	return slot0.heroViewProxyDic[slot1]
end

function slot0.GetHeroViewProxy(slot0)
	return slot0:GreateHeroViewProxy(slot0.heroDataType)
end

function slot0.CheckComboSkill(slot0)
	if slot0.stageID and slot0.stageID ~= 0 then
		if BattleStageTools.GetStageCfg(slot0.stageType, slot0.stageID) and slot1.combo_skill_id and slot1.combo_skill_id ~= 0 then
			slot0.customComboSkill = slot1.combo_skill_id
			slot0.needComboSkillPanel = true
			slot0.canChangeComboSkill = false

			return
		end

		if type(BattleStageTools.GetRestrictHeroList(slot0.stageType, slot0.stageID)) == "table" then
			slot0.customComboSkill = 0
			slot0.needComboSkillPanel = false
			slot0.canChangeComboSkill = false
		end
	end

	slot0:CustomCheckComboSkill()
end

function slot0.GetComboSkillID(slot0)
	slot1 = nil
	slot0.comboSkillID = (not slot0.stageID or slot0.stageID == 0 or (not BattleStageTools.GetStageCfg(slot0.stageType, slot0.stageID) or not slot2.combo_skill_id or slot2.combo_skill_id == 0 or slot2.combo_skill_id) and (type(BattleStageTools.GetRestrictHeroList(slot0.stageType, slot0.stageID)) == "table" and 0 or slot0:CustomGetComboSkillID())) and slot0:CustomGetComboSkillID()

	return slot0.comboSkillID
end

function slot0.SetComboSkillID(slot0, slot1)
	slot0.comboSkillID = slot1

	slot0:CustomSetComboSkillID(slot1)
end

function slot0.CheckMimirInfo(slot0)
	if slot0.stageID and slot0.stageID ~= 0 and BattleStageTools.GetStageCfg(slot0.stageType, slot0.stageID) and type(slot1.chip_list) == "table" then
		slot0.canChangeMimir = false
	end
end

function slot0.GetMimirID(slot0)
	slot1 = nil

	if slot0.stageID and slot0.stageID ~= 0 then
		if BattleStageTools.GetStageCfg(slot0.stageType, slot0.stageID) and type(slot2.chip_list) == "table" then
			slot1 = slot2.chip_list[1]
			slot0.chipList = {}

			for slot6 = 2, 3 do
				slot0.chipList[slot6 - 1] = slot2.chip_list[slot6]
			end
		else
			slot1 = slot0:CustomMimirID()
		end
	else
		slot1 = slot0:CustomMimirID()
	end

	slot0.mimirID = slot1

	return slot0.mimirID
end

function slot0.SetMimirID(slot0, slot1)
	slot0.mimirID = slot1

	slot0:CustomSetMimirID(slot1)
end

function slot0.GetMimirChipList(slot0)
	slot1 = nil

	if slot0.stageID and slot0.stageID ~= 0 then
		if BattleStageTools.GetStageCfg(slot0.stageType, slot0.stageID) and type(slot2.chip_list) == "table" then
			slot1 = {
				[slot6 - 1] = slot2.chip_list[slot6]
			}

			for slot6 = 2, 3 do
			end
		else
			slot1 = slot0:CustomGetMimirChipList()
		end
	else
		slot1 = slot0:CustomGetMimirChipList()
	end

	slot0.chipList = slot1

	return slot0.chipList
end

function slot0.InsertMimirChip(slot0, slot1)
	slot0:CustomInsertMimirChip(slot1)
	slot0:GetMimirChipList()
end

function slot0.RemoveMimirChip(slot0, slot1)
	slot0:CustomRemoveMimirChip(slot1)
	slot0:GetMimirChipList()
end

function slot0.SetMimirChipList(slot0, slot1)
	slot0:CustomSetMimirChipList(slot1)
	slot0:GetMimirChipList()
end

return slot0
