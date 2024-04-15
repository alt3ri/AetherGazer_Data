local var_0_0 = class("DormLinkGameLevelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng2ndUI/XH2ndLinkGameUI/XH2ndLGStageUI"
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
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.topPointController = ControllerUtil.GetController(arg_5_0.numbgGo_.transform, "topScore")
	arg_5_0.challengeController = ControllerUtil.GetController(arg_5_0.selectmodeGo_.transform, "mode")
	arg_5_0.stageController = {}

	for iter_5_0 = 1, DormLinkGameConst.LevelMax do
		arg_5_0.stageController[iter_5_0] = ControllerUtil.GetController(arg_5_0["stage" .. iter_5_0 .. "Tgl_"].transform, "stage")
	end

	arg_5_0.easyController = ControllerUtil.GetController(arg_5_0.eazyGo_.transform, "score")
	arg_5_0.hardController = ControllerUtil.GetController(arg_5_0.normalhardGo_.transform, "score")
	arg_5_0.difficultController = ControllerUtil.GetController(arg_5_0.mode1Go_.transform, "selectMode")
	arg_5_0.specialController = ControllerUtil.GetController(arg_5_0.hardGo_.transform, "score")
	arg_5_0.textController = ControllerUtil.GetController(arg_5_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_6_0)
	for iter_6_0 = 1, DormLinkGameConst.LevelMax do
		arg_6_0:AddToggleListener(arg_6_0["stage" .. iter_6_0 .. "Tgl_"], function(arg_7_0)
			if arg_7_0 and iter_6_0 ~= arg_6_0.selIndex then
				arg_6_0:SelLevel(iter_6_0)
			end
		end)
	end

	arg_6_0:AddBtnListenerScale(arg_6_0.receiveBtn_, nil, function()
		JumpTools.OpenPageByJump("dormLinkGameActivityView")
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.startBtn_, nil, function()
		if arg_6_0.selIndex and arg_6_0.difficulty then
			local var_9_0 = DormLinkGameData:GetLevelInfoByIndexAndDiff(arg_6_0.selIndex, arg_6_0.difficulty)
			local var_9_1, var_9_2, var_9_3 = DormLinkGameTools:ChecklevelUnLock(var_9_0)

			if var_9_1 then
				DormLinkGameData:CheckToEnterDormLinkScene(var_9_0)
				manager.audio:PlayBGM("ui_battle", "ui_battle_stopbgm", "ui_battle.awb")
			elseif var_9_2 == DormLinkGameConst.LevelLockType.preLevel then
				local var_9_4 = ActivityLinkGameCfg.get_id_list_by_activity_id[var_9_3][1]
				local var_9_5 = ActivityLinkGameCfg[var_9_4].name

				ShowTips(string.format(GetTips("ACTIVITY_LINKGAME_PRE_LIMIT"), var_9_5))
			elseif var_9_2 == DormLinkGameConst.LevelLockType.time then
				local var_9_6 = ActivityLinkGameCfg[var_9_0].activity_id
				local var_9_7 = ActivityData:GetActivityData(var_9_6)
				local var_9_8 = GetTips("OPEN_TIME")

				if var_9_7 then
					ShowTips(string.format(var_9_8, manager.time:GetLostTimeStr(var_9_7.startTime)))
				end
			elseif var_9_2 == DormLinkGameConst.LevelLockType.stop then
				ShowTips("TIME_OVER")
			end
		end
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.eazyBtn_, nil, function()
		arg_6_0:ChoseDifficult(1)
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.hardBtn_, nil, function()
		arg_6_0:ChoseDifficult(2)
	end)
end

function var_0_0.OnEnter(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_12_0.activityID_ = DormLinkGameData:GetMainActivityID()

	local var_12_0 = DormLinkGameData:GetCurLevelID() or DormLinkGameData:GetSaveLevelID() or 1
	local var_12_1
	local var_12_2

	arg_12_0.selIndex, var_12_2 = DormLinkGameData:GetIndexAndDiffByLevelInfo(var_12_0)
	arg_12_0["stage" .. arg_12_0.selIndex .. "Tgl_"].isOn = true

	arg_12_0:SelLevel(arg_12_0.selIndex)
	arg_12_0:ChoseDifficult(var_12_2)
	arg_12_0:RefreshView()
	manager.redPoint:bindUIandKey(arg_12_0.receiveBtn_.transform, RedPointConst.ACTIVITY_2_1_LINKGAME_LEVEL_REWARD)
end

function var_0_0.ChoseDifficult(arg_13_0, arg_13_1)
	arg_13_0.difficulty = arg_13_1

	if arg_13_1 == 1 then
		arg_13_0.difficultController:SetSelectedState("eazy")
	elseif arg_13_1 == 2 then
		arg_13_0.difficultController:SetSelectedState("hard")
	end
end

function var_0_0.RefreshView(arg_14_0)
	arg_14_0:RefreshAllLevelTopPoint()
	arg_14_0:UpdataLastTime()
	arg_14_0:UpdataLevelState()
end

function var_0_0.RefreshAllLevelTopPoint(arg_15_0)
	local var_15_0 = DormLinkGameData:GetAllLevelTopPoint()

	if var_15_0 > 0 then
		arg_15_0.topPointController:SetSelectedState("have")

		arg_15_0.topNum.text = var_15_0
	else
		arg_15_0.topPointController:SetSelectedState("nun")
	end
end

function var_0_0.SelLevel(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1 * 2 - 1

	arg_16_0.selIndex = arg_16_1

	local var_16_1, var_16_2, var_16_3 = DormLinkGameTools:ChecklevelUnLock(var_16_0)

	if ActivityLinkGameCfg[var_16_0].difficult == 1 then
		arg_16_0.challengeController:SetSelectedState("mode1")
		arg_16_0:ChoseDifficult(1)
	else
		local var_16_4 = ActivityLinkGameCfg[var_16_0].difficult

		arg_16_0:ChoseDifficult(var_16_4)
		arg_16_0.challengeController:SetSelectedState("mode2")

		arg_16_0.massage1Text_.text = GetTips("ACTIVITY_LINKGAME_CHALLENGE_1")
		arg_16_0.massage2Text_.text = GetTips("ACTIVITY_LINKGAME_CHALLENGE_2")
	end

	arg_16_0:RefreshScore()

	arg_16_0.talklabelText_.text = ""

	if not var_16_1 then
		arg_16_0.easyController:SetSelectedState("non")
		arg_16_0.hardController:SetSelectedState("non")
		arg_16_0.textController:SetSelectedState("false")

		if var_16_2 == DormLinkGameConst.LevelLockType.preLevel then
			local var_16_5 = ActivityLinkGameCfg.get_id_list_by_activity_id[var_16_3][1]
			local var_16_6 = ActivityLinkGameCfg[var_16_5].name

			ShowTips(string.format(GetTips("ACTIVITY_LINKGAME_PRE_LIMIT"), var_16_6))
		elseif var_16_2 == DormLinkGameConst.LevelLockType.time then
			local var_16_7 = ActivityLinkGameCfg[var_16_0].activity_id
			local var_16_8 = ActivityData:GetActivityData(var_16_7)
			local var_16_9 = GetTips("OPEN_TIME")

			if var_16_8 then
				ShowTips(string.format(var_16_9, manager.time:GetLostTimeStr(var_16_8.startTime)))
			end
		elseif var_16_2 == DormLinkGameConst.LevelLockType.stop then
			ShowTips("TIME_OVER")
		end

		return
	end

	arg_16_0.textController:SetSelectedState("true")

	arg_16_0.talklabelText_.text = ActivityLinkGameCfg[var_16_0].linkgame_des
end

function var_0_0.RefreshSingleLevelState(arg_17_0, arg_17_1)
	local var_17_0 = (arg_17_1 + 1) / 2

	if DormLinkGameTools:ChecklevelUnLock(arg_17_1) then
		arg_17_0["text" .. var_17_0 .. "Text_"].text = ActivityLinkGameCfg[arg_17_1].name

		if DormLinkGameData:CheckLevelIsClear(var_17_0) then
			arg_17_0.stageController[var_17_0]:SetSelectedState("clear")
		else
			arg_17_0.stageController[var_17_0]:SetSelectedState("normal")
		end
	else
		arg_17_0.stageController[var_17_0]:SetSelectedState("lock")
	end
end

function var_0_0.RefreshScore(arg_18_0)
	if arg_18_0.selIndex then
		local var_18_0 = arg_18_0.selIndex * 2 - 1

		if ActivityLinkGameCfg[arg_18_0.selIndex * 2 - 1].difficult == 1 then
			local var_18_1 = DormLinkGameData:GetLevelScore(var_18_0)
			local var_18_2 = DormLinkGameData:GetLevelScore(var_18_0 + 1)

			if var_18_1 and var_18_1 > 0 then
				arg_18_0.easyController:SetSelectedState("have")

				arg_18_0.easyScore.text = string.format(GetTips("ACTIVITY_LINKGAME_SCORE_RECORDER"), var_18_1)
			else
				arg_18_0.easyController:SetSelectedState("non")
			end

			if var_18_2 and var_18_2 > 0 then
				arg_18_0.hardController:SetSelectedState("have")

				arg_18_0.hardScore.text = string.format(GetTips("ACTIVITY_LINKGAME_SCORE_RECORDER"), var_18_2)
			else
				arg_18_0.hardController:SetSelectedState("non")
			end
		else
			local var_18_3 = DormLinkGameData:GetLevelScore(var_18_0)

			if var_18_3 and var_18_3 > 0 then
				arg_18_0.specialController:SetSelectedState("have")

				arg_18_0.score2Text_.text = string.format(GetTips("ACTIVITY_LINKGAME_SCORE_RECORDER"), var_18_3)
			else
				arg_18_0.specialController:SetSelectedState("non")
			end
		end
	end
end

function var_0_0.UpdataLastTime(arg_19_0)
	local var_19_0 = ActivityData:GetActivityData(arg_19_0.activityID_)
	local var_19_1 = var_19_0.startTime
	local var_19_2 = var_19_0.stopTime
	local var_19_3 = manager.time:GetServerTime()

	if var_19_3 < var_19_1 then
		arg_19_0.lastTime.text = GetTips("SOLO_NOT_OPEN")
	elseif var_19_3 < var_19_2 then
		arg_19_0.lastTime.text = manager.time:GetLostTimeStr2(var_19_2)
	else
		arg_19_0.lastTime.text = GetTips("TIME_OVER")
	end
end

function var_0_0.UpdataLevelState(arg_20_0)
	local var_20_0 = DormLinkGameData:GetLevelInfoList()

	if var_20_0 then
		for iter_20_0, iter_20_1 in pairs(var_20_0) do
			if iter_20_0 % 2 == 1 then
				arg_20_0:RefreshSingleLevelState(iter_20_0)
			end
		end
	end
end

function var_0_0.OnExit(arg_21_0)
	manager.windowBar:HideBar()
	arg_21_0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(arg_21_0.receiveBtn_.transform, RedPointConst.ACTIVITY_2_1_LINKGAME_LEVEL_REWARD)
end

function var_0_0.Dispose(arg_22_0)
	if arg_22_0.countTimer then
		arg_22_0.countTimer:Stop()

		arg_22_0.countTimer = nil
	end

	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
