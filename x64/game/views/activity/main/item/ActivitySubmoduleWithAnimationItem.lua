ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")
slot0 = class("ActivitySubmoduleWithAnimationItem", ActivitySubmoduleItem)

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if manager.time:GetServerTime() < uv0.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0.startTime_)))

			return
		end

		if uv0.stopTime_ <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		manager.notify:Invoke(ACTIVITY_MAIN_CLICK_BTN)
		LeanTween.delayedCall(0.6, System.Action(function ()
			ActivityTools.JumpToSubmodulePage(uv0.activityId_)
		end))
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
