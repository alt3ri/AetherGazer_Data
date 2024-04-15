slot1 = class("SailBattleEventView", import("game.views.sailGame.sailGameEvent.SailGameEventBaseView"))

function slot1.AcceptEvent(slot0)
	slot0:Go("/sectionSelectHero", {
		section = SailGameEventCfg[slot0.eventID_].stage_id,
		sectionType = BattleConst.STAGE_TYPE_NEW.SAIL_GAME,
		activityID = slot0.activityID_,
		customBarList = {
			BACK_BAR
		}
	})
end

function slot1.RefreshReward(slot0)
	slot3 = getRewardFromDropCfg(BattleSailGameStageCfg[SailGameEventCfg[slot0.eventID_].stage_id].drop_lib_id, true)[1]
	slot0.rewardIcon_.sprite = ItemTools.getItemSprite(slot3.id)
	slot0.rewardNumText_.text = slot3.num
end

return slot1
