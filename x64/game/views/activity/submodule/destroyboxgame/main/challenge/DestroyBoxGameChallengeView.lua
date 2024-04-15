slot0 = class("DestroyBoxGameChallengeView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.boxSelectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.boxStateController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.rewardStateController_ = ControllerUtil.GetController(slot0.transform_, "rewardState")
	slot0.rewardItem_ = CommonItem.New(slot0.itemGo_)

	slot0.rewardItem_:RegistCallBack(function (slot0)
		if uv0.receiveRewardState_ == 1 then
			uv0:ReceiveReward()
		else
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
		end
	end)
	slot0.rewardItem_:ShowFloor("1")
end

function slot0.OnEnter(slot0, slot1)
	slot0.mainActivityID_ = slot1
	slot0.id_ = DestroyBoxGameData:GetDifficultList(slot1)[DestroyBoxGameData.SPECTIAL_HARD_LEVEL][slot0.index_]
	slot2 = DestroyBoxGameCfg[slot0.id_]
	slot3 = slot2.activity_id
	slot0.activityID_ = slot3
	slot4 = DestroyBoxGameRewardCfg.get_id_list_by_activity_id[slot3][1]
	slot5 = DestroyBoxGameRewardCfg[slot4].item_list[1]
	slot0.rewardID_ = slot4

	slot0.rewardItem_:RefreshData({
		id = slot5[1],
		number = slot5[2]
	})
	slot0.rewardItem_:HideNum()
	slot0:RefreshData()
	slot0:RefreshUI()
	slot0:AddTimer()
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, slot2.difficult, slot0.activityID_))
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, DestroyBoxGameCfg[slot0.id_].difficult, slot0.activityID_))
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.rewardItem_:Dispose()

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		slot1 = DestroyBoxGameCfg[uv0.id_]

		if not uv0.isTimeLock_ and not not uv0.isFinishPreStage_ then
			DestroyBoxGameAction.ClickBoxStageItem(uv0.activityID_, uv0.id_)
		end

		if DestroyBoxGameData:GetSelectID(slot1.main_activity_id) ~= uv0.id_ then
			DestroyBoxGameData:SetSelectIDAndDifficult(slot2, uv0.id_)
			manager.notify:Invoke(DESTROY_BOX_GAME_SELECT_STAGE, uv0.id_)
		end

		if uv0.receiveRewardState_ == 1 then
			uv0:ReceiveReward()
		end
	end)
	slot0:AddBtnListener(slot0.rankBtn_, nil, function ()
		if manager.time:GetServerTime() < ActivityData:GetActivityData(ActivityCfg[uv0.activityID_].sub_activity_list[1]).startTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(slot1.startTime, nil, true)))

			return
		elseif slot1.stopTime <= slot2 then
			ShowTips("TIME_OVER")

			return
		end

		uv0:Go("/rankBase", {
			type = RankBaseConst.RANK_TYPE.ALL,
			subType = RankBaseConst.SUB_TYPE.SCORE,
			activityID = slot0
		})
	end)
end

function slot0.RefreshData(slot0)
	slot0.targetScore_ = DestroyBoxGameRewardCfg[slot0.rewardID_].complete_num

	if DestroyBoxGameData:GetStageData(slot0.id_) then
		slot0.maxScore_ = slot2.maxScore

		if slot0.targetScore_ <= slot0.maxScore_ then
			slot0.receiveRewardState_ = 1
		end
	else
		slot0.maxScore_ = 0
	end

	slot0.receiveRewardState_ = table.keyof(DestroyBoxGameData:GetReceiveRewardList(slot0.mainActivityID_), slot0.rewardID_) and 2 or slot0.receiveRewardState_
	slot0.isFinishPreStage_ = DestroyBoxGameData:IsFinishPreStage(slot0.id_)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshRewardState()
	slot0:RefreshTips()
end

function slot0.RefreshTips(slot0)
	slot0.curScoreText_.text = slot0.maxScore_
	slot0.targetScoreText_.text = string.format("/%s", slot0.targetScore_)

	if DestroyBoxGameCfg[DestroyBoxGameCfg[slot0.id_].unlock_condition[1]].difficult == 1 then
		slot4 = GetTips("HARDLEVEL_EASY")
	elseif slot4 == 2 then
		slot4 = GetTips("HARDLEVEL_HARD")
	end

	slot0.lockText_.text = string.format(GetTips("DESTROY_BOX_GAME_UNLOCK_STAGE_1"), ActivityCfg[slot3.activity_id].remark, slot4, slot2[2])
end

function slot0.RefreshRewardState(slot0)
	if slot0.receiveRewardState_ == 2 then
		slot0.rewardStateController_:SetSelectedState("received")
	elseif slot0.receiveRewardState_ == 1 then
		slot0.rewardStateController_:SetSelectedState("canReceive")
	else
		slot0.rewardStateController_:SetSelectedState("normal")
	end
end

function slot0.RefreshBoxState(slot0)
	slot1 = DestroyBoxGameCfg[slot0.id_]

	if not slot0.isFinishPreStage_ or slot0.isTimeLock_ then
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

function slot0.ReceiveReward(slot0)
	DestroyBoxGameAction.RequestReward(slot0.mainActivityID_, {
		slot0.rewardID_
	}, function ()
		uv0:RefreshData()
		uv0:RefreshRewardState()
	end)
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
