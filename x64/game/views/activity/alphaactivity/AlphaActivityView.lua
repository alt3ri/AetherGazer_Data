local var_0_0 = class("AlphaActivityView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Alpha/PhaseActivityUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.taskItems_ = {}
	arg_4_0.generalTask_ = AlphaStageTaskItem.New(arg_4_0.generalTaskGo_)
	arg_4_0.itemPool_ = Pool.New(arg_4_0.taskItemTemplate_, arg_4_0.taskItemContent_, 0)
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.taskItemScroll_, AlphaTaskItem)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.leftBtn_:GetComponent(typeof(Button)), nil, function()
		arg_5_0:RefreshContent(arg_5_0.stage_ - 1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.rightBtn_:GetComponent(typeof(Button)), nil, function()
		arg_5_0:RefreshContent(arg_5_0.stage_ + 1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.phaseBtn_, nil, function()
		JumpTools.OpenPageByJump("PopupPhaseActivityUI")
	end)
	arg_5_0:AddDragListener(arg_5_0.scrollGo_, function()
		return
	end, function()
		return
	end, function(arg_11_0, arg_11_1)
		arg_5_0:RefreshContentByDrag(arg_11_0, arg_11_1)
	end)
	arg_5_0:AddDragListener(arg_5_0.backGo_, function()
		return
	end, function()
		return
	end, function(arg_14_0, arg_14_1)
		arg_5_0:RefreshContentByDrag(arg_14_0, arg_14_1)
	end)
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.stage_ = arg_15_0:GetAlphaTaskStage()

	arg_15_0.generalTask_:OnEnter()

	for iter_15_0 = 1, #arg_15_0.taskItems_ do
		arg_15_0.taskItems_[iter_15_0]:OnEnter()
	end

	arg_15_0:RefreshContent(arg_15_0.stage_)
end

function var_0_0.GetAlphaTaskStage(arg_16_0)
	return TaskData2:GetAssignmentPhase()
end

function var_0_0.GetTaskList(arg_17_0)
	local var_17_0 = {
		stageTask = {}
	}
	local var_17_1 = TaskData2:GetTypedTaskSortList(TaskConst.TASK_TYPE.ALPHA)

	for iter_17_0, iter_17_1 in pairs(var_17_1) do
		if AssignmentCfg[iter_17_1.id].type == TaskConst.TASK_TYPE.ALPHA then
			local var_17_2 = AssignmentCfg[iter_17_1.id].phase

			if not var_17_0[var_17_2] then
				var_17_0[var_17_2] = {}
			end

			if AssignmentCfg[iter_17_1.id].condition == TaskConst.STAGE_TASK_ID and AssignmentCfg[iter_17_1.id].additional_parameter[1] == TaskConst.TASK_TYPE.ALPHA then
				var_17_0.stageTask[var_17_2] = iter_17_1.id
			else
				var_17_0[var_17_2][#var_17_0[var_17_2] + 1] = TaskData2:GetTask(iter_17_1.id)
			end
		end
	end

	return var_17_0
end

function var_0_0.GetTaskIDByStage(arg_18_0, arg_18_1)
	return arg_18_0:GetTaskList().stageTask[arg_18_1]
end

function var_0_0.GetStage(arg_19_0)
	return arg_19_0.stage_
end

function var_0_0.indexItem(arg_20_0, arg_20_1, arg_20_2)
	arg_20_2:RefreshUI(arg_20_0.sortedList_[arg_20_1].id)
end

function var_0_0.RefreshContentByDrag(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 == 0 then
		return
	end

	if math.abs(arg_21_1) > UnityEngine.Screen.width then
		return
	end

	if math.abs(arg_21_2) > UnityEngine.Screen.height then
		return
	end

	if math.abs(arg_21_2 / arg_21_1) < 0.5773 then
		if arg_21_1 > 0 then
			arg_21_0:RefreshContent(arg_21_0.stage_ + 1)

			return
		end

		if arg_21_1 < 0 then
			arg_21_0:RefreshContent(arg_21_0.stage_ - 1)

			return
		end
	end
end

function var_0_0.RefreshContent(arg_22_0, arg_22_1)
	if arg_22_1 > TaskConst.ALPHA_LAST_STAGE then
		arg_22_0:RefreshContent(TaskConst.ALPHA_LAST_STAGE)

		return
	end

	if arg_22_1 < 1 then
		arg_22_0:RefreshContent(1)

		return
	end

	arg_22_0.sortedList_ = arg_22_0:SortedTask(arg_22_1)
	arg_22_0.stage_ = arg_22_1
	arg_22_0.titleText_.text = GetI18NText(AssignmentCfg[arg_22_0:GetTaskIDByStage(arg_22_1)].desc)

	arg_22_0.generalTask_:RefreshUI(arg_22_0:GetTaskIDByStage(arg_22_1))
	arg_22_0.scrollHelper_:StartScroll(#arg_22_0.sortedList_)

	if arg_22_1 > arg_22_0:GetAlphaTaskStage() then
		ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), AssignmentCfg[arg_22_0:GetTaskList().stageTask[arg_22_1 - 1]].desc))
	end

	if arg_22_1 <= 1 then
		SetActive(arg_22_0.leftBtn_, false)
	elseif arg_22_1 >= TaskConst.ALPHA_LAST_STAGE then
		SetActive(arg_22_0.rightBtn_, false)
	else
		SetActive(arg_22_0.leftBtn_, true)
		SetActive(arg_22_0.rightBtn_, true)
	end
end

function var_0_0.SortedTask(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetTaskList()[arg_23_1]
	local var_23_1 = {}
	local var_23_2 = {}
	local var_23_3 = {}

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if iter_23_1.complete_flag < 1 then
			if AssignmentCfg[iter_23_1.id].need <= iter_23_1.progress then
				table.insert(var_23_1, iter_23_1)
			else
				table.insert(var_23_2, iter_23_1)
			end
		else
			table.insert(var_23_3, iter_23_1)
		end
	end

	local var_23_4 = {}

	local function var_23_5(arg_24_0, arg_24_1)
		return arg_24_0.id < arg_24_1.id
	end

	table.sort(var_23_1, var_23_5)
	table.sort(var_23_2, var_23_5)
	table.sort(var_23_3, var_23_5)
	table.insertto(var_23_4, var_23_1)
	table.insertto(var_23_4, var_23_2)
	table.insertto(var_23_4, var_23_3)

	return var_23_4
end

function var_0_0.RefreshIcon(arg_25_0)
	local var_25_0 = AssignmentCfg[arg_25_0:GetTaskIDByStage(arg_25_0.stage_)].reward[1][1]

	if ItemCfg[var_25_0].type == ItemConst.ITEM_TYPE.HERO then
		arg_25_0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. var_25_0)
	else
		arg_25_0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Item_l" .. var_25_0)
	end
end

function var_0_0.OnTaskListChange(arg_26_0)
	if arg_26_0:GetAlphaTaskStage() > TaskConst.ALPHA_LAST_STAGE then
		arg_26_0:RefreshContent(TaskConst.ALPHA_LAST_STAGE)

		return
	end

	arg_26_0:RefreshContent(arg_26_0:GetAlphaTaskStage())
end

function var_0_0.OnTop(arg_27_0)
	arg_27_0:ShowDefaultBar()
end

function var_0_0.OnExit(arg_28_0)
	arg_28_0.generalTask_:OnExit()

	for iter_28_0 = 1, #arg_28_0.taskItems_ do
		arg_28_0.taskItems_[iter_28_0]:OnExit()
	end

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_29_0)
	arg_29_0:RemoveAllListeners()

	for iter_29_0 = 1, #arg_29_0.taskItems_ do
		arg_29_0.taskItems_[iter_29_0]:Dispose()
	end

	arg_29_0.generalTask_:Dispose()
	arg_29_0.itemPool_:Dispose()
	arg_29_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_29_0)
end

return var_0_0
