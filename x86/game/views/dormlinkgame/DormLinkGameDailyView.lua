ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("DormLinkGameDailyView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return DormLinkGameTools:GetMainUIName(slot0.activityID_)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexDailyItemList), slot0.uilistUilist_, DormLinkGameDailyItem)
	slot0.clearCon_ = ControllerUtil.GetController(slot0.transform_, "oneclick")
end

function slot0.indexDailyItemList(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.list_[slot1], slot0.activityID_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.btnstartBtn_, nil, function ()
		JumpTools.OpenPageByJump("/dormLinkGameLevelView", {
			activityID_ = uv0.activityID_
		})
	end)
	slot0:AddBtnListenerScale(slot0.receiveBtn_, nil, function ()
		slot0 = {}
		slot1 = DormLinkGameTools:GetTaskActivityID(uv0.activityID_)

		for slot5, slot6 in ipairs(uv0.list_) do
			if TaskData2:GetTask(slot6).complete_flag < 1 and AssignmentCfg[slot6].need <= slot8.progress then
				table.insert(slot0, slot6)
			end
		end

		TaskAction:SubmitTaskList(slot0)
	end)
	slot0:AddBtnListener(slot0.tipBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelpPro", {
			hideHomeBtn = 1,
			pages = GameSetting.linkgame_describe.value
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshView()
	slot0:RegisterEvents()
	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_1_LINKGAME_UNCOMPLETE_LEVEL, 0)
end

function slot0.UpdateBar(slot0)
	slot1 = DormLinkGameTools:GetCurrencyID(slot0.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		slot1
	})
	manager.windowBar:SetBarCanAdd(slot1, true)
end

function slot0.UpdataLastTime(slot0)
	slot1 = true
	slot2 = ActivityData:GetActivityData(slot0.activityID_)
	slot3 = slot2.startTime

	if slot2.stopTime < manager.time:GetServerTime() then
		slot1 = false
	end

	if not slot1 then
		slot0.clearCon_:SetSelectedState("off")
	end

	if slot5 < slot3 then
		slot0.lastTimeText_.text = GetTips("SOLO_NOT_OPEN")
	elseif slot5 < slot4 then
		slot0.lastTimeText_.text = manager.time:GetLostTimeStrWith2Unit(slot4)
	else
		slot0.lastTimeText_.text = GetTips("TIME_OVER")
	end
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, function ()
		uv0:RefreshTask()
	end)
end

function slot0.RefreshView(slot0)
	slot0:RefreshTask()
	slot0:UpdataLastTime()
end

function slot0.RefreshTask(slot0)
	slot0.list_ = {}

	function slot3(slot0, slot1)
		if AssignmentCfg[slot0].type ~= AssignmentCfg[slot1].type then
			return slot2.type < slot3.type
		end

		return slot0 < slot1
	end

	slot4 = {}
	slot5 = {}
	slot6 = {}

	for slot10, slot11 in pairs(TaskTools:GetActivityTaskList(DormLinkGameTools:GetTaskActivityID(slot0.activityID_)) or {}) do
		if AssignmentCfg[slot11.id].activity_id == slot1 then
			if slot11.complete_flag >= 1 then
				table.insert(slot6, slot12)
			elseif slot13.need <= slot11.progress then
				table.insert(slot4, slot12)
			else
				table.insert(slot5, slot12)
			end
		end
	end

	table.sort(slot4, slot3)
	table.sort(slot5, slot3)
	table.sort(slot6, slot3)
	table.insertto(slot0.list_, slot4)
	table.insertto(slot0.list_, slot5)
	table.insertto(slot0.list_, slot6)
	slot0.scrollHelper_:StartScroll(#slot0.list_)

	if #slot4 > 0 then
		slot0.clearCon_:SetSelectedState("on")
	else
		slot0.clearCon_:SetSelectedState("off")
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()

		slot0.scrollHelper_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
