ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("RoguelikeMainView_2_6", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRoguelikeUI/JapanRoguelikeMainUI"
end

function slot0.Init(slot0)
	slot0.gameObject_:InjectUI(slot0)
	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.BtnReward, nil, handler(slot0, slot0.OnBtnRewardClick))
	slot0:AddBtnListener(slot0.BtnDifficult, nil, handler(slot0, slot0.OnBtnDifficultClick))
	slot0:AddBtnListener(slot0.BtnNormal, nil, handler(slot0, slot0.OnBtnNormalClick))
	slot0:AddBtnListener(slot0.BtnInfo, nil, handler(slot0, slot0.OnBtnInfoClick))
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6))
	manager.redPoint:bindUIandKey(slot0.BtnDifficult.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_6))
	StrategyMatrixAction.SetStrategyRead(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6)
	slot0.LockTag:SetActive(not StrategyMatrixData:GetIsClearance(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6))
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6))
	manager.redPoint:unbindUIandKey(slot0.BtnDifficult.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_6))
end

function slot0.OnBtnRewardClick(slot0)
	OperationRecorder.RecordButtonTouch("activity_polyhedron_izanami_reward1")
	JumpTools.OpenPageByJump("strategyMatrixRward", {
		task_activity_id = ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6
	})
end

function slot0.OnBtnNormalClick(slot0)
	OperationRecorder.RecordButtonTouch("activity_polyhedron_izanami_easy")
	ActivityTools.JumpToSubmodulePage(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6)
end

function slot0.OnBtnInfoClick(slot0)
	JumpTools.OpenPageByJump("gameHelp", {
		key = "ACTIVITY_ROGUELIKE_DESCRIBE",
		content = GetTips(StrategyMatrixTools.GetGameTipKey(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_6))
	})
end

function slot0.OnBtnDifficultClick(slot0)
	OperationRecorder.RecordButtonTouch("activity_polyhedron_izanami_hard")

	if not ActivityTools.GetActivityIsOpenWithTip(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_6, true) then
		return
	end

	if not StrategyMatrixData:GetIsClearance(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6) then
		ShowTips("THOR_STRATEGY_UNLOCK")

		return
	end

	slot2 = StrategyMatrixData:GetGameState(slot1)

	if not StrategyMatrixData:GetRead(slot1) then
		StrategyMatrixAction.SetStrategyRead(slot1)
	end

	if slot2 == MatrixConst.STATE_TYPE.NOTSTARTED or slot2 == MatrixConst.STATE_TYPE.FAIL then
		JumpTools.OpenPageByJump("/matrixBlank/roguelikeAffix", {
			activity_id = slot1
		})
	else
		ActivityTools.JumpToSubmodulePage(slot1)
	end
end

return slot0
