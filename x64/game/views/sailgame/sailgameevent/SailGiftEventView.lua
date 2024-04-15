slot1 = class("SailShopEventView", import("game.views.sailGame.sailGameEvent.SailGameEventBaseView"))

function slot1.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesGiftEventPopUI"
end

function slot1.RefreshReward(slot0)
	slot2 = SailGameData:GetCurGameData(slot0.activityID_).eventList[slot0.curStageIndex_].giftInfo
	slot0.rewardIcon_.sprite = ItemTools.getItemSprite(slot2.itemID)
	slot0.rewardNumText_.text = slot2.itemNum

	SetActive(slot0.rewardPanelGo_, true)
end

function slot1.AcceptEvent(slot0)
	slot0.tipsIndex_ = SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS

	SailGameAction.EventOperate(slot0.activityID_, slot0.curStageIndex_, nil)
end

return slot1
