slot0 = class("PushSnowBallMatchPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballMatchmakingUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.cancelHandler_ = handler(slot0, function ()
		uv0:Back()
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		PushSnowBallAction:SendCancelMatching()
		uv0.cancelHandler_()
	end)
end

function slot0.OnEnter(slot0)
	slot0.matchingTimer = 0
	slot0.timeText_.text = slot0.matchingTimer .. "s"

	slot0:AddTimer()
	manager.notify:RegistListener(PUSH_SNOWBALL_CANCLE_MATCHING, slot0.cancelHandler_)
	manager.notify:RegistListener(PUSH_SNOWBALL_SUCCESS_MATCHING, slot0.cancelHandler_)
end

function slot0.AddTimer(slot0)
	slot0.timer_ = Timer.New(function ()
		uv0.matchingTimer = uv0.matchingTimer + 1
		uv0.timeText_.text = uv0.matchingTimer .. "s"
	end, 1, -1, true)

	slot0.timer_:Start()
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	manager.notify:RemoveListener(PUSH_SNOWBALL_CANCLE_MATCHING, slot0.cancelHandler_)
	manager.notify:RemoveListener(PUSH_SNOWBALL_SUCCESS_MATCHING, slot0.cancelHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
