slot0 = class("XH3rdWaterMainRewardItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.statusController_:GetSelectedState() == "finish" then
			ActivityWaterAction.GetTotalAssistantReward(ActivityWaterData:GetCurrentSchedule(uv0.activityId_).schedule_id, ActivityWaterData:GetCurrentAssistantRole(uv0.activityId_), {
				uv0.rewardData_[1]
			}, {
				{
					uv0.rewardData_[2],
					uv0.rewardData_[3]
				}
			})
		end
	end)
	slot0.commonItem_:RegistCallBack(function (slot0)
		if uv0.statusController_:GetSelectedState() == "finish" then
			ActivityWaterAction.GetTotalAssistantReward(ActivityWaterData:GetCurrentSchedule(uv0.activityId_).schedule_id, ActivityWaterData:GetCurrentAssistantRole(uv0.activityId_), {
				uv0.rewardData_[1]
			}, {
				{
					uv0.rewardData_[2],
					uv0.rewardData_[3]
				}
			})
		else
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
		end
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(ACTIVITY_WATER_TOTAL_ASSISTANT_REWARD_UPDATE, function ()
		uv0:UpdateView()
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.activityId_ = slot2
	slot0.rewardData_ = slot3

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	if ActivityWaterData:GetCurrentAssistantRoleProcess(slot0.activityId_) < slot0.rewardData_[1] then
		slot0.statusController_:SetSelectedState("notFinish")
	elseif ActivityWaterData:HaveGetTotalProgressReward(slot0.activityId_, slot0.rewardData_[1]) then
		slot0.statusController_:SetSelectedState("haveGet")
	else
		slot0.statusController_:SetSelectedState("finish")
	end

	slot0.valueText_.text = NumberTools.FormatNumberWithThousandsSeparator(slot0.rewardData_[1])

	slot0.commonItem_:RefreshData({
		id = slot0.rewardData_[2],
		number = slot0.rewardData_[3]
	})
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
