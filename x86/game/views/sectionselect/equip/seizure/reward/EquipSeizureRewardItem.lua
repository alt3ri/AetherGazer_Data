slot0 = class("EquipSeizureRewardItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.rewardItemList_ = {}
	slot0.controller_ = slot0.controlExCo_:GetController("status")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		uv0:ClickItem()
	end)
end

function slot0.ClickItem(slot0)
	EquipSeizureAction.SendReceiveReward({
		slot0.rewardID_
	}, function (slot0)
		if isSuccess(slot0.result) then
			manager.notify:Invoke(EQUIP_SEIZURE_REWARD)
		end
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil
end

function slot0.SetData(slot0, slot1)
	slot2 = EquipSeizurePointRewardCfg[slot1]
	slot0.rewardList_ = slot2.reward_item_list
	slot0.descText_.text = string.format(GetTips("EQUIP_SEIZURE_POINT_REWARD_DESC"), slot2.need)
	slot0.rewardID_ = slot1

	slot0:RefreshBtn()
	slot0:RefreshRewardItem()
end

function slot0.RefreshRewardItem(slot0)
	for slot4, slot5 in ipairs(slot0.rewardList_) do
		slot6 = clone(ItemTemplateData)
		slot6.id = slot5[1]
		slot6.number = slot5[2]

		function slot6.clickFun(slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
		end

		if slot0.rewardItemList_[slot4] then
			slot0.rewardItemList_[slot4]:SetData(slot6)
		else
			slot0.rewardItemList_[slot4] = CommonItemPool.New(slot0.rewardParent_, slot6)
		end
	end

	for slot4 = #slot0.rewardList_ + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot4]:Show(false)
	end
end

function slot0.RefreshBtn(slot0)
	if table.keyof(EquipSeizureData:GetReceiveList(), slot0.rewardID_) then
		slot0.controller_:SetSelectedState("haveGet")
	elseif table.keyof(EquipSeizureData:GetCanReceiveList(), slot0.rewardID_) then
		slot0.controller_:SetSelectedState("canGet")
	else
		slot0.controller_:SetSelectedState("cannotGet")
	end
end

return slot0
