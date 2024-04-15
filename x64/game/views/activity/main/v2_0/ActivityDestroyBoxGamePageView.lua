ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("ActivityDestroyBoxGamePageView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionBoxUI/JapanRegionBoxMainUI"
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.btn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(slot0.activityID_), slot0.activityID_))
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.btn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(slot0.activityID_), slot0.activityID_))
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:Go("/destroyBoxGame", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		slot0 = "DESTROY_BOX_GAME_DESC"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(slot0),
			key = slot0
		})
	end)
end

return slot0
