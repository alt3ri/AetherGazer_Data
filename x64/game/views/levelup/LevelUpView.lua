slot0 = class("LevelUpView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/PlayerlvlpopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()

	slot0.timer_ = FrameTimer.New(function ()
		uv0:Update()
	end, 1, -1)

	slot0.timer_:Start()

	slot0.callBack_ = slot0.params_.callback
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.callBack_ then
		slot0.callBack_()
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RemoveListeners(slot0)
end

function slot0.OnSubscribe(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = slot0.params_.levelUpInfoList[1].fromLevel
	slot2 = slot0.params_.levelUpInfoList[#slot0.params_.levelUpInfoList].toLevel
	slot3 = GameLevelSetting[slot1].fatigue_max
	slot4 = GameLevelSetting[slot2].fatigue_max

	for slot9 = slot1 + 1, slot2 do
		slot5 = 0 + GameLevelSetting[slot9].fatigue_upgrade_reward
	end

	slot0.fromLevelText_.text = tostring(slot1)
	slot0.toLevelText_.text = tostring(slot2)
	slot0.getFatigueText_.text = string.format("+%d", slot5)
	slot0.fatigueUpLimitText_.text = string.format("%d(+%d)", slot4, slot4 - slot3)
end

function slot0.Update(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
