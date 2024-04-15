slot0 = class("ActivityPushBoxMainView", ReduxView)
slot1 = 2.25

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10AnniversaryEntranceUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardPreviewTbl_ = {
		"CAKE_INDEX_REWARD_1",
		"CAKE_INDEX_REWARD_2",
		"CAKE_INDEX_REWARD_3",
		"CAKE_INDEX_REWARD_4",
		"CAKE_INDEX_REWARD_5",
		"CAKE_INDEX_REWARD_6",
		"CAKE_INDEX_REWARD_7"
	}
	slot0.materialPreviewTbl_ = {
		"CAKE_INDEX_MATERIAL_1",
		"CAKE_INDEX_MATERIAL_2",
		"CAKE_INDEX_MATERIAL_3",
		"CAKE_INDEX_MATERIAL_4",
		"CAKE_INDEX_MATERIAL_5",
		"CAKE_INDEX_MATERIAL_6",
		"CAKE_INDEX_MATERIAL_7"
	}
	slot0.cakeClip_ = {
		"00",
		"01",
		"02",
		"03",
		"04",
		"05",
		"06",
		"07"
	}
	slot0.materialItem_ = {}
	slot0.rewardItem_ = CommonItem.New(slot0.rewardGo_)

	slot0.rewardItem_:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)

	slot0.rewardCon_ = {}

	for slot5, slot6 in ipairs(ActivityCelebrationCakeCfg.get_id_list_by_activity_id[slot0.params_.activityID]) do
		slot0.rewardCon_[slot5] = ControllerUtil.GetController(slot0["preRewardGo_" .. slot5].transform, "state")
	end

	slot0.OnMaterialUpdateHandler_ = handler(slot0, slot0.OnMaterialUpdate)
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.progressCon_ = ControllerUtil.GetController(slot0.transform_, "progress")
	slot0.rewardItemCon_ = ControllerUtil.GetController(slot0.rewardItem_.transform_, "completed")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.taskBtn_, nil, function ()
		JumpTools.OpenPageByJump("activityPushBoxReward", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.materialBtn_, nil, function ()
		JumpTools.OpenPageByJump("/activityPushBoxMaterial", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.makeBtn_, nil, function ()
		if uv0:IsComplete(uv0.curIndex_ + 1) then
			ActivityPushBoxAction.StartMaking(uv0.activityID_, uv0.curIndex_ + 1)
		end
	end)
	slot0:AddBtnListener(slot0.preViewBtn_, nil, function ()
		JumpTools.OpenPageByJump("activityPushBoxRewardPre", {
			activityID = uv0.activityID_
		})
	end)
end

function slot0.OnEnter(slot0)
	SetActive(slot0.countDownGo_, false)
	slot0.progressCon_:SetSelectedState(-1)

	slot0.activityID_ = slot0.params_.activityID

	manager.notify:RegistListener(MATERIAL_MODIFY, slot0.OnMaterialUpdateHandler_)
	slot0:BindRedPointUI()
	slot0:RefreshData()
	slot0:RefreshTime()
	slot0:RefreshUI()
	slot0:RefreshAni()
end

function slot0.RefreshData(slot0)
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
end

function slot0.RefreshTime(slot0)
	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.startTime_ then
		slot0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			if uv0.startTime_ <= manager.time:GetServerTime() then
				uv0:StopTimer()
				uv0:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot1 < slot0.stopTime_ then
		slot0.timeLable_.text = manager.time:GetLostTimeStr2(slot0.stopTime_)
		slot0.timer_ = Timer.New(function ()
			if uv0.stopTime_ <= manager.time:GetServerTime() then
				uv0:StopTimer()
				uv0:RefreshTime()

				return
			end

			uv0.timeLable_.text = manager.time:GetLostTimeStr2(uv0.stopTime_)
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeLable_.text = GetTips("TIME_OVER")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshUI(slot0)
	slot0:RefreshState()
	slot0:RefreshMaterial()
end

function slot0.RefreshState(slot0)
	slot0.curIndex_ = ActivityPushBoxData:GetCurIndex(slot0.activityID_)

	slot0.progressCon_:SetSelectedState(slot0.curIndex_)

	for slot4 = 1, slot0.curIndex_ do
		slot0.rewardCon_[slot4]:SetSelectedState("complete")
	end

	for slot4 = slot0.curIndex_ + 2, #slot0.rewardCon_ do
		slot0.rewardCon_[slot4]:SetSelectedState("uncomplete")
	end

	if slot0.curIndex_ >= #ActivityCelebrationCakeCfg.get_id_list_by_activity_id[slot0.activityID_] then
		slot0.makeBtn_.interactable = false
		slot0.cfg_ = ActivityCelebrationCakeCfg[slot1[slot0.curIndex_]]

		slot0.rewardItemCon_:SetSelectedState("true")

		slot0.rewardPreviewTxt_.text = GetTips(slot0.rewardPreviewTbl_[slot0.curIndex_])
		slot0.materialPreviewTxt_.text = GetTips(slot0.materialPreviewTbl_[slot0.curIndex_])

		slot0.stateCon_:SetSelectedState("finished")
	else
		slot0.rewardCon_[slot0.curIndex_ + 1]:SetSelectedState(slot0:IsComplete(slot0.curIndex_ + 1) and "current" or "uncomplete")

		slot0.makeBtn_.interactable = slot2
		slot0.cfg_ = ActivityCelebrationCakeCfg[slot1[slot0.curIndex_ + 1]]

		slot0.rewardItemCon_:SetSelectedState("false")

		slot0.rewardPreviewTxt_.text = GetTips(slot0.rewardPreviewTbl_[slot0.curIndex_ + 1])
		slot0.materialPreviewTxt_.text = GetTips(slot0.materialPreviewTbl_[slot0.curIndex_ + 1])

		slot0.stateCon_:SetSelectedState(slot0.curIndex_ == #slot0.rewardCon_ - 1 and "last" or "normal")
	end

	slot0.rewardItem_:RefreshData(formatReward(slot0.cfg_.award_list[1]))
end

function slot0.IsComplete(slot0, slot1)
	for slot8, slot9 in ipairs(ActivityCelebrationCakeCfg[ActivityCelebrationCakeCfg.get_id_list_by_activity_id[slot0.activityID_][slot1]].cost_list) do
		if ItemTools.getItemNum(slot9[1]) < slot9[2] then
			return false
		end
	end

	return true
end

function slot0.RefreshMaterial(slot0)
	for slot5, slot6 in ipairs(slot0.cfg_.cost_list) do
		if not slot0.materialItem_[slot5] then
			slot0.materialItem_[slot5] = RewardItem.New(slot0.materialTemplate_, slot0.materialParent_)

			slot0.materialItem_[slot5]:UpdateCommonItemAni()
		end

		slot0.materialItem_[slot5]:SetData(slot6)

		slot8 = slot6[2]
		slot9 = ItemTools.getItemNum(slot6[1])
		slot10 = slot9 .. "/" .. slot8

		if slot9 < slot8 then
			slot10 = string.format("<color=#FF0000>%d</color>", slot9) .. "/" .. slot8
		end

		slot0.materialItem_[slot5].commonItem_:SetBottomText(slot10)
		slot0.materialItem_[slot5].commonItem_:RegistCallBack(function ()
			ShowPopItem(POP_MERGE_ITEM, uv0)
		end)
	end

	for slot5 = #slot1 + 1, #slot0.materialItem_ do
		slot0.materialItem_[slot5]:Show(false)
	end
end

function slot0.RefreshAni(slot0)
	slot0.cakeAni_:Play(slot0.cakeClip_[slot0.curIndex_ + 1], -1, 1)
end

function slot0.OnPushBoxMakeCake(slot0, slot1)
	slot0.curIndex_ = ActivityPushBoxData:GetCurIndex(slot0.activityID_)

	slot0.cakeAni_:Play(slot0.cakeClip_[slot0.curIndex_ + 1], -1, 0)
	SetActive(slot0.countDownGo_.gameObject, true)

	slot0.makeBtn_.interactable = false

	if slot0.curIndex_ >= #slot0.rewardCon_ then
		manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_cake02")
	else
		manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_cake01")
	end

	slot0:RemoveTween()

	slot0.tween_ = LeanTween.value(uv0, 0, uv0):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0.countSlider_.fillAmount = 1 - slot0 / uv1
		uv0.countText_.text = string.format("%.2f", slot0)
	end)):setOnComplete(System.Action(function ()
		SetActive(uv0.countDownGo_.gameObject, false)

		if #uv1 > 0 then
			getReward(uv1, nil, , , true)
		end

		uv0:RefreshUI()
		uv0:RemoveTween()
	end))
end

function slot0.OnMaterialUpdate(slot0)
	slot0:RefreshMaterial()
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end
end

function slot0.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. ActivityConst.ACTIVITY_2_10_PUSH_BOX_TASK)
	manager.redPoint:bindUIandKey(slot0.makeBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX_MATERIAL .. "_" .. slot0.activityID_)
	manager.redPoint:bindUIandKey(slot0.materialBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX_FATIGUE .. "_" .. slot0.activityID_)
end

function slot0.UnbindRedPointUI(slot0)
	manager.redPoint:unbindUIandKey(slot0.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. ActivityConst.ACTIVITY_2_10_PUSH_BOX_TASK)
	manager.redPoint:unbindUIandKey(slot0.makeBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX_MATERIAL .. "_" .. slot0.activityID_)
	manager.redPoint:unbindUIandKey(slot0.materialBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX_FATIGUE .. "_" .. slot0.activityID_)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0:RemoveTween()
	slot0:UnbindRedPointUI()
	slot0.rewardItem_:OnExit()
	manager.windowBar:HideBar()

	for slot4, slot5 in ipairs(slot0.materialItem_) do
		slot5:OnExit()
	end

	manager.notify:RemoveListener(MATERIAL_MODIFY, slot0.OnMaterialUpdateHandler_)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.OnMaterialUpdateHandler_ = nil

	slot0.rewardItem_:Dispose()

	for slot4, slot5 in ipairs(slot0.materialItem_) do
		slot5:Dispose()
	end

	slot0.super.Dispose(slot0)
end

return slot0
