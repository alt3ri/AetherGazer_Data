slot0 = class("SailFishingResultView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdFishingSettlementUI"
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
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		SailGameTools.GoToGameView(uv0.activityID_)
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.score_ = slot0.params_.score

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	for slot5 = #ActivityPointRewardCfg.get_id_list_by_activity_id[slot0.activityID_], 1, -1 do
		if ActivityPointRewardCfg[slot1[slot5]].need <= slot0.score_ then
			slot0.rewardCfg_ = ActivityPointRewardCfg[slot6].reward_item_list[1]

			break
		end
	end

	slot0.scoreText_.text = slot0.score_

	if ItemTools.getItemSprite(slot0.rewardCfg_[1]) then
		slot0.rewardIcon_.sprite = slot2
	end

	slot0.rewardNumText_.text = slot0.rewardCfg_[2]
end

return slot0
