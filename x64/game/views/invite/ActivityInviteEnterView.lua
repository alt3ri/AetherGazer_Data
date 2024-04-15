slot1 = class("ActivityInviteEnterView", import("game.views.activity.Main.toggle.ActivityMainBasePanel"))

function slot1.GetUIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionConserverUI/JapanRegionConMainUI"
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot1.OnEnter(slot0)
	slot1 = ActivityData:GetActivityData(InviteData:GetDataByPara("activityId"))
	slot0.startTime_ = slot1.startTime
	slot0.stopTime_ = slot1.stopTime

	slot0:AddTimer()
	manager.redPoint:bindUIandKey(slot0.goBtn_.transform, RedPointConst.INVITE_MAIN, {
		x = 150,
		y = 35
	})

	slot0.descTxt_.text = GetTips("ACTIVITY_INVITE_DECORATE")
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.goBtn_.transform, RedPointConst.INVITE_MAIN)
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		slot0 = InviteData:GetDataByPara("selectHeroIndex")

		if InviteData:GetDataByPara("allComplete") then
			JumpTools.GoToSystem("/ActivityInviteRegionView", {
				selectIndex = 1
			})
		elseif slot0 then
			JumpTools.GoToSystem("/ActivityInviteRegionView", {
				selectIndex = slot0
			})
		else
			JumpTools.GoToSystem("/ActivityInviteMain", {})
		end
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_INVITE_DESCRIPTION")
		})
	end)
end

return slot1
