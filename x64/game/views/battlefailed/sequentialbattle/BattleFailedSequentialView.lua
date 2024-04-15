NewBattleFailedWithButtonView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedWithButtonView")
slot0 = class("BattleFailedSequentialView", NewBattleFailedWithButtonView)

function slot0.OnClickRestart(slot0)
	slot1 = slot0.params_.stageData:GetActivityID()
	slot2 = SequentialBattleData:GetCurrentFinishStageIndex(slot1) + 1

	BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE, SequentialBattleChapterCfg[slot1].stage_id[slot2], slot1, slot1, slot2, {
		activityID = slot1
	}))
end

function slot0.OnClickBack(slot0)
	slot1 = slot0.params_.stageData:GetActivityID()

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("SEQUENTIAL_BATTLE_RESET_STAGE"),
		OkCallback = function ()
			SequentialBattleAction.ResetTeam(uv0, function (slot0)
				if isSuccess(slot0.result) then
					SequentialBattleData:ResetChapterTeamData(uv0)
					uv1:QuitUI()
				else
					ShowTips(slot0.result)
				end
			end)
		end
	})
end

return slot0
