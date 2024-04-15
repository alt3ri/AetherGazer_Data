slot0 = class("ChapterVariantSubPlotBaseItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "lockState")
	slot0.stageDataChangeHandler_ = handler(slot0, slot0.StageDataChange)
end

function slot0.OnEnter(slot0, slot1)
	slot0.chapterID_ = slot1

	slot0:RefreshStageLockState()
	slot0:BindRedPoint()

	if ChapterCfg[slot1].activity_id ~= 0 then
		slot0:AddTimer()
	else
		slot0:RefreshControllerState()
	end

	manager.notify:RegistListener(BATTLE_STAGE_PLOT_CHANGE, slot0.stageDataChangeHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(BATTLE_STAGE_PLOT_CHANGE, slot0.stageDataChangeHandler_)
	slot0:UnBindRedPoint()
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	slot0.stageDataChangeHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		JumpTools.Jump2SubPlotByChapterID(uv0.chapterID_, true)
	end)
end

function slot0.BindRedPoint(slot0)
end

function slot0.UnBindRedPoint(slot0)
end

function slot0.RefreshStageLockState(slot0)
	if ChapterCfg[slot0.chapterID_].section_id_list[1] == nil or BattleStageData:GetStageData()[slot2] then
		slot0.isLock_ = false
	else
		slot0.isLock_ = true
	end

	slot0:RefreshControllerState()
end

function slot0.StageDataChange(slot0)
	slot0:RefreshStageLockState()
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.timeLock_ = false

	if ActivityData:GetActivityRefreshTime(ChapterCfg[slot0.chapterID_].activity_id) < manager.time:GetServerTime() then
		slot0:RefreshControllerState()

		return
	end

	slot0.controller_:SetSelectedState("timeLock")

	slot0.timerText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot2))
	slot0.timeLock_ = true
	slot0.timer_ = Timer.New(function ()
		if uv0 <= manager.time:GetServerTime() then
			uv1.timeLock_ = false

			uv1:RefreshControllerState()
			uv1:StopTimer()
		else
			uv1.timerText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0))
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshControllerState(slot0)
	if slot0.timeLock_ then
		slot0.controller_:SetSelectedState("timeLock")
	elseif slot0.isLock_ then
		slot0.controller_:SetSelectedState("lock")
	else
		slot0.controller_:SetSelectedState("normal")
	end
end

return slot0
