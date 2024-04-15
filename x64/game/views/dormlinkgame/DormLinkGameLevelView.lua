slot0 = class("DormLinkGameLevelView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng2ndUI/XH2ndLinkGameUI/XH2ndLGStageUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.topPointController = ControllerUtil.GetController(slot0.numbgGo_.transform, "topScore")
	slot4 = "mode"
	slot0.challengeController = ControllerUtil.GetController(slot0.selectmodeGo_.transform, slot4)
	slot0.stageController = {}

	for slot4 = 1, DormLinkGameConst.LevelMax do
		slot0.stageController[slot4] = ControllerUtil.GetController(slot0["stage" .. slot4 .. "Tgl_"].transform, "stage")
	end

	slot0.easyController = ControllerUtil.GetController(slot0.eazyGo_.transform, "score")
	slot0.hardController = ControllerUtil.GetController(slot0.normalhardGo_.transform, "score")
	slot0.difficultController = ControllerUtil.GetController(slot0.mode1Go_.transform, "selectMode")
	slot0.specialController = ControllerUtil.GetController(slot0.hardGo_.transform, "score")
	slot0.textController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, DormLinkGameConst.LevelMax do
		slot0:AddToggleListener(slot0["stage" .. slot4 .. "Tgl_"], function (slot0)
			if slot0 and uv0 ~= uv1.selIndex then
				uv1:SelLevel(uv0)
			end
		end)
	end

	slot0:AddBtnListenerScale(slot0.receiveBtn_, nil, function ()
		JumpTools.OpenPageByJump("dormLinkGameActivityView")
	end)
	slot0:AddBtnListenerScale(slot0.startBtn_, nil, function ()
		if uv0.selIndex and uv0.difficulty then
			slot1, slot2, slot3 = DormLinkGameTools:ChecklevelUnLock(DormLinkGameData:GetLevelInfoByIndexAndDiff(uv0.selIndex, uv0.difficulty))

			if slot1 then
				DormLinkGameData:CheckToEnterDormLinkScene(slot0)
				manager.audio:PlayBGM("ui_battle", "ui_battle_stopbgm", "ui_battle.awb")
			elseif slot2 == DormLinkGameConst.LevelLockType.preLevel then
				ShowTips(string.format(GetTips("ACTIVITY_LINKGAME_PRE_LIMIT"), ActivityLinkGameCfg[ActivityLinkGameCfg.get_id_list_by_activity_id[slot3][1]].name))
			elseif slot2 == DormLinkGameConst.LevelLockType.time then
				if ActivityData:GetActivityData(ActivityLinkGameCfg[slot0].activity_id) then
					ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot5.startTime)))
				end
			elseif slot2 == DormLinkGameConst.LevelLockType.stop then
				ShowTips("TIME_OVER")
			end
		end
	end)
	slot0:AddBtnListenerScale(slot0.eazyBtn_, nil, function ()
		uv0:ChoseDifficult(1)
	end)
	slot0:AddBtnListenerScale(slot0.hardBtn_, nil, function ()
		uv0:ChoseDifficult(2)
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.activityID_ = DormLinkGameData:GetMainActivityID()
	slot2 = nil
	slot0.selIndex, slot4 = DormLinkGameData:GetIndexAndDiffByLevelInfo(DormLinkGameData:GetCurLevelID() or DormLinkGameData:GetSaveLevelID() or 1)
	slot0["stage" .. slot0.selIndex .. "Tgl_"].isOn = true

	slot0:SelLevel(slot0.selIndex)
	slot0:ChoseDifficult(slot4)
	slot0:RefreshView()
	manager.redPoint:bindUIandKey(slot0.receiveBtn_.transform, RedPointConst.ACTIVITY_2_1_LINKGAME_LEVEL_REWARD)
end

function slot0.ChoseDifficult(slot0, slot1)
	slot0.difficulty = slot1

	if slot1 == 1 then
		slot0.difficultController:SetSelectedState("eazy")
	elseif slot1 == 2 then
		slot0.difficultController:SetSelectedState("hard")
	end
end

function slot0.RefreshView(slot0)
	slot0:RefreshAllLevelTopPoint()
	slot0:UpdataLastTime()
	slot0:UpdataLevelState()
end

function slot0.RefreshAllLevelTopPoint(slot0)
	if DormLinkGameData:GetAllLevelTopPoint() > 0 then
		slot0.topPointController:SetSelectedState("have")

		slot0.topNum.text = slot1
	else
		slot0.topPointController:SetSelectedState("nun")
	end
end

function slot0.SelLevel(slot0, slot1)
	slot2 = slot1 * 2 - 1
	slot0.selIndex = slot1
	slot3, slot4, slot5 = DormLinkGameTools:ChecklevelUnLock(slot2)

	if ActivityLinkGameCfg[slot2].difficult == 1 then
		slot0.challengeController:SetSelectedState("mode1")
		slot0:ChoseDifficult(1)
	else
		slot0:ChoseDifficult(ActivityLinkGameCfg[slot2].difficult)
		slot0.challengeController:SetSelectedState("mode2")

		slot0.massage1Text_.text = GetTips("ACTIVITY_LINKGAME_CHALLENGE_1")
		slot0.massage2Text_.text = GetTips("ACTIVITY_LINKGAME_CHALLENGE_2")
	end

	slot0:RefreshScore()

	slot0.talklabelText_.text = ""

	if not slot3 then
		slot0.easyController:SetSelectedState("non")
		slot0.hardController:SetSelectedState("non")
		slot0.textController:SetSelectedState("false")

		if slot4 == DormLinkGameConst.LevelLockType.preLevel then
			ShowTips(string.format(GetTips("ACTIVITY_LINKGAME_PRE_LIMIT"), ActivityLinkGameCfg[ActivityLinkGameCfg.get_id_list_by_activity_id[slot5][1]].name))
		elseif slot4 == DormLinkGameConst.LevelLockType.time then
			if ActivityData:GetActivityData(ActivityLinkGameCfg[slot2].activity_id) then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot7.startTime)))
			end
		elseif slot4 == DormLinkGameConst.LevelLockType.stop then
			ShowTips("TIME_OVER")
		end

		return
	end

	slot0.textController:SetSelectedState("true")

	slot0.talklabelText_.text = ActivityLinkGameCfg[slot2].linkgame_des
end

function slot0.RefreshSingleLevelState(slot0, slot1)
	slot2 = (slot1 + 1) / 2

	if DormLinkGameTools:ChecklevelUnLock(slot1) then
		slot0["text" .. slot2 .. "Text_"].text = ActivityLinkGameCfg[slot1].name

		if DormLinkGameData:CheckLevelIsClear(slot2) then
			slot0.stageController[slot2]:SetSelectedState("clear")
		else
			slot0.stageController[slot2]:SetSelectedState("normal")
		end
	else
		slot0.stageController[slot2]:SetSelectedState("lock")
	end
end

function slot0.RefreshScore(slot0)
	if slot0.selIndex then
		slot1 = slot0.selIndex * 2 - 1

		if ActivityLinkGameCfg[slot0.selIndex * 2 - 1].difficult == 1 then
			slot3 = DormLinkGameData:GetLevelScore(slot1 + 1)

			if DormLinkGameData:GetLevelScore(slot1) and slot2 > 0 then
				slot0.easyController:SetSelectedState("have")

				slot0.easyScore.text = string.format(GetTips("ACTIVITY_LINKGAME_SCORE_RECORDER"), slot2)
			else
				slot0.easyController:SetSelectedState("non")
			end

			if slot3 and slot3 > 0 then
				slot0.hardController:SetSelectedState("have")

				slot0.hardScore.text = string.format(GetTips("ACTIVITY_LINKGAME_SCORE_RECORDER"), slot3)
			else
				slot0.hardController:SetSelectedState("non")
			end
		elseif DormLinkGameData:GetLevelScore(slot1) and slot2 > 0 then
			slot0.specialController:SetSelectedState("have")

			slot0.score2Text_.text = string.format(GetTips("ACTIVITY_LINKGAME_SCORE_RECORDER"), slot2)
		else
			slot0.specialController:SetSelectedState("non")
		end
	end
end

function slot0.UpdataLastTime(slot0)
	slot1 = ActivityData:GetActivityData(slot0.activityID_)
	slot3 = slot1.stopTime

	if manager.time:GetServerTime() < slot1.startTime then
		slot0.lastTime.text = GetTips("SOLO_NOT_OPEN")
	elseif slot4 < slot3 then
		slot0.lastTime.text = manager.time:GetLostTimeStr2(slot3)
	else
		slot0.lastTime.text = GetTips("TIME_OVER")
	end
end

function slot0.UpdataLevelState(slot0)
	if DormLinkGameData:GetLevelInfoList() then
		for slot5, slot6 in pairs(slot1) do
			if slot5 % 2 == 1 then
				slot0:RefreshSingleLevelState(slot5)
			end
		end
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(slot0.receiveBtn_.transform, RedPointConst.ACTIVITY_2_1_LINKGAME_LEVEL_REWARD)
end

function slot0.Dispose(slot0)
	if slot0.countTimer then
		slot0.countTimer:Stop()

		slot0.countTimer = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
