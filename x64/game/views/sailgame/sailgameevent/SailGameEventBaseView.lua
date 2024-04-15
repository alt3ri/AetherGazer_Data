slot0 = class("SailGameEventBaseView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesBaseEventPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	if slot0.cancelBtn_ then
		slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
			uv0:CancelEvent()
		end)
	end

	if slot0.acceptBtn_ then
		slot0:AddBtnListener(slot0.acceptBtn_, nil, function ()
			uv0:AcceptEvent()
		end)
	end
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.curStageIndex_ = slot0.params_.stageIndex
	slot0.eventID_ = slot0.params_.eventID

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshReward()
	slot0:RefreshTitle()
end

function slot0.RefreshReward(slot0)
	if SailGameData:GetCurGameData(activityID).eventList[slot0.curStageIndex_].rewardNum > 0 then
		slot0.rewardIcon_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id)
		slot0.rewardNumText_.text = slot2

		SetActive(slot0.rewardPanelGo_, true)
	else
		SetActive(slot0.rewardPanelGo_, false)
	end
end

function slot0.RefreshTitle(slot0)
	slot0.titleText_.text = SailGameEventCfg[slot0.eventID_].name
	slot0.descText_.text = SailGameEventCfg[slot0.eventID_].desc

	if getSpriteWithoutAtlas("TextureConfig/Fishing/FishPortrait/" .. SailGameEventCfg[slot0.eventID_].picture) then
		slot0.roleIcon_.sprite = slot1
	end
end

function slot0.CancelEvent(slot0)
	slot0.tipsIndex_ = nil

	SailGameAction.EventOperate(slot0.activityID_, slot0.curStageIndex_, SailGameConst.EVENT_COMMON_OPERATE.OVER)
end

function slot0.AcceptEvent(slot0)
	slot0.tipsIndex_ = SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS

	SailGameAction.EventOperate(slot0.activityID_, slot0.curStageIndex_, SailGameConst.EVENT_COMMON_OPERATE.OVER)
end

function slot0.OnEventOperateSuccess(slot0)
	SailGameAction.SetEventEndMark(slot0.activityID_, slot0.tipsIndex_)
	SailGameTools.GoToGameView(slot0.activityID_)
end

return slot0
