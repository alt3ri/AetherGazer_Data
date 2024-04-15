ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("LimitedCalculationPageView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10ArtifactUI/JapanRegionUI_2_10ArtifactMainUI"
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
		ActivityTools.JumpToSubmodulePage(uv0.activityID_)
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		slot0 = LimitedCalculationTools.GetGameHelpKey(uv0.activiytID_)

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(slot0),
			key = slot0
		})
	end)
end

return slot0
