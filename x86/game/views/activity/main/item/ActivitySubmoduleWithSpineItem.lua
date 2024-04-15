ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")
slot0 = class("ActivitySubmoduleWithSpineItem", ActivitySubmoduleItem)

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.spine_ = slot0.spineGo_.transform:GetComponent(typeof(Spine.Unity.SkeletonGraphic))
end

function slot0.RefreshLock(slot0)
	uv0.super.RefreshLock(slot0)

	if slot0.stopTime_ <= manager.time:GetServerTime() or manager.time:GetServerTime() < slot0.startTime_ then
		slot0.spine_.color = Color(0.7058823529411765, 0.6823529411764706, 0.6823529411764706)
	else
		slot0.spine_.color = Color(1, 1, 1)
	end
end

return slot0
