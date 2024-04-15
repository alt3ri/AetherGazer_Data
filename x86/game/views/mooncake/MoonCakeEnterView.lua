slot1 = class("MoonCakeEnterView", import("game.views.activity.Main.toggle.ActivityMainBasePanel"))

function slot1.GetUIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeEnterUI"
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
	slot0:RefreshStage()
	manager.redPoint:bindUIandKey(slot0.enterBtn_.transform, string.format("%s_%s", RedPointConst.MOON_CAKE, slot0.activityID_))
	slot0:RegistEventListener(ACTIVITY_UPDATE, handler(slot0, slot0.OnActivityUpdate))
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.enterBtn_.transform, string.format("%s_%s", RedPointConst.MOON_CAKE, slot0.activityID_))
	slot0:RemoveAllEventListener()
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.enterBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		if uv0.isPartyOpen_ then
			JumpTools.OpenPageByJump("/moonCakeParty", {
				activityID = uv0.partyActivityID_,
				mainActivityID = uv0.activityID_,
				partyOwnerUID = USER_ID
			})
		elseif uv0.isCakeOpen_ then
			JumpTools.OpenPageByJump("/moonCakeMain", {
				activityID = uv0.cakeActivityID_,
				mainActivityID = uv0.activityID_
			})
		end
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "MID_AUTUMN_FESTIVAL_DESCRIPTION",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("MID_AUTUMN_FESTIVAL_DESCRIPTION")
		})
	end)
end

function slot1.RefreshStage(slot0)
	slot0.cakeActivityID_ = MoonCakeTools.GetCakeStageActivityID(slot0.activityID_)
	slot1 = ActivityData:GetActivityData(slot0.cakeActivityID_)
	slot0.cakeStartTime_ = slot1.startTime
	slot0.cakeStopTime_ = slot1.stopTime
	slot0.isCakeOpen_ = slot0.cakeStartTime_ <= manager.time:GetServerTime() and slot2 < slot0.cakeStopTime_
	slot0.partyActivityID_ = MoonCakeTools.GetPartyStageActivityID(slot0.activityID_)
	slot1 = ActivityData:GetActivityData(slot0.partyActivityID_)
	slot0.partyStartTime_ = slot1.startTime
	slot0.partyStopTime_ = slot1.stopTime
	slot0.isPartyOpen_ = slot0.partyStartTime_ <= slot2 and slot2 < slot0.partyStopTime_
end

function slot1.OnActivityUpdate(slot0, slot1)
	if ActivityTools.GetActivityType(slot1) == ActivityTemplateConst.MOON_CAKE_MAKE or slot2 == ActivityTemplateConst.MOON_CAKE_PARTY then
		slot0:RefreshStage()
	end
end

return slot1
