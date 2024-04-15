slot1, slot2, slot3, slot4 = nil

return {
	LoadScene = function (slot0)
		uv0 = false
		uv1 = slot0

		if SceneManager.GetSceneByName("X222") and slot1.isLoaded == true then
			uv0 = true

			if uv1 then
				uv1()

				uv1 = nil
			end

			return
		end

		if uv2 then
			return
		end

		uv2 = Asset.LoadLevelAsync("Levels/X222", true)

		if uv3 then
			uv3:Stop()

			uv3 = nil
		end

		uv3 = FrameTimer.New(uv4.Process, 1, -1)

		uv3:Start()
	end,
	Process = function ()
		if uv0:IsDone() then
			if uv1 then
				uv1()

				uv1 = nil
			end

			uv0 = nil
			uv2 = true

			if uv3 then
				uv3:Stop()

				uv3 = nil
			end
		end
	end,
	UnLoadScene = function ()
		if uv0 or not uv1 then
			return
		end

		uv0 = nil

		if SceneManager.GetSceneByName("X222") and slot0.isLoaded == true then
			SceneManager.UnloadSceneAsync("X222")
		end

		uv1 = false

		manager.audio:Pause("effect", false)
	end,
	GoToGameView = function (slot0)
		if not isNil(SailGameManager.Instance) and SailGameManager.Instance:IsRunning() then
			JumpTools.OpenPageByJump("/sailGame", {
				activityID = slot0
			})
		else
			uv0.LoadScene(function ()
				slot1 = GameSetting.activity_skadi_sea_total_time.value[1]
				slot2 = 0

				if SailGameData:GetCurGameData(uv0).curStageIndex - 1 > 0 then
					slot2 = GameSetting.activity_skadi_sea_event_time.value[slot4 - 1]
				end

				slot5 = SailGameDataForExchange.New()
				slot5.curStageIndex = slot4 - 1
				slot5.startTime = slot2
				slot5.maxTime = GameSetting.activity_skadi_sea_total_time.value[1]

				for slot11, slot12 in pairs(SailGameConst.STAGE_TIME[uv0]) do
					-- Nothing
				end

				slot5.eventTimeList = {
					[slot12] = slot11
				}
				slot8 = {}

				for slot13, slot14 in pairs(SailGameConst.GAME_TIME_TIPS) do
					slot8[#slot8 + 1] = slot13
				end

				slot5.tipsTimeList = slot8

				SailGameManager.Instance:SetExchangeData(slot5)
				JumpTools.OpenPageByJump("/sailGame", {
					activityID = uv0
				})
			end)
		end
	end,
	ShutDown = function ()
		if uv0 == true then
			if not isNil(SailGameManager.Instance) then
				SailGameManager.Instance:ShutDown()
			end

			uv1.UnLoadScene()
		end
	end,
	GetBuildingTotalReward = function (slot0, slot1)
		if not SailGameData:GetBuildingLastReceiveTimeList(slot0)[slot1] then
			return 0
		end

		return SailGameBuildingCfg[slot1].token_get[1][2] * math.floor((manager.time:GetServerTime() - slot2) / uv0.GetBuildingTimePerReward())
	end,
	GetNextRecoverTimeStep = function (slot0)
		slot3 = -1

		if SailGameData:GetSailCount(slot0) < GameSetting.activity_skadi_sea_be_out_num_max.value[1] then
			slot3 = slot2 - slot1 == 1 and slot5 + 1 or manager.time:GetServerTime() + SailGameData:GetFullRecoverTimeStep(slot0) - manager.time:GetServerTime() - uv0.GetSailRecoverTime() * (slot8 - 1) + 1
		end

		return slot3
	end,
	GetBuildingTimePerReward = function ()
		if not uv0.cacheBuildingTime_ then
			uv0.cacheBuildingTime_ = GameSetting.activity_skadi_sea_building_calculate_time.value[1] * 60
		end

		return uv0.cacheBuildingTime_
	end,
	GetSailRecoverTime = function ()
		if not uv0.cacheSailRecoverTime_ then
			uv0.cacheSailRecoverTime_ = GameSetting.activity_skadi_sea_be_out_num_recover_time.value[1] * 3600
		end

		return uv0.cacheSailRecoverTime_
	end
}
