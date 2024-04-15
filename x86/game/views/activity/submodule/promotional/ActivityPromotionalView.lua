ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("ActivityPromotionalView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return ActivityPromotionalCfg[slot0.activityID_].prefab_name
end

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.heroController_ = ControllerUtil.GetController(slot0.heroTrialTf_, "name")
	slot0.skinController_ = ControllerUtil.GetController(slot0.heroSkinTf_, "name")
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.heroTrialBtn_, nil, function ()
		SDKTools.SendMessageToSDK("hero_publicize_page_jump", {
			type = 1
		})
		JumpTools.JumpToPage2(ActivityPromotionalCfg[uv0.activityID_].hero_trial_navigation)
	end)
	slot0:AddBtnListener(slot0.heroSkinBtn_, nil, function ()
		SDKTools.SendMessageToSDK("hero_publicize_page_jump", {
			type = 2
		})
		JumpTools.JumpToPage2(ActivityPromotionalCfg[uv0.activityID_].hero_skin_navigation)
	end)
	slot0:AddBtnListener(slot0.heroDrawBtn_, nil, function ()
		SDKTools.SendMessageToSDK("hero_publicize_page_jump", {
			type = 3
		})
		OperationRecorder.RecordButtonTouch("activity_hero_" .. uv0.activityID_)
		JumpTools.JumpToPage2(ActivityPromotionalCfg[uv0.activityID_].hero_draw_navigation)
	end)
end

function slot0.HideRedPoint(slot0)
	if not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_RANGE + slot0.activityID_) then
		RedPointAction.HandleRedPoint(RedPointConst.ACTIVITY_RANGE + slot1)
		manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(slot1), slot1), 0)
	end
end

function slot0.Show(slot0, slot1)
	uv0.super.Show(slot0, slot1)

	if slot1 then
		slot0:RefreshHeroTrialState()
		slot0:RefreshHeroSkinState()
	end
end

function slot0.RefreshHeroTrialState(slot0)
	if HeroTrialData:GetHeroTrialStateList()[ActivityPromotionalCfg[slot0.activityID_].hero_trial_id] == 1 or slot2 == 2 then
		slot0.heroController_:SetSelectedState("true")
	else
		slot0.heroController_:SetSelectedState("false")
	end
end

function slot0.RefreshHeroSkinState(slot0)
	if SkinTrialData:IsCompleted(ActivityPromotionalCfg[slot0.activityID_].hero_skin_id) then
		slot0.skinController_:SetSelectedState("true")
	else
		slot0.skinController_:SetSelectedState("false")
	end
end

function slot0.RefreshTime(slot0)
	slot2 = manager.time:GetServerTime()
	slot0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(slot0.activityID_).stopTime)
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()
	slot0:RefreshTime()

	slot0.timer_ = Timer.New(function ()
		uv0:RefreshTime()
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
