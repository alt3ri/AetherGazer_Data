slot1 = class("TangramPuzzleTaskView", import("game.views.activity.Main.toggle.ActivityMainBasePanel"))

function slot1.GetUIName(slot0)
	return TangramPuzzleTools.GetTaskUIName(slot0.activityID_)
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scrollView_, PuzzleNewTaskItem)
	slot0.taskUpdateHandler_ = handler(slot0, slot0.UpdateData)
	slot0.allReceiveController_ = ControllerUtil.GetController(slot0.transform_, "allReceive")

	for slot5, slot6 in ipairs(ActivityCfg[slot0.activityID_].sub_activity_list) do
		if ActivityCfg[slot6].activity_template == ActivityTemplateConst.TASK then
			slot0.taskActivityID_ = slot6

			break
		end
	end
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.playBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		uv0:Go("/tangramPuzzlePlay", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.allReceiveBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		slot0 = {}

		for slot4, slot5 in ipairs(uv0.taskDataList_) do
			if slot5.progress < AssignmentCfg[slot5.id].need or slot5.complete_flag >= 1 then
				break
			end

			slot0[#slot0 + 1] = slot5.id
		end

		TaskAction:SubmitTaskList(slot0)
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_PUZZLE_III_EXPLAIN",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_PUZZLE_III_EXPLAIN")
		})
	end)
end

function slot1.Dispose(slot0)
	slot0.taskUpdateHandler_ = nil

	slot0.scrollHelper_:Dispose()

	slot0.scrollHelper_ = nil

	slot0:StopTimer()
	uv0.super.Dispose(slot0)
end

function slot1.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 == true then
		slot0:RefreshUI()
		slot0:RegistEventListener(OSIRIS_TASK_UPDATE, slot0.taskUpdateHandler_)
	else
		slot0:RemoveAllEventListener()
	end
end

function slot1.RefreshUI(slot0)
	slot0.taskDataList_ = TaskData2:GetActivityTaskSortList(slot0.taskActivityID_)

	slot0.scrollHelper_:StartScroll(#slot0.taskDataList_)
	slot0:RefreshReceiveBtn()
end

function slot1.RefreshReceiveBtn(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(slot0.taskDataList_) do
		if AssignmentCfg[slot6.id].need <= slot6.progress and slot6.complete_flag < 1 then
			slot1 = 1

			break
		end
	end

	slot0.allReceiveController_:SetSelectedIndex(slot1)
end

function slot1.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskDataList_[slot1].id, slot0.taskActivityID_)
end

function slot1.UpdateData(slot0)
	slot0:RefreshUI()
end

function slot1.RefreshTimeText(slot0)
	if slot0.timeText_ then
		slot0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(slot0.stopTime_, true)
	end
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.playBtnTrans_, string.format("%s_%d", RedPointConst.TANGRAM_PUZZLE_CLUE, slot0.activityID_))
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.playBtnTrans_, string.format("%s_%s", RedPointConst.TANGRAM_PUZZLE_CLUE, slot0.activityID_))
end

return slot1
