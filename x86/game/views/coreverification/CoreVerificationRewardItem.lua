slot0 = class("CoreVerificationRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		CoreVerificationAction.GetReward({
			reward_list = {
				uv0.data_
			}
		})
		uv0.controller_:SetSelectedState("complete")
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItems_ = {}
	slot0.controller_ = slot0.allBtnController_:GetController("all")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.type_ = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot2 = ConditionCfg[CoreVerificationRewardCfg[slot0.data_].condition]
	slot0.titleText_.text = string.format(GetI18NText(slot2.desc), slot2.params[1])
	slot3, slot4, slot5, slot6 = CoreVerificationData:GetTaskProcess(slot0.data_)
	slot0.progressBar_.value = slot3 / slot4
	slot0.progressText_.text = string.format("%s/%s", slot3, slot4)

	if slot6 then
		slot0.controller_:SetSelectedState("complete")
	elseif slot5 then
		slot0.controller_:SetSelectedState("receive")
	else
		slot0.controller_:SetSelectedState("lock")
	end

	for slot11, slot12 in ipairs(slot1.reward or {}) do
		slot13 = formatReward(slot12)
		slot14 = clone(ItemTemplateData)

		if slot0.rewardItems_[slot11] == nil then
			slot0.rewardItems_[slot11] = CommonItemView.New(slot0[string.format("awardItem%dObj_", slot11)])

			slot0.rewardItems_[slot11].ResetTransform = function ()
			end
		end

		slot14.id = slot13.id
		slot14.number = slot13.num
		slot14.timeValid = slot12.timeValid or 0
		slot14.completedFlag = slot0.taskComplete_
		slot14.clickFun = handler(slot0, slot0.OnClickCommonItem)

		slot0.rewardItems_[slot11]:SetData(slot14)
	end

	for slot11 = #slot1.reward + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot11]:SetData(nil)
	end
end

function slot0.OnClickCommonItem(slot0, slot1)
	ShowPopItem(POP_ITEM, {
		slot1.id,
		slot1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = {}

	uv0.super.Dispose(slot0)
end

return slot0
