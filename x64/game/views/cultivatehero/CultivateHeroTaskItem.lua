slot0 = class("CultivateHeroTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.rewardState_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		CultivateHeroAction.RequireReceiveHeroTaskList(uv0.activityID_, {
			uv0.taskID_
		}, function ()
			uv0.onReceived_()
		end)
	end)
end

function slot0.Dispose(slot0)
	slot0.onReceived_ = nil

	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.taskID_ = slot2

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshDesc()
	slot0:RefreshState()
	slot0:RefreshItem()
end

function slot0.RefreshDesc(slot0)
	slot1 = CultivateHeroTaskCfg[slot0.taskID_]
	slot0.descText_.text = GetI18NText(slot1.desc)
	slot4 = slot1.condition

	if CultivateHeroData:GetHeroTaskInfoList(slot0.activityID_)[slot0.taskID_] and slot3.progress and slot3.progress < slot2 then
		slot4 = slot3.progress
	end

	slot0.progressText_.text = string.format("%d/%d", slot4, slot2)
	slot0.progressSlider_.value = slot4 / slot2
end

function slot0.RefreshItem(slot0)
	slot0.rewardCfg_ = CultivateHeroTaskCfg[slot0.taskID_].reward[1]

	if slot0.commonItem_ == nil then
		slot0.commonItem_ = CommonItemView.New(slot0.rewardItemGo_)
		slot0.itemData_ = clone(ItemTemplateData)

		function slot0.itemData_.clickFun(slot0)
			ShowPopItem(POP_ITEM, slot0)
		end
	end

	slot0.itemData_.id = slot0.rewardCfg_[1]
	slot0.itemData_.number = slot0.rewardCfg_[2]

	slot0.commonItem_:SetData(slot0.itemData_)
end

function slot0.RefreshState(slot0)
	slot1 = CultivateHeroData:GetHeroTaskInfoList(slot0.activityID_)
	slot3 = slot1[slot0.taskID_].isReceived

	if not slot1[slot0.taskID_].isCompleted then
		slot0.rewardState_:SetSelectedState("uncomplete")
	elseif not slot3 then
		slot0.rewardState_:SetSelectedState("unreceive")
	else
		slot0.rewardState_:SetSelectedState("received")
	end
end

function slot0.SetReveivedHandler(slot0, slot1)
	slot0.onReceived_ = slot1
end

return slot0
