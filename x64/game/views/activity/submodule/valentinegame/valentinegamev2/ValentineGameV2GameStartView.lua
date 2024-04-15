slot0 = class("ValentineGameV2GameStartView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineStarUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.timer_ = Timer.New(function ()
		uv0:StopTimer()
		JumpTools.OpenPageByJump("/valentineGameV2HeroAnswerView", {
			activityID = uv0.activityID_
		})
	end, 3, 1)

	slot0.timer_:Start()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	slot0:StopTimer()
	slot0.super.Dispose(slot0)
end

return slot0
