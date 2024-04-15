slot0 = class("ActivityQuestSubView", BaseView)
slot1 = {
	inProgress = 1,
	done = 0,
	complete = 2
}

function slot2()
	return true
end

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	uv0.super.Ctor(slot0, slot1)

	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.itemCls = slot4
	slot0.activity = slot2
	slot0.taskFilter = slot3 or uv1
	slot0.showSubmitAll = slot5

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.questList = LuaList.New(handler(slot0, slot0.UpdateQuestItem), slot0.questList_, slot0.itemCls)

	if slot0.showSubmitAll then
		slot0.clearController = ControllerUtil.GetController(slot0.transform_, "clear")

		slot0:AddBtnListenerScale(slot0.receiveBtn_, nil, function ()
			slot0 = {}

			for slot4, slot5 in ipairs(uv0.quests) do
				if slot5.status == uv1.complete then
					table.insert(slot0, slot5.id)
				end
			end

			TaskAction:SubmitTaskList(slot0)
		end)
	end
end

function slot0.UpdateQuestItem(slot0, slot1, slot2)
	slot3 = slot0.quests[slot1]

	slot2:SetData(slot3.id, slot3.activityID)

	if slot0.OnQuestItemRender then
		slot0:OnQuestItemRender(slot4, slot2, slot1)
	end
end

function slot0.RefreshAllTask(slot0)
	slot0.quests = {}
	slot1 = 0

	for slot7, slot8 in pairs(TaskData2:GetActivityTaskSortList(slot0.activity)) do
		if slot0.taskFilter(slot8) then
			slot9 = uv0.inProgress

			if slot8.complete_flag >= 1 then
				slot9 = uv0.done
			elseif AssignmentCfg[slot8.id].need <= slot8.progress then
				slot9 = uv0.complete
				slot1 = slot1 + 1
			end

			table.insert(slot0.quests, {
				id = slot8.id,
				activityID = AssignmentCfg[slot8.id].activity_id,
				status = slot9
			})
		end
	end

	slot0.completeQuest = slot1

	if slot0.showSubmitAll then
		if slot1 > 0 then
			slot0.clearController:SetSelectedState("true")
		else
			slot0.clearController:SetSelectedState("false")
		end
	end

	slot0.questList:StartScroll(#slot0.quests)
end

function slot0.OnEnter(slot0)
	slot0:RefreshAllTask()
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(slot0, slot0.RefreshAllTask))
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	if slot0.questList then
		slot0.questList:Dispose()

		slot0.questList = nil
	end

	slot0.quests = nil

	uv0.super.Dispose(slot0)
end

return slot0
