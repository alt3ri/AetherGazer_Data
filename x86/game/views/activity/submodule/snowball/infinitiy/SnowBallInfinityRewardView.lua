ActivityInfinityPoolRewardPreviewBaseView = import("game.views.activity.Submodule.infinityTask.base.rewardPreview.ActivityInfinityPoolRewardPreviewBaseView")
slot0 = class("SnowBallInfinityRewardView", ActivityInfinityPoolRewardPreviewBaseView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/JapanRegionSnowballRewardPopUI"
end

function slot0.GetRewardPreviewItem(slot0)
	return OsirisRewardPreviewItem
end

return slot0
