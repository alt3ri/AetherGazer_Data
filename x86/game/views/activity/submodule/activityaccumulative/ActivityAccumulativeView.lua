ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("ActivityAccumulativeView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_AccumulateUI/NorseUI_3_0_AccumulateUI"
end

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.nodeList = {}
	slot0.drawIndex = 0
	slot0.taskUpdateHandler_ = handler(slot0, slot0.TaskUpdate)
	slot0.controller_ = slot0.lastControllerexcollection_:GetController("default0")
	slot0.taskScroll_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uilistUilist_, AccumulativeGachaItem)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot0.tasklist[slot1], slot1)

	slot3 = slot0.tasklist[slot1] and slot0.tasklist[slot1].state or 0
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:TaskUpdate()

	slot0.contentTrs_.localPosition = Vector3.New(-222 * slot0.drawIndex, 0, 0)

	manager.notify:RegistListener(ACCUMULATIVEGACHA_UPDATE, slot0.taskUpdateHandler_)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.notify:RemoveListener(ACCUMULATIVEGACHA_UPDATE, slot0.taskUpdateHandler_)
end

function slot0.Dispose(slot0)
	slot0.taskUpdateHandler_ = nil

	slot0.taskScroll_:Dispose()

	for slot4, slot5 in pairs(slot0.nodeList) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.GoToSystem("/draw", nil, ViewConst.SYSTEM_ID.DRAW)
	end)
	slot0:AddBtnListener(slot0.descbtnBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_ACCUMULATIVE_INSTRUCTIONS",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_ACCUMULATIVE_INSTRUCTIONS")
		})
	end)
end

function slot0.RefreshTimeText(slot0)
	slot0.texttimeText_.text = manager.time:GetLostTimeStrWith2Unit(slot0.stopTime_)
end

function slot0.TaskUpdate(slot0)
	slot0.tasklist = ActivityAccumulativeData:GetList(slot0.activityID_)

	slot0.taskScroll_:StartScroll(#slot0.tasklist)

	slot1 = 0
	slot0.descTxt_.text = ActivityAccumulativeData:GetNum()
	slot0.textText_.text = GetTips("ACTIVITY_ACCUMULATIVE_INTRODUCE")
	slot2 = {
		0.08,
		0.18,
		0.3,
		0.42,
		0.54,
		0.66,
		0.78,
		0.9,
		1,
		1
	}
	slot3 = 1425
	slot4 = 0
	slot5 = 0.1
	slot6 = 0
	slot7 = 0
	slot8 = 9999

	for slot12 = 1, #slot0.tasklist do
		if not slot0.nodeList[slot12] then
			slot0.nodeList[slot12] = AccumulativeGachaPoint.New(slot0[string.format("point%sGo_", slot12)])
		end

		if ActivityPointRewardCfg[slot0.tasklist[slot12].id] then
			slot4 = math.max(slot4, slot14.need)
			slot0.drawIndex = math.max(slot13.state == 2 and slot12 or 0, slot0.drawIndex)

			if slot14.need <= ActivityAccumulativeData:GetNum() then
				slot5 = 0.12
				slot6 = slot2[slot12]

				slot0.nodeList[slot12]:SetIsDraw(true)

				slot7 = math.max(slot7, slot14.need)
			else
				slot8 = math.min(slot8, slot14.need)

				slot0.nodeList[slot12]:SetIsDraw(false)
			end
		end
	end

	slot0.sliderSlr_.value = slot6 + (ActivityAccumulativeData:GetNum() - slot7) / (slot8 - slot7) * slot5
end

return slot0
