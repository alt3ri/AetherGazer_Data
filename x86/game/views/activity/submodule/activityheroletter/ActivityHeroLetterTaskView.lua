slot0 = class("ActivityHeroLetterTaskView", ReduxView)

function slot0.UIName(slot0)
	return ActivityHeroLetterTools.GetTaskUIName(slot0.params_.activityID)
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

	slot0.onSubmitTaskResponseHandle_ = handler(slot0, slot0.OnTaskRefresh)
	slot0.stateCon_ = slot0.conCollecter_:GetController("state")
	slot0.lockCon_ = slot0.rewardCollecter_:GetController("lock")
	slot0.rewardCon_ = slot0.rewardCollecter_:GetController("reward")
	slot0.rewardGo_ = {}
	slot0.rewardItem_ = {}

	for slot4 = 1, 3 do
		slot0.rewardGo_[slot4] = slot0["rewardGo_" .. slot4]
		slot0.rewardItem_[slot4] = CommonItemView.New(slot0.rewardGo_[slot4])
	end
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		TaskAction:SubmitTask(uv0.taskID_)
	end)
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, slot0.onSubmitTaskResponseHandle_)
	slot0.lockCon_:SetSelectedState("on")
	slot0:RefreshUI()
	slot0:RefreshTask()
end

function slot0.RefreshUI(slot0)
	slot0.id_ = slot0.params_.id
	slot0.cfg_ = ActivityHeroTaskCfg[slot0.id_]
	slot1 = slot0.cfg_.hero_id
	slot0.name2_.text = HeroCfg[slot1].suffix
	slot0.name1_.text = string.format(GetTips("ACTIVITY_HERO_TASK_REWARD"), HeroCfg[slot1].suffix)
	slot0.icon_.sprite = getSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. slot1)
	slot0.desc_.text = slot0.cfg_.desc

	slot0.rewardCon_:SetSelectedState(ActivityHeroLetterTools.IsReward(slot0.id_) and "on" or "off")
end

function slot0.RefreshTask(slot0)
	slot0.taskID_ = slot0.cfg_.task_id
	slot1 = AssignmentCfg[slot0.taskID_]
	slot0.taskDesc_.text = slot1.desc
	slot4 = slot1.need < TaskData2:GetTask(slot0.taskID_).progress and slot3 or slot2.progress
	slot0.progress_.text = slot4 .. "/" .. slot3
	slot0.slider_.value = slot4 / slot3
	slot5 = slot1.reward or {}

	for slot9, slot10 in ipairs(slot5) do
		slot11 = clone(ItemTemplateData)
		slot11.id = slot10[1]
		slot11.number = slot10[2]

		function slot11.clickFun()
			ShowPopItem(POP_ITEM, {
				uv0.id
			})
		end

		slot0.rewardItem_[slot9]:SetData(slot11)
	end

	for slot9 = #slot5 + 1, #slot0.rewardItem_ do
		slot0.rewardItem_[slot9]:SetData()
	end

	if slot2.complete_flag == 1 then
		slot0.stateCon_:SetSelectedState("complete")
	elseif slot3 <= slot4 then
		slot0.stateCon_:SetSelectedState("get")
	else
		slot0.stateCon_:SetSelectedState("unfinished")
	end
end

function slot0.OnTaskRefresh(slot0)
	slot0:RefreshUI()
	slot0:RefreshTask()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, slot0.onSubmitTaskResponseHandle_)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.rewardItem_) do
		slot5:Dispose()
	end

	slot0.super.Dispose(slot0)
end

return slot0
