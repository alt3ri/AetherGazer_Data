slot0 = class("XH3rdWaterSingleRoomProxy", BaseRoomProxy)

function slot0.CreateTemplate(slot0, slot1)
	return BattleActivityWaterTemplate.New(slot0.stageId_, slot0.activityId_)
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

function slot0.OnBattleQuit(slot0, slot1, slot2, slot3)
	OpenPageUntilLoaded("/cooperationBlank/xH3rdWaterSelectAssistant", {
		activityId = slot1:GetMainActivityId()
	})
end

return slot0
