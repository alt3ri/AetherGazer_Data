ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("ActivityPtScrollEnterView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return ActivityPtScrollTools.GetEnterUIName(slot0.activityID_)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:RefreshDesc()
	slot0:RefreshShop()

	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.clearCon_ = ControllerUtil.GetController(slot0.taskRect_, "clear")
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ActivityPtScrollTaskItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.list_[slot1], slot0.activityID_)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.exchangeBtn_, nil, function ()
		for slot6, slot7 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityShopCfg[ActivityPtScrollTools.GetShopActivityID(uv0.activityID_)].activity_theme]) do
			if ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[slot7].shop_id].activity_id) and slot9:IsActivitying() then
				table.insert({}, ActivityShopCfg[slot7].shop_id)
			end
		end

		slot3, slot4 = ShopTools.IsShopOpen(slot1.shop_id)

		if slot3 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = slot1.shop_id,
				showShops = slot2
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif slot4 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif slot4 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.OpenPageByJump("/activityPtScroll", {
			mainActivityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.allReceiveBtn_, nil, function ()
		slot1 = ActivityPtScrollTools.GetTaskActivityID(uv0.activityID_)

		for slot5, slot6 in ipairs(uv0.list_) do
			if slot6 ~= 0 then
				if TaskData2:GetTask(slot6).complete_flag < 1 and AssignmentCfg[slot6].need <= slot8.progress then
					table.insert({}, slot6)
				end
			end
		end

		if uv0:IsInfinityFinish() then
			ActivityPtScrollAction.TryToSubmitScrollTask(uv0.activityID_, slot0)
		else
			TaskAction:SubmitTaskList(slot0)
		end
	end)
	slot0:AddBtnListener(slot0.tipBtn_, nil, function ()
		if ActivityPtScrollTools.GetHelpKey(uv0.activityID_) ~= "" then
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(slot0),
				key = slot0
			})
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
	slot0:BindRedPointUI()
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(slot0, slot0.RefreshTask))
	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_OPEN .. "_" .. slot0.activityID_, 0)
	saveData(RedPointConst.ACTIVITY_PT_SCROLL_OPEN, tostring(slot0.activityID_), true)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshActivityData()
	slot0:RefreshTime()
	slot0:RefreshTask()
end

function slot0.RefreshActivityData(slot0)
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
	slot1 = ActivityPtScrollTools.GetLevelActivityID(slot0.activityID_)

	if type(ActivityCfg[slot0.activityID_].unlock_condition) ~= "table" then
		slot0.lock_.text = ""
	else
		slot0.lock_.text = string.format(GetTips("ACTIVITY_XUHENG_PT_LOCK"), ChapterCfg[slot2[2][1]].subhead)
	end

	slot0.isLock_ = not ActivityTools.IsUnlockActivity(slot0.activityID_)
	slot0.challengeCurrencyID_ = ActivityPtScrollTools.GetChallengeCurrencyID(slot0.activityID_)
end

function slot0.RefreshTime(slot0)
	slot1 = nil
	slot5 = ActivityData:GetActivityData(ActivityPtScrollTools.GetLevelActivityID(slot0.activityID_)).stopTime

	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.startTime_ then
		slot0.stateCon_:SetSelectedState("close")

		slot0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.startTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot2 < slot0.stopTime_ then
		if slot0.stopTime_ - slot2 < GameSetting.time_remaining_show.value[1] * 86400 then
			slot0.shopTimeLable_.text = manager.time:GetLostTimeStrWith2Unit(slot0.stopTime_)

			SetActive(slot0.shopTimeGo_, true)
		else
			SetActive(slot0.shopTimeGo_, false)
		end

		if slot2 < slot5 then
			slot0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(slot5)

			if slot0.isLock_ then
				slot0.stateCon_:SetSelectedState("lock")
			else
				slot0.stateCon_:SetSelectedState("unlock")
			end
		else
			slot0.timeLable_.text = GetTips("TIME_OVER")

			slot0.stateCon_:SetSelectedState("onlyShop")
		end

		slot0.timer_ = Timer.New(function ()
			uv0 = manager.time:GetServerTime()
			uv1 = uv2.stopTime_ - uv0

			if uv1 <= 0 then
				uv2:StopTimer()
				uv2:RefreshTime()

				return
			end

			if uv1 < GameSetting.time_remaining_show.value[1] * 86400 then
				uv2.shopTimeLable_.text = manager.time:GetLostTimeStrWith2Unit(uv2.stopTime_)

				SetActive(uv2.shopTimeGo_, true)
			else
				SetActive(uv2.shopTimeGo_, false)
			end

			if uv0 < uv3 then
				uv2.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(uv3)

				if uv2.isLock_ then
					uv2.stateCon_:SetSelectedState("lock")
				else
					uv2.stateCon_:SetSelectedState("unlock")
				end
			else
				uv2.timeLable_.text = GetTips("TIME_OVER")

				uv2.stateCon_:SetSelectedState("onlyShop")
			end
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.stateCon_:SetSelectedState("close")

		slot0.timeLable_.text = GetTips("TIME_OVER")
		slot0.shopTimeLable_.text = GetTips("TIME_OVER")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
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

	for slot10, slot11 in pairs(TaskTools:GetActivityTaskList(ActivityPtScrollTools.GetTaskActivityID(slot0.activityID_)) or {}) do
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

	if slot0:IsInfinityFinish() then
		table.insert(slot4, 1, 0)
	else
		table.insert(slot5, 1, 0)
	end

	table.insertto(slot0.list_, slot4)
	table.insertto(slot0.list_, slot5)
	table.insertto(slot0.list_, slot6)

	if #slot4 > 0 then
		slot0.clearCon_:SetSelectedState("true")
	else
		slot0.clearCon_:SetSelectedState("false")
	end

	slot0.scrollHelper_:StartScroll(#slot0.list_)
end

function slot0.IsInfinityFinish(slot0)
	return GameSetting.activity_pt_roulette_task_times.value[1] <= ActivityPtScrollData:GetClearTime(slot0.activityID_)
end

function slot0.Show(slot0, slot1)
	uv0.super.Show(slot0, slot1)

	if slot1 then
		slot0:RefreshTask()
	end
end

function slot0.RefreshDesc(slot0)
	if slot0.activityDesc_ and ActivityPtScrollTools.GetDesc(slot0.activityID_) ~= "" then
		slot0.activityDesc_.text = GetTips(slot1)
	end
end

function slot0.RefreshShop(slot0)
	slot0.shopName_.text = ShopListCfg[ActivityShopCfg[ActivityPtScrollTools.GetShopActivityID(slot0.activityID_)].shop_id].remark
end

function slot0.UpdateBar(slot0)
	slot1 = ActivityPtScrollTools.GetCurrencyID(slot0.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		slot1
	})
	manager.windowBar:SetBarCanClick(slot1, true)
end

function slot0.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.goBtn_.transform, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. slot0.activityID_)
end

function slot0.UnbindRedPointUI(slot0)
	manager.redPoint:unbindUIandKey(slot0.goBtn_.transform, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. slot0.activityID_)
end

function slot0.OnExit(slot0)
	slot0:UnbindRedPointUI()
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
