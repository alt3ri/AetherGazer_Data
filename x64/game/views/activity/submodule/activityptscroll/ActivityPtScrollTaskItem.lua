slot0 = class("ActivityPtScrollTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItems_ = {}
	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.taskID_ == 0 then
			ActivityPtScrollAction.TryToSubmitScrollTask(uv0.activityID_)
		else
			TaskAction:SubmitTask(uv0.taskID_)
		end
	end)
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.taskID_ = slot1
	slot0.activityID_ = slot2
	slot0.taskActivityID_ = ActivityPtScrollTools.GetTaskActivityID(slot0.activityID_)
	slot0.info_ = TaskData2:GetTask(slot0.taskID_)
	slot0.cfg_ = AssignmentCfg[slot1]

	if slot0.taskID_ == 0 then
		slot0:RefreshInfinityTask()
	else
		slot0:RefreshNormalTask()
	end
end

function slot0.RefreshInfinityTask(slot0)
	slot2 = ActivityPtScrollData:GetClearTime(slot0.activityID_)
	slot0.desc_.text = string.format(GetTips("ACTIVITY_ROULETTE_TASK_DESC"), GameSetting.activity_pt_roulette_task_times.value[1])

	slot0.typeCon_:SetSelectedState("infinity")

	slot3, slot4 = nil

	for slot9, slot10 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[slot0.activityID_]) do
		if ActivityPtRouletteStageCfg[slot10].mode == 2 then
			slot12 = slot11.cost
			slot4 = slot12[2]
			slot3 = slot12[1]

			break
		end
	end

	slot0:RefreshReward({
		{
			slot3,
			slot4
		}
	})

	slot0.progress_.text = slot2 .. "/" .. slot1
	slot0.slider_.value = slot1 < slot2 and 1 or slot2 / slot1

	if slot1 <= slot2 then
		slot0.stateCon_:SetSelectedState("complete")
	else
		slot0.stateCon_:SetSelectedState("unfinish")
	end
end

function slot0.RefreshNormalTask(slot0)
	slot1 = TaskData2:GetTask(slot0.taskID_)
	slot2 = AssignmentCfg[slot0.taskID_]
	slot0.desc_.text = slot2.desc

	if slot2.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		slot0.typeCon_:SetSelectedState("normal")
	else
		slot0.typeCon_:SetSelectedState("challenge")
	end

	slot0:RefreshReward(slot2.reward)

	slot5 = slot2.need < slot1.progress and slot4 or slot1.progress
	slot0.progress_.text = slot5 .. "/" .. slot4
	slot0.slider_.value = slot5 / slot4

	if slot1.complete_flag >= 1 then
		slot0.stateCon_:SetSelectedState("received")
	elseif slot2.need <= slot1.progress then
		slot0.stateCon_:SetSelectedState("complete")
	else
		slot0.stateCon_:SetSelectedState("unfinish")
	end
end

function slot0.RefreshReward(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if not slot0.rewardItems_[slot5] then
			slot0.rewardItems_[slot5] = CommonItemView.New(Object.Instantiate(slot0.rewardItem_, slot0.rewardParent_))
		end

		slot7 = cfgToItemTemplate(slot6)

		function slot7.clickFun(slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id
			})
		end

		slot0.rewardItems_[slot5]:SetData(slot7)
		slot0.rewardItems_[slot5].countdownController_:SetSelectedState("false")
	end

	for slot5 = #slot1 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot5]:Show(false)
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot4]:Dispose()
	end

	slot0.super.Dispose(slot0)
end

return slot0
