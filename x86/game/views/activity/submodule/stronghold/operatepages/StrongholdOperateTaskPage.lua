slot0 = class("StrongholdOperateTaskPage", StrongholdOperateBasePage)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.hander_ = slot1
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/VersionUI/XuHeng3rdUI/Stronghold/Operate/StrongholdNoteUI"), slot2)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:Refresh()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tabController = ControllerUtil.GetController(slot0.transform_, "tab")
	slot0.rewardController = ControllerUtil.GetController(slot0.transform_, "reward")
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_taskList, StrongholdOperateTaskItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_type1Btn, function ()
		if uv0:SelectTab(1) then
			uv0.m_animator:Play("Fx_messagebg_qiehuan", 0, 0)
		end
	end)
	slot0:AddBtnListener(nil, slot0.m_type2Btn, function ()
		if uv0:SelectTab(2) then
			uv0.m_animator:Play("Fx_messagebg_qiehuan", 0, 0)
		end
	end)
	slot0:AddBtnListener(nil, slot0.m_type3Btn, function ()
		if uv0:SelectTab(3) then
			uv0.m_animator:Play("Fx_messagebg_qiehuan", 0, 0)
		end
	end)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		TaskAction:SubmitTaskList(uv0._finishList)
	end)
end

function slot0.UpdateTaskData(slot0)
	slot0._taskIDList, slot0._finishList = slot0:GetTaskData(slot0.selectIndex)
end

function slot0.UpdateTaskRed(slot0)
	slot1, slot2 = slot0:GetTaskData(1)
	slot3, slot4 = slot0:GetTaskData(2)
	slot5, slot6 = slot0:GetTaskData(3)

	manager.redPoint:SetRedPointIndependent(slot0.m_type1Btn.transform, #slot2 > 0)
	manager.redPoint:SetRedPointIndependent(slot0.m_type2Btn.transform, #slot4 > 0)
	manager.redPoint:SetRedPointIndependent(slot0.m_type3Btn.transform, #slot6 > 0)
end

function slot0.GetTaskData(slot0, slot1)
	slot2, slot3 = nil

	if slot1 == 1 then
		slot2 = 711
		slot3 = 712
	elseif slot1 == 2 then
		slot2 = 721
		slot3 = 722
	else
		slot2 = 731
		slot3 = 732
	end

	slot4 = TaskTools:GetActivityTaskList(slot0.task_activity_id) or {}
	slot5 = clone(TaskTools.GetTaskList(slot4, slot2))

	table.insertto(slot5, TaskTools.GetTaskList(slot4, slot3))
	table.sort(slot5, function (slot0, slot1)
		slot5 = TaskData2:GetTask(slot1)

		if TaskData2:GetTask(slot0).complete_flag >= 1 == (slot5.complete_flag >= 1) then
			if AssignmentCfg[slot0].need <= slot4.progress == (AssignmentCfg[slot1].need <= slot5.progress) then
				return slot0 < slot1
			else
				return slot8
			end
		else
			return slot7
		end
	end)

	slot6 = {}

	for slot10, slot11 in ipairs(slot5) do
		if TaskData2:GetTask(slot11).complete_flag == 0 and AssignmentCfg[slot11].need <= slot13.progress then
			table.insert(slot6, slot11)
		end
	end

	return slot5, slot6
end

function slot0.SelectTab(slot0, slot1, slot2)
	if slot0.selectIndex == slot1 and not slot2 then
		return false
	end

	slot0.tabController:SetSelectedIndex(slot1 - 1)

	slot0.selectIndex = slot1

	slot0:UpdateTaskData()
	slot0.scrollHelper_:StartScroll(#slot0._taskIDList)
	slot0:RefreshRecivedAll()
	slot0:RefreshUI()

	return true
end

function slot0.RefreshUI(slot0)
	slot1 = slot0.selectIndex
	slot2, slot3, slot4, slot5 = StrongholdData:GetStrongholdLevel(slot1)
	slot0.m_lvname.text = ActivityStrongholdLevelCfg[slot2].level_des
	slot0.m_typeName.text = GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. slot1) .. " Lv." .. slot3

	if ActivityStrongholdLevelCfg[slot2 + 1] then
		slot9 = slot8.exp - slot6.exp
		slot0.m_expSlider.value = slot4 / slot9
		slot0.m_expLab.text = slot4 .. "/" .. slot9
		slot0.m_ceilLab.text = GetTips("ACTIVITY_STRONGHOLD_COIN_WEEK_CEIL") .. StrongholdData:GetWeeklyExp(slot0.activity_id, slot1) .. "/" .. StrongholdData:GetWeeklyMaxExp(slot0.activity_id, slot1)
	else
		slot0.m_expSlider.value = 1
		slot0.m_expLab.text = slot6.exp .. "/" .. slot6.exp
		slot0.m_ceilLab.text = GetTips("ACTIVITY_STRONGHOLD_SKILL_MAX")
	end
end

function slot0.Refresh(slot0, slot1)
	slot0.activity_id = slot1
	slot0.task_activity_id = 0

	for slot6, slot7 in ipairs(ActivityCfg[slot1].sub_activity_list) do
		if ActivityTemplateConst.TASK == ActivityCfg[slot7].activity_template then
			slot0.task_activity_id = slot7

			break
		end
	end

	if slot0.selectIndex == nil then
		slot0:SelectTab(1, true)
	else
		slot0:UpdateTaskData()
		slot0.scrollHelper_:Refresh()
		slot0:RefreshRecivedAll()
	end

	slot0:UpdateTaskRed()
end

function slot0.RefreshRecivedAll(slot0)
	if #slot0._finishList > 0 then
		slot0.rewardController:SetSelectedIndex(1)
	else
		slot0.rewardController:SetSelectedIndex(0)
	end
end

function slot0.OnTaskListChange(slot0)
	slot0:UpdateTaskData()
	slot0.scrollHelper_:StartScrollWithoutAnimator(#slot0._taskIDList, slot0.scrollHelper_:GetScrolledPosition())
	slot0:RefreshRecivedAll()
	slot0:UpdateTaskRed()
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.task_activity_id, slot0._taskIDList[slot1])
end

function slot0.OnCurrencyChange(slot0)
	slot0:RefreshUI()
end

return slot0
