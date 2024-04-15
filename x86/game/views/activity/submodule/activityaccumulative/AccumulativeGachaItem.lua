slot0 = class("AccumulativeGachaItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.drawstateController_ = slot0.itemControllerexcollection_:GetController("drawstate")
	slot0.showController_ = slot0.itemControllerexcollection_:GetController("show")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data = slot1

	slot0.showController_:SetSelectedState("state" .. tostring(3))

	if not slot0.commonItemView_ then
		slot0.commonItemView_ = CommonItemView.New(slot0.commonItem_)
	end

	slot3 = formatReward(ActivityPointRewardCfg[slot1.id].reward_item_list[1])

	CommonTools.SetCommonData(slot0.commonItemView_, {
		id = slot3.id,
		number = slot3.num,
		clickFun = function (slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
		end
	}, slot0.CommonData1)

	slot0.processText_.text = ActivityPointRewardCfg[slot1.id].need

	slot0.drawstateController_:SetSelectedState(tostring(slot1.state + 1))
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.bg01Btn_, nil, function ()
		if ActivityPointRewardCfg[uv0.data.id] and ActivityAccumulativeData:GetNum() < slot0.need then
			ShowTips("ACTIVITY_ACCUMULATIVE_TIPS")

			return
		end

		ActivityAccumulativeAction.GetAccumulateReward(uv0.data.id)
	end)
end

function slot0.RefreshBtnState(slot0)
end

function slot0.AddTimer(slot0)
end

return slot0
