slot0 = class("NewServerBPTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()

	slot0.normalRewardList_ = {}
	slot0.normalItemDataList_ = {}
	slot0.upgradeRewardList_ = {}
	slot0.upgradeItemDataList_ = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.progressController_ = slot0.controllerEx_:GetController("active")
	slot0.progressHeadController_ = slot0.controllerEx_:GetController("isHead")
end

function slot0.AddUIListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.taskID_ = slot1
	slot0.activityID_ = slot2
	slot0.isHead_ = slot3
	slot8 = 0
	slot9 = 0

	if NewServerBPTaskCfg[slot0.taskID_].need <= NewServerData:GetAccumulateCurrency() then
		slot8 = NewServerData:GetBPTaskStatus()[slot1] and slot10[slot1].is_receive_reward == 1 and 2 or 1

		if NewServerData:GetBPTaskIsRecharge() >= 1 then
			slot9 = slot10[slot1] and slot10[slot1].is_receive_recharge_reward == 1 and 2 or 1
		end
	end

	for slot14, slot15 in ipairs(NewServerBPTaskCfg[slot0.taskID_].reward) do
		if not slot0.normalRewardList_[slot14] then
			slot0.normalRewardList_[slot14] = CommonItemView.New(slot0.normalRewardPanel_:GetChild(slot14 - 1).gameObject)
		end

		if not slot0.normalItemDataList_[slot14] then
			slot0.normalItemDataList_[slot14] = clone(ItemTemplateData)
			slot0.normalItemDataList_[slot14].clickFun = handler(slot0, slot0.OnClickReward)
		end

		slot0.normalItemDataList_[slot14].id = slot15[1]
		slot0.normalItemDataList_[slot14].number = slot15[2]
		slot0.normalItemDataList_[slot14].highLight = slot8 == 1
		slot0.normalItemDataList_[slot14].completedFlag = slot8 == 2

		slot0.normalRewardList_[slot14]:SetData(slot0.normalItemDataList_[slot14])
	end

	for slot15, slot16 in ipairs(NewServerBPTaskCfg[slot0.taskID_].recharge_reward) do
		if not slot0.upgradeRewardList_[slot15] then
			slot0.upgradeRewardList_[slot15] = CommonItemView.New(slot0.upgradeRewardPanel_:GetChild(slot15 - 1).gameObject)
		end

		if not slot0.upgradeItemDataList_[slot15] then
			slot0.upgradeItemDataList_[slot15] = clone(ItemTemplateData)
			slot0.upgradeItemDataList_[slot15].clickFun = handler(slot0, slot0.OnClickReward)
		end

		slot0.upgradeItemDataList_[slot15].id = slot16[1]
		slot0.upgradeItemDataList_[slot15].number = slot16[2]
		slot0.upgradeItemDataList_[slot15].highLight = slot9 == 1
		slot0.upgradeItemDataList_[slot15].completedFlag = slot9 == 2
		slot0.upgradeItemDataList_[slot15].locked = slot5 < 1

		slot0.upgradeRewardList_[slot15]:SetData(slot0.upgradeItemDataList_[slot15])
	end

	slot0.progressController_:SetSelectedState(slot6 <= slot7 and "true" or "false")
	slot0.progressHeadController_:SetSelectedState(tostring(slot0.isHead_))

	slot0.targetText_.text = slot6
	slot12, slot13 = nil

	if slot4 then
		slot12 = slot6 - NewServerBPTaskCfg[slot4].need
		slot13 = slot7 - NewServerBPTaskCfg[slot4].need
	else
		slot12 = slot6
		slot13 = slot7
	end

	if slot13 / slot12 < 0 then
		slot14 = 0
	elseif slot14 > 1 then
		slot14 = 1
	end

	if slot3 then
		slot0.headSlider_.value = slot14
	else
		slot0.middleSlider_.value = slot14
	end
end

function slot0.OnClickReward(slot0, slot1)
	if not ActivityTools.ActivityOpenCheck(slot0.activityID_) then
		return
	end

	if #slot0:GetCanReceiveTaskList() > 0 then
		NewServerAction.ReceiveBPReward(slot2, slot0.receiveHandler_)

		return true
	else
		ShowPopItem(POP_ITEM, {
			slot1.id,
			slot1.number
		})
	end

	return false
end

function slot0.GetCanReceiveTaskList(slot0)
	slot1 = {}
	slot3 = NewServerData:GetBPTaskStatus()
	slot4 = NewServerData:GetBPTaskIsRecharge()

	for slot9, slot10 in ipairs(NewServerCfg[slot0.activityID_].bp) do
		if NewServerBPTaskCfg[slot10].need <= NewServerData:GetAccumulateCurrency() then
			if slot3[slot10] then
				if slot3[slot10].is_receive_reward < 1 then
					slot1[#slot1 + 1] = {
						receive_type = 1,
						id = slot10
					}
				end

				if slot4 >= 1 and slot3[slot10].is_receive_recharge_reward < 1 then
					slot1[#slot1 + 1] = {
						receive_type = 2,
						id = slot10
					}
				end
			else
				slot1[#slot1 + 1] = {
					receive_type = 1,
					id = slot10
				}

				if slot4 >= 1 then
					slot1[#slot1 + 1] = {
						receive_type = 2,
						id = slot10
					}
				end
			end
		end
	end

	return slot1
end

function slot0.SetReceiveHandler(slot0, slot1)
	slot0.receiveHandler_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.upgradeRewardList_ then
		for slot4, slot5 in ipairs(slot0.upgradeRewardList_) do
			slot5:Dispose()
		end

		slot0.upgradeRewardList_ = nil
	end

	if slot0.normalRewardList_ then
		for slot4, slot5 in ipairs(slot0.normalRewardList_) do
			slot5:Dispose()
		end

		slot0.normalRewardList_ = nil
	end

	slot0.receiveHandler_ = nil
end

return slot0
