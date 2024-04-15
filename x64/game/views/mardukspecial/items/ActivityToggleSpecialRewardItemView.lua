slot1 = class("ActivityToggleSpecialRewardItemView", import("game.views.mardukSpecial.items.MardukSpecialRewardItemView"))

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.items_ = {
		ActivityToggleSpecialRewardConditionItemView.New(slot0.itemGo1_),
		ActivityToggleSpecialRewardConditionItemView.New(slot0.itemGo2_),
		ActivityToggleSpecialRewardConditionItemView.New(slot0.itemGo3_)
	}
end

return slot1
