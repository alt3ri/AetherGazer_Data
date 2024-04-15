require("game.data.BackHomeCricketDataTemplate")

slot0 = singletonClass("BackHomeCricketBattleData")
slot1, slot2 = nil

function slot0.InitSimpleCricketBattleInfo(slot0, slot1)
end

function slot0.InitDetailCricketBattleData(slot0, slot1)
end

function slot0.EnterCurSystem(slot0)
end

function slot0.ExitCurSystem(slot0)
	if uv0 then
		uv0:Dispose()

		uv0 = nil
	end
end

function slot0.ExitBackHomeSystem(slot0)
	if uv0 then
		uv0:Dispose()

		uv0 = nil
	end
end

function slot0.RefreshCricketBattleDailyZero(slot0)
end

function slot0.InitSingleBattleData(slot0, slot1, slot2, slot3)
	if uv0 then
		uv0:Dispose()

		uv0 = nil
	end

	uv0 = BackHomeCricketBattleResult.New(slot1, slot2, slot3)
end

function slot0.GetSingleBattleData(slot0)
	if uv0 then
		return uv0
	end
end

function slot0.SetDanceBackCB(slot0)
	if uv0 then
		if uv0.settleType == BackHomeCricketConst.ROOM_TYPE.Video or uv0.enemyID ~= nil then
			slot1 = uv0.stageID

			function uv1()
				JumpTools.OpenPageByJump("/idolTraineeEnterBattleView", {
					pvpBattle = true,
					stageID = uv0
				})
			end

			return
		end

		slot2 = IdolTraineeTools:GetPveStageChapter(uv0.stageID)

		function uv1()
			JumpTools.OpenPageByJump("/idolTraineeEnterBattleView", {
				pvpBattle = false,
				stageID = uv0
			})
			JumpTools.OpenPageByJump("/idolTraineeLevelMainView", {
				chapterID = uv1
			})
			JumpTools.OpenPageByJump("/idolTraineeChapterMain")
		end
	end
end

function slot0.InvokeDanceBackCB(slot0)
	if uv0 then
		uv0()

		uv0 = nil
	end
end

return slot0
