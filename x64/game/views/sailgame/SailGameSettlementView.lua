slot0 = class("SailGameSettlementView", ReduxView)

function slot0.UIName(slot0)
	return ""
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
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		JumpTools.OpenPageByJump("/sailMain", {
			activityID = uv0.activityID_
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	for slot6, slot7 in ipairs(SailGameData:GetCurGameData(slot0.activityID_).eventList) do
		slot1 = 0 + slot7.rewardNum
	end

	slot0.rewardNumText_.text = slot1
	slot0.rewardIcon_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id)
end

return slot0
