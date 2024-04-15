slot1 = class("CombineGameEnterView", import("game.views.activity.Main.toggle.ActivityMainBasePanel"))

function slot1.GetUIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfMainUI"
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

	slot1 = ActivityData:GetActivityData(CombineGameData:GetDataByPara("activityId"))
	slot0.startTime_ = slot1.startTime
	slot0.stopTime_ = slot1.stopTime

	slot0:AddTimer()
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.GoToSystem("/CombineGameMainView", {})
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("COMBINE_GAME_EXPLAIN")
		})
	end)
end

return slot1
