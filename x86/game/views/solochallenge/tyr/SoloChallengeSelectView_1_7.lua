slot1 = class("SoloChallengeSelectView_1_7", import("game.views.soloChallenge.Factory.FactorySoloChallengeSelectView"))

function slot1.UIName(slot0)
	return "UI/VersionUI/DarkFlameUI/DFSoloChallengeUI/DFSoloChallengeConfigUI"
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.activityID_ = slot0.params_.activityID
	slot0.difficultyIndex_ = slot0.params_.difficultyIndex
	slot0.stageList_ = ActivitySoloChallengeCfg[slot0.activityID_].stage_id[slot0.difficultyIndex_][2]

	slot0:SetDefaultCustom()
end

function slot1.SetDefaultCustom(slot0)
end

function slot1.OnResetData(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		SoloChallengeData:ResetLockData(slot2)
		JumpTools.OpenPageByJump("/soloChallengeMainView_1_7", {
			activityID = ActivitySoloChallengeCfg[slot0.activityID_].main_activity_id
		})
	else
		ShowTips(slot1.result)
	end
end

function slot1.OnGoBack(slot0)
	JumpTools.OpenPageByJump("/soloChallengeMainView_1_7", {
		activityID = ActivitySoloChallengeCfg[slot0.activityID_].main_activity_id
	})
end

return slot1
