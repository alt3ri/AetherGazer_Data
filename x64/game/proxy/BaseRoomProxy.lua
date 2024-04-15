TeamInfo = class("TeamInfo")

function TeamInfo.Ctor(slot0)
	slot0.HeroList = {
		0,
		0,
		0
	}
	slot0.TrialHeroList = {
		0,
		0,
		0
	}
	slot0.LockStateList = {
		false,
		false,
		false
	}
	slot0.LockHeroList = {}
	slot0.ComboSkillId = 0
	slot0.MimirInfo = {
		ChipMgrId = 0,
		Chip = {}
	}
	slot0.ContId = 0
	slot0.TeamId = 0
	slot0.IsInvalid = false
end

slot0 = class("BaseRoomProxy")

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4)
	slot0.stageId_ = slot1
	slot0.stageType_ = slot2
	slot0.activityId_ = slot3
	slot0.data_ = slot4
end

function slot0.GetTemplate(slot0, slot1)
	if slot0.template_ == nil then
		slot0.template_ = slot0:CreateTemplate(slot1)
	end

	return slot0.template_
end

function slot0.GetHeroTeam(slot0)
	slot5.HeroList, slot5.LockStateList, slot5.LockHeroList, slot5.TrialHeroList = GetLocalHeroTeam(slot0.stageType_, slot0.stageId_, slot0.activityId_)

	return TeamInfo.New()
end

function slot0.SetHeroTeam(slot0, slot1)
	SetHeroTeam(slot0.stageType_, slot0.stageId_, slot0.activityId_, slot1.HeroList, slot1.TrialHeroList, slot1.ComboSkillId, slot1.MimirInfo, slot1.ContId, slot1.TeamId)
end

function slot0.CreateBattleCallback(slot0, slot1, slot2, slot3, slot4)
	if isSuccess(slot1) then
		return slot0:CreateBattleSuccessCallback(slot1, slot2, slot3, slot4)
	else
		return slot0:CreateBattleFailedCallback(slot1, slot2, slot3, slot4)
	end
end

function slot0.CreateBattleSuccessCallback(slot0, slot1, slot2, slot3, slot4)
	return function ()
		slot1, slot2 = GetResultReward()

		manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.WIN, function ()
			JumpTools.OpenPageByJump("/newSettlement", {
				result = uv0,
				rewardList = uv1,
				stageData = uv2,
				starMissionData = uv3,
				battleResult = uv4
			})
			manager.story:RemovePlayer()
			EndBattleLogic(uv0)
		end)
	end
end

function slot0.CreateBattleFailedCallback(slot0, slot1, slot2, slot3, slot4)
	return function ()
		manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.LOSE, function ()
			JumpTools.OpenPageByJump("/battlefailed", {
				stageData = uv0,
				starMissionData = uv1,
				battleResult = uv2,
				isHalfWay_ = uv3.tempData.isHalfWay_
			})
			manager.story:RemovePlayer()
			EndBattleLogic(uv4)
		end)
	end
end

function slot0.CreateTemplate(slot0, slot1)
	return nil
end

function slot0.OnBattleStart(slot0)
end

function slot0.OnBattleResult(slot0, slot1, slot2, slot3)
end

function slot0.OnBattleQuit(slot0, slot1, slot2, slot3)
end

function slot0.Dispose(slot0)
end

return slot0
