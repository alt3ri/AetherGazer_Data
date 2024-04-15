local var_0_0 = class("SettingView2", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Setting/SettingUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.typeNameS_ = {
		polyhedronAddition = 9,
		intelligence = 2,
		remind = 9,
		sound = 3,
		polyhedronHeroInfo = 10,
		artifact = 7,
		affix = 5,
		game = 4,
		screen = 1,
		skill = 6,
		operation = 8,
		polyhedronTeamInfo = 10
	}
	arg_4_0.toggle_ = {}
	arg_4_0.toggleSelect_ = {}
	arg_4_0.toggleUnSelect_ = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0.typeNameS_) do
		arg_4_0.toggle_[iter_4_0] = arg_4_0[iter_4_0 .. "Tgl_"]
		arg_4_0.toggleUnSelect_[iter_4_0] = arg_4_0[iter_4_0 .. "UnselectGo_"]
		arg_4_0.toggleSelect_[iter_4_0] = arg_4_0[iter_4_0 .. "SelectGo_"]
	end

	arg_4_0.viewList_ = {}
	arg_4_0.viewListGo_ = {}
end

function var_0_0.ChangeShowView(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 then
		arg_5_0:RecordStay(arg_5_0.params_.selectType)

		arg_5_0.params_.selectType = arg_5_1
	end

	if arg_5_0.viewListGo_[arg_5_1] then
		SetActive(arg_5_0.viewListGo_[arg_5_1], arg_5_2)
	elseif arg_5_2 then
		if arg_5_1 == "screen" then
			local var_5_0 = Asset.Load("UI/Setting/GraphicSettingUI")

			arg_5_0.viewListGo_[arg_5_1] = Object.Instantiate(var_5_0, arg_5_0.panelTrs_)
			arg_5_0.viewList_[arg_5_1] = GraphicSettingView.New(arg_5_0, arg_5_0.viewListGo_[arg_5_1])
		elseif arg_5_1 == "intelligence" then
			local var_5_1 = arg_5_0.params_.stageData

			if var_5_1 and var_5_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
				local var_5_2 = Asset.Load("UI/Setting/VariableSettingUI")

				arg_5_0.viewListGo_[arg_5_1] = Object.Instantiate(var_5_2, arg_5_0.panelTrs_)
				arg_5_0.viewList_[arg_5_1] = MatrixStageSettingView.New(arg_5_0.viewListGo_[arg_5_1], BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX)
			elseif var_5_1 and (var_5_1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or var_5_1:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX) then
				local var_5_3 = Asset.Load("UI/Setting/VariableSettingUI")

				arg_5_0.viewListGo_[arg_5_1] = Object.Instantiate(var_5_3, arg_5_0.panelTrs_)
				arg_5_0.viewList_[arg_5_1] = MatrixStageSettingView.New(arg_5_0.viewListGo_[arg_5_1], var_5_1:GetType(), var_5_1:GetActivityID())
			else
				local var_5_4 = Asset.Load("UI/Setting/IntelligenceUI")

				arg_5_0.viewListGo_[arg_5_1] = Object.Instantiate(var_5_4, arg_5_0.panelTrs_)
				arg_5_0.viewList_[arg_5_1] = IntelligenceView.New(arg_5_0, arg_5_0.viewListGo_[arg_5_1], arg_5_0.params_)
			end
		elseif arg_5_1 == "sound" then
			local var_5_5 = Asset.Load("UI/Setting/SoundSettingUI")

			arg_5_0.viewListGo_[arg_5_1] = Object.Instantiate(var_5_5, arg_5_0.panelTrs_)
			arg_5_0.viewList_[arg_5_1] = SoundSettingView.New(arg_5_0, arg_5_0.viewListGo_[arg_5_1])
		elseif arg_5_1 == "game" then
			local var_5_6 = Asset.Load("UI/Setting/GameSettingUI")

			arg_5_0.viewListGo_[arg_5_1] = Object.Instantiate(var_5_6, arg_5_0.panelTrs_)
			arg_5_0.viewList_[arg_5_1] = GameSettingView.New(arg_5_0, arg_5_0.viewListGo_[arg_5_1], arg_5_0.params_)
		elseif arg_5_1 == "operation" then
			local var_5_7 = Asset.Load("UI/Setting/GameOperationSettingUI")

			arg_5_0.viewListGo_[arg_5_1] = Object.Instantiate(var_5_7, arg_5_0.panelTrs_)
			arg_5_0.viewList_[arg_5_1] = GameOperationSettingView.New(arg_5_0, arg_5_0.viewListGo_[arg_5_1], arg_5_0.params_)
		elseif arg_5_1 == "affix" then
			local var_5_8 = Asset.Load("UI/Setting/AffixDescriptionUI")

			arg_5_0.viewListGo_[arg_5_1] = Object.Instantiate(var_5_8, arg_5_0.panelTrs_)

			local var_5_9 = arg_5_0.params_.stageData

			if var_5_9:GetType() == BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE then
				arg_5_0.viewList_[arg_5_1] = SoloChallengeAffixDescriptionView.New(arg_5_0, arg_5_0.viewListGo_[arg_5_1], arg_5_0.dataAffix)
			elseif var_5_9:GetType() == BattleConst.STAGE_TYPE_NEW.RACE_TRIAL then
				arg_5_0.viewList_[arg_5_1] = RaceTrialAffixDescriptionView.New(arg_5_0, arg_5_0.viewListGo_[arg_5_1], arg_5_0.dataAffix)
			else
				arg_5_0.viewList_[arg_5_1] = AffixDescriptionView.New(arg_5_0, arg_5_0.viewListGo_[arg_5_1], arg_5_0.dataAffix)
			end
		elseif arg_5_1 == "skill" then
			local var_5_10 = Asset.Load("UI/Setting/SkillSettingUI")

			arg_5_0.viewListGo_[arg_5_1] = Object.Instantiate(var_5_10, arg_5_0.panelTrs_)
			arg_5_0.viewList_[arg_5_1] = SkillDescriptionView.New(arg_5_0, arg_5_0.viewListGo_[arg_5_1], arg_5_0.params_.stageData)
		elseif arg_5_1 == "artifact" then
			local var_5_11 = Asset.Load("UI/Setting/InformationSettingUI")

			arg_5_0.viewListGo_[arg_5_1] = Object.Instantiate(var_5_11, arg_5_0.panelTrs_)

			local var_5_12 = arg_5_0.params_.stageData

			if var_5_12:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
				arg_5_0.viewList_[arg_5_1] = MatrixArtifactSettingView.New(arg_5_0.viewListGo_[arg_5_1], MatrixData:GetArtifactList())
			elseif var_5_12:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX then
				arg_5_0.viewList_[arg_5_1] = MatrixArtifactSettingView.New(arg_5_0.viewListGo_[arg_5_1], ActivityMatrixData:GetArtifactList(var_5_12:GetActivityID()))
			elseif var_5_12:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX then
				arg_5_0.viewList_[arg_5_1] = MatrixArtifactSettingView.New(arg_5_0.viewListGo_[arg_5_1], StrategyMatrixData:GetArtifactList(var_5_12:GetActivityID()))
			elseif var_5_12:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
				local var_5_13 = WarChessData:GetArtifactData()
				local var_5_14 = {}

				for iter_5_0, iter_5_1 in pairs(var_5_13) do
					table.insert(var_5_14, {
						id = iter_5_0
					})
				end

				arg_5_0.viewList_[arg_5_1] = WarChessArtifactSettingView.New(arg_5_0.viewListGo_[arg_5_1], var_5_14)
			end
		elseif arg_5_1 == "remind" then
			local var_5_15 = Asset.Load("UI/Setting/RemindSettingUI")

			arg_5_0.viewListGo_[arg_5_1] = Object.Instantiate(var_5_15, arg_5_0.panelTrs_)
			arg_5_0.viewList_[arg_5_1] = RemindSettingView.New(arg_5_0, arg_5_0.viewListGo_[arg_5_1])
		elseif arg_5_1 == "polyhedronAddition" then
			local var_5_16 = Asset.Load("Widget/System/PolyhedronBattle/PolyhedronSettingUI")

			arg_5_0.viewListGo_[arg_5_1] = Object.Instantiate(var_5_16, arg_5_0.panelTrs_)
			arg_5_0.viewList_[arg_5_1] = PolyhedronAdditionSettingView.New(arg_5_0.viewListGo_[arg_5_1])
		elseif arg_5_1 == "polyhedronTeamInfo" then
			local var_5_17 = Asset.Load("Widget/System/PolyhedronBattle/PolyhedronRanksUI")

			arg_5_0.viewListGo_[arg_5_1] = Object.Instantiate(var_5_17, arg_5_0.panelTrs_)
			arg_5_0.viewList_[arg_5_1] = PolyhedronTeamInfoSettingView.New(arg_5_0.viewListGo_[arg_5_1])
		elseif arg_5_1 == "polyhedronHeroInfo" then
			local var_5_18 = Asset.Load("Widget/System/PolyhedronBattle/PolyhedronContingentUI")

			arg_5_0.viewListGo_[arg_5_1] = Object.Instantiate(var_5_18, arg_5_0.panelTrs_)
			arg_5_0.viewList_[arg_5_1] = PolyhedronHeroInfoSettingView.New(arg_5_0.viewListGo_[arg_5_1])
		end
	end
end

function var_0_0.AddUIListener(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.typeNameS_) do
		arg_6_0:AddToggleListener(arg_6_0.toggle_[iter_6_0], function(arg_7_0)
			if arg_7_0 then
				OperationRecorder.Record(arg_6_0.class.__cname, "switch_page_" .. iter_6_0)

				if iter_6_0 == "remind" then
					saveData("setting", "newFunction", 0)
					manager.redPoint:setTip(RedPointConst.SETTING_NEW_FUNCTION, 0)
				end
			end

			SetActive(arg_6_0.toggleUnSelect_[iter_6_0], not arg_7_0)
			SetActive(arg_6_0.toggleSelect_[iter_6_0], arg_7_0)
			arg_6_0:ChangeShowView(iter_6_0, arg_7_0)
		end)
	end

	arg_6_0:AddBtnListenerScale(arg_6_0.saveBtn_, nil, function()
		for iter_8_0, iter_8_1 in pairs(arg_6_0.viewList_) do
			iter_8_1:SaveData()
		end

		ShowTips("SAVE_SYSTEM_SETTING")
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.resetBtn_, nil, function()
		arg_6_0.viewList_[arg_6_0.params_.selectType]:RecoverTmpData()
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.quitBattleBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_BATTLE"),
			OkCallback = function()
				gameContext:DestroyCurRoutes()

				if arg_6_0.params_.stageData:GetIsCooperation() then
					local var_11_0 = BattleFieldData:GetServerBattleID()

					CooperationAction.LeaveCooperationBattle(function(arg_12_0)
						BattleInstance.QuitBattle(arg_6_0.params_.stageData, true, true)
					end, var_11_0)
				else
					LuaExchangeHelper.GameOver(3)
				end
			end
		})
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.continueBtn_, nil, function()
		if arg_6_0:GetIsContinuousFight() then
			arg_6_0:Back()
		else
			gameContext:DestroyCurRoutes()
		end

		LuaExchangeHelper.ContinueGame()
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.restartBtn_, nil, function()
		manager.audio:DestoryCriAtom()
		BattleController.GetInstance():LaunchBattle(arg_6_0.params_.stageData)
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.polyhedronSettlementBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("POLYHEDRON_BATTLE_GIVE_UP_AND_SETTLE"),
			OkCallback = function()
				PolyhedronAction.QueryPolyhedronGiveUp(function(arg_17_0)
					if isSuccess(arg_17_0.result) then
						manager.audio:PlayBGM("ui_battle", "ui_battle_lose", "ui_battle.awb")
						manager.audio:PlayEffect("ui_battle", "ui_battle_ultimate_out", "")
						manager.audio:PlayEffect("ui_skip", "ui_reset", "")
						DestroyLua()
						LuaExchangeHelper.GoToMain()
						OpenPageUntilLoaded("/polyhedronBlank/polyhedronOver", {})
					else
						ShowTips(arg_17_0.result)
					end
				end)
			end
		})
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.polyhedronQuitBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_BATTLE"),
			OkCallback = function()
				manager.audio:PlayBGM("ui_battle", "ui_battle_lose", "ui_battle.awb")
				manager.audio:PlayEffect("ui_battle", "ui_battle_ultimate_out", "")
				manager.audio:PlayEffect("ui_skip", "ui_reset", "")
				DestroyLua()
				LuaExchangeHelper.GoToMain()
				OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
			end
		})
	end)
end

function var_0_0.GetIsContinuousFight(arg_20_0)
	if arg_20_0.isSystem_ or arg_20_0.params_.stageData == nil then
		return false
	end

	return arg_20_0.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON
end

function var_0_0.RefreshSettingType(arg_21_0)
	local var_21_0 = arg_21_0.params_.setType or SettingConst.SETTING_TYPE.SYSTEM
	local var_21_1 = arg_21_0.params_.stageData

	arg_21_0.isSystem_ = var_21_0 == SettingConst.SETTING_TYPE.SYSTEM

	SetActive(arg_21_0.screenGo_, arg_21_0.isSystem_)
	SetActive(arg_21_0.saveGo_, arg_21_0.isSystem_)
	SetActive(arg_21_0.resetGo_, arg_21_0.isSystem_)
	SetActive(arg_21_0.remindGo_, arg_21_0.isSystem_)
	SetActive(arg_21_0.quitBattleGo_, not arg_21_0.isSystem_ and not arg_21_0.params_.newbie and var_21_1:GetType() ~= BattleConst.STAGE_TYPE_NEW.POLYHEDRON)
	SetActive(arg_21_0.continueGo_, not arg_21_0.isSystem_)
	SetActive(arg_21_0.polyhedronSettlementGo_, not arg_21_0.isSystem_ and var_21_1 and var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON)
	SetActive(arg_21_0.polyhedronQuitGo_, not arg_21_0.isSystem_ and var_21_1 and var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON)

	if not arg_21_0.isSystem_ and var_21_1 and (var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE or var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON or var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON) then
		SetActive(arg_21_0.restartGo_, true)
	else
		SetActive(arg_21_0.restartGo_, false)
	end

	local var_21_2 = var_21_1 and not arg_21_0.isSystem_ and var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL
	local var_21_3 = var_21_1 and not arg_21_0.isSystem_ and var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON
	local var_21_4 = var_21_1 and not arg_21_0.isSystem_ and var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.STRONGHOLD

	if not arg_21_0.isSystem_ and not var_21_2 and not var_21_3 and not var_21_4 then
		arg_21_0.dataAffix = {}

		if var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.RACE_TRIAL then
			local var_21_5 = var_21_1:GetActivityID()
			local var_21_6 = RaceTrialData:GetCustomList(var_21_5)
			local var_21_7

			for iter_21_0, iter_21_1 in ipairs(var_21_6) do
				local var_21_8 = ActivityAffixPoolCfg[iter_21_1].affix

				table.insert(arg_21_0.dataAffix, {
					var_21_8[1],
					var_21_8[2]
				})
			end
		else
			arg_21_0.dataAffix = var_21_1:GetSettingShowAffix()
		end

		SetActive(arg_21_0.affixGo_, #arg_21_0.dataAffix > 0)
	else
		SetActive(arg_21_0.affixGo_, false)
	end

	if var_21_1 and not arg_21_0.isSystem_ and (var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX) then
		SetActive(arg_21_0.intelligenceGo_, true)
	else
		SetActive(arg_21_0.intelligenceGo_, false)
	end

	if arg_21_0.isSystem_ or not var_21_1 or var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.LEVIATHAN_GAME or var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.SKADI_GAME or table.keyof(GameSetting.setting_need_not_skill_info.value, var_21_1:GetStageId()) then
		SetActive(arg_21_0.skillGo_, false)
	else
		local var_21_9 = GetSceneDataForExcehange().roleDataInLua[0]

		if var_21_9 then
			local var_21_10 = SkinCfg[var_21_9.ID] and SkinCfg[var_21_9.ID].hero

			if HeroCfg[var_21_10] and HeroCfg[var_21_10].hide_info ~= 0 then
				SetActive(arg_21_0.skillGo_, false)
			else
				SetActive(arg_21_0.skillGo_, true)
			end
		else
			SetActive(arg_21_0.skillGo_, false)
		end
	end

	if var_21_1 and not arg_21_0.isSystem_ and var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.ARTIFACT then
		SetActive(arg_21_0.affixGo_, false)
	end

	if var_21_1 and not arg_21_0.isSystem_ and var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL then
		SetActive(arg_21_0.affixGo_, false)
	end

	if not arg_21_0.isSystem_ then
		if var_21_1 and (var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX or var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS) then
			SetActive(arg_21_0.artifactGo_, true)
			SetActive(arg_21_0.affixGo_, false)
		else
			SetActive(arg_21_0.artifactGo_, false)
		end
	else
		SetActive(arg_21_0.artifactGo_, false)
	end

	if var_21_1 and var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON then
		SetActive(arg_21_0.polyhedronAdditionGo_, true)
		SetActive(arg_21_0.polyhedronTeamInfoGo_, true)
		SetActive(arg_21_0.polyhedronHeroInfoGo_, true)
	else
		SetActive(arg_21_0.polyhedronAdditionGo_, false)
		SetActive(arg_21_0.polyhedronTeamInfoGo_, false)
		SetActive(arg_21_0.polyhedronHeroInfoGo_, false)
	end

	if var_21_0 == SettingConst.SETTING_TYPE.SYSTEM then
		arg_21_0.toggle_.screen.isOn = true

		arg_21_0:ChangeShowView("screen", true)

		arg_21_0.params_.selectType = "screen"
	elseif var_21_0 == SettingConst.SETTING_TYPE.BATTLE_MAIN or var_21_1 and (var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX) then
		arg_21_0.toggle_.intelligence.isOn = true
		arg_21_0.params_.selectType = "intelligence"
	elseif var_21_1 and var_21_1:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON then
		arg_21_0.toggle_.polyhedronAddition.isOn = true

		arg_21_0:ChangeShowView("polyhedronAddition", true)

		arg_21_0.params_.selectType = "polyhedronAddition"
	else
		arg_21_0.toggle_.sound.isOn = true
		arg_21_0.params_.selectType = "sound"
	end

	arg_21_0:RefreshQuitType()
end

function var_0_0.RefreshQuitType(arg_22_0)
	if arg_22_0.isSystem_ then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			NAVI_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			arg_22_0:BackFunc(function()
				arg_22_0:Back()
			end)
		end)
		manager.windowBar:RegistHomeCallBack(function()
			arg_22_0:BackFunc(function()
				arg_22_0:Go("/home")
			end)
		end)
	end
end

function var_0_0.BackFunc(arg_27_0, arg_27_1)
	local var_27_0 = false

	for iter_27_0, iter_27_1 in pairs(arg_27_0.viewList_) do
		if iter_27_1:CheckDataChange() then
			var_27_0 = true
		end
	end

	if var_27_0 then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("TIP_SETTING_CHANGE"),
			OkCallback = function()
				for iter_28_0, iter_28_1 in pairs(arg_27_0.viewList_) do
					iter_28_1:SaveData()
				end

				OperationRecorder.Record(arg_27_0.class.__cname, "panel/btn_save")
				arg_27_1()
			end,
			CancelCallback = function()
				for iter_29_0, iter_29_1 in pairs(arg_27_0.viewList_) do
					iter_29_1:RecoverTmpData()
				end

				OperationRecorder.Record(arg_27_0.class.__cname, "cancel")
				arg_27_1()
			end
		})
	else
		arg_27_1()
	end
end

function var_0_0.Init(arg_30_0)
	arg_30_0:InitUI()
	arg_30_0:AddUIListener()
end

function var_0_0.OnPicSettingChange(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_0.viewList_.screen then
		arg_31_0.viewList_.screen:OnPicSettingChange(arg_31_1, arg_31_2)
	end
end

function var_0_0.OnSoundSettingChange(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_0.viewList_.sound then
		arg_32_0.viewList_.sound:OnSoundSettingChange(arg_32_1, arg_32_2)
	end

	if arg_32_0.viewList_.game then
		arg_32_0.viewList_.game:OnSoundSettingChange(arg_32_1, arg_32_2)
	end
end

function var_0_0.OnPushSettingChange(arg_33_0, arg_33_1, arg_33_2)
	return
end

function var_0_0.OnGameSettingChange(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_0.viewList_.game then
		arg_34_0.viewList_.game:OnGameSettingChange(arg_34_1, arg_34_2)
	end
end

function var_0_0.OnDownloaded(arg_35_0, arg_35_1)
	if arg_35_0.viewList_.sound then
		arg_35_0.viewList_.sound:OnDownloaded(arg_35_1)
	end
end

function var_0_0.OnCancalDownload(arg_36_0)
	if arg_36_0.viewList_.sound then
		arg_36_0.viewList_.sound:OnCancalDownload()
	end
end

function var_0_0.OnLanguagePackageDeleted(arg_37_0)
	if arg_37_0.viewList_.sound then
		arg_37_0.viewList_.sound:OnLanguagePackageDeleted()
	end
end

function var_0_0.OnRemindChange(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_0.viewList_.remind then
		arg_38_0.viewList_.remind:OnRemindChange(arg_38_1, arg_38_2)
	end
end

function var_0_0.OnCooperationRestrictUpdate(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_0.viewList_.remind then
		arg_39_0.viewList_.remind:OnCooperationRestrictUpdate()
	end
end

function var_0_0.OnPolyhedronSwitchHero(arg_40_0)
	if arg_40_0.viewList_.polyhedronTeamInfo then
		arg_40_0.viewList_.polyhedronTeamInfo:OnPolyhedronSwitchHero()
	end
end

function var_0_0.OnEnter(arg_41_0)
	for iter_41_0, iter_41_1 in pairs(arg_41_0.viewList_) do
		if iter_41_0 == "intelligence" then
			local var_41_0 = arg_41_0.params_.stageData

			if var_41_0 and var_41_0:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
				-- block empty
			elseif var_41_0 and var_41_0:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX then
				-- block empty
			elseif var_41_0 and var_41_0:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX then
				-- block empty
			else
				iter_41_1:RefreshData(nil, arg_41_0.params_)
			end
		else
			iter_41_1:OnEnter()
		end
	end

	arg_41_0:RefreshSettingType()
	arg_41_0:BindRedPointUI()
end

function var_0_0.BindRedPointUI(arg_42_0)
	manager.redPoint:bindUIandKey(arg_42_0.toggle_.remind.transform, RedPointConst.SETTING_REMIND)
	manager.redPoint:bindUIandKey(arg_42_0.toggle_.screen.transform, RedPointConst.SETTING_SCREEN)
end

function var_0_0.UnBindRedPointUI(arg_43_0)
	manager.redPoint:unbindUIandKey(arg_43_0.toggle_.remind.transform, RedPointConst.SETTING_REMIND)
	manager.redPoint:unbindUIandKey(arg_43_0.toggle_.screen.transform, RedPointConst.SETTING_SCREEN)
end

function var_0_0.OnExit(arg_44_0)
	arg_44_0:UnBindRedPointUI()

	for iter_44_0, iter_44_1 in pairs(arg_44_0.viewList_) do
		iter_44_1:OnExit()
	end

	if arg_44_0.isSystem_ then
		manager.windowBar:HideBar()
	else
		LuaExchangeHelper.ApplyBattleSetting()
	end

	arg_44_0.isSystem_ = nil

	arg_44_0:RecordStay(arg_44_0.params_.selectType)
end

function var_0_0.Dispose(arg_45_0)
	for iter_45_0, iter_45_1 in pairs(arg_45_0.viewList_) do
		iter_45_1:Dispose()
	end

	arg_45_0.params_ = nil

	var_0_0.super.Dispose(arg_45_0)
end

function var_0_0.RecordStay(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0:GetStayTime()

	if var_46_0 == 0 then
		return
	end

	local var_46_1 = 0

	if arg_46_1 == "screen" then
		local var_46_2 = 10201

		OperationRecorder.RecordStayView("STAY_VIEW_SETTING", var_46_0, var_46_2)
	elseif arg_46_1 == "sound" then
		local var_46_3 = 10202

		OperationRecorder.RecordStayView("STAY_VIEW_SETTING", var_46_0, var_46_3)
	elseif arg_46_1 == "game" then
		local var_46_4 = 10203

		OperationRecorder.RecordStayView("STAY_VIEW_SETTING", var_46_0, var_46_4)
	elseif arg_46_1 == "skill" then
		local var_46_5 = arg_46_0.viewList_.skill and arg_46_0.viewList_.skill.nType or 1

		arg_46_0:RecordStaySkill(var_46_5)
	end

	arg_46_0:UpdateLastOpenTime()
end

function var_0_0.RecordStaySkill(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0:GetStayTime()

	if var_47_0 == 0 then
		return
	end

	local var_47_1 = 0

	if arg_47_1 == 1 then
		var_47_1 = 50201
	elseif arg_47_1 == 2 then
		var_47_1 = 50202
	end

	OperationRecorder.RecordStayView("STAY_VIEW_SETTING_SKILL", var_47_0, var_47_1)
	arg_47_0:UpdateLastOpenTime()
end

function var_0_0.OnExitInput(arg_48_0)
	if not arg_48_0.isSystem_ then
		gameContext:DestroyCurRoutes()
		LuaExchangeHelper.ContinueGame()

		return true
	end
end

return var_0_0
