slot1 = class("ActivityAttributeArenaEnterView", import("game.views.activity.Main.toggle.ActivityMainBasePanel"))

function slot1.GetUIName(slot0)
	return AttributeArenaTools.GetEnterUI(slot0.activityID_)
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.GoToSystem("/activityAttributeArena", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(nil, slot0.descBtn_, function ()
		slot0 = "ACTIVITY_ATTRIBUTE_GAME_TIP"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(slot0),
			key = slot0
		})
	end)
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA, slot0.activityID_))

	slot0.descTxt_.text = GetTips("ACTIVITY_ATTRIBUTE_ENTER_TIP")
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA, slot0.activityID_))
end

return slot1
