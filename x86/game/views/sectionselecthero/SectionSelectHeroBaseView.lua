local var_0_0 = class("SectionSelectHeroBaseView", ReduxView)
local var_0_1 = {
	{
		position = Vector3(500, 0, 0),
		rotation = Vector3(0, 0, 0),
		scale = Vector3(1, 1, 1)
	},
	{
		position = Vector3(502, 0, -2.5),
		rotation = Vector3(0, -16.419, 0),
		scale = Vector3(1, 1, 1)
	},
	{
		position = Vector3(498, 0, -2.5),
		rotation = Vector3(0, 9.932, 0),
		scale = Vector3(1, 1, 1)
	}
}
local var_0_2 = 462.5
local var_0_3 = Vector3.Distance(var_0_1[1].position, var_0_1[2].position)
local var_0_4 = var_0_1[2].position.z - var_0_1[1].position.z
local var_0_5 = var_0_1[2].position.x - var_0_1[1].position.x

function var_0_0.UIName(arg_1_0)
	return "UI/StagePrepare/BattleSelectHeroUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()

	arg_3_0.comboSkillView_ = arg_3_0:GetComboSkillView().New(arg_3_0.goComboSkill_)
	arg_3_0.chipView_ = arg_3_0:GetChipView().New(arg_3_0.chipPanel_)
end

function var_0_0.GetChipView(arg_4_0)
	return SectionSelectHeroChip
end

function var_0_0.GetComboSkillView(arg_5_0)
	return SectionComboSkillView
end

function var_0_0.HeroPosAdaptUI(arg_6_0)
	for iter_6_0 = 1, 3 do
		local var_6_0 = arg_6_0.heroRect_[iter_6_0].anchoredPosition.x * UnityEngine.Screen.width / arg_6_0.panel.rect.width + 0.5 * UnityEngine.Screen.width

		var_0_1[iter_6_0].position.x, var_0_1[iter_6_0].position.z = manager.ui:ScreenToWorldPoint(var_6_0, 0, 7.6 - offset[iter_6_0])
	end
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.roomProxy_ = arg_7_0.params_.roomProxy

	manager.ui:SetMainCamera("battleHeroSelect")
	manager.ui:AdaptUIByFOV()

	if arg_7_0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS or arg_7_0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.SAIL_GAME or arg_7_0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			NAVI_BAR
		})
	end

	arg_7_0.multiple_ = arg_7_0.params_.multiple or 1
	arg_7_0.stageID_ = arg_7_0.params_.section
	arg_7_0.stageType_ = arg_7_0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	if not arg_7_0.params_.reserveParams then
		arg_7_0.params_.reserveParams = ReserveTools.GetReserveParams(arg_7_0.stageType_, arg_7_0.stageID_, arg_7_0.params_.activityID)
	elseif not arg_7_0.params_.reserveParams.customData.activityID then
		arg_7_0.params_.reserveParams.customData.activityID = arg_7_0.params_.activityID
	end

	arg_7_0.reserveParams_ = arg_7_0.params_.reserveParams
	arg_7_0.heroModel_ = {}
	arg_7_0.loadAsyncIndex_ = {}
	arg_7_0.loadingList_ = {}
	arg_7_0.cacheHeroNumber_ = {
		1,
		2,
		3
	}
	arg_7_0.cacheHeroTeam_ = {}
	arg_7_0.heroTrialList_ = {}

	arg_7_0:RefreshEffectActive()
	arg_7_0:RefreshChip()
	arg_7_0:RefreshHeroTeam()
	arg_7_0:LoadHeroModels()
	arg_7_0:RefreshText()
	arg_7_0:HidePanel()
	arg_7_0:RefreshRace()
	arg_7_0:RefreshReservesBtn()
	arg_7_0:RefreshSortType()
	arg_7_0:RefreshRecommend()

	arg_7_0.params_.isReserves = nil
end

function var_0_0.OnExit(arg_8_0)
	if arg_8_0.talkTimer_ then
		arg_8_0.talkTimer_:Stop()

		arg_8_0.talkTimer_ = nil
	end

	if arg_8_0.talkCDTimer_ then
		arg_8_0.talkCDTimer_:Stop()

		arg_8_0.talkCDTimer_ = nil
	end

	arg_8_0.params_.isSorted = false

	HeroTools.StopTalk()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	arg_8_0:DestroyHeroModels()
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.chipView_:Dispose()

	arg_9_0.chipView_ = nil

	arg_9_0.comboSkillView_:Dispose()

	arg_9_0.comboSkillView_ = nil

	if arg_9_0.ani_ then
		Object.Destroy(arg_9_0.ani_)
	end

	arg_9_0:RemoveTriggerListeners()
	arg_9_0:RemoveListeners()

	arg_9_0.stageName_ = nil
	arg_9_0.warningImage_ = nil
	arg_9_0.recommendGo_ = nil
	arg_9_0.powerGo_ = nil
	arg_9_0.recommendImage_ = nil
	arg_9_0.recommendPowerText_ = nil
	arg_9_0.recommendPowerNumText_ = nil
	arg_9_0.powerNumText_ = nil
	arg_9_0.powerText_ = nil
	arg_9_0.powerImg_ = nil
	arg_9_0.effectPanel_ = nil
	arg_9_0.effectImage_ = nil
	arg_9_0.effectName_ = nil
	arg_9_0.effectText_ = nil
	arg_9_0.effectHeroText_ = nil
	arg_9_0.addBtnGo_ = nil
	arg_9_0.addBtnImg_ = nil
	arg_9_0.heroPowerPanel_ = nil
	arg_9_0.heroPowerIcon_ = nil
	arg_9_0.heroPowerText_ = nil
	arg_9_0.drag_ = nil
	arg_9_0.dragPosition_ = nil
	arg_9_0.startBtn_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.InitUI(arg_10_0)
	arg_10_0:BindCfgUI()

	arg_10_0.addBtnGo_ = {}
	arg_10_0.addBtnImg_ = {}
	arg_10_0.heroPowerPanel_ = {}
	arg_10_0.heroPowerIcon_ = {}
	arg_10_0.heroPowerText_ = {}
	arg_10_0.hpGp_ = {}
	arg_10_0.hpImg_ = {}
	arg_10_0.hpText_ = {}
	arg_10_0.energyGo_ = {}
	arg_10_0.energyText_ = {}
	arg_10_0.drag_ = {}
	arg_10_0.dragImg_ = {}
	arg_10_0.dragPosition_ = {}
	arg_10_0.heroRect_ = {}

	for iter_10_0 = 1, 3 do
		arg_10_0.heroPowerPanel_[iter_10_0] = arg_10_0[string.format("heroPowerPanel%s_", iter_10_0)]
		arg_10_0.heroPowerIcon_[iter_10_0] = arg_10_0[string.format("heroPowerIcon%s_", iter_10_0)]
		arg_10_0.heroPowerText_[iter_10_0] = arg_10_0[string.format("heroPowerText%s_", iter_10_0)]
		arg_10_0.addBtnGo_[iter_10_0] = arg_10_0[string.format("addBtnGo%s_", iter_10_0)]
		arg_10_0.addBtnImg_[iter_10_0] = arg_10_0[string.format("addBtnImg%s_", iter_10_0)]
		arg_10_0.energyGo_[iter_10_0] = arg_10_0[string.format("energyGo%s_", iter_10_0)]
		arg_10_0.energyText_[iter_10_0] = arg_10_0[string.format("energyLabel%s_", iter_10_0)]
		arg_10_0.drag_[iter_10_0] = arg_10_0[string.format("drag%s_", iter_10_0)]
		arg_10_0.dragImg_[iter_10_0] = arg_10_0["dragImg_" .. iter_10_0]
		arg_10_0.hpGp_[iter_10_0] = arg_10_0[string.format("hp%sGo_", iter_10_0)]
		arg_10_0.hpImg_[iter_10_0] = arg_10_0[string.format("blood%sImg_", iter_10_0)]
		arg_10_0.hpText_[iter_10_0] = arg_10_0[string.format("hptext%sText_", iter_10_0)]

		arg_10_0:CreateDragListeners(iter_10_0)

		arg_10_0.dragPosition_[iter_10_0] = arg_10_0.drag_[iter_10_0].transform.localPosition
		arg_10_0.heroRect_[iter_10_0] = arg_10_0[string.format("heroRect_%s", iter_10_0)]
	end
end

function var_0_0.CreateDragListeners(arg_11_0, arg_11_1)
	arg_11_0.drag_[arg_11_1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_12_0, arg_12_1)
		if arg_11_0.selectIndex_ then
			return
		end

		if #arg_11_0.loadingList_ > 0 then
			return
		end

		if arg_11_0.lockStateList_[arg_11_1] or arg_11_0.params_.canChangeTeam ~= nil and arg_11_0.params_.canChangeTeam == false then
			ShowTips("CAN_NOT_CHANGE_HERO")

			return
		end

		arg_11_0.selectIndex_ = arg_11_1
		arg_11_0.cacheSelectIndex_ = arg_11_1
		arg_11_0.cacheHeroNumber_ = {
			1,
			2,
			3
		}
	end))
	arg_11_0.drag_[arg_11_1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_13_0, arg_13_1)
		if arg_11_0.selectIndex_ ~= arg_11_1 then
			return
		end

		if #arg_11_0.loadingList_ > 0 then
			return
		end

		local var_13_0 = Vector3((arg_13_1.position.x - Screen.width / 2) * manager.ui.canvasRate, 0, 0)

		if arg_13_0.transform.localPosition.x > 237 or var_13_0.x > 237 then
			arg_13_0.transform.localPosition = Vector3(237, var_13_0.y, var_13_0.z)
		elseif arg_13_0.transform.localPosition.x < -688 or var_13_0.x < -688 then
			arg_13_0.transform.localPosition = Vector3(-688, var_13_0.y, var_13_0.z)
		else
			arg_13_0.transform.localPosition = var_13_0
		end

		local var_13_1 = arg_11_0:GetModelOffesetPosition(arg_13_0.transform.localPosition)

		if arg_11_0.heroModel_[arg_11_1] then
			arg_11_0.heroModel_[arg_11_1].transform.localPosition = var_0_1[1].position + var_13_1

			if not arg_11_0.lockStateList_[arg_11_1] or arg_11_0.params_.canChangeTeam ~= nil and arg_11_0.params_.canChangeTeam == true then
				arg_11_0:TryModifyHeroPos()
			end
		end
	end))
	arg_11_0.drag_[arg_11_1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_14_0, arg_14_1)
		if arg_11_0.selectIndex_ ~= arg_11_1 then
			return
		end

		if #arg_11_0.loadingList_ > 0 then
			return
		end

		arg_14_0.transform.localPosition = arg_11_0.dragPosition_[arg_11_1]

		if not arg_11_0.lockStateList_[arg_11_1] or arg_11_0.params_.canChangeTeam ~= nil and arg_11_0.params_.canChangeTeam == true then
			arg_11_0:EndDrag(arg_11_1)
		end

		arg_11_0.selectIndex_ = nil
	end))
	arg_11_0.drag_[arg_11_1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(handlerArg1(arg_11_0, arg_11_0.ClickHero, arg_11_1)))
end

function var_0_0.RemoveTriggerListeners(arg_15_0)
	for iter_15_0 = 1, 3 do
		arg_15_0.drag_[iter_15_0]:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
		arg_15_0.drag_[iter_15_0]:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
		arg_15_0.drag_[iter_15_0]:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
		arg_15_0.drag_[iter_15_0]:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	end
end

function var_0_0.ClickHero(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_3.dragging then
		if arg_16_0.selectIndex_ then
			return
		end

		if #arg_16_0.loadingList_ > 0 then
			return
		end

		BattleFieldData:SetCurrentSelectHeroData(arg_16_0.cacheHeroTeam_[arg_16_1], arg_16_0.heroTrialList_[arg_16_1])
		OperationRecorder.Record(arg_16_0.class.__cname, "click_add")
		arg_16_0:GoHeroInfoUI(arg_16_1)
	end
end

function var_0_0.TryModifyHeroPos(arg_17_0)
	local var_17_0 = arg_17_0.heroModel_[arg_17_0.selectIndex_].transform.localPosition

	for iter_17_0 = 1, 3 do
		if math.abs(var_0_1[iter_17_0].position.x - var_17_0.x) <= 0.6 and iter_17_0 ~= arg_17_0.cacheSelectIndex_ then
			if arg_17_0.cacheHeroTeam_[arg_17_0.cacheHeroNumber_[iter_17_0]] == 0 then
				break
			end

			if arg_17_0.lockStateList_[arg_17_0.selectIndex_] or arg_17_0.lockStateList_[iter_17_0] then
				return
			end

			if arg_17_0.heroModel_[arg_17_0.cacheHeroNumber_[iter_17_0]] then
				arg_17_0.heroModel_[arg_17_0.cacheHeroNumber_[iter_17_0]].transform.localPosition = var_0_1[arg_17_0.cacheSelectIndex_].position
				arg_17_0.heroModel_[arg_17_0.cacheHeroNumber_[iter_17_0]].transform.localEulerAngles = var_0_1[arg_17_0.cacheSelectIndex_].rotation
			end

			local var_17_1 = arg_17_0.cacheHeroNumber_[iter_17_0]

			arg_17_0.cacheHeroNumber_[iter_17_0] = arg_17_0.cacheHeroNumber_[arg_17_0.cacheSelectIndex_]
			arg_17_0.cacheHeroNumber_[arg_17_0.cacheSelectIndex_] = var_17_1
			arg_17_0.cacheSelectIndex_ = iter_17_0

			break
		end
	end
end

function var_0_0.EndDrag(arg_18_0, arg_18_1)
	local var_18_0 = {}

	for iter_18_0 = 1, 3 do
		var_18_0[iter_18_0] = arg_18_0.cacheHeroTeam_[arg_18_0.cacheHeroNumber_[iter_18_0]]
	end

	local var_18_1 = {}

	for iter_18_1, iter_18_2 in pairs(var_18_0) do
		local var_18_2 = 1

		for iter_18_3 = 1, 3 do
			if arg_18_0.cacheHeroTeam_[iter_18_3] == iter_18_2 then
				var_18_2 = iter_18_3

				break
			end
		end

		var_18_1[iter_18_1] = arg_18_0.heroModel_[var_18_2]

		if var_18_1[iter_18_1] then
			var_18_1[iter_18_1].transform.localPosition = var_0_1[iter_18_1].position
			var_18_1[iter_18_1].transform.localEulerAngles = var_0_1[iter_18_1].rotation
		end
	end

	arg_18_0.heroModel_ = var_18_1

	arg_18_0:SwapIndex(arg_18_0.selectIndex_, arg_18_0.cacheSelectIndex_)
	arg_18_0:ChangeHeroTeam(var_18_0)
	arg_18_0:RefreshHeroTeam()
	OperationRecorder.Record(arg_18_0.class.__cname, "endDrag")
end

function var_0_0.AddListeners(arg_19_0)
	arg_19_0:AddBtnListener(arg_19_0.startBtn_, nil, function()
		arg_19_0:OnClickStartBattle()
	end)
	arg_19_0:AddBtnListener(arg_19_0.reservesBtn_, nil, function()
		arg_19_0:GotoReservesUI()
	end)
end

function var_0_0.GotoReservesUI(arg_22_0)
	JumpTools.OpenPageByJump("/reservesUI", {
		isInit = true,
		stage_type = arg_22_0.stageType_,
		stage_id = arg_22_0.stageID_,
		activityID = arg_22_0.params_.activityID,
		hero_list = arg_22_0.cacheHeroTeam_,
		hero_trial_list = arg_22_0.heroTrialList_,
		lockList = arg_22_0.lockList_,
		comboSkill = arg_22_0.comboSkillView_:GetCurComboSkill(),
		chipInfo = {
			enabledID = arg_22_0.chipView_:GetCurMimirID(),
			chipList = arg_22_0.chipView_:GetCurChipList()
		},
		reserveParams = arg_22_0.reserveParams_
	})
end

function var_0_0.RemoveListeners(arg_23_0)
	arg_23_0.startBtn_.onClick:RemoveAllListeners()
end

function var_0_0.OnClickStartBattle(arg_24_0)
	if #arg_24_0.loadingList_ > 0 then
		return
	end

	if arg_24_0.cacheHeroTeam_[1] ~= 0 then
		arg_24_0:SaveTeamInfo()
		arg_24_0:StartBattle()
	else
		ShowTips("ERROR_HERO_ONE_NOT_IN")
	end
end

function var_0_0.StartBattle(arg_25_0)
	local var_25_0

	if arg_25_0.roomProxy_ then
		var_25_0 = arg_25_0.roomProxy_:GetTemplate()
	else
		var_25_0 = BattleStageFactory.Produce(arg_25_0.stageType_, arg_25_0.stageID_, arg_25_0.params_.activityID, arg_25_0.reserveParams_)
	end

	var_25_0:SetMultiple(arg_25_0.multiple_)
	BattleController.GetInstance():LaunchBattle(var_25_0)
end

function var_0_0.RefreshHeroTeam(arg_26_0)
	arg_26_0:GetSelectHero()
	arg_26_0:RefreshAddBtn()
	arg_26_0:RefreshCombo()
	arg_26_0:RefreshHp()
end

function var_0_0.LoadHeroModels(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.cacheHeroTeam_) do
		if iter_27_1 ~= 0 and iter_27_1 then
			local var_27_0 = arg_27_0:GetSkinCfg(iter_27_0, iter_27_1)

			table.insert(arg_27_0.loadingList_, iter_27_1)

			arg_27_0.loadAsyncIndex_[iter_27_0] = manager.resourcePool:AsyncLoad("Char/" .. var_27_0.ui_modelId, ASSET_TYPE.TPOSE, function(arg_28_0)
				arg_27_0.heroModel_[iter_27_0] = arg_28_0
				arg_27_0.heroModel_[iter_27_0].transform.localEulerAngles = var_0_1[iter_27_0].rotation
				arg_27_0.heroModel_[iter_27_0].transform.localPosition = var_0_1[iter_27_0].position
				arg_27_0.heroModel_[iter_27_0].transform.localScale = var_0_1[iter_27_0].scale

				local var_28_0 = table.keyof(arg_27_0.loadingList_, iter_27_1)

				if var_28_0 then
					table.remove(arg_27_0.loadingList_, var_28_0)
				end
			end)
		end
	end
end

function var_0_0.GetSkinCfg(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0.heroTrialList_[arg_29_1] ~= 0 then
		return SkinCfg[HeroStandardSystemCfg[arg_29_0.heroTrialList_[arg_29_1]].skin_id]
	elseif arg_29_0.lockStateList_[arg_29_1] then
		return SkinCfg[arg_29_2]
	else
		return arg_29_0:GetHeroCfg(arg_29_2)
	end
end

function var_0_0.GetHeroCfg(arg_30_0, arg_30_1)
	return HeroTools.HeroUsingSkinInfo(arg_30_1)
end

function var_0_0.DestroyHeroModels(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.heroModel_) do
		manager.resourcePool:DestroyOrReturn(iter_31_1, ASSET_TYPE.TPOSE)

		if dl then
			SetActive(dl, true)
		end
	end

	for iter_31_2, iter_31_3 in pairs(arg_31_0.loadAsyncIndex_) do
		manager.resourcePool:StopAsyncQuest(arg_31_0.loadAsyncIndex_[iter_31_2])
	end

	arg_31_0.loadAsyncIndex_ = nil
	arg_31_0.heroModel_ = nil
end

function var_0_0.GetModelOffesetPosition(arg_32_0, arg_32_1)
	local var_32_0 = Vector3(0, 0, 0)
	local var_32_1 = arg_32_1.x - arg_32_0.dragPosition_[1].x

	if var_32_1 > 0 then
		var_32_0.x = -var_32_1 * var_0_5 / var_0_2
		var_32_0.z = var_32_1 * var_0_4 / var_0_2
	else
		var_32_0.x = -var_32_1 * var_0_5 / var_0_2
		var_32_0.z = -var_32_1 * var_0_4 / var_0_2
	end

	return var_32_0
end

function var_0_0.RefreshAddBtn(arg_33_0)
	for iter_33_0 = 1, 3 do
		if arg_33_0.lockStateList_[iter_33_0] == true and arg_33_0.cacheHeroTeam_[iter_33_0] == 0 then
			arg_33_0.addBtnImg_[iter_33_0].sprite = getSprite("Atlas/BattleSelectHero", "icon_no")
		else
			arg_33_0.addBtnImg_[iter_33_0].sprite = getSprite("Atlas/BattleSelectHero", "btn_add")
		end

		arg_33_0.addBtnImg_[iter_33_0]:SetNativeSize()
	end

	for iter_33_1, iter_33_2 in ipairs(arg_33_0.cacheHeroTeam_) do
		SetActive(arg_33_0.addBtnGo_[iter_33_1], iter_33_2 == 0)

		if iter_33_1 == 2 or iter_33_1 == 3 then
			SetActive(arg_33_0.addBtnGo_[iter_33_1], iter_33_2 == 0 and arg_33_0.params_.sectionType ~= BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO)
		end

		if iter_33_2 and iter_33_2 == 0 then
			SetActive(arg_33_0.heroPowerPanel_[iter_33_1].gameObject, false)
		else
			local var_33_0 = RaceEffectCfg[HeroCfg[iter_33_2].race]

			arg_33_0.heroPowerText_[iter_33_1].text = arg_33_0:GetHeroPower(iter_33_1)
			arg_33_0.heroPowerIcon_[iter_33_1].sprite = getSprite("Atlas/CampItemAtlas", var_33_0.icon)

			SetActive(arg_33_0.heroPowerPanel_[iter_33_1].gameObject, true)
		end
	end

	arg_33_0.dragImg_[2].raycastTarget = arg_33_0.params_.sectionType ~= BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO
	arg_33_0.dragImg_[3].raycastTarget = arg_33_0.params_.sectionType ~= BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO
end

function var_0_0.RefreshReservesBtn(arg_34_0)
	local var_34_0 = true

	for iter_34_0 = 1, 3 do
		if arg_34_0.lockStateList_[iter_34_0] then
			var_34_0 = false
		end
	end

	if arg_34_0.params_.canChangeTeam ~= nil and arg_34_0.params_.canChangeTeam == false then
		var_34_0 = false
	end

	SetActive(arg_34_0.reservesBtn_.gameObject, var_34_0)
end

function var_0_0.HidePanel(arg_35_0)
	if arg_35_0:GetRecommendLevel() == 0 then
		SetActive(arg_35_0.recommendGo_, false)
	else
		SetActive(arg_35_0.recommendGo_, true)
	end
end

function var_0_0.RefreshHp(arg_36_0)
	if arg_36_0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS then
		for iter_36_0, iter_36_1 in pairs(arg_36_0.cacheHeroTeam_) do
			if iter_36_1 and iter_36_1 == 0 then
				SetActive(arg_36_0.hpGp_[iter_36_0], false)
			else
				local var_36_0 = NewWarChessData:GetHeroHp(iter_36_1)

				if not var_36_0 then
					print("英雄血量不存在")
				else
					SetActive(arg_36_0.hpGp_[iter_36_0], true)

					arg_36_0.hpImg_[iter_36_0].fillAmount = var_36_0 / NewChessConst.HERO_HP_RATE
					arg_36_0.hpText_[iter_36_0].text = math.ceil(var_36_0 / NewChessConst.HERO_HP_RATE * 100) .. "%"
				end
			end
		end
	else
		for iter_36_2 = 1, 3 do
			SetActive(arg_36_0.hpGp_[iter_36_2], false)
		end
	end
end

function var_0_0.RefreshRace(arg_37_0)
	local var_37_0, var_37_1, var_37_2 = arg_37_0:GetRaceEffect()

	arg_37_0.maxRaceID_ = var_37_0
	arg_37_0.maxRacePlayerCount_ = var_37_2

	if arg_37_0.params_.forceRace then
		local var_37_3 = arg_37_0.params_.forceRace
		local var_37_4 = RaceEffectCfg[var_37_3]

		SetActive(arg_37_0.effectTitlePanel_, true)

		arg_37_0.effectName_.text = GetI18NText(var_37_4.name)
		arg_37_0.effectImage_.sprite = getSprite("Atlas/CampItemAtlas", var_37_4.icon)
		arg_37_0.effectHeroText_.text = GetI18NText(var_37_4.desc)
		arg_37_0.effectText_.text = GetI18NText(var_37_4.battle_desc)
		arg_37_0.titleCanvasGroup1_.alpha = 1
		arg_37_0.titleCanvasGroup2_.alpha = 1

		SetActive(arg_37_0.activeGo2_, false)
		SetActive(arg_37_0.activeGo1_, false)
	else
		SetActive(arg_37_0.effectTitlePanel_, var_37_0 ~= 0)

		if var_37_1 then
			local var_37_5 = RaceEffectCfg[var_37_0]

			arg_37_0.effectText_.text = GetI18NText(var_37_5.battle_desc)
			arg_37_0.titleCanvasGroup2_.alpha = 1
		else
			arg_37_0.effectText_.text = GetTips("NO_BATTLE_BUFF")
			arg_37_0.titleCanvasGroup2_.alpha = 0.8
		end

		SetActive(arg_37_0.activeGo2_, not var_37_1)
		SetActive(arg_37_0.activeGo1_, var_37_0 == 0)

		if var_37_0 == 0 then
			arg_37_0.titleCanvasGroup1_.alpha = 0.8
			arg_37_0.effectHeroText_.text = GetTips("NO_CORRECTOR_BUFF")

			return
		end

		arg_37_0.titleCanvasGroup1_.alpha = 1

		local var_37_6 = RaceEffectCfg[var_37_0]

		arg_37_0.effectName_.text = GetI18NText(var_37_6.name)
		arg_37_0.effectHeroText_.text = GetI18NText(var_37_6.desc)
		arg_37_0.effectImage_.sprite = getSprite("Atlas/CampItemAtlas", var_37_6.icon)
	end
end

function var_0_0.RefreshText(arg_38_0)
	arg_38_0.stageName_.text = BattleStageTools.GetStageName(arg_38_0.stageType_, arg_38_0.stageID_)
	arg_38_0.recommendPowerNumText_.text = arg_38_0:GetRecommendLevel()
end

function var_0_0.RefreshEffectActive(arg_39_0)
	SetActive(arg_39_0.effectPanelGo_, arg_39_0.params_.isHideEffect ~= true)
end

function var_0_0.RefershPower(arg_40_0)
	SetActive(arg_40_0.goPowerPanel_, true)

	local var_40_0 = arg_40_0.totalPower_

	arg_40_0.powerNumText_.text = var_40_0
	arg_40_0.recommendPowerNumText_.text = arg_40_0:GetRecommendLevel()

	local var_40_1 = var_40_0 > arg_40_0:GetRecommendLevel()
	local var_40_2

	if var_40_1 then
		var_40_2 = Color(0.2117647, 0.227451, 0.2588235)
	else
		var_40_2 = Color(0.8705883, 0.3098039, 0.3098039)
	end

	SetActive(arg_40_0.selectPowerGo_, not var_40_1)

	arg_40_0.powerNumText_.color = var_40_2
end

function var_0_0.RefreshChip(arg_41_0)
	local var_41_0 = not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER)

	SetActive(arg_41_0.chipPanel_, var_41_0)

	if var_41_0 then
		arg_41_0.chipView_:SetData(arg_41_0.stageType_, arg_41_0.stageID_, arg_41_0.params_.activityID, arg_41_0.reserveParams_)
	end
end

function var_0_0.RefreshCombo(arg_42_0)
	arg_42_0.comboSkillView_:SetHeroList(arg_42_0.stageType_, arg_42_0.stageID_, arg_42_0.params_.activityID, arg_42_0.cacheHeroTeam_, arg_42_0.heroTrialList_, arg_42_0.params_.index, arg_42_0.reserveParams_)
end

function var_0_0.RefreshSortType(arg_43_0)
	if not arg_43_0.params_.isSorted then
		HeroData:ResetSortValue()
	end
end

function var_0_0.RefreshRecommend(arg_44_0)
	if not arg_44_0.params_.recommend_type then
		SetActive(arg_44_0.recommendTypeGo_, false)

		return
	end

	SetActive(arg_44_0.recommendTypeGo_, true)

	for iter_44_0, iter_44_1 in ipairs(GameDisplayCfg.hero_atack_type_tag.value) do
		if iter_44_1[1] == arg_44_0.params_.recommend_type then
			local var_44_0 = iter_44_1[2]

			arg_44_0.recommendTypeIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/HeroIconUI/AttributeIcon/" .. var_44_0)

			break
		end
	end
end

function var_0_0.PlayHeroTalk(arg_45_0, arg_45_1)
	if arg_45_0.talkTimer_ then
		arg_45_0.talkTimer_:Stop()

		arg_45_0.talkTimer_ = nil
	end

	HeroTools.StopTalk()

	if arg_45_0.talkCDTimer_ then
		return
	end

	arg_45_0.talkTimer_ = Timer.New(function()
		HeroTools.PlayTalk(arg_45_1, "leader")

		arg_45_0.talkTimer_ = nil
		arg_45_0.talkCDTimer_ = Timer.New(function()
			arg_45_0.talkCDTimer_:Stop()

			arg_45_0.talkCDTimer_ = nil
		end, HeroConst.SET_LEADER_VOICE_CD, 1)

		arg_45_0.talkCDTimer_:Start()
	end, HeroConst.TALK_DELAY_TIME, 1)

	arg_45_0.talkTimer_:Start()
end

function var_0_0.GoHeroInfoUI(arg_48_0, arg_48_1)
	local var_48_0 = BattleStageTools.GetRestrictHeroList(arg_48_0.stageType_, arg_48_0.stageID_)

	if type(var_48_0) == "table" then
		local var_48_1 = var_48_0[arg_48_1]

		if var_48_1[1] == 0 or var_48_1[1] ~= 0 and HeroCfg[var_48_1[1]] and not table.keyof(HeroCfg.get_id_list_by_private[0], var_48_1[1]) then
			ShowTips("CAN_NOT_CHANGE_HERO")

			return
		end
	end

	arg_48_0:Go(arg_48_0:GetHeroTeamInfoRoute(), {
		isEnter = true,
		selectHeroPos = arg_48_1,
		stageID = arg_48_0.stageID_,
		activityID = arg_48_0.params_.activityID,
		stageType = arg_48_0.stageType_,
		reserveParams = arg_48_0.reserveParams_,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT
	})
end

function var_0_0.GetHeroTeamInfoRoute(arg_49_0)
	return "/heroTeamInfo"
end

function var_0_0.SwapIndex(arg_50_0, arg_50_1, arg_50_2)
	return
end

function var_0_0.ChangeHeroTeam(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_0.roomProxy_ then
		arg_51_0.roomProxy_:SetTeamInfo(arg_51_2)
	else
		local var_51_0 = arg_51_1
		local var_51_1 = {}

		for iter_51_0, iter_51_1 in ipairs(arg_51_1) do
			local var_51_2 = table.keyof(arg_51_0.cacheHeroTeam_, iter_51_1)

			var_51_1[iter_51_0] = arg_51_0.heroTrialList_[var_51_2]
		end

		if var_51_0[1] ~= arg_51_0.cacheHeroTeam_[1] then
			arg_51_0:PlayHeroTalk(var_51_0[1])
		end

		ReserveTools.SetTeam(arg_51_0.reserveParams_, var_51_0, var_51_1, arg_51_0.comboSkillView_:GetCurComboSkill(), arg_51_0.chipView_:GetCurMimirID(), arg_51_0.chipView_:GetCurChipList())
	end
end

function var_0_0.SaveTeamInfo(arg_52_0)
	if ReserveTools.NeedCacheTeam(arg_52_0.stageType_, arg_52_0.stageID_) then
		ReserveTools.SetTeam(arg_52_0.reserveParams_, arg_52_0.cacheHeroTeam_, arg_52_0.heroTrialList_, arg_52_0.comboSkillView_:GetCurComboSkill(), arg_52_0.chipView_:GetCurMimirID(), arg_52_0.chipView_:GetCurChipList())
	end
end

function var_0_0.GetSelectHero(arg_53_0)
	local var_53_0 = false

	if arg_53_0.roomProxy_ then
		local var_53_1 = arg_53_0.roomProxy_:GetHeroTeam()

		arg_53_0.cacheHeroTeam_ = var_53_1.HeroList
		arg_53_0.lockStateList_ = var_53_1.LockStateList
		arg_53_0.lockList_ = var_53_1.LockHeroList
		arg_53_0.heroTrialList_ = var_53_1.TrialHeroList

		if var_53_1.IsInvalid then
			arg_53_0:ChangeHeroTeam(arg_53_0.cacheHeroTeam_)
		end
	else
		local var_53_2

		arg_53_0.cacheHeroTeam_, arg_53_0.lockStateList_, arg_53_0.lockList_, arg_53_0.heroTrialList_, var_53_2 = ReserveTools.GetHeroList(arg_53_0.reserveParams_)
	end
end

function var_0_0.GetRaceEffect(arg_54_0)
	local var_54_0 = {}
	local var_54_1 = 0
	local var_54_2 = false
	local var_54_3 = arg_54_0.cacheHeroTeam_

	for iter_54_0, iter_54_1 in ipairs(var_54_3) do
		if iter_54_1 ~= 0 then
			local var_54_4 = HeroCfg[iter_54_1].race

			var_54_0[var_54_4] = (var_54_0[var_54_4] or 0) + 1

			if var_54_0[var_54_4] == 2 then
				var_54_1 = var_54_4
			elseif var_54_0[var_54_4] == 3 then
				var_54_2 = true
			end
		end
	end

	return var_54_1, var_54_2, var_54_0[var_54_1] or 1
end

function var_0_0.GetTotalPower(arg_55_0)
	local var_55_0 = 0

	for iter_55_0, iter_55_1 in pairs(arg_55_0.cacheHeroTeam_) do
		if iter_55_1 ~= 0 then
			var_55_0 = var_55_0 + arg_55_0:GetHeroPower(iter_55_0)
		end
	end

	return var_55_0
end

function var_0_0.GetRecommendLevel(arg_56_0)
	return BattleStageTools.GetStageCfg(arg_56_0.stageType_, arg_56_0.stageID_).recommend_level or 0
end

function var_0_0.GetHeroPower(arg_57_0, arg_57_1)
	if arg_57_0.heroTrialList_[arg_57_1] ~= 0 then
		return getHeroPower(arg_57_0.heroTrialList_[arg_57_1], true)
	end

	return getHeroPower(arg_57_0.cacheHeroTeam_[arg_57_1], false)
end

return var_0_0
