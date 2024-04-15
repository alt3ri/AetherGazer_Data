slot1 = class("SoloHeartDemonEnterView", import("game.views.activity.Main.toggle.ActivityMainBasePanel"))

function slot1.GetUIName(slot0)
	return "Widget/System/Challenge_SoloHeartDemonUI/JapanRegionSoloMain"
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.Controller = ControllerUtil.GetController(slot0.gameObject_.transform, "lock")
end

function slot1.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.goBtn_.transform, RedPointConst.SOLO_HEART_DEMON)
	slot0:UpdateView()
	slot0:HideRedPoint()
end

function slot1.UpdateView(slot0)
	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	slot0.remainTime = 0

	for slot4, slot5 in pairs(ActivityCfg.get_id_list_by_activity_template[270]) do
		if ActivityData:GetActivityIsOpen(slot5) then
			slot0.activityId = slot5

			break
		end
	end

	slot0.remainTime = ActivityData:GetActivityData(slot0.activityID_).stopTime
	slot0.remainTxt_.text = manager.time:GetLostTimeStrWith2Unit(slot0.remainTime)
	slot0.updateTimer_ = Timer.New(function ()
		uv0.remainTxt_.text = manager.time:GetLostTimeStrWith2Unit(uv0.remainTime)
	end, 1, slot0.remainTime - manager.time:GetServerTime() + 1, 1)

	slot0.updateTimer_:Start()

	slot0.describeTxt_.text = GetTips("SOLO_HEART_DEMON_ENTER_DESCRIBE")

	slot0.Controller:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) and "lock" or "unlock")
end

function slot1.HideRedPoint(slot0)
	SoloHeartDemonAction.UpdateEnterRedPoint(slot0.activityId)
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)

	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(slot0.goBtn_.transform, RedPointConst.SOLO_HEART_DEMON)
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON)[2]))
		elseif ActivityData:GetActivityIsOpen(ActivityConst.SOLO_HEART_DEMON) == false then
			ShowTips("SOLO_HEART_DEMON_CLOSED")
		else
			JumpTools.GoToSystem("/soloHeartDemonMain", {
				activityId = uv0.activityId
			})
			SoloHeartDemonAction.UpdateViewRedPoint()
		end
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "SOLO_HEART_DEMON_DESCRIBE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("SOLO_HEART_DEMON_EXPLAIN")
		})
	end)
end

return slot1
