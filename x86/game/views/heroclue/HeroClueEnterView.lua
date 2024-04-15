slot1 = class("HeroClueEnterView", import("game.views.activity.Main.toggle.ActivityMainBasePanel"))

function slot1.GetUIName(slot0)
	return HeroClueTools.GetEnterViewUIName(slot0.activityID_)
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scrollView_, HeroClueTaskItem)
	slot0.taskUpdateHandler_ = handler(slot0, slot0.UpdateData)
	slot0.allReceiveController_ = ControllerUtil.GetController(slot0.transform_, "allReceive")
	slot0.taskActivityID_ = HeroClueTools.GetTaskActivityID(slot0.activityID_)
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.playBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		JumpTools.OpenPageByJump("/heroClueMain", {
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
			key = "ACTIVITY_HERO_CLUE_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_HERO_CLUE_DESC")
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
		manager.redPoint:bindUIandKey(slot0.playBtn_.transform, string.format("%s_%d", RedPointConst.HERO_CLUE_PLAY, slot0.activityID_))
		slot0:RegistEventListener(OSIRIS_TASK_UPDATE, slot0.taskUpdateHandler_)
	else
		manager.redPoint:unbindUIandKey(slot0.playBtn_.transform, string.format("%s_%s", RedPointConst.HERO_CLUE_PLAY, slot0.activityID_))
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
	HeroClueAction.UpdateDrawRedPoint(slot0.activityID_)
end

return slot1
