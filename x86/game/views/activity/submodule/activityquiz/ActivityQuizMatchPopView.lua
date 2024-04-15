slot0 = class("ActivityQuizMatchPopView", ReduxView)

function slot0.UIName(slot0)
	return ActivityQuizTools.GetMatchPopUIName(slot0.params_.activityId)
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		ActivityQuizAction.CancelMarch()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityId

	slot0:RefreshTime()
end

function slot0.RefreshTime(slot0)
	slot0:StopTimer()

	slot0.cnt_.text = 0 .. "s"
	slot0.timer_ = Timer.New(function ()
		uv0 = uv0 + 1
		uv1.cnt_.text = uv0 .. "s"
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnQuizStartGame(slot0)
	slot0:Back()
end

function slot0.OnActivityQuizCancelMatch(slot0)
	slot0:Back()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
