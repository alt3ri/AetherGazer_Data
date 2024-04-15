slot0 = class("DestroyBoxGameNormalItemView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.boxStateController_ = ControllerUtil.GetController(slot0.transform_, "boxState")
	slot0.boxSelectController_ = ControllerUtil.GetController(slot0.transform_, "select")

	slot0:Show(true)
end

function slot0.OnEnter(slot0, slot1)
	slot0.id_ = slot1
	slot2 = DestroyBoxGameCfg[slot0.id_]
	slot0.activityID_ = slot2.activity_id
	slot4 = table.keyof(DestroyBoxGameData:GetDifficultList(slot2.main_activity_id)[slot2.difficult], slot0.id_)
	slot0.numText_.text = string.format("%02d", slot4)
	slot0.index_ = slot4
	slot0.isClearStage_ = DestroyBoxGameData:IsClearStage(slot1)
	slot0.isFinishPreStage_ = DestroyBoxGameData:IsFinishPreStage(slot1)

	slot0:AddTimer()
	slot0:AddRedPoint()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0:RemoveRedPoint()
end

function slot0.AddRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, DestroyBoxGameCfg[slot0.id_].difficult, slot0.activityID_))
end

function slot0.RemoveRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, DestroyBoxGameCfg[slot0.id_].difficult, slot0.activityID_))
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		slot0 = DestroyBoxGameCfg[uv0.id_]
		slot2 = slot0.main_activity_id

		if uv0.isTimeLock_ then
			if manager.time:GetServerTime() < ActivityData:GetActivityData(slot0.activity_id).startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(slot3.startTime, nil, true)))
			elseif slot3.stopTime <= slot4 then
				ShowTips("TIME_OVER")
			end

			return
		elseif not uv0.isFinishPreStage_ then
			if DestroyBoxGameCfg[DestroyBoxGameCfg[uv0.id_].unlock_condition[1]].difficult == 1 then
				slot6 = GetTips("HARDLEVEL_EASY")
			elseif slot6 == 2 then
				slot6 = GetTips("HARDLEVEL_HARD")
			end

			if slot4[2] > 1 then
				ShowTips(string.format(GetTips("DESTROY_BOX_GAME_UNLOCK_STAGE_1"), ActivityCfg[slot5.activity_id].remark, slot6, slot4[2]))
			else
				ShowTips(string.format(GetTips("DESTROY_BOX_GAME_UNLOCK_STAGE"), ActivityCfg[slot5.activity_id].remark, slot6))
			end

			return
		end

		DestroyBoxGameAction.ClickBoxStageItem(uv0.activityID_, uv0.id_)

		if DestroyBoxGameData:GetSelectID(slot2) ~= uv0.id_ then
			DestroyBoxGameData:SetSelectIDAndDifficult(slot2, uv0.id_)
			manager.notify:Invoke(DESTROY_BOX_GAME_SELECT_STAGE, uv0.id_)
		end
	end)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SwitchDifficult(slot0)
	slot1 = DestroyBoxGameCfg[slot0.id_]

	slot0:RemoveRedPoint()

	slot0.id_ = DestroyBoxGameCfg.get_id_list_by_activity_id[slot1.activity_id][DestroyBoxGameData:GetSelectDifficult(slot1.main_activity_id)]

	slot0:AddRedPoint()

	slot0.isClearStage_ = DestroyBoxGameData:IsClearStage(slot0.id_)
	slot0.isFinishPreStage_ = DestroyBoxGameData:IsFinishPreStage(slot0.id_)

	slot0:AddTimer()
end

function slot0.RefreshBoxState(slot0)
	slot1 = DestroyBoxGameCfg[slot0.id_]

	if slot0.isClearStage_ then
		slot0.boxStateController_:SetSelectedState("clear")
	elseif not slot0.isFinishPreStage_ or slot0.isTimeLock_ then
		slot0.boxStateController_:SetSelectedState("lock")
	else
		slot0.boxStateController_:SetSelectedState("unlock")
	end
end

function slot0.SwitchSelectItem(slot0, slot1)
	if slot0.id_ == slot1 then
		slot0.boxSelectController_:SetSelectedState("true")
	else
		slot0.boxSelectController_:SetSelectedState("false")
	end
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.isTimeLock_ = ActivityTools.GetActivityStatus(DestroyBoxGameCfg[slot0.id_].activity_id) ~= 1

	slot0:RefreshBoxState()

	if slot0.isFinishPreStage_ then
		slot0.timer_ = Timer.New(function ()
			if ActivityTools.GetActivityStatus(uv0.activity_id) ~= 1 ~= uv1.isTimeLock_ then
				uv1.isTimeLock_ = slot0

				uv1:RefreshBoxState()
			end
		end, 1, -1)

		slot0.timer_:Start()
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
