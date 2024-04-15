ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("ZumaHomeView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaMainUI"
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnstartBtn_, nil, function ()
		JumpTools.OpenPageByJump("/ZumaMainView", {})
	end)
	slot0:AddBtnListener(nil, slot0.descBtn_, function ()
		slot0 = "ACTIVITY_ZUMA_DESC"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(slot0),
			key = slot0
		})
	end)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	ZumaData:SetZumaActivityID(slot0.activityID_)
	manager.redPoint:bindUIandKey(slot0.btnstartBtn_.transform, RedPointConst.ZUMA .. ActivityConst.ACTIVITY_ZUMA)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.btnstartBtn_.transform, RedPointConst.ZUMA .. ActivityConst.ACTIVITY_ZUMA)
end

return slot0
