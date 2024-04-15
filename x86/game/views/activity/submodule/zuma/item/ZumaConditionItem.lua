slot0 = class("ZumaConditionItem", ReduxView)
slot1 = {
	showState = {
		unFinish = "state0",
		name = "clear",
		finish = "state1"
	}
}

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.showStateController = slot0.controllerEx_:GetController(uv0.showState.name)
end

function slot0.RefreshConditionState(slot0, slot1, slot2)
	slot3 = ActivityPointRewardCfg[slot1]
	slot4 = slot3.need
	slot0.descText_.text = string.format(GetTips("ACTIVITY_ZUMA_LEVEL_TARGET_DESC"), slot4)
	slot0.rewardValueText_.text = slot3.reward_item_list[1][2]
	slot0.imageImg_.sprite = ItemTools.getItemSprite(slot3.reward_item_list[1][1])

	slot0.showStateController:SetSelectedState(slot2 < slot4 and uv0.showState.unFinish or uv0.showState.finish)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
