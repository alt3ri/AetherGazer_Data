ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("ActivityValentineGameV2MainView", ActivityMainBasePanel)
slot1 = "ACTIVITY_VALENTINE_DESCRIBE"

function slot0.GetUIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineActivityMainUI"
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		JumpTools.OpenPageByJump("/valentineGameV2SelectHeroView", {
			activityID = ActivityConst.INDIA_VALENTINE_GAME_V2
		})
	end)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips(uv0),
			key = uv0
		})
	end)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.btn_.transform, RedPointConst.VALENTINE_GAME .. "_" .. slot0.activityID_)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.btn_.transform, RedPointConst.VALENTINE_GAME .. "_" .. slot0.activityID_)
end

return slot0
