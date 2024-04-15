slot1 = class("SailEnterView", import("game.views.activity.Main.toggle.ActivityMainBasePanel"))

function slot1.GetUIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesHomeUI"
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.goBtn_.transform, string.format("%s_%s", RedPointConst.SAIL_GAME, slot0.activityID_))
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.goBtn_.transform, string.format("%s_%s", RedPointConst.SAIL_GAME, slot0.activityID_))
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		SailGameData:SetSelectedMainBtn(uv0.activityID_)
		JumpTools.OpenPageByJump("/sailMain", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_SKADI_SEA_DESCRIBE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_SKADI_SEA_DESCRIBE")
		})
	end)
end

return slot1
