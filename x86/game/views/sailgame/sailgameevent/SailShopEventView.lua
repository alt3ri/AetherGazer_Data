slot1 = class("SailShopEventView", import("game.views.sailGame.sailGameEvent.SailGameEventBaseView"))

function slot1.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesTransactionEventPopUI"
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiList_, SailShopItem)
end

function slot1.Dispose(slot0)
	slot0.itemList_:Dispose()

	slot0.itemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot1.RefreshUI(slot0)
	slot0.shopDataList_ = SailGameData:GetCurGameData(slot0.activityID_).eventList[slot0.curStageIndex_].shopInfo

	slot0.itemList_:StartScroll(#slot0.shopDataList_)
	slot0:RefreshTitle()
end

function slot1.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.activityID_, slot0.shopDataList_[slot1], slot1)
end

function slot1.OnEventOperateSuccess(slot0, slot1)
	if slot1 ~= SailGameConst.EVENT_COMMON_OPERATE.OVER then
		slot0.shopDataList_ = SailGameData:GetCurGameData(slot0.activityID_).eventList[slot0.curStageIndex_].shopInfo

		slot0.itemList_:StartScroll(#slot0.shopDataList_)
	else
		SailGameAction.SetEventEndMark(slot0.activityID_, SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS)
		SailGameTools.GoToGameView(slot0.activityID_)
	end
end

return slot1
